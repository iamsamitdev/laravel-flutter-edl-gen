<?php

namespace App\Http\Resources\V1;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Storage;

class IncidentResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'          => $this->id,
            'plant_id'    => $this->power_plant_id,
            'plant_name'  => $this->whenLoaded('powerPlant', fn () => $this->powerPlant->name),
            'title'       => $this->title,
            'description' => $this->description,
            'severity'    => $this->severity,
            'status'      => $this->status,
            'latitude'    => $this->latitude !== null ? (float) $this->latitude : null,
            'longitude'   => $this->longitude !== null ? (float) $this->longitude : null,
            'photo_url'   => $this->photo_path !== null
                ? Storage::disk('public')->url($this->photo_path)
                : null,
            'reported_by' => $this->whenLoaded('reporter', fn () => $this->reporter->name),
            'occurred_at' => $this->occurred_at?->toIso8601String(),
            'created_at'  => $this->created_at->toIso8601String(),
        ];
    }
}
