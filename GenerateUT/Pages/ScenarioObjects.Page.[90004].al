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
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ObjectsTable: Record AllObjWithCaption;
                        ObjectTypeEnum: Enum ObjectTypeEnum;
                    begin
                        ObjectsTable.SetRange("Object Type", Rec.ObjectType);
                        if (Rec.ObjectType = ObjectTypeEnum::Codeunit) then begin
                            ObjectsTable.SetFilter("Object Caption", 'Library*| EMR*');
                            ObjectsTable.SetRange("Object Subtype", '');
                        end;
                        if Page.RunModal(Page::"All Objects with Caption", ObjectsTable) = Action::LookupOK then
                            Rec.ObjectID := ObjectsTable."Object ID";
                        CreatePageBehaviour();

                    end;

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
        EnableLenght := not (Format(Rec.ObjectType) in ['Table', 'Page', 'Boolean', 'Codeunit']);
        Clear(ObjectUTName);
        if (Format(Rec.ObjectType) in ['Table', 'Page', 'Codeunit']) then
            if ((Format(Rec.ObjectType) <> '') and (Rec.ObjectID <> 0)) then
                if ObjectsTable.Get(Rec.ObjectType, Rec.ObjectID) then begin
                    ObjectUTName := ObjectsTable."Object Caption";
                    Rec.ObjectName := DelChr(ObjectUTName, '=', ' -');
                    Clear(Rec.FieldLenght);
                end;
    end;

    var
        EnableLenght: Boolean;
        ObjectUTName: Text[50];
        ObjectName: Text[50];
}