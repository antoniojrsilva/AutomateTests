pageextension 50003 BankCardExtension extends "Bank Account Card"
{
    layout
    {
        modify("Bank Branch No.")
        {
            trigger OnBeforeValidate()
            begin
                if StrLen(Rec."Bank Branch No.") <> 6 then
                    Error('The Sort Code should have 6 digits');
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}