<?php

namespace App\Repositories;

use Illuminate\Support\Facades\DB;
use App\Events\DataMigrationRequested;

abstract class BaseRepository
{
    protected $connection = 'old_db';
    protected $chunkSize = 100;

    /**
     * Get the table name (to be implemented by child classes).
     *
     * @return string
     */
    abstract protected function getTableName(): string;

    /**
     * Define custom filtering logic for the table data (to be implemented by child classes).
     *
     * @param array $data
     * @return array
     */
    abstract protected function filterData(array $data): array;

    /**
     * Process the table data in chunks and dispatch events.
     *
     * @param callable $callback
     * @return void
     */
    public function processInChunks(callable $callback)
    {
        $table = $this->getTableName();

        DB::connection($this->connection)
            ->table($table)
            ->orderBy('id')
            ->chunk($this->chunkSize, function ($rows) use ($callback, $table) {
                $data = $rows->map(function ($row) {
                    return (array) $row;
                })->toArray();

                $filteredData = $this->filterData($data);

                // Dispatch event with filtered data
                event(new DataMigrationRequested($table, $filteredData));

                // Call the callback for logging or additional processing
                $callback($table, count($filteredData));
            });
    }
}