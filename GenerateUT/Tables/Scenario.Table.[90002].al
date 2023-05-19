table 90002 TestScenario
{
    Caption = 'Test Scenarios';

    fields
    {
        field(10; FeatureCode; Code[20])
        {
            Caption = 'Feature Code';
            TableRelation = TestFeature.FeatureCode;
        }
        field(20; ScenarioCode; code[20])
        {
            Caption = 'Scenario Code';
            NotBlank = true;
        }
        field(30; ScenarioDescription; Text[100])
        {
            Caption = 'Scenario Description';
        }
        field(40; ScenarioName; Text[100])
        {
            Caption = 'Scenario Name';
        }
        field(50; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
    }
    keys
    {
        key(PK; FeatureCode, ScenarioCode)
        {
            Clustered = true;
        }
    }
}