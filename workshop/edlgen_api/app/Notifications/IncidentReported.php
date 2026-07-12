<?php

namespace App\Notifications;

use App\Models\Incident;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;

/**
 * แจ้งเตือนหัวหน้ากะ (role = supervisor) เมื่อมีการแจ้งเหตุขัดข้องใหม่
 */
class IncidentReported extends Notification
{
    use Queueable;

    public function __construct(public Incident $incident) {}

    public function via(object $notifiable): array
    {
        return ['database']; // Production: เพิ่ม 'fcm' สำหรับ Push Notification
    }

    public function toArray(object $notifiable): array
    {
        return [
            'incident_id' => $this->incident->id,
            'title'       => "แจ้งเหตุขัดข้อง: {$this->incident->title}",
            'severity'    => $this->incident->severity,
            'plant_id'    => $this->incident->power_plant_id,
        ];
    }
}
