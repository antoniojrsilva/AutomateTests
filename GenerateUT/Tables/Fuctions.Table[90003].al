table 90003 TestFunction
{
    fields
    {
        field(10; FeatureCode; Code[20])
        {
            Caption = 'Feature Code';
        }
        field(20; ScenarioCode; code[20])
        {
            Caption = 'Scenario Code';
            TableRelation = TestScenario.ScenarioCode where(FeatureCode = field(FeatureCode));
        }
        field(30; FunctionNo; Integer)
        {
            Caption = 'Function Number';
            NotBlank = true;
        }
        field(40; Description; text[100])
        {
            Caption = 'Procedure Description';
        }
        field(50; ProcedureType; Enum ProcedureType)
        {
            Caption = 'Procedure Type';
            NotBlank = true;
        }
        field(60; ProcedureName; text[100])
        {
            Caption = 'Procedure Name';
            NotBlank = true;
        }
        field(70; UITest; Boolean)
        {
            Caption = 'UI';
        }
        field(80; PositiveNegative; Boolean)
        {
            Caption = 'Positive-Negative Test';
        }
        field(90)
    }
    keys
    {
        key(PK; FeatureCode, ScenarioCode, FunctionNo)
        {
            Clustered = true;
        }
    }
}