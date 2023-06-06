table 90006 FieldParameterssObjects
{
    Caption = 'Table Field for Functions';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; FeatureCode; Code[20])
        {
            Caption = 'Feature Code';
            TableRelation = ParameterssObjects.FeatureCode;
        }
        field(20; ScenarioCode; code[20])
        {
            Caption = 'Scenario Code';
            NotBlank = true;
            TableRelation = ParameterssObjects.ScenarioCode;
        }
        field(30; ProcedureNo; integer)
        {
            Caption = 'Procedure Number';
            TableRelation = ParameterssObjects.ProcedureNo;
        }
        field(40; ParameterNo; Integer)
        {
            Caption = 'Parameter Number';
            TableRelation = ParameterssObjects.ParameterNo;
        }
        field(70; TableNo; Integer)
        {
            TableRelation = Field.TableNo;
        }
        field(55; Index; integer)
        {
            AutoIncrement = true;
        }
        field(60; FieldNo; Integer)
        {
            Caption = 'Field Number';
            TableRelation = Field."No.";
        }
    }
    keys
    {
        key(PK; FeatureCode, ScenarioCode, ProcedureNo, ParameterNo, TableNo, Index)
        {
            Clustered = true;
        }
    }
}