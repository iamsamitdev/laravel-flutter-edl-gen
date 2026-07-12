<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PowerPlant extends Model
{
    /** @use HasFactory<\Database\Factories\PowerPlantFactory> */
    use HasFactory;

    protected $fillable = [
        'name', 'code', 'type', 'capacity_mw', 'province', 'is_active',
    ];

    protected function casts(): array
    {
        return [
            'capacity_mw' => 'decimal:2',
            'is_active'   => 'boolean',
        ];
    }

    // โรงไฟฟ้า 1 แห่ง มีค่าการอ่านหลายรายการ
    public function readings(): HasMany
    {
        return $this->hasMany(EnergyReading::class);
    }

    // โรงไฟฟ้า 1 แห่ง มีเหตุขัดข้องหลายรายการ
    public function incidents(): HasMany
    {
        return $this->hasMany(Incident::class);
    }

    // โรงไฟฟ้า 1 แห่ง มีมิเตอร์หลายตัว (ใช้ใน Day 5 Feature 5)
    public function meterReadings(): HasMany
    {
        return $this->hasMany(MeterReading::class);
    }
}
