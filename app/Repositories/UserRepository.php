<?php

namespace App\Repositories;

class UserRepository extends BaseRepository
{
    protected function getTableName(): string
    {
        return 'users';
    }

    protected function filterData(array $data): array
    {
        $filteredData = [];

        foreach ($data as $row) {
            // Skip test/dummy data (e.g., name contains 'test' or is_test flag)
            if (
                strpos($row['name'], 'test') === false && 
                strpos($row['email'], 'test') === false && 
                $row['is_test'] !== 1
                ) {
                $filteredData[] = $row;
            }
        }

        return $filteredData;
    }
}