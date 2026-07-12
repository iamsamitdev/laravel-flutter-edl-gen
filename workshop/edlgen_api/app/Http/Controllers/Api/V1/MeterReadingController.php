<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\V1\MeterReadingResource;
use App\Models\MeterReading;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Support\Facades\DB;

class MeterReadingController extends Controller
{
    /**
     * GET /api/v1/meter-readings/today
     * รายการที่บันทึกวันนี้ของผู้ใช้ปัจจุบัน (หน้าจอ Meter Reading)
     */
    public function today(Request $request): AnonymousResourceCollection
    {
        $readings = MeterReading::query()
            ->where('recorded_by', $request->user()->id)
            ->whereDate('recorded_for', today())
            ->orderByDesc('recorded_for')
            ->get();

        return MeterReadingResource::collection($readings);
    }

    /**
     * POST /api/v1/meter-readings
     * บันทึกค่ามิเตอร์รายชั่วโมง (Day 5 Feature 5 - Optimistic Update ฝั่งแอป)
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'plant_id'     => ['required', 'integer', 'exists:power_plants,id'],
            'meter_code'   => ['required', 'string', 'regex:/^MTR-[0-9]{4}$/'], // เช่น MTR-0042
            'reading_kwh'  => ['required', 'numeric', 'min:0', 'max:99999999'],
            'recorded_for' => ['required', 'date_format:Y-m-d H:00:00'],        // ชั่วโมงเต็มเท่านั้น
        ]);

        // กันบันทึกซ้ำ: มิเตอร์เดิม + ชั่วโมงเดิม → 409 Conflict
        $duplicated = MeterReading::where('meter_code', $validated['meter_code'])
            ->where('recorded_for', $validated['recorded_for'])
            ->exists();

        if ($duplicated) {
            return response()->json([
                'message' => 'มีการบันทึกค่ามิเตอร์นี้ในชั่วโมงดังกล่าวแล้ว',
            ], 409);
        }

        $reading = DB::transaction(function () use ($validated, $request) {
            return MeterReading::create([
                'power_plant_id' => $validated['plant_id'],
                'meter_code'     => $validated['meter_code'],
                'reading_kwh'    => $validated['reading_kwh'],
                'recorded_for'   => $validated['recorded_for'],
                'recorded_by'    => $request->user()->id,
            ]);
        });

        return response()->json(['data' => new MeterReadingResource($reading)], 201);
    }
}
