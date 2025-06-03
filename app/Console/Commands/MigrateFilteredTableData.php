<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Repositories\NewsRepository;
use App\Repositories\UserRepository;
use App\Repositories\DomainRepository;

class MigrateFilteredTableData extends Command
{
    protected $signature = 'migrate:table {table? : The table to migrate (e.g., users, domains, news)}';
    protected $description = 'Migrate filtered table data';

    protected $repositories = [
        'users' => UserRepository::class,
        'domains' => DomainRepository::class,
        'news' => NewsRepository::class,
    ];

    public function handle()
    {
        $table = $this->argument('table');
        $tables = $table ? [$table] : array_keys($this->repositories);

        $this->info('Starting data migration...');

        foreach ($tables as $tbl) {
            if (!array_key_exists($tbl, $this->repositories)) {
                $this->error("No repository defined for table: {$tbl}");
                continue;
            }

            $repositoryClass = $this->repositories[$tbl];
            $repository = app($repositoryClass);

            if (!$this->tableExists($tbl)) {
                $this->error("Table {$tbl} does not exist in the old database.");
                continue;
            }

            $this->info("Processing table: {$tbl}");
            $repository->processInChunks(function ($table, $count) {
                $this->info("Dispatched migration jobs for {$table} with {$count} records");
            });
        }

        $this->info('Data migration completed.');
    }

    protected function tableExists($table)
    {
        return \Illuminate\Support\Facades\DB::connection('old_db')->getSchemaBuilder()->hasTable($table);
    }
}
