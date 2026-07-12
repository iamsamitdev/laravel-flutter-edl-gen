<?php

namespace App\Http\Resources\V1;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PowerPlantResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'          => $this->id,
            'name'        => $this->name,
            'code'        => $this->code,
            'type'        => $this->type,
            'capacity_mw' => (float) $this->capacity_mw,   // บังคับเป็น number ไม่ใช่ string
            'province'    => $this->province,
            'is_active'   => $this->is_active,

            // Conditional Field: ส่ง readings เฉพาะเมื่อ Controller สั่ง eager load มา
            // ป้องกัน N+1 Query และ Over-fetching ไปพร้อมกัน
            'latest_readings' => EnergyReadingResource::collection(
                $this->whenLoaded('readings')
            ),

            // Conditional Field: จำนวนเหตุขัดข้องที่ยังไม่ปิด ส่งเฉพาะเมื่อ withCount มา
            'open_incidents_count' => $this->whenCounted('incidents'),

            // ส่ง updated_at ให้เฉพาะผู้ใช้ที่ล็อกอิน (ตัวอย่าง when แบบเงื่อนไข)
            'updated_at' => $this->when(
                $request->user() !== null,
                fn () => $this->updated_at?->toIso8601String()
            ),
        ];
    }
}
