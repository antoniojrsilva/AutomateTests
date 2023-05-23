page 90004 ScenarioObjects
{
    Caption = 'Objects for Scenario';
    SourceTable = ScenariosObjects;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Rep)
            {
                field(ObjectType; Rec.ObjectType)
                {
                    trigger OnValidate()
                    begin
                        if Format(ObjectType) in ['Table', 'Page'] then
                            EnableLookup := true
                        else
                            EnableLookup := false;
                    end;

                }
                field(ObjectID; Rec.ObjectID)
                {
                    Editable = Enablelookup;
                }
            }
        }
    }
    var
        Enablelookup: Boolean;
}