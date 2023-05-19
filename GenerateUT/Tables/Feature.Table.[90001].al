table 90001 TestFeature
{
    Caption = 'Test Feature';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; FeatureCode; code[20])
        {
            Caption = 'Feature Code';
            NotBlank = true;
        }
        field(20; Description; Text[100])
        {
            Caption = 'Feature Description';
        }
        field(30; UTNumber; Integer)
        {
            Caption = 'UT Number';
        }
        field(40; UTName; Text[30])
        {
            Caption = 'UT Name';
        }

    }
    keys
    {
        key(PK; FeatureCode)
        {
            Clustered = true;
        }
    }
}