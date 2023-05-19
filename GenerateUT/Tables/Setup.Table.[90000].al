table 90000 TestSetup
{
    Caption = 'Automated Test Setup';

    fields
    {
        field(10; SetupCode; Code[1])
        {

        }
        field(20; PrefixGiven; text[30])
        {
            Caption = 'Prefix for Procedures "GIVEN"';
        }
        field(30; PrefixWhen; text[30])
        {
            Caption = 'Prefix for Procedures "WHEN"';
        }
        field(40; PrefixThen; Text[30])
        {
            Caption = 'Prefix for Procedures "THEN"';
        }
        field(50; UTNumber; integer)
        {
            Caption = 'UT Number';
            InitValue = 90000;
        }
    }
    keys
    {
        key(PK; SetupCode)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        Rec.UTNumber := 90000;
    end;
}
