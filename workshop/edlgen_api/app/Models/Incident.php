<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Incident extends Model
{
    protected $fillable = [
        'power_plant_id', 'reported_by', 'title', 'description',
        'severity', 'status', 'occurred_at',
        'photo_path', 'latitude', 'longitude', 'client_uuid',
    ];

    protected function casts(): array
    {
        return [
            'occurred_at' => 'datetime',
            'latitude'    => 'float',
            'longitude'   => 'float',
        ];
    }

    public function powerPlant(): BelongsTo
    {
        return $this->belongsTo(PowerPlant::class);
    }

    public function reporter(): BelongsTo
    {
        return $this->belongsTo(User::class, 'reported_by');
    }
}
