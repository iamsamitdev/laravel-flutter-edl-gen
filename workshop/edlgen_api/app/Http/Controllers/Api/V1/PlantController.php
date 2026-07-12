<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\PowerPlant;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class PlantController extends Controller
{
    /**
     * GET /api/v1/plants?status=online|offline|maintenance
     * รายการโรงไฟฟ้าแบบย่อ (Day 3 Dashboard + Dropdown ในฟอร์ม Day 5)
     */
    public function index(Request $request): JsonResponse
    {
        $status = $request->query('status');

        $plants = PowerPlant::query()
            ->when($status === 'online', fn ($q) => $q->where('is_active', true))
            ->when($status === 'offline', fn ($q) => $q->where('is_active', false))
            ->orderBy('name')
            ->get()
            ->map(function (PowerPlant $plant) {
                $latestOutput = (float) ($plant->readings()
                    ->latest('recorded_at')
                    ->value('output_mw') ?? 0);

                return [
                    'id'                => $plant->id,
                    'name'              => $plant->name,
                    'code'              => $plant->code,
                    'type'              => $plant->type,
                    'province'          => $plant->province,
                    'capacity_mw'       => (float) $plant->capacity_mw,
                    'current_output_mw' => $latestOutput,
                    'status'            => $plant->is_active ? 'online' : 'offline',
                ];
            });

        return response()->json(['data' => $plants]);
    }

    /**
     * GET /api/v1/plants/{id}
     * รายละเอียดโรงไฟฟ้ารายตัว (หน้า Plant Detail)
     */
    public function show(int $id): JsonResponse
    {
        $plant = PowerPlant::with([
            'readings' => fn ($q) => $q->latest('recorded_at')->limit(30),
        ])->findOrFail($id);

        $latest = $plant->readings->first();

        return response()->json([
            'data' => [
                'id'                => $plant->id,
                'name'              => $plant->name,
                'code'              => $plant->code,
                'type'              => $plant->type,
                'province'          => $plant->province,
                'capacity_mw'       => (float) $plant->capacity_mw,
                'current_output_mw' => (float) ($latest?->output_mw ?? 0),
                'frequency_hz'      => (float) ($latest?->frequency_hz ?? 0),
                'voltage_kv'        => (float) ($latest?->voltage_kv ?? 0),
                'status'            => $plant->is_active ? 'online' : 'offline',
                'energy_today_mwh'  => round((float) $plant->readings()
                    ->whereDate('recorded_at', today())->sum('output_mw'), 2),
                'readings'          => $plant->readings->map(fn ($r) => [
                    'output_mw'   => (float) $r->output_mw,
                    'recorded_at' => $r->recorded_at->toIso8601String(),
                ])->values(),
            ],
        ]);
    }
}
