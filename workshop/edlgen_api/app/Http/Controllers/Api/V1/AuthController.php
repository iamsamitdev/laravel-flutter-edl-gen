<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\V1\UserResource;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    /**
     * POST /api/v1/login และ /api/v1/auth/login
     * รับ email + password + device_name แล้วคืน Sanctum Token
     *
     * Response มีทั้ง key ระดับบน (token/user - ใช้ใน Lab Day 1)
     * และ key `data` (token/expires_at/user - มาตรฐาน Day 5)
     */
    public function login(Request $request): JsonResponse
    {
        // 1) Validate ข้อมูลขาเข้า - ถ้าไม่ผ่าน Laravel คืน 422 ให้อัตโนมัติ
        $credentials = $request->validate([
            'email'       => ['required', 'email'],
            'password'    => ['required', 'string'],
            'device_name' => ['required', 'string'], // เช่น "samsung-a54-somchai"
        ]);

        // 2) หา user และตรวจรหัสผ่าน
        $user = User::where('email', $credentials['email'])->first();

        if (! $user || ! Hash::check($credentials['password'], $user->password)) {
            // ตอบกลับแบบเดียวกันทั้ง "ไม่พบ user" และ "รหัสผิด" กันการเดา email
            throw ValidationException::withMessages([
                'email' => ['ข้อมูลเข้าสู่ระบบไม่ถูกต้อง'],
            ]);
        }

        // 3) สร้าง Token ผูกกับชื่ออุปกรณ์ + จำกัดสิทธิ์ + วันหมดอายุ (Day 5)
        $token = $user->createToken(
            name: $credentials['device_name'],
            abilities: ['monitoring:read', 'monitoring:write'],
            expiresAt: now()->addMinutes(60),
        );

        return response()->json([
            'message' => 'เข้าสู่ระบบสำเร็จ',
            'token'   => $token->plainTextToken,   // Day 1 Lab ใช้ key นี้
            'user'    => new UserResource($user),
            'data'    => [                         // Day 5 มาตรฐาน
                'token'      => $token->plainTextToken,
                'expires_at' => $token->accessToken->expires_at?->toIso8601String(),
                'user'       => new UserResource($user),
            ],
        ]);
    }

    /**
     * POST /api/v1/refresh และ /api/v1/auth/refresh  (Token Rotation - Day 4/5)
     * ลบ token เดิมแล้วออกใบใหม่ทันที
     */
    public function refresh(Request $request): JsonResponse
    {
        $user = $request->user();
        $request->user()->currentAccessToken()->delete();

        $token = $user->createToken(
            name: 'refreshed-'.now()->timestamp,
            abilities: ['monitoring:read', 'monitoring:write'],
            expiresAt: now()->addMinutes(60),
        );

        return response()->json([
            'token' => $token->plainTextToken,
            'data'  => [
                'token'      => $token->plainTextToken,
                'expires_at' => $token->accessToken->expires_at?->toIso8601String(),
            ],
        ]);
    }

    /**
     * POST /api/v1/logout และ /api/v1/auth/logout  (ต้องแนบ Bearer Token)
     * ลบเฉพาะ token ของอุปกรณ์ที่เรียกเข้ามา
     * (Logout ทุกอุปกรณ์: $request->user()->tokens()->delete();)
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'ออกจากระบบสำเร็จ']);
    }

    /**
     * GET /api/v1/me และ /api/v1/auth/me  (ต้องแนบ Bearer Token)
     * คืนข้อมูลผู้ใช้ปัจจุบัน - ใช้ทดสอบว่า token ยังใช้ได้
     */
    public function me(Request $request): JsonResponse
    {
        return response()->json([
            'user' => new UserResource($request->user()),
            'data' => new UserResource($request->user()),
        ]);
    }
}
