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
            group(Functions)
            {
                action(createfile)
                {
                    Caption = 'Generate Test UT''s';

                    trigger OnAction()
                    begin
                        CreateUTFile();
                    end;
                }
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

    procedure CreateUTFile()
    var
        TempBLOB: Codeunit "Temp Blob";
        InS: InStream;
        OutS: OutStream;
        Filename: Text;
        TxtBuilder: TextBuilder;
        SufixFilename: label '.[%1].al';
    begin
        Filename := DelChr(Rec.UTName, '=', ' ') + StrSubstNo(SufixFilename, Format(Rec.UTNumber));
        TxtBuilder.AppendLine('Codeunit ' + Format(Rec.UTNumber) + ' "' + Rec.UTName + '"');
        TxtBuilder.AppendLine('{');
        GenerateUTProperties(TxtBuilder);
        GenerateUTOnRun(TxtBuilder);
        GenerateUTScenarios(TxtBuilder);
        TxtBuilder.AppendLine('}');
        TempBLOB.CreateOutStream(OutS);
        OutS.WriteText(TxtBuilder.ToText());
        TempBLOB.CreateInStream(InS);
        DownloadFromStream(Ins, '', '', '', Filename);
    end;

    local procedure GenerateUTProperties(var TxtBuilder: TextBuilder)
    begin
        tab := 9;
        TxtBuilder.AppendLine(Format(tab) + 'SubType = Test;');
        TxtBuilder.AppendLine(Format(tab) + 'TestPermissions = Disabled;')
    end;

    local procedure GenerateUTOnRun(TxtBuilder: TextBuilder)
    begin
        tab := 9;
        TxtBuilder.AppendLine();
        TxtBuilder.AppendLine(Format(tab) + 'Trigger OnRun()');
        TxtBuilder.AppendLine(Format(tab) + 'begin');
        TxtBuilder.Append(Format(tab) + Format(tab));
        TxtBuilder.AppendLine('//[FEATURE] ' + Rec.Description);
        TxtBuilder.AppendLine(Format(tab) + 'end;');
    end;

    local procedure GenerateUTScenarios(var TxtBuilder: TextBuilder)
    var
        Scenario: Record TestScenario;
        ErrorMsg: Label 'The Feature %1 doesn''t have active Scenarios';
    begin
        Scenario.SetRange(FeatureCode, Rec.FeatureCode);
        Scenario.SetRange(Active, true);
        If Scenario.IsEmpty then
            Error(StrSubstNo(ErrorMsg, Rec.FeatureCode));
        Scenario.FindSet(false);
        repeat
            GenerateUTTriggers(Scenario, TxtBuilder);
        until Scenario.Next() = 0;
    end;

    local procedure GenerateUTTriggers(Scenario: Record TestScenario; var TxtBuilder: TextBuilder)
    var
        Functions: Record TestFunction;
        ErrorMsg: Label 'The Scenario %1 doesn''t have active Functions';
        TxtProcedures: TextBuilder;
    begin
        tab := 9;
        TxtBuilder.AppendLine();
        TxtBuilder.AppendLine(Format(tab) + '[' + 'Test' + ']');
        TxtBuilder.AppendLine(Format(tab) + 'procedure ' + DelChr(Scenario.ScenarioName, '=', ' ') + '()');
        TxtBuilder.AppendLine(Format(tab) + 'begin');
        TxtBuilder.Append(Format(tab) + Format(tab));
        TxtBuilder.AppendLine('//[SCENARIO] ' + Scenario.ScenarioDescription);
        Functions.SetRange(FeatureCode, Scenario.FeatureCode);
        Functions.SetRange(ScenarioCode, Scenario.ScenarioCode);
        if Functions.FindSet(false) then
            repeat
                GenerateUTProcedures(Functions, TxtBuilder, TxtProcedures);
            until Functions.Next() = 0;
        TxtBuilder.AppendLine(Format(tab) + 'end;');
        TxtBuilder.Append(TxtProcedures.ToText());
    end;

    local procedure GenerateUTProcedures(Functions: Record TestFunction; var TxtBuilder: TextBuilder; var TxtProcedures: TextBuilder)
    begin
        tab := 9;
        TxtBuilder.Append(Format(tab) + Format(tab));
        TxtBuilder.AppendLine('//[' + Format(Functions.ProcedureType) + ']' + Functions.Description);
        TxtBuilder.Append(Format(tab) + Format(tab));
        TxtBuilder.AppendLine(DelChr(Functions.ProcedureName, '=', ' ') + '();');
        GenerateUTFunctions(Functions, TxtProcedures);
    end;

    local procedure GenerateUTFunctions(Functions: Record TestFunction; var TxtProcedures: TextBuilder)
    begin
        tab := 9;
        TxtProcedures.AppendLine();
        TxtProcedures.AppendLine(Format(tab) + 'local procedure ' + DelChr(Functions.ProcedureName, '=', ' ') + '()');
        TxtProcedures.AppendLine(Format(tab) + 'begin');
        TxtProcedures.AppendLine(Format(tab) + 'end;');
    end;

    var
        tab: Char;

}
