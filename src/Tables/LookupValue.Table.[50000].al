table 50000 "LookupValue"
{
    fields
    {
        field(10; Item; code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(20; Description; text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Item)
        {
            Clustered = true;
        }
    }
}