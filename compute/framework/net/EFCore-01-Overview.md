https://docs.microsoft.com/en-us/ef/core/
## Definition & Function
Entity Framework(EF) Core is a lightweight, extensble, open source and cross-platform version of the popular Entity Framework data access technology.
+ EF Core can serve as an object-releational mapper (O/RM), which:
  - Enable .NET developers to work with a database using .NET object.
  - Eliminates the need for most of the data-access code that typically need to be written.

## Includes
+ Use migrations to construct DataBase Schema.(EF Core provides two primary ways of keeping the EF Core model and DataBase schema in sync.To chooses betwwen the two, decide whether your EF Core or DataBase is the source of truth.)
+ Create Model.
+ Save and Query data.

## Migration
+ Use here that your application is going to **production**. you need a way to safely evolve the schema without dropping the entire databases.

## The model
With EF Core, data access is performed using a model,. A model is made up of entity classed and a context object that represents a session with the database.  
The context object allows **querying and saving data**.  
EF supports the following model development approaches:
+ Generate a model from an existing database.
+ Hand code a model to match the database.
+ Once a model is created, Use [EF Migrations](https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/?tabs=dotnet-core-cli) to create a database from the model.Migration allow evolving the database as the model changes.
