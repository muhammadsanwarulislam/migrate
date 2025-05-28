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
                stripos($row['name'], 'test') === false &&
                stripos($row['email'], 'test') === false &&
                !isset($row['is_test']) || $row['is_test'] == 1
            ) {
                $filteredData[] = $row;
            }
        }

        return $filteredData;
    }
}