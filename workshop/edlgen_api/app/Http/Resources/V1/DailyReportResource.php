<?php

namespace App\Http\Resources\V1;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DailyReportResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'            => $this->id,
            'plant_id'      => $this->power_plant_id,
            'plant_name'    => $this->powerPlant->name,
            'report_date'   => $this->report_date->format('Y-m-d'),
            'energy_mwh'    => (float) $this->energy_mwh,
            'peak_mw'       => (float) $this->peak_mw,
            'availability'  => (float) $this->availability,
            'water_level_m' => (float) $this->water_level_m,
        ];
    }
}
