page 50002 "CodeUnit Metadata List"
{

    ApplicationArea = All;
    Caption = 'CodeUnit Metadata List';
    PageType = List;
    SourceTable = "CodeUnit Metadata";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(TableNo; Rec.TableNo)
                {
                    ApplicationArea = All;
                }
                field(SingleInstance; Rec.SingleInstance)
                {
                    ApplicationArea = All;
                }
                field(SubType; Rec.SubType)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
