<?php

namespace App\Http\Resources\V1;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class EnergyReadingResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'           => $this->id,
            'output_mw'    => (float) $this->output_mw,
            'frequency_hz' => (float) $this->frequency_hz,
            'voltage_kv'   => (float) $this->voltage_kv,
            'recorded_at'  => $this->recorded_at->toIso8601String(),
        ];
    }
}
