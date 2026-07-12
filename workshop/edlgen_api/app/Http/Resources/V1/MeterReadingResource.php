<?php

namespace App\Http\Resources\V1;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MeterReadingResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'           => $this->id,
            'plant_id'     => $this->power_plant_id,
            'meter_code'   => $this->meter_code,
            'reading_kwh'  => (float) $this->reading_kwh,
            'recorded_for' => $this->recorded_for->toIso8601String(),
            'recorded_by'  => $this->recorded_by,
            'created_at'   => $this->created_at->toIso8601String(),
        ];
    }
}
