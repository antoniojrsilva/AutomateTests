tableextension 50004 BankAccountTableExt extends "Bank Account"
{
    fields
    {
        modify("Bank Branch No.")
        {
            trigger OnBeforeValidate()
            var
                VarInteger: Integer;
            begin
                if StrLen("Bank Branch No.") <> 6 then
                    Error('The Sort Code should have 6 digits');
                if not Evaluate(VarInteger, "Bank Branch No.") then
                    Error('The Sort Code should have only digits');
            end;
        }
    }
}