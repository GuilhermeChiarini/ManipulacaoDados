# ManipulacaoDados
Manipulação de dados e persistência em base de dados relacional

1. [Installation](#1-installation)
2. [Usage](2-usage)
3. [Configuration](#3-configuration)

## 1. Installation

1. Require the package using composer:

    ```
    composer require jeroennoten/laravel-adminlte
    ```

2. Add the service provider to the `providers` in `config/app.php`:

    ```php
    JeroenNoten\LaravelAdminLte\ServiceProvider::class,
    ```

3. Publish the public assets:

    ```
    php artisan vendor:publish --provider="JeroenNoten\LaravelAdminLte\ServiceProvider" --tag=assets
    ```
