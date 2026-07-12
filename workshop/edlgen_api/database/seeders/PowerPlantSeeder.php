<?php

namespace Database\Seeders;

use App\Models\PowerPlant;
use Illuminate\Database\Seeder;

class PowerPlantSeeder extends Seeder
{
    public function run(): void
    {
        $plants = [
            ['name' => 'Nam Ngum 1',    'code' => 'NN1', 'type' => 'hydro', 'capacity_mw' => 155.00, 'province' => 'Vientiane'],
            ['name' => 'Nam Ngum 2',    'code' => 'NN2', 'type' => 'hydro', 'capacity_mw' => 615.00, 'province' => 'Vientiane'],
            ['name' => 'Theun-Hinboun', 'code' => 'THB', 'type' => 'hydro', 'capacity_mw' => 500.00, 'province' => 'Bolikhamxay'],
            ['name' => 'Houay Ho',      'code' => 'HH',  'type' => 'hydro', 'capacity_mw' => 152.00, 'province' => 'Champasak'],
            ['name' => 'Solar Farm 1',  'code' => 'SF1', 'type' => 'solar', 'capacity_mw' => 30.00,  'province' => 'Savannakhet'],
        ];

        foreach ($plants as $plant) {
            $created = PowerPlant::create($plant);

            // ค่าอ่านย้อนหลัง 24 ชั่วโมง (5 โรง × 24 = 120 แถว)
            foreach (range(1, 24) as $hour) {
                $created->readings()->create([
                    'output_mw'    => round($created->capacity_mw * (mt_rand(55, 92) / 100), 2),
                    'frequency_hz' => round(mt_rand(4985, 5015) / 100, 2),
                    'voltage_kv'   => round(mt_rand(2180, 2320) / 10, 2),
                    'recorded_at'  => now()->subHours($hour),
                ]);
            }
        }
    }
}
