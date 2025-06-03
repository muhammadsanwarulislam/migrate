<?php

namespace App\Repositories;

class DomainRepository extends BaseRepository
{
    protected function getTableName(): string
    {
        return 'domains';
    }

    protected function filterData(array $data): array
    {
        return array_filter($data, function ($row) {
            // Example: Exclude test domains and inactive domains
            return stripos($row['name'], 'test') === false &&
                   ($row['status'] ?? 'active') === 'active';
        });
    }
}