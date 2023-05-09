pageextension 50000 "Customer Card Extension" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(LookupValue; Rec.LookupValue)
            {

            }
        }
    }
}