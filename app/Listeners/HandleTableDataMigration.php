<?php

namespace App\Listeners;

use App\Jobs\FilteredDataMigratingJob;
use Illuminate\Support\Facades\Log;
use App\Events\TableDataFiltered;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class HandleTableDataMigration
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
    public function handle(TableDataFiltered $event)
    {
        // Log filtered data count
        Log::info("Filtered {$event->table} data: " . count($event->data) . " records");

        // Dispatch filtered data to queue for insertion
        if(!empty($event->data)) {
            FilteredDataMigratingJob::dispatch($event->table, $event->data)->onQueue('migration');
        }
    }
}
