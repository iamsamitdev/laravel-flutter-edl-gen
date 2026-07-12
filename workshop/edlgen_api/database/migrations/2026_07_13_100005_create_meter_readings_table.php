<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('meter_readings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('power_plant_id')->constrained()->cascadeOnDelete();
            $table->foreignId('recorded_by')->constrained('users');
            $table->string('meter_code', 20);            // รูปแบบ MTR-0000
            $table->decimal('reading_kwh', 12, 2);       // ค่าที่อ่านได้ (kWh)
            $table->dateTime('recorded_for');            // ชั่วโมงเต็มที่บันทึก เช่น 2026-07-13 14:00:00
            $table->timestamps();

            // กันบันทึกซ้ำ: มิเตอร์เดียวกัน + ชั่วโมงเดียวกัน มีได้แถวเดียว (Controller ตอบ 409)
            $table->unique(['meter_code', 'recorded_for']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('meter_readings');
    }
};
