tableextension 50000 "Customer Extension" extends Customer
{
    fields
    {
        field(50000; "LookupValue"; code[20])
        {
            Caption = 'Lookup Value Code';
            TableRelation = LookupValue.Item;
        }
    }
}