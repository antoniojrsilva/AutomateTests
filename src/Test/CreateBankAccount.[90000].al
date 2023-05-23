Codeunit 90000 "Create Bank Account"
{
    SubType = Test;
    TestPermissions = Disabled;

    [Test]
    procedure EnterSortNumber()
    var
        BankAccount: Record "Bank Account";
        SortCode: Text[50];
    begin
        //[SCENARIO] Enter Bank Sort Code as 6 digits number
        //[Given]Generate Bank Account
        CreateBankAccount(BankAccount);
        //[Given]Generate Sort Code
        GenerateSortCode(SortCode);
        //[When]Assign Sort Code to Bank Account
        AssignSortCode(BankAccount, SortCode);
        //[Then]Verify Field receive 6 digits
        VerifySorteCodeOnBankAccount(BankAccount, SortCode);
    end;

    local procedure CreateBankAccount(var BankAccount: Record "Bank Account")
    var
        Bank: Codeunit "Library - ERM";
    begin
        CreateBankAccount(BankAccount);
    end;

    local procedure GenerateSortCode(var SortCode: Text[50])
    var
        Library4PS: Codeunit "Library-4PSUK-Cash Management";
    begin
        Library4PS.GenerateBankSortCode(SortCode, 6);
    end;

    local procedure AssignSortCode(var BankAccount: Record "Bank Account"; SortCode: Text[50])
    begin
        BankAccount.Validate("Bank Branch No.", SortCode);
    end;

    local procedure VerifySorteCodeOnBankAccount(var BankAccount: Record "Bank Account"; SortCode: Text[50])
    var
        Assert: Codeunit "Library Assert";
        Error01: Label 'Sort Code %1 in Bank Account is different from %2 generated';
    begin
        Assert.AreEqual(BankAccount."Bank Branch No.", SortCode, StrSubstNo(Error01, BankAccount."Bank Branch No.", SortCode));
    end;
}