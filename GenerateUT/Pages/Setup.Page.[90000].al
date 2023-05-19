page 90000 SetupPage
{
    Caption = 'Automated Test Setup';
    ApplicationArea = All;
    PageType = Card;
    SourceTable = TestSetup;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(PrefixGiven; Rec.PrefixGiven)
                {
                    Caption = 'Prefix for GIVEN object';
                    ToolTip = 'Specifies the value of the Prefix for Procedures "GIVEN" field.';
                }
                field(PrefixWhen; Rec.PrefixWhen)
                {
                    Caption = 'Prefix for WHEN object';
                    ToolTip = 'Specifies the value of the Prefix for Procedures "WHEN" field.';
                }
                field(PrefixThen; Rec.PrefixThen)
                {
                    Caption = 'Prefix for THEN object';
                    ToolTip = 'Specifies the value of the Prefix for Procedures "THEN" field.';
                }
                field(UTNumber; Rec.UTNumber)
                {
                    ToolTip = 'Specifies the value of the UT Number field.';
                }
            }
        }
    }
    trigger OnInit()
    begin
        If Rec.IsEmpty then begin

            Rec.Insert();
        end;
    end;
}
