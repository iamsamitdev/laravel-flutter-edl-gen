<?php

namespace Database\Factories;

use App\Models\PowerPlant;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<PowerPlant>
 */
class PowerPlantFactory extends Factory
{
    protected $model = PowerPlant::class;

    public function definition(): array
    {
        return [
            'name'        => 'Plant '.fake()->unique()->numberBetween(1, 999),
            'code'        => 'PL'.fake()->unique()->numberBetween(100, 999),
            'type'        => fake()->randomElement(['hydro', 'solar', 'thermal']),
            'capacity_mw' => fake()->randomFloat(2, 20, 700),
            'province'    => fake()->randomElement(['Vientiane', 'Champasak', 'Bolikhamxay', 'Savannakhet']),
            'is_active'   => true,
        ];
    }
}
