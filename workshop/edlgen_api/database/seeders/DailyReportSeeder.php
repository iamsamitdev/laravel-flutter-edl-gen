<?php

namespace Database\Seeders;

use App\Models\DailyReport;
use App\Models\PowerPlant;
use Illuminate\Database\Seeder;

class DailyReportSeeder extends Seeder
{
    /**
     * รายงานการผลิตรายวันย้อนหลัง 30 วัน ของทุกโรงไฟฟ้า (Day 5 Feature 3)
     */
    public function run(): void
    {
        foreach (PowerPlant::all() as $plant) {
            foreach (range(0, 29) as $daysAgo) {
                DailyReport::create([
                    'power_plant_id' => $plant->id,
                    'report_date'    => today()->subDays($daysAgo),
                    'energy_mwh'     => round($plant->capacity_mw * 24 * (mt_rand(55, 90) / 100), 2),
                    'peak_mw'        => round($plant->capacity_mw * (mt_rand(85, 98) / 100), 2),
                    'availability'   => round(mt_rand(880, 999) / 10, 2),   // 88.0-99.9 %
                    'water_level_m'  => round(mt_rand(1800, 2100) / 10, 2), // 180.0-210.0 m
                ]);
            }
        }
    }
}
