<?php

namespace App\Console\Commands;

use App\Events\PowerReadingUpdated;
use App\Models\PowerPlant;
use Illuminate\Console\Command;

class SimulatePowerReadings extends Command
{
    protected $signature = 'edlgen:simulate-readings {--interval=3 : วินาทีระหว่างข้อมูลแต่ละชุด}';

    protected $description = 'จำลองค่าการผลิตไฟฟ้าแบบ Real-time สำหรับ Workshop (กด Ctrl+C เพื่อหยุด)';

    public function handle(): void
    {
        $interval = (int) $this->option('interval');
        $plants = PowerPlant::where('is_active', true)->get();

        if ($plants->isEmpty()) {
            $this->error('ไม่พบโรงไฟฟ้าในระบบ - รัน php artisan migrate:fresh --seed ก่อน');

            return;
        }

        $this->info("เริ่มจำลองข้อมูล {$plants->count()} โรงผลิต ทุก {$interval} วินาที (Ctrl+C เพื่อหยุด)");

        while (true) {
            // สุ่มโรงไฟฟ้า 1 แห่ง แล้วจำลองค่าอ่านรอบกำลังผลิตติดตั้ง
            $plant = $plants->random();

            $reading = $plant->readings()->create([
                'output_mw'    => round($plant->capacity_mw * (mt_rand(60, 95) / 100), 2),
                'frequency_hz' => round(mt_rand(4990, 5010) / 100, 2),   // 49.90-50.10 Hz
                'voltage_kv'   => round(mt_rand(2245, 2320) / 10, 2),    // 224.5-232.0 kV
                'recorded_at'  => now(),
            ]);

            PowerReadingUpdated::dispatch($reading);
            $this->line("ส่งค่า: {$plant->name} = {$reading->output_mw} MW | {$reading->frequency_hz} Hz");

            sleep($interval);
        }
    }
}
