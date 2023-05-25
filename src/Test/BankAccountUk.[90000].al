Codeunit 90000 "BankAccountUk"
{
	SubType = Test;
	TestPermissions = Disabled;

	Trigger OnRun()
	begin
		//[FEATURE] Test Bank Account for UK
	end;

	[Test]
	procedure SortCodeUK()
	var
		BankAccountCard: Page "Bank Account Card";
		BankAccountTable: Record "Bank Account";
		SortNumber: Code[20];
	begin
		//[SCENARIO] Sort Code 
		//[Given]Create Bank Account
		CreateBankAccount(BankAccountTable, SortNumber);
		//[Given]Create Sort Code
		CreateSortCode(BankAccountCard);
		//[Then]Assign Sort Code to Bank
		AssignSortCodetoBank();
		//[When]Verify Valid Sort Code Bank
		VerifySortCodeonBank();
	end;

	local procedure CreateBankAccount(BankAccountTable: Record "Bank Account"; SortNumber: Code[20])
	begin
	end;

	local procedure CreateSortCode(BankAccountCard: Page "Bank Account Card")
	begin
	end;

	local procedure AssignSortCodetoBank()
	begin
	end;

	local procedure VerifySortCodeonBank()
	begin
	end;
}
