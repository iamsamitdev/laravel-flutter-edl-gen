<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Day 5 Feature 4: แจ้งเหตุขัดข้องพร้อมรูปถ่าย + พิกัด GPS
     */
    public function up(): void
    {
        Schema::table('incidents', function (Blueprint $table) {
            $table->string('photo_path')->nullable()->after('status');       // storage/app/public/incidents/...
            $table->decimal('latitude', 10, 7)->nullable()->after('photo_path');
            $table->decimal('longitude', 10, 7)->nullable()->after('latitude');
            $table->uuid('client_uuid')->nullable()->unique()->after('longitude'); // Idempotency key (Outbox Pattern - Day 4)
        });
    }

    public function down(): void
    {
        Schema::table('incidents', function (Blueprint $table) {
            $table->dropColumn(['photo_path', 'latitude', 'longitude', 'client_uuid']);
        });
    }
};
