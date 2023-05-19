pageextension 50001 SalesQuoteArchiveExtension extends "Sales Quote"
{
    layout
    {
        addlast(General)
        {
            field(Lookupvalue; Rec.Lookupvalue)
            {
                ApplicationArea = All;
            }
        }

    }
}