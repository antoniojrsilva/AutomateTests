page 90001 FeaturesPage
{
    ApplicationArea = All;
    Caption = 'Automated Test Features';
    PageType = Card;
    SourceTable = TestFeature;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(FeatureCode; Rec.FeatureCode)
                {
                    ToolTip = 'Specifies the value of the Feature Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Feature Description field.';
                }
                field(UTNumber; Rec.UTNumber)
                {
                    ShowMandatory = true;
                }
                field(UTName; Rec.UTName)
                {
                    ShowMandatory = true;
                }
            }
            part(Scenarios; ScenariosPage)
            {
                SubPageLink = FeatureCode = FIELD(FeatureCode);
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(createfile)
            {
                Caption = 'Generate Test UT''s';

                trigger OnAction()
                var
                    GenerateUTFile: codeunit CreateUT;
                begin
                    GenerateUTFile.CreateUTFile(Rec);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TestSetup: Record TestSetup;
    begin
        if not TestSetup.Get() then
            TestSetup.Insert(true);
        Rec.UTNumber := TestSetup.UTNumber;
        TestSetup.UTNumber += 1;
        TestSetup.Modify();
    end;

}
