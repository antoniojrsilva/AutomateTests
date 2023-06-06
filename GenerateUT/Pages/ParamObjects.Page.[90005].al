page 90005 ParametersObjectPage
{
    ApplicationArea = All;
    Caption = 'Parameter on Function';
    PageType = List;
    SourceTable = ParameterssObjects;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ParameterNo; Rec.ParameterNo)
                {
                    ToolTip = 'Specifies the value of the Parameter Number field.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ScenarioObjects: Record ScenariosObjects;
                    begin
                        ScenarioObjects.Reset();
                        ScenarioObjects.SetRange(FeatureCode, Rec.FeatureCode);
                        ScenarioObjects.SetRange(ScenarioCode, Rec.ScenarioCode);
                        if Page.RunModal(Page::ScenarioObjects, ScenarioObjects) = Action::LookupOK then begin
                            Rec.Validate(ParameterNo, ScenarioObjects.Parameters);
                            GetVariableNames();
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        GetVariableNames();
                    end;
                }
                field(ObjectCaptionName; ObjectCaptionName)
                {

                }
                field(ObjectName; ObjectName)
                {

                }
                field(IsPointer; Rec.IsPointer)
                {
                    ToolTip = 'Specifies the value of the IsPointer field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Fields)
            {
                Caption = 'Fields';
                Image = Database;
                ApplicationArea = All;
                trigger OnAction()
                var
                    FieldParamObjects: Record FieldParameterssObjects;
                begin
                    if not IsTable() then
                        exit;
                    FieldParamObjects.SetRange(FeatureCode, Rec.FeatureCode);
                    FieldParamObjects.SetRange(ScenarioCode, Rec.ScenarioCode);
                    FieldParamObjects.SetRange(ProcedureNo, Rec.ProcedureNo);
                    FieldParamObjects.SetRange(ParameterNo, Rec.ParameterNo);
                    FieldParamObjects.SetRange(TableNo, GetTableValue());
                    //   if FieldParamObjects.FindSet(false) then
                    Page.RunModal(Page::FieldParamObjects, FieldParamObjects);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        GetVariableNames();
    end;

    local procedure GetTableValue(): Integer
    var
        ScenariosObjects: Record ScenariosObjects;
    begin
        if ScenariosObjects.Get(Rec.FeatureCode, Rec.ScenarioCode, Rec.ParameterNo) then
            exit(ScenariosObjects.ObjectID);
    end;

    local procedure IsTable(): Boolean
    var
        ScenariosObjects: Record ScenariosObjects;
        ObjectType: Enum ObjectTypeEnum;
    begin
        if ScenariosObjects.Get(Rec.FeatureCode, Rec.ScenarioCode, Rec.ParameterNo) then
            if ScenariosObjects.ObjectType = ObjectType::Table then
                exit(true);
        exit(false);
    end;

    local procedure GetVariableNames()
    var
        ScenarioObjects: Record ScenariosObjects;
        ObjectsTable: Record AllObjWithCaption;
    begin
        Clear(ObjectName);
        Clear(ObjectCaptionName);
        if ScenarioObjects.Get(Rec.FeatureCode, Rec.ScenarioCode, Rec.ParameterNo) then
            ObjectName := ScenarioObjects.ObjectName;
        if ObjectsTable.Get(ScenarioObjects.ObjectType, ScenarioObjects.ObjectID) then
            ObjectCaptionName := ObjectsTable."Object Caption";
    end;

    var
        ObjectCaptionName: Text[50];
        ObjectName: Text[50];

}
