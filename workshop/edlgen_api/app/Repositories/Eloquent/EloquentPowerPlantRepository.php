<?php

namespace App\Repositories\Eloquent;

use App\Models\PowerPlant;
use App\Repositories\Contracts\PowerPlantRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class EloquentPowerPlantRepository implements PowerPlantRepositoryInterface
{
    public function paginateWithIncidentCount(int $perPage = 15): LengthAwarePaginator
    {
        return PowerPlant::query()
            ->withCount(['incidents' => fn ($q) => $q->where('status', '!=', 'resolved')])
            ->orderBy('name')
            ->paginate($perPage);
    }

    public function findWithLatestReadings(int $id, int $readingLimit = 10): ?PowerPlant
    {
        return PowerPlant::query()
            ->with(['readings' => fn ($q) => $q->latest('recorded_at')->limit($readingLimit)])
            ->find($id);
    }

    public function create(array $attributes): PowerPlant
    {
        return PowerPlant::create($attributes);
    }

    public function storeReadingWithStatus(int $plantId, array $reading): PowerPlant
    {
        return DB::transaction(function () use ($plantId, $reading) {
            $plant = PowerPlant::lockForUpdate()->findOrFail($plantId);
            $plant->readings()->create($reading);
            $plant->update(['is_active' => $reading['output_mw'] > 0]);

            return $plant->refresh();
        });
    }
}
