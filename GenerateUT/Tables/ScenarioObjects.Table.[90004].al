table 90004 ScenariosObjects
{
    Caption = 'Objects for Scenario';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; FeatureCode; Code[20])
        {
            Caption = 'Feature Code';
            TableRelation = TestScenario.FeatureCode;
        }
        field(20; ScenarioCode; code[20])
        {
            Caption = 'Scenario Code';
            NotBlank = true;
            TableRelation = TestScenario.ScenarioCode;
        }
        field(30; RowNumber; integer)
        {
            AutoIncrement = true;
        }
        field(40; ObjectName; Text[30])
        {
            Caption = 'Object Name';
            trigger OnValidate()
            begin
                ObjectName := DelChr(ObjectName, ' ');
            end;

        }
        field(50; ObjectType; Enum ObjectType)
        {
            Caption = 'Object Type';
        }
        field(60; ObjectID; Integer)
        {
            Caption = 'Object ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field(ObjectType));
        }
        field(70; FieldLenght; integer)
        {
            Caption = 'Field Lenght';
        }
    }
    keys
    {
        key(PK; FeatureCode, ScenarioCode, RowNumber)
        {
            Clustered = true;
        }
    }
}