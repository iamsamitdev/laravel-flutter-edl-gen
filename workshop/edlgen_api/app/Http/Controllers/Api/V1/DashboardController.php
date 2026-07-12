<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\EnergyReading;
use App\Models\Incident;
use App\Models\PowerPlant;
use Illuminate\Http\JsonResponse;

class DashboardController extends Controller
{
    /**
     * GET /api/v1/dashboard/summary
     * สรุปภาพรวมสำหรับการ์ดบน Dashboard (Day 3)
     */
    public function summary(): JsonResponse
    {
        // กำลังผลิตรวม = ผลรวมค่าอ่านล่าสุดของแต่ละโรงไฟฟ้าที่ยังเดินเครื่อง
        $totalPowerMw = PowerPlant::query()
            ->where('is_active', true)
            ->get()
            ->sum(function (PowerPlant $plant) {
                return (float) ($plant->readings()->latest('recorded_at')->value('output_mw') ?? 0);
            });

        return response()->json([
            'data' => [
                'total_power_mw' => round($totalPowerMw, 2),
                'online_plants'  => PowerPlant::where('is_active', true)->count(),
                'total_plants'   => PowerPlant::count(),
                'alert_count'    => Incident::where('status', '!=', 'resolved')->count(),
                'updated_at'     => EnergyReading::max('recorded_at'),
            ],
        ]);
    }
}
