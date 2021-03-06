- [System.Data](https://docs.microsoft.com/en-us/dotnet/api/system.data): Provides access to classes that represent the ADO.NET architecture. ADO.NET lets you build components that efficiently manage data from multiple data sources.
    - DataSet: Represents an in-memory cache of data.
    - DataTable
    - DataColumn
    - DataRow
- [System.Data.Common](https://docs.microsoft.com/en-us/dotnet/api/system.data.common):Contains classes shared by .NET data providers.
    - DataAdapter: Represent a set of SQL commands and a database connection that are used to fill `DataSet(DataAdapter.FillAsync(DataSet))`and update the data source.
    - DBCommand