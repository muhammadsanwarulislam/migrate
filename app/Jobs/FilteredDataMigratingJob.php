<?php

namespace App\Jobs;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;

class FilteredDataMigratingJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $table;
    protected $data;

    public function __construct($table, $data)
    {
        $this->table = $table;
        $this->data = $data;
    }

    public function handle()
    {
        try {
            // Insert data in chunks to avoid memory issues
            collect($this->data)->chunk(100)->each(function ($chunk) {
                DB::table($this->table)->updateOrInsert(['id' => $chunk->first()->id],$chunk->toArray());
            });

            Log::info("Successfully migrated {$this->table} data: " . count($this->data) . " records");
        } catch (\Exception $e) {
            Log::error("Error migrating {$this->table} data: " . $e->getMessage());
            $this->fail($e);
        }
    }
}
