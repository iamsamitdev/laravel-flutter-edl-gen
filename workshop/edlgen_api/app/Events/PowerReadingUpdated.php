<?php

namespace App\Events;

use App\Models\EnergyReading;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

/**
 * Broadcast ค่าการผลิตล่าสุดไปยัง Flutter ผ่าน Reverb (Pusher protocol)
 * Channel: power.readings | Event: power.reading.updated
 *
 * ใช้ ShouldBroadcastNow เพื่อส่งทันทีไม่ผ่าน Queue (เหมาะกับห้องอบรม)
 * Production ควรเปลี่ยนเป็น ShouldBroadcast + queue:work
 */
class PowerReadingUpdated implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public function __construct(
        public EnergyReading $reading,
    ) {}

    public function broadcastOn(): array
    {
        return [
            new Channel('power.readings'),
        ];
    }

    public function broadcastAs(): string
    {
        return 'power.reading.updated';
    }

    public function broadcastWith(): array
    {
        return [
            'plant_id'    => $this->reading->power_plant_id,
            'plant_name'  => $this->reading->powerPlant->name,
            'power_mw'    => (float) $this->reading->output_mw,
            'frequency'   => (float) $this->reading->frequency_hz,
            'voltage_kv'  => (float) $this->reading->voltage_kv,
            'recorded_at' => $this->reading->recorded_at->toIso8601String(),
        ];
    }
}
