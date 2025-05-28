## Database Migrator
This Laravel project provides a robust solution for migrating data from an old database to a new, simplified database schema. It filters out test or dummy data during migration using Laravel's events, listeners, and queues for efficient and scalable data processing. A dummy users table is included for testing the migration process.
Features

- Scalable Data Migration: Handles large datasets across (n+1) tables by processing data in chunks (1000 rows per chunk) to prevent memory issues.
- Test/Dummy Data Filtering: Excludes test or dummy data based on configurable criteria (e.g., names/emails containing "test" or is_test flag).
- Asynchronous Processing: Utilizes Laravel queues (e.g., Redis or database driver) to process data migrations asynchronously, ensuring performance and reliability.
- Event-Driven Architecture: Leverages Laravel events and listeners to modularize data filtering and processing logic.
- Error Handling and Logging: Includes comprehensive logging for migration progress and errors, stored in storage/logs/laravel.log.
- Dummy Data for Testing: Provides a sample users table with 20 records (11 valid, 9 test/dummy) to test the migration and filtering logic.
- Customizable: Easily extendable to support additional tables and custom filtering rules for each table's schema.

## Prerequisites

- PHP 8.1 or higher
- Laravel 11.x or 12.x
- MySQL (or another supported database) for both old and new databases
- Redis (recommended) or database queue driver for queue processing
- Composer for dependency management

## Installation
Follow these steps to set up the project locally:

Clone the Repository
git clone <repository-url>
cd migrate


Install Dependencies
Install PHP dependencies using Composer:
composer install


Configure Environment
Copy the .env.example file to .env and update it with your database credentials for both the old and new databases:
# Old database (source)
```
OLD_DB_HOST=127.0.0.1
OLD_DB_PORT=3306
OLD_DB_DATABASE=old_database
OLD_DB_USERNAME=root
OLD_DB_PASSWORD=
```

# New database (destination)
```
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=new_database
DB_USERNAME=root
DB_PASSWORD=
```

# Queue configuration (recommended: redis)
```
QUEUE_CONNECTION=redis / database
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379
```


## Set Up Queue Driver
If using the database queue driver, create the jobs table:
```
php artisan queue:table
php artisan migrate
```

For Redis, ensure the Redis server is running and configured in .env.

Run Migrations for New Database
Create the schema for the new database (e.g., users table):
```
php artisan migrate
```

## Usage

Start the Queue Worker
```
Run the queue worker to process migration jobs:
php artisan queue:work --queue=migration
```
Run this in a separate terminal or as a background process.

Execute the migration command to process data from the old database to the new database:
```
php artisan migrate:database
```
- Reads data from each table in the old database (configured in MigrateDatabase.php).
- Dispatches a DataMigrationRequested event for filtering.
- Filters out test/dummy data using the FilterDataMigration listener.
- Queues filtered data for insertion into the new database via MigrateDataJob.

## Monitor Logs
Check storage/logs/laravel.log for migration progress and error details.


Testing the Migration
To test the migration with the dummy users table:

Ensure the dummy data is seeded in the old_db database (see Installation step 6).

Run the migration command:
```
php artisan migrate:database
```


Verify the new_database.users table contains only non-test records (e.g., 11 records out of 20, excluding those with is_test = 1 or "test"/"dummy" in name/email).


Use the following SQL query to check:
```
SELECT * FROM new_database.users;
```

Extending to Additional Tables
To migrate additional tables (up to 120):

Create Migrations: Generate migrations for each table in the new database:
php artisan make:migration create_<table_name>_table


Update Filtering Logic: Modify the FilterDataMigration listener (app/Listeners/FilterDataMigration.php) to include filtering rules for each new table. Example:
```
if ($event->table === 'orders') {
    foreach ($event->data as $row) {
        if (stripos($row['name'], 'test') === false && stripos($row['email'], 'test') === false) {
            $filteredData[] = [
                'user_id' => $row['user_id'],
                'description' => $row['description'],
                'amount' => $row['amount'],
                'created_at' => $row['created_at'] ?? now(),
                'updated_at' => $row['updated_at'] ?? now(),
            ];
        }
    }
}
```

**Add Tables to Command:** Update the ```$tables array in app/Console/Commands/MigrateDatabase.php`` to include new table names:
```protected $tables = ['users',  /* add other tables */];```


**Test with Dummy Data: Create migrations and seeders for additional tables in the old_db database, similar to the users table setup.**


## Troubleshooting

- **Queue Jobs Failing:** Check storage/logs/laravel.log for errors. Ensure the queue worker is running and the queue driver is properly configured.
- **Database Connection Issues:** Verify database credentials in .env and ensure both databases are accessible.
- **Memory Issues:** Adjust the chunk size in MigrateDatabase.php (default: 1000 rows) if processing large tables causes memory exhaustion.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for suggestions or bug reports.
