<?php

use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\DailyReportController;
use App\Http\Controllers\Api\V1\DashboardController;
use App\Http\Controllers\Api\V1\IncidentController;
use App\Http\Controllers\Api\V1\MeterReadingController;
use App\Http\Controllers\Api\V1\PlantController;
use App\Http\Controllers\Api\V1\PowerPlantController;
use Illuminate\Support\Facades\Route;

// ทุกเส้นทางในกลุ่มนี้จะขึ้นต้นด้วย /api/v1/ อัตโนมัติ
Route::prefix('v1')->group(function () {

    // ── Route สาธารณะ (ไม่ต้องล็อกอิน) ─────────────────────────────
    Route::get('/health', fn () => response()->json([
        'status' => 'ok',
        'app'    => 'EDL-Gen Monitoring API',
    ]));

    // Lab 1.1 - ทดสอบ API Versioning
    Route::get('/ping', fn () => response()->json([
        'service' => 'EDL-Gen Monitoring API',
        'version' => 'v1',
        'time'    => now()->toIso8601String(),
    ]));

    // Login (Day 1 ใช้ /login, Day 5 ใช้ /auth/login - ชี้ Controller เดียวกัน)
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/auth/login', [AuthController::class, 'login']);

    // ── Route ที่ต้องมี Sanctum Token ───────────────────────────────
    Route::middleware('auth:sanctum')->group(function () {

        // Auth (alias ทั้งสองแบบ)
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/me', [AuthController::class, 'me']);
        Route::post('/refresh', [AuthController::class, 'refresh']);
        Route::post('/auth/logout', [AuthController::class, 'logout']);
        Route::get('/auth/me', [AuthController::class, 'me']);
        Route::post('/auth/refresh', [AuthController::class, 'refresh']);

        // Day 1: โรงไฟฟ้าเต็มรูปแบบ (Repository Pattern + Resource + Pagination)
        Route::apiResource('power-plants', PowerPlantController::class)
            ->only(['index', 'show']);

        // Day 3: Dashboard summary + รายการโรงไฟฟ้าแบบย่อ
        Route::get('/dashboard/summary', [DashboardController::class, 'summary']);
        Route::get('/plants', [PlantController::class, 'index']);
        Route::get('/plants/{id}', [PlantController::class, 'show']);

        // Day 5 Feature 3: รายงานการผลิตรายวัน (+ Filter)
        Route::get('/reports/daily', [DailyReportController::class, 'index']);

        // Day 5 Feature 4: แจ้งเหตุขัดข้อง (รูป + GPS + Notification)
        Route::get('/incidents', [IncidentController::class, 'index']);
        Route::post('/incidents', [IncidentController::class, 'store']);
        Route::get('/incidents/{incident}', [IncidentController::class, 'show']);
        Route::patch('/incidents/{incident}', [IncidentController::class, 'update']);

        // Day 5 Feature 5: บันทึกค่ามิเตอร์ (Optimistic Update + 409 dedup)
        Route::get('/meter-readings/today', [MeterReadingController::class, 'today']);
        Route::post('/meter-readings', [MeterReadingController::class, 'store']);
    });
});
