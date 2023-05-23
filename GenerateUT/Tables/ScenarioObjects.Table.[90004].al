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
        field(40; ObjectType; Enum ObjectType)
        {

        }
        field(50; ObjectID; Integer)
        {
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field(ObjectType));
        }
        field(60; FieldLenght; integer)
        {

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