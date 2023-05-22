tableextension 50003 "SalesHeaderArchive" extends "Sales Header Archive"
{
    fields
    {
        field(50000; LookupValue; Code[20])
        {
            Caption = 'Lookup Value';
            TableRelation = LookupValue.Item;
            DataClassification = ToBeClassified;
        }
    }
}