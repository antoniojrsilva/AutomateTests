page 90003 FuctionsPage
{
    Caption = 'Automated Test Fuctions';
    PageType = List;
    SourceTable = TestFunction;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(FunctionNo; Rec.FunctionNo)
                {
                    ToolTip = 'Specifies the value of the Function Number field.';
                }
                field(ProcedureType; Rec.ProcedureType)
                {
                    ToolTip = 'Specifies the value of the Test Type field.';
                }
                field(Description; Rec.Description)
                {

                }
                field(ProcedureName; Rec.ProcedureName)
                {

                }
                field(UITest; Rec.UITest)
                {

                }
            }
        }
    }

}
