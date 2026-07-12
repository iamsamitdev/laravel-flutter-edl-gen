<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class EnergyReading extends Model
{
    protected $fillable = [
        'power_plant_id', 'output_mw', 'frequency_hz', 'voltage_kv', 'recorded_at',
    ];

    protected function casts(): array
    {
        return [
            'output_mw'    => 'decimal:2',
            'frequency_hz' => 'decimal:2',
            'voltage_kv'   => 'decimal:2',
            'recorded_at'  => 'datetime',
        ];
    }

    public function powerPlant(): BelongsTo
    {
        return $this->belongsTo(PowerPlant::class);
    }
}
