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
                        if Page.RunModal(Page::ScenarioObjects, ScenarioObjects) = Action::LookupOK then
                            Rec.ParameterNo := ScenarioObjects.Parameters;
                    end;

                }
                field(IsPointer; Rec.IsPointer)
                {
                    ToolTip = 'Specifies the value of the IsPointer field.';
                }
            }
        }
    }
}
