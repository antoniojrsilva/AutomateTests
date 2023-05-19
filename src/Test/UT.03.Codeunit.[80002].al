codeunit 80002 "Unit Test 03"
{
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
        //[FEATURE] LookupValue Sales Arquive
    end;

    [Test]
    procedure ArchivesalesOrderWithLookupValue()
    begin
        //[SCENARIO] Archive Sales Order with lookup value
        //[GIVEN] Sales Order with lookup value
        //[WHEN] Sales Order is archived
        //[THEN] Archive sales order has lookup from sales order
    end;
}