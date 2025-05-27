<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use App\Events\DataMigrationRequested;

class MigrateDatabase extends Command
{
    protected $signature = 'migrate:database';
    protected $description = 'Migrate data from old database to new database with filtering';

    public function handle()
    {
        $this->info('Starting database migration...');

        // List of tables to migrate (extend this for all 120 tables)
        $tables = ['users']; // Add other table names here
        foreach ($tables as $table) {
            // Fetch data from old database in chunks
            DB::connection('old_db')->table($table)
                ->orderBy('id')
                ->chunk(10, function ($rows) use ($table) {
                    // Convert rows to array for event
                    $data = $rows->map(function ($row) {
                        return (array) $row;
                    })->toArray();

                    // Dispatch event for filtering
                    event(new DataMigrationRequested($table, $data));
                });

            $this->info("Dispatched migration jobs for {$table}");
        }

        $this->info('Database migration completed.');
    }
}