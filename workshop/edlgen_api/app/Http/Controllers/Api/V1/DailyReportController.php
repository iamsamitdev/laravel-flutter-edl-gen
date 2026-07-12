<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\V1\DailyReportResource;
use App\Models\DailyReport;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class DailyReportController extends Controller
{
    /**
     * GET /api/v1/reports/daily?date_from=2026-07-01&date_to=2026-07-15&plant_id=2
     * รายงานการผลิตรายวัน พร้อม Filter (Day 5 Feature 3)
     */
    public function index(Request $request): AnonymousResourceCollection
    {
        $filters = $request->validate([
            'date_from' => ['nullable', 'date'],
            'date_to'   => ['nullable', 'date', 'after_or_equal:date_from'],
            'plant_id'  => ['nullable', 'integer', 'exists:power_plants,id'],
        ]);

        $reports = DailyReport::query()
            ->with('powerPlant')
            ->when($filters['date_from'] ?? null,
                fn ($q, $date) => $q->whereDate('report_date', '>=', $date))
            ->when($filters['date_to'] ?? null,
                fn ($q, $date) => $q->whereDate('report_date', '<=', $date))
            ->when($filters['plant_id'] ?? null,
                fn ($q, $id) => $q->where('power_plant_id', $id))
            ->orderByDesc('report_date')
            ->limit(60)   // จำกัดสูงสุด 60 รายการต่อคำขอ
            ->get();

        return DailyReportResource::collection($reports);
    }
}
