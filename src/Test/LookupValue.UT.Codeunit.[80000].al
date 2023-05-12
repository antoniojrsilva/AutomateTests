codeunit 80000 "LooupValue UT Customer"
{
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
        //[FEATURE] LookupValue UT Customer
    end;

    [Test]
    procedure AssignLookupValueToCustomer()
    var
        Customer: Record Customer;
        lcl_LookupValue: Code[20];
    begin
        //[SCENARIO #0001] Assign lookup value to customer
        //[GIVEN] Lookup Value
        lcl_LookupValue := CreateaLookupValueCode();
        //[GIVEN] Customer
        CreateCustomer(Customer);
        //[WHEN] Set lookup value on customer
        SetLookupValueOnCustomer(Customer, lcl_LookupValue);
        //[THEN] Customer has lookup value code field populated
        VerifyLookupValueOnCustomer(Customer."No.", lcl_LookupValue);
    end;

    // [Test]
    // procedure AssignNonExistingLookupValueToCustomer()
    // var
    //     Customer: Record Customer;
    //     lcl_LookupValue: Code[20];
    // begin
    //     //[SCENARIO #0002] Assign non-existing lookup value to Customer
    //     //[GIVEN] Non-existing lookup value
    //     lcl_LookupValue := 'WRONGCODE';
    //     //[GIVEN] Customer

    //     //[WHEN] Set no-existing lookup value on Customer
    //     //[THEN] Non existing lookup value error thrown
    // end;

    local procedure CreateaLookupValueCode(): Code[20]
    var
        LookupValue: Record LookupValue;
        LibraryUtility: Codeunit "Library - Utility";
    begin
        LookupValue.Init();
        LookupValue.Validate(Item, LibraryUtility.GenerateRandomCode20(LookupValue.FieldNo(Item), Database::LookupValue));
        LookupValue.Validate(Description, 'Code -> ' + LookupValue.Item);
        LookupValue.Insert();
        exit(LookupValue.Item);
    end;

    local procedure CreateCustomer(var Customer: Record Customer)
    var
        LibrarySales: Codeunit "Library - Sales";
    begin
        LibrarySales.CreateCustomer(Customer);
    end;

    local procedure SetLookupValueOnCustomer(var Customer: Record Customer; LookupValue: Code[20])
    begin
        Customer.Validate(LookupValue, LookupValue);
        Customer.Modify()
    end;

    local procedure VerifyLookupValueOnCustomer(CustomerNo: Code[20]; LookupValueCode: Code[20])
    var
        Customer: Record Customer;
        Assert: Codeunit "Library Assert";
        FieldOnTableTxt: Label '%1 on %2';
    begin
        Customer.Get(CustomerNo);
        Assert.AreEqual(LookupValueCode, Customer.LookupValue, StrSubstNo(FieldOnTableTxt, Customer.FieldCaption(LookupValue), Customer.TableCaption()));
    end;
}