pageextension 50002 "SalesQuoteListExtension" extends "Sales Quote Archives"
{
    layout
    {
        addfirst(Control1)
        {
            field(LookupValue; Rec.LookupValue)
            {
                ApplicationArea = All;
            }
        }
    }
}