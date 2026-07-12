<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MeterReading extends Model
{
    protected $fillable = [
        'power_plant_id', 'recorded_by', 'meter_code', 'reading_kwh', 'recorded_for',
    ];

    protected function casts(): array
    {
        return [
            'reading_kwh'  => 'decimal:2',
            'recorded_for' => 'datetime',
        ];
    }

    public function powerPlant(): BelongsTo
    {
        return $this->belongsTo(PowerPlant::class);
    }

    public function recorder(): BelongsTo
    {
        return $this->belongsTo(User::class, 'recorded_by');
    }
}
