<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\V1\PowerPlantResource;
use App\Repositories\Contracts\PowerPlantRepositoryInterface;
use App\Services\PowerPlantService;
use Illuminate\Http\Request;

class PowerPlantController extends Controller
{
    public function __construct(
        private readonly PowerPlantService $service,
        private readonly PowerPlantRepositoryInterface $repository,
    ) {}

    /**
     * GET /api/v1/power-plants
     * รายการโรงไฟฟ้าแบบแบ่งหน้า พร้อม open_incidents_count
     */
    public function index(Request $request)
    {
        $plants = $this->service->listForDashboard(
            perPage: (int) $request->query('per_page', 15),
        );

        return PowerPlantResource::collection($plants);
    }

    /**
     * GET /api/v1/power-plants/{id}
     * โรงไฟฟ้ารายตัว พร้อมค่าการอ่านล่าสุด 10 รายการ
     */
    public function show(int $id)
    {
        $plant = $this->repository->findWithLatestReadings($id);

        abort_if($plant === null, 404, 'ไม่พบโรงไฟฟ้าที่ต้องการ');

        return new PowerPlantResource($plant);
    }
}
