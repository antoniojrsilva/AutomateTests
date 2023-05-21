codeunit 80004 "Test Unit 04"
{
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
        //[FEATURE] Lookup Value Sales Archive
    end;

    [Test]
    procedure ArchiveSalesDocumentWithLookupValue()
    begin
        //[SCENARIO #0018] Archive sales order with lookup value
        //[GIVEN] Sales order with lookup value
        CreateSalesDocumentWithLookupValue(SalesHeader);
        //[WHEN] Sales Order is Archived
        ArchiveSalesOrderDocument(SalesHeader);
        //[THEN] Archived sales order has lookup value from sales order
        VerifyLookupValueOnSalesDocumentArchive(SalesHeader);
    end;

    local procedure CreateSalesDocumentWithLookupValue(var SalesHeard: Record "Sales Header")
    begin
    end;

    local procedure ArchiveSalesOrderDocument(var SalesHeard: Record "Sales Header")
    begin
    end;

    local procedure VerifyLookupValueOnSalesDocumentArchive(var SalesHeard: Record "Sales Header")
    begin
    end;

    var
        SalesHeader: Record "Sales Header";
}