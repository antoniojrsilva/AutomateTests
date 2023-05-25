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
                        CreatePageBehaviour();
                    end;

                }
                field(ObjectID; Rec.ObjectID)
                {
                    Editable = not EnableLenght;
                    trigger OnValidate()
                    begin
                        CreatePageBehaviour();
                    end;

                }
                field(ObjectUTName; ObjectUTName)
                {
                    Caption = 'BC Object Name';
                    Editable = false;
                }
                field(ObjectName; Rec.ObjectName)
                {
                }
                field(FieldLenght; Rec.FieldLenght)
                {
                    Editable = EnableLenght;
                    ShowMandatory = EnableLenght;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CreatePageBehaviour();
    end;

    local procedure CreatePageBehaviour()
    var
        ObjectsTable: Record AllObjWithCaption;
    begin
        EnableLenght := true;
        EnableLenght := not (Format(Rec.ObjectType) in ['Table', 'Page', 'Boolean']);
        Clear(ObjectUTName);
        if (Format(Rec.ObjectType) in ['Table', 'Page']) then
            if ((Format(Rec.ObjectType) <> '') and (Rec.ObjectID <> 0)) then
                if ObjectsTable.Get(Rec.ObjectType, Rec.ObjectID) then begin
                    ObjectUTName := ObjectsTable."Object Caption";
                    Clear(Rec.FieldLenght);
                end;
    end;

    var
        EnableLenght: Boolean;
        ObjectUTName: Text[50];
}