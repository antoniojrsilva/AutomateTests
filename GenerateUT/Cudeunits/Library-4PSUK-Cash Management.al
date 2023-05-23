codeunit 99999 "Library-4PSUK-Cash Management"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure GenerateBankSortCode(var SortCode: Text[50]; lenght: Integer)
    begin
        SortCode := Utils.GenerateRandomNumericText(lenght);
    end;

    procedure SetSortCodeOnBank(var BankAccount: Record "Bank Account"; SortCode: Text[50])
    begin
        BankAccount.Validate("Bank Branch No.", SortCode);
        BankAccount.Modify();
    end;

    var
        TypeHelp: Codeunit "Type Helper";
        Assert: Codeunit "Library Assert";
        Utils: Codeunit "Library - Utility";
}