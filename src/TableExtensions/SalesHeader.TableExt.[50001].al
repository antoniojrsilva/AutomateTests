tableextension 50001 "Sales Header Extension" extends "Sales Header"
{
    fields
    {
        field(50000; Lookupvalue; Code[20])
        {
            Caption = 'Lookup Value';
            TableRelation = LookupValue.Item;
        }
    }
}