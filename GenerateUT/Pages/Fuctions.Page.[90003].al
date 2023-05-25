page 90003 FuctionsPage
{
    Caption = 'Automated Test Fuctions';
    PageType = List;
    SourceTable = TestFunction;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ProcedureType; Rec.ProcedureType)
                {
                    ToolTip = 'Specifies the value of the Test Type field.';
                }
                field(Description; Rec.Description)
                {

                }
                field(ProcedureName; Rec.ProcedureName)
                {

                }
                field(UITest; Rec.UITest)
                {

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Functions)
            {
                Caption = 'Parameters';
                ApplicationArea = All;
                Image = Action;
                RunObject = Page ParametersObjectPage;
                RunPageLink = FeatureCode = field(FeatureCode), ScenarioCode = field(ScenarioCode), ProcedureNo = field(ProcedureUT);
            }
        }
    }
}
