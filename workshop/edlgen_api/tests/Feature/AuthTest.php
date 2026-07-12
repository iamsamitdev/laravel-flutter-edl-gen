<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class AuthTest extends TestCase
{
    use RefreshDatabase;

    private function createEngineer(): User
    {
        return User::factory()->create([
            'email'    => 'engineer@edlgen.la',
            'password' => Hash::make('password123'),
        ]);
    }

    public function test_login_สำเร็จได้_token(): void
    {
        $this->createEngineer();

        $response = $this->postJson('/api/v1/auth/login', [
            'email'       => 'engineer@edlgen.la',
            'password'    => 'password123',
            'device_name' => 'phpunit-test',
        ]);

        $response->assertOk()
            ->assertJsonStructure([
                'token',
                'data' => ['token', 'expires_at', 'user' => ['id', 'name', 'email', 'role']],
            ]);
    }

    public function test_รหัสผ่านผิด_ต้องได้_422(): void
    {
        $this->createEngineer();

        $this->postJson('/api/v1/auth/login', [
            'email'       => 'engineer@edlgen.la',
            'password'    => 'wrong-password',
            'device_name' => 'phpunit-test',
        ])->assertStatus(422);
    }

    public function test_เรียก_route_ป้องกันโดยไม่มี_token_ต้องได้_401(): void
    {
        $this->getJson('/api/v1/me')->assertStatus(401);
    }

    public function test_logout_แล้ว_token_ใช้ซ้ำไม่ได้(): void
    {
        $this->createEngineer();

        $login = $this->postJson('/api/v1/login', [
            'email'       => 'engineer@edlgen.la',
            'password'    => 'password123',
            'device_name' => 'phpunit-test',
        ]);

        $token = $login->json('token');
        $headers = ['Authorization' => "Bearer {$token}"];

        $this->getJson('/api/v1/me', $headers)->assertOk();
        $this->postJson('/api/v1/logout', [], $headers)->assertOk();

        // ล้าง guard cache ของ test client ก่อนยิงซ้ำ (จำลอง request ใหม่จริง ๆ)
        $this->app->get('auth')->forgetGuards();

        $this->getJson('/api/v1/me', $headers)->assertStatus(401);
    }
}
