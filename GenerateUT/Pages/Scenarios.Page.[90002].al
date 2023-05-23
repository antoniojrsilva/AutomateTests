page 90002 ScenariosPage
{
    Caption = 'Automated Test Scenarios';
    PageType = ListPart;
    SourceTable = TestScenario;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ScenarioCode; Rec.ScenarioCode)
                {
                    ToolTip = 'Specifies the value of the Scenario Code field.';
                }
                field(ScenarioDescription; Rec.ScenarioDescription)
                {
                    ToolTip = 'Specifies the value of the Scenario Description field.';
                }
                field(ScenarioName; Rec.ScenarioName)
                {
                }
                field(Active; Rec.Active)
                {
                }
                field(PositiveNegative; Rec.PositiveNegative)
                {

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'Line';
                Image = "Action";

                action(Functions)
                {
                    Caption = 'Functions';
                    Ellipsis = true;
                    Image = Action;
                    RunObject = Page FuctionsPage;
                    RunPageLink = FeatureCode = field(FeatureCode), ScenarioCode = field(ScenarioCode);
                    ApplicationArea = All;
                }
                action(Objects)
                {
                    Caption = 'Objects';
                    Ellipsis = true;
                    Image = AddWatch;
                    RunObject = Page ScenarioObjects;
                    RunPageLink = FeatureCode = field(FeatureCode), ScenarioCode = field(ScenarioCode);
                    ApplicationArea = All;
                }
            }
        }
    }
}