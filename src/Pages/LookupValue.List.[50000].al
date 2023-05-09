page 50000 "LookupValue"
{
    Caption = 'Lookup Value List';
    PageType = List;
    ApplicationArea = All;
    SourceTable = LookupValue;

    layout
    {
        area(Content)
        {
            repeater(Rep)
            {
                field(Item; Rec.Item)
                {

                }
                field(Description; Rec.Description)
                {

                }
            }
        }
    }
}