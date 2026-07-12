<?php

namespace App\Providers;

use App\Repositories\Contracts\PowerPlantRepositoryInterface;
use App\Repositories\Eloquent\EloquentPowerPlantRepository;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        // Repository Pattern: ผูก Interface กับ Implementation จริง
        // สลับ Database Driver ได้โดยไม่แตะ Service/Controller (Day 1 Module 4)
        $this->app->bind(
            PowerPlantRepositoryInterface::class,
            EloquentPowerPlantRepository::class,
        );
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
