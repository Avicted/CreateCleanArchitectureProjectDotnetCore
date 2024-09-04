#!/bin/bash

# Script to set up a Clean Architecture solution in .NET Core

# Function to display help
function display_help() {
    echo "Usage: $0 [options]"
    echo
    echo "This script sets up a Clean Architecture solution in .NET Core."
    echo
    echo "Options:"
    echo "  -h, --help        Show this help message and exit"
    echo
    echo "Example:"
    echo "  $0"
    exit 0
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    display_help
fi

# Prompt the user for the project name
read -p "Enter the project name: " project_name

# Create a new solution
dotnet new sln -n $project_name

# Create projects for each layer
dotnet new classlib -n $project_name.Core
dotnet new classlib -n $project_name.Infrastructure
dotnet new classlib -n $project_name.UseCases
dotnet new webapi -n $project_name.Web

# Add projects to the solution
dotnet sln $project_name.sln add $project_name.Core/$project_name.Core.csproj
dotnet sln $project_name.sln add $project_name.Infrastructure/$project_name.Infrastructure.csproj
dotnet sln $project_name.sln add $project_name.UseCases/$project_name.UseCases.csproj
dotnet sln $project_name.sln add $project_name.Web/$project_name.Web.csproj

# Set up project references
dotnet add $project_name.Web/$project_name.Web.csproj reference $project_name.UseCases/$project_name.UseCases.csproj
dotnet add $project_name.UseCases/$project_name.UseCases.csproj reference $project_name.Core/$project_name.Core.csproj
dotnet add $project_name.UseCases/$project_name.UseCases.csproj reference $project_name.Infrastructure/$project_name.Infrastructure.csproj

# Optional: Add basic DI setup in the Web project (Startup.cs)
startup_file="$project_name.Web/Startup.cs"

# Add service registration for UseCases and Infrastructure in Startup.cs
if grep -q "public void ConfigureServices(IServiceCollection services)" $startup_file; then
    sed -i '/public void ConfigureServices(IServiceCollection services)/a \
    \    // Register UseCase services\n\
    \    // services.AddScoped<IYourService, YourService>();\n\
    \n\
    \    // Register Infrastructure services\n\
    \    // services.AddScoped<IYourRepository, YourRepository>();\n\
    \ ' $startup_file
else
    echo "Unable to find ConfigureServices method in Startup.cs"
fi

# Run the project to verify everything is set up correctly
dotnet run --project $project_name.Web/$project_name.Web.csproj

echo "Clean Architecture setup complete for project: $project_name"

