<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\V1\IncidentResource;
use App\Models\Incident;
use App\Models\User;
use App\Notifications\IncidentReported;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\Notification;

class IncidentController extends Controller
{
    /**
     * GET /api/v1/incidents
     * รายการเหตุขัดข้อง (ใหม่สุดก่อน)
     */
    public function index(): AnonymousResourceCollection
    {
        $incidents = Incident::query()
            ->with(['powerPlant', 'reporter'])
            ->orderByDesc('occurred_at')
            ->paginate(20);

        return IncidentResource::collection($incidents);
    }

    /**
     * GET /api/v1/incidents/{incident}
     */
    public function show(Incident $incident): IncidentResource
    {
        return new IncidentResource($incident->load(['powerPlant', 'reporter']));
    }

    /**
     * POST /api/v1/incidents  (multipart/form-data)
     * แจ้งเหตุขัดข้อง + รูปถ่าย + พิกัด GPS (Day 5 Feature 4)
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'plant_id'    => ['required', 'integer', 'exists:power_plants,id'],
            'title'       => ['required', 'string', 'max:150'],
            'description' => ['required', 'string', 'max:2000'],
            'severity'    => ['required', 'in:low,medium,high,critical'],
            'latitude'    => ['required', 'numeric', 'between:-90,90'],
            'longitude'   => ['required', 'numeric', 'between:-180,180'],
            'photo'       => ['required', 'image', 'mimes:jpeg,png', 'max:5120'], // 5 MB
            'client_uuid' => ['nullable', 'uuid'],
        ]);

        // Idempotency: ถ้าเคยส่ง client_uuid นี้แล้ว ตอบ 409 กันบันทึกซ้ำ (Outbox Pattern)
        if (! empty($validated['client_uuid'])
            && Incident::where('client_uuid', $validated['client_uuid'])->exists()) {
            return response()->json([
                'message' => 'เหตุขัดข้องนี้ถูกบันทึกไปแล้ว (duplicate client_uuid)',
            ], 409);
        }

        $photoPath = $request->file('photo')->store('incidents', 'public');

        $incident = Incident::create([
            'power_plant_id' => $validated['plant_id'],
            'title'          => $validated['title'],
            'description'    => $validated['description'],
            'severity'       => $validated['severity'],
            'latitude'       => $validated['latitude'],
            'longitude'      => $validated['longitude'],
            'client_uuid'    => $validated['client_uuid'] ?? null,
            'photo_path'     => $photoPath,
            'status'         => 'open',
            'occurred_at'    => now(),
            'reported_by'    => $request->user()->id,
        ]);

        // แจ้งหัวหน้ากะทุกคนผ่าน Database Notification (Production: เพิ่ม FCM)
        $supervisors = User::where('role', 'supervisor')->get();
        Notification::send($supervisors, new IncidentReported($incident));

        return response()->json(
            ['data' => new IncidentResource($incident)],
            201,
        );
    }

    /**
     * PATCH /api/v1/incidents/{incident}
     * อัปเดตสถานะ Timeline: open → investigating → resolved (Day 4 StatusCubit)
     */
    public function update(Request $request, Incident $incident): IncidentResource
    {
        $validated = $request->validate([
            'status' => ['required', 'in:open,investigating,resolved'],
        ]);

        $incident->update($validated);

        return new IncidentResource($incident->refresh());
    }
}
