table 90005 ParameterssObjects
{
    Caption = 'Parameter for Functions';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; FeatureCode; Code[20])
        {
            Caption = 'Feature Code';
            TableRelation = TestFunction.FeatureCode;
        }
        field(20; ScenarioCode; code[20])
        {
            Caption = 'Scenario Code';
            NotBlank = true;
            TableRelation = TestFunction.ScenarioCode;
        }
        field(30; ProcedureNo; integer)
        {
            Caption = 'Procedure Number';
            TableRelation = TestFunction.ProcedureUT;
        }
        field(50; ParameterNo; Integer)
        {
            Caption = 'Parameter Number';
            TableRelation = ScenariosObjects.Parameters where(FeatureCode = field(FeatureCode), ScenarioCode = field(ScenarioCode));
        }
        field(60; ErrorLabel; Text[50])
        {
            Caption = 'Label Value';
        }
        field(70; IsPointer; Boolean)
        {
            Caption = 'Var';
            InitValue = true;
        }
        field(80; ObjectType; Enum ObjectTypeEnum)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(ScenariosObjects.ObjectType where(FeatureCode = field(FeatureCode), ScenarioCode = field(ScenarioCode), Parameters = field(ParameterNo)));
        }
    }
    keys
    {
        key(PK; FeatureCode, ScenarioCode, ProcedureNo, ParameterNo)
        {
            Clustered = true;
        }
    }
}