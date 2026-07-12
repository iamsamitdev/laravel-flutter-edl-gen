<?php

namespace App\Repositories\Contracts;

use App\Models\PowerPlant;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface PowerPlantRepositoryInterface
{
    /** ดึงรายการโรงไฟฟ้าแบบแบ่งหน้า พร้อมจำนวนเหตุขัดข้องที่ยังไม่ปิด */
    public function paginateWithIncidentCount(int $perPage = 15): LengthAwarePaginator;

    /** ดึงโรงไฟฟ้ารายตัว พร้อมค่าการอ่านล่าสุด */
    public function findWithLatestReadings(int $id, int $readingLimit = 10): ?PowerPlant;

    /** สร้างโรงไฟฟ้าใหม่ */
    public function create(array $attributes): PowerPlant;

    /** บันทึกค่าการอ่าน + อัปเดตสถานะโรงไฟฟ้าใน Transaction เดียว */
    public function storeReadingWithStatus(int $plantId, array $reading): PowerPlant;
}
