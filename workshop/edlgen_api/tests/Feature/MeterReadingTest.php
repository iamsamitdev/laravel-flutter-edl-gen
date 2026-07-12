<?php

namespace Tests\Feature;

use App\Models\PowerPlant;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class MeterReadingTest extends TestCase
{
    use RefreshDatabase;

    public function test_บันทึกค่ามิเตอร์สำเร็จได้_201(): void
    {
        $user = User::factory()->create();
        $plant = PowerPlant::factory()->create();
        Sanctum::actingAs($user);

        $response = $this->postJson('/api/v1/meter-readings', [
            'plant_id'     => $plant->id,
            'meter_code'   => 'MTR-0042',
            'reading_kwh'  => 15230.5,
            'recorded_for' => now()->startOfHour()->format('Y-m-d H:00:00'),
        ]);

        $response->assertCreated();
        $this->assertDatabaseHas('meter_readings', ['meter_code' => 'MTR-0042']);
    }

    public function test_บันทึกซ้ำชั่วโมงเดิม_ต้องได้_409(): void
    {
        $user = User::factory()->create();
        $plant = PowerPlant::factory()->create();
        Sanctum::actingAs($user);

        $payload = [
            'plant_id'     => $plant->id,
            'meter_code'   => 'MTR-0042',
            'reading_kwh'  => 15230.5,
            'recorded_for' => now()->startOfHour()->format('Y-m-d H:00:00'),
        ];

        $this->postJson('/api/v1/meter-readings', $payload)->assertCreated();
        $this->postJson('/api/v1/meter-readings', $payload)->assertStatus(409);
    }

    public function test_รหัสมิเตอร์ผิดรูปแบบ_ต้องได้_422(): void
    {
        $user = User::factory()->create();
        $plant = PowerPlant::factory()->create();
        Sanctum::actingAs($user);

        $this->postJson('/api/v1/meter-readings', [
            'plant_id'     => $plant->id,
            'meter_code'   => 'METER-42',   // ไม่ตรง ^MTR-[0-9]{4}$
            'reading_kwh'  => 100,
            'recorded_for' => now()->startOfHour()->format('Y-m-d H:00:00'),
        ])->assertStatus(422);
    }
}
