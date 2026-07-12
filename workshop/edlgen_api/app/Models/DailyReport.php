<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DailyReport extends Model
{
    protected $fillable = [
        'power_plant_id', 'report_date', 'energy_mwh',
        'peak_mw', 'availability', 'water_level_m',
    ];

    protected function casts(): array
    {
        return [
            'report_date'   => 'date',
            'energy_mwh'    => 'decimal:2',
            'peak_mw'       => 'decimal:2',
            'availability'  => 'decimal:2',
            'water_level_m' => 'decimal:2',
        ];
    }

    public function powerPlant(): BelongsTo
    {
        return $this->belongsTo(PowerPlant::class);
    }
}
