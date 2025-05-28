<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Repositories\UserRepository;

class MigrateDatabase extends Command
{
    protected $signature = 'migrate:database';
    protected $description = 'Migrate data from old database to new database with filtering';

    protected $userRepository;

    public function __construct(UserRepository $userRepository)
    {
        parent::__construct();
        $this->userRepository = $userRepository;
    }

    public function handle()
    {
        $this->info('Starting database migration...');

        $this->userRepository->processInChunks(function ($table, $count) {
            $this->info("Dispatched migration jobs for {$table} with {$count} records");
        });

        $this->info('Database migration completed.');
    }
}