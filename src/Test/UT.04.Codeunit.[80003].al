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
        CreateSalesDocumentWithLookupValue();
        //[WHEN] Sales Order is Archived
        //[THEN] Archived sales order has lookup value from sales order
    end;

    local procedure CreateSalesDocumentWithLookupValue()
    begin

    end;
}