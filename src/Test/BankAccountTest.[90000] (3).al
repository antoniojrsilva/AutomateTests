Codeunit 90000 "BankAccountTest"
{
    SubType = Test;
    TestPermissions = Disabled;

    Trigger OnRun()
    begin
        //[FEATURE] Bank Account Test
    end;

    [Test]
    procedure SortCodewithonly6digits()
    var
        BankAccount: Record "Bank Account";
        SortCode: Code[20];
    begin
        //[SCENARIO] Sort Code with only 6 digits
        //[Given]Creat Bank Account
        CreatBankAccount(BankAccount);
        //[When]Fill Sort Code more 6 digits
        asserterror FillSortCodemore6digits(BankAccount, SortCode);
        //[When]Fill Sort Code less 6 digits
        asserterror FillSortCodeless6digits(BankAccount, SortCode);
        //[When]Fill Sort Code 6 no digits
        asserterror FillSortCode6nodigits(BankAccount, SortCode);
        //[When]Fill Sort Code 6 digits
        FillSortCode6digits(BankAccount, SortCode);
    end;

    local procedure CreatBankAccount(var BankAccount: Record "Bank Account")
    var
        LibraryERM: Codeunit "Library - ERM";

    begin
        LibraryERM.CreateBankAccount(BankAccount);
    end;

    local procedure FillSortCodemore6digits(var BankAccount: Record "Bank Account"; var SortCode: Code[20])
    var
        LibraryUtility: Codeunit "Library - Utility";

    begin
        SortCode := LibraryUtility.GenerateRandomNumericText(10);
        BankAccount.Validate("Bank Branch No.", SortCode);
        BankAccount.Modify(true);
    end;

    local procedure FillSortCodeless6digits(var BankAccount: Record "Bank Account"; var SortCode: Code[20])
    var
        LibraryUtility: Codeunit "Library - Utility";

    begin
        SortCode := LibraryUtility.GenerateRandomNumericText(4);
        BankAccount.Validate("Bank Branch No.", SortCode);
        BankAccount.Modify(true);
    end;

    local procedure FillSortCode6nodigits(var BankAccount: Record "Bank Account"; var SortCode: Code[20])
    var
        LibraryUtility: Codeunit "Library - Utility";

    begin
        SortCode := LibraryUtility.GenerateRandomText(6);
        BankAccount.Validate("Bank Branch No.", SortCode);
        BankAccount.Modify(true);
    end;

    local procedure FillSortCode6digits(var BankAccount: Record "Bank Account"; var SortCode: Code[20])
    var
        LibraryUtility: Codeunit "Library - Utility";

    begin
        SortCode := LibraryUtility.GenerateRandomNumericText(6);
        BankAccount.Validate("Bank Branch No.", SortCode);
        BankAccount.Modify(true);

    end;
}
