CREATE PROCEDURE OrchestratePopulateTables
AS
BEGIN
    SET NOCOUNT ON;

    EXEC PopulateDimensionTables;

    EXEC PopulateFactTable;

    SET NOCOUNT OFF;
END
GO