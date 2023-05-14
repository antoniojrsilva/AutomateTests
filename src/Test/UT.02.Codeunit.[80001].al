codeunit 80001 "Unit Test 02"
{
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
        //[FEATURE] Add Lookup Value to other tables
    end;

    [Test]
    procedure AssignLookupValueToSalesHeader()
    var
        SalesHeader: Record "Sales Header";
        lcl_LookupValue: Code[20];
        lcl_CustomerNo: Code[20];
    begin
        //[SCENARIO #0004] Assign lookup value to Sales Header
        //[GIVEN] Create a new Lookup Value
        lcl_LookupValue := CreateNewLookupValue();
        //[GIVEN] Create a new Sales Header
        lcl_CustomerNo := CreateNewSalesHeader(SalesHeader);
        //[WHEN] Set new Lookup to new Sales Header
        SetLookupValueOnSalesHeader(SalesHeader, lcl_LookupValue);
        //[THEN] Sales Header has lookup value code field populated  
        VerifyLookupValueOnSalesHeader(SalesHeader, lcl_LookupValue);
    end;

    procedure AssignNonExistingLookuponSalesOrder(var SalesHeader: Record "Sales Header")
    var

    begin
        //[SCENARIO #0005] Assign non-existing lookup value on Sales Header
    end;

    local procedure CreateNewLookupValue(): Code[20]
    var
        LookupValue: Record LookupValue;
        LibraryUtility: Codeunit "Library - Utility";
    begin
        LookupValue.Init();
        LookupValue.Validate(Item, LibraryUtility.GenerateRandomCode20(LookupValue.FieldNo(Item), Database::LookupValue));
        LookupValue.Validate(Description, 'Sales Header -> ' + LookupValue.Item);
        LookupValue.Insert()
    end;

    local procedure CreateNewSalesHeader(var SalesHeader: Record "Sales Header"): Code[20]
    var
        LibrarySales: Codeunit "Library - Sales";
        Customer: Record Customer;
    begin
        LibrarySales.CreateCustomer(Customer);
        LibrarySales.CreateSalesHeader(SalesHeader, SalesHeader."Document Type"::Order, Customer."No.");
        exit(Customer."No.")
    end;

    local procedure SetLookupValueOnSalesHeader(SalesHeader: Record "Sales Header"; lcl_LookupValue: Code[20])
    begin
        SalesHeader.Validate(Lookupvalue, lcl_LookupValue);
        SalesHeader.Modify();
    end;

    local procedure VerifyLookupValueOnSalesHeader(var SalesHeader: Record "Sales Header"; lcl_lookupValue: Code[20])
    var
        Assert: Codeunit "Library Assert";
        lbl_Error: Label '%1 on %2';
    begin
        Assert.AreEqual(lcl_lookupValue, SalesHeader.Lookupvalue, StrSubstNo(lbl_Error, SalesHeader.FieldCaption(Lookupvalue), SalesHeader.TableCaption()));
    end;
}