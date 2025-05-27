<?php

namespace App\Listeners;

use App\Jobs\MigrateDataJob;
use Illuminate\Support\Facades\Log;
use App\Events\DataMigrationRequested;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class FilterDataMigration
{
    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(DataMigrationRequested $event)
    {
        $filteredData = [];

        // Example filtering for 'users' table
        if ($event->table === 'users') {
            foreach ($event->data as $row) {
                // Skip test/dummy data (e.g., name contains 'test' or email contains 'test')
                if (
                    stripos($row['name'], 'test') === false &&
                    stripos($row['email'], 'test') === false
                ) {
                    $filteredData[] = [
                        'name' => $row['name'],
                        'email' => $row['email'],
                        'password' => $row['password'], // Ensure passwords are hashed if needed
                        'created_at' => $row['created_at'] ?? now(),
                        'updated_at' => $row['updated_at'] ?? now(),
                    ];
                }
            }
        }
        // Log filtered data count
        Log::info("Filtered {$event->table} data: " . count($filteredData) . " records");

        // Dispatch filtered data to queue for insertion
        MigrateDataJob::dispatch($event->table, $filteredData)->onQueue('migration');
    }
}
