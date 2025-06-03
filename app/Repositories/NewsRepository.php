<?php

namespace App\Repositories;

class NewsRepository extends BaseRepository
{
    protected function getTableName(): string
    {
        return 'news';
    }

    protected function filterData(array $data): array
    {
        return array_filter($data, function ($row) {
            // Example: Exclude draft news or test titles
            return stripos($row['title'], 'test') === false &&
                   ($row['status'] ?? 'published') !== 'draft';
        });
    }
}