<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // วิศวกรทดสอบของ EDL-Gen (ข้อมูลจำลอง) - ใช้ Login ในแอป
        User::factory()->create([
            'name'     => 'Somphone Engineer',
            'email'    => 'engineer@edlgen.la',
            'password' => Hash::make('password123'),
            'role'     => 'operator',
        ]);

        // หัวหน้ากะ - ผู้รับ Notification เมื่อมีการแจ้งเหตุขัดข้อง (Day 5 Feature 4)
        User::factory()->create([
            'name'     => 'Khamla Supervisor',
            'email'    => 'supervisor@edlgen.la',
            'password' => Hash::make('password123'),
            'role'     => 'supervisor',
        ]);

        $this->call([
            PowerPlantSeeder::class,
            DailyReportSeeder::class,
        ]);
    }
}
