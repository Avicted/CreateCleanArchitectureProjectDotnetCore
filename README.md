# Clean Architecture Template for Dotnet Core
This is the most basic template for Clean Architecture in Dotnet Core.
It let's you start from scratch with a clean architecture in mind.


## Project Dependency Tree:

1. **Core Project** (AppName.Core)

    Description: Contains core entities and interfaces.
    References:
        **None**

2. **UseCases Project** (AppName.UseCases)

    Description: Contains application services and business logic.
    References:
        **AppName.Core** (for entities and interfaces)

3. **Infrastructure Project** (AppName.Infrastructure)

    Description: Implements data access, repositories, and database configuration.
    References:
        **AppName.Core** (for entities and interfaces)
        **AppName.UseCases** (optional, if services need to be used)

4. **Web Project** (AppName.Web)

    Description: Provides API endpoints and application configuration.
    References:

    - **AppName.Core** (for entities and possibly DTOs)
    - **AppName.UseCases** (to access application services)
    - **AppName.Infrastructure** (for data access and repositories)

---


For a more advanced template, please check out [Ardalis: Clean Architecture](https://github.com/ardalis/CleanArchitecture)