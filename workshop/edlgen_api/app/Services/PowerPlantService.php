<?php

namespace App\Services;

use App\Repositories\Contracts\PowerPlantRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class PowerPlantService
{
    public function __construct(
        private readonly PowerPlantRepositoryInterface $repository,
    ) {}

    public function listForDashboard(int $perPage): LengthAwarePaginator
    {
        return $this->repository->paginateWithIncidentCount($perPage);
    }
}
