<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('daily_reports', function (Blueprint $table) {
            $table->id();
            $table->foreignId('power_plant_id')->constrained()->cascadeOnDelete();
            $table->date('report_date')->index();        // วันที่ของรายงาน
            $table->decimal('energy_mwh', 10, 2);        // พลังงานรวมทั้งวัน (MWh)
            $table->decimal('peak_mw', 8, 2);            // กำลังผลิตสูงสุดของวัน (MW)
            $table->decimal('availability', 5, 2);       // ความพร้อมจ่าย (%)
            $table->decimal('water_level_m', 6, 2);      // ระดับน้ำ (เมตร)
            $table->timestamps();

            // 1 โรงไฟฟ้า มีรายงานได้วันละ 1 ฉบับ
            $table->unique(['power_plant_id', 'report_date']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('daily_reports');
    }
};
