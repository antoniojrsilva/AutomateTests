codeunit 90001 CreateUT
{

    procedure CreateUTFile(Feature: Record TestFeature)
    var
        TempBLOB: Codeunit "Temp Blob";
        InS: InStream;
        OutS: OutStream;
        Filename: Text;
        TxtBuilder: TextBuilder;
        SufixFilename: label '.[%1].al';
    begin
        Filename := DelChr(Feature.UTName, '=', ' ') + StrSubstNo(SufixFilename, Format(Feature.UTNumber));
        TxtBuilder.AppendLine('Codeunit ' + Format(Feature.UTNumber) + ' "' + Feature.UTName + '"');
        TxtBuilder.AppendLine('{');
        GenerateUTProperties(TxtBuilder);
        GenerateUTOnRun(Feature, TxtBuilder);
        GenerateUTScenarios(Feature, TxtBuilder);
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

    local procedure GenerateUTOnRun(Feature: Record TestFeature; TxtBuilder: TextBuilder)
    begin
        tab := 9;
        TxtBuilder.AppendLine();
        TxtBuilder.AppendLine(Format(tab) + 'Trigger OnRun()');
        TxtBuilder.AppendLine(Format(tab) + 'begin');
        TxtBuilder.Append(Format(tab) + Format(tab));
        TxtBuilder.AppendLine('//[FEATURE] ' + Feature.Description);
        TxtBuilder.AppendLine(Format(tab) + 'end;');
    end;

    local procedure GenerateUTScenarios(Feature: Record TestFeature; var TxtBuilder: TextBuilder)
    var
        Scenario: Record TestScenario;
        ErrorMsg: Label 'The Feature %1 doesn''t have active Scenarios';
    begin
        Scenario.SetRange(FeatureCode, Feature.FeatureCode);
        Scenario.SetRange(Active, true);
        If Scenario.IsEmpty then
            Error(StrSubstNo(ErrorMsg, Feature.FeatureCode));
        Scenario.FindSet(false);
        repeat
            GenerateUTTriggers(Scenario, TxtBuilder);
        until Scenario.Next() = 0;
    end;

    local procedure GenerateUTTriggers(Scenario: Record TestScenario; var TxtBuilder: TextBuilder)
    var
        Functions: Record TestFunction;
        ScenarioObjects: Record ScenariosObjects;
        ErrorMsg: Label 'The Scenario %1 doesn''t have active Functions';
        TxtProcedures: TextBuilder;
        ObjectTypeEnum: Enum ObjectTypeEnum;
    begin
        tab := 9;
        TxtBuilder.AppendLine();
        TxtBuilder.AppendLine(Format(tab) + '[' + 'Test' + ']');
        TxtBuilder.AppendLine(Format(tab) + 'procedure ' + DelChr(Scenario.ScenarioName, '=', ' ') + '()');
        ScenarioObjects.SetRange(FeatureCode, Scenario.FeatureCode);
        ScenarioObjects.SetRange(ScenarioCode, Scenario.ScenarioCode);
        ScenarioObjects.SetFilter(ObjectType, '<>%1&<>%2', ObjectTypeEnum::Codeunit, ObjectTypeEnum::Label);
        if not ScenarioObjects.IsEmpty then
            if ScenarioObjects.FindSet(false) then begin
                TxtBuilder.AppendLine(Format(tab) + 'var');
                repeat
                    GenerateVarScenario(ScenarioObjects, TxtBuilder);
                until ScenarioObjects.Next() = 0;
            end;
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

    local procedure GenerateVarScenario(ScenarioObjects: Record ScenariosObjects; var TxtBuilder: TextBuilder)
    var
        ObjectTypeEnum: Enum ObjectTypeEnum;
        AllObjects: Record AllObjWithCaption;
    begin
        tab := 9;
        TxtBuilder.Append(Format(tab) + Format(tab));
        TxtBuilder.Append(ScenarioObjects.ObjectName + ': ');
        case ScenarioObjects.ObjectType of
            ObjectTypeEnum::Boolean:
                TxtBuilder.AppendLine('Boolean;');
            ObjectTypeEnum::Code:
                TxtBuilder.AppendLine('Code[' + Format(ScenarioObjects.FieldLenght) + '];');
            ObjectTypeEnum::Text:
                TxtBuilder.AppendLine('Text[' + Format(ScenarioObjects.FieldLenght) + '];');
            ObjectTypeEnum::Table:
                begin
                    AllObjects.Get(ScenarioObjects.ObjectType, ScenarioObjects.ObjectID);
                    TxtBuilder.AppendLine('Record "' + AllObjects."Object Name" + '";');
                end;
            ObjectTypeEnum::Page:
                begin
                    AllObjects.Get(ScenarioObjects.ObjectType, ScenarioObjects.ObjectID);
                    TxtBuilder.AppendLine('TestPage "' + AllObjects."Object Name" + '";');
                end;
        end;
    end;

    local procedure GenerateUTProcedures(Functions: Record TestFunction; var TxtBuilder: TextBuilder; var TxtProcedures: TextBuilder)
    begin
        tab := 9;
        TxtBuilder.Append(Format(tab) + Format(tab));
        TxtBuilder.AppendLine('//[' + Format(Functions.ProcedureType) + ']' + Functions.Description);
        TxtBuilder.Append(Format(tab) + Format(tab));
        TxtBuilder.Append(Functions.ProcedureName + '(');
        InsertParameterOnProceduresCall(Functions, TxtBuilder);
        TxtBuilder.AppendLine(');');
        GenerateUTFunctions(Functions, TxtProcedures);
    end;

    local procedure InsertParameterOnProceduresCall(Functions: Record TestFunction; var TxtBuilder: TextBuilder)
    var
        ParamObjects: Record ParameterssObjects;
        ScenarioObjects: Record ScenariosObjects;
        ObjectTypeEnum: Enum ObjectTypeEnum;
        FunctionNo: Integer;
    begin
        tab := 9;
        ParamObjects.CalcFields(ObjectType);
        ParamObjects.SetRange(FeatureCode, Functions.FeatureCode);
        ParamObjects.SetRange(ScenarioCode, Functions.ScenarioCode);
        ParamObjects.SetRange(ProcedureNo, Functions.ProcedureUT);
        ParamObjects.SetFilter(ObjectType, '<>%1&<>%2', ObjectTypeEnum::Codeunit, ObjectTypeEnum::Label);
        FunctionNo := ParamObjects.Count;
        if ParamObjects.FindSet(false) then
            repeat
                ScenarioObjects.Get(ParamObjects.FeatureCode, ParamObjects.ScenarioCode, ParamObjects.ParameterNo);
                FunctionNo -= 1;
                TxtBuilder.Append(ScenarioObjects.ObjectName);
                if FunctionNo > 0 then
                    TxtBuilder.Append(', ');
            until ParamObjects.Next() = 0;
    end;

    local procedure GenerateUTFunctions(Functions: Record TestFunction; var TxtProcedures: TextBuilder)
    var
        ParamObjects: Record ParameterssObjects;
        TxtLocalVar: TextBuilder;
        FunctionNo: Integer;
    begin
        tab := 9;
        TxtProcedures.AppendLine();
        TxtProcedures.Append(Format(tab) + 'local procedure ' + Functions.ProcedureName + '(');
        ParamObjects.CalcFields(ObjectType);
        ParamObjects.SetRange(FeatureCode, Functions.FeatureCode);
        ParamObjects.SetRange(ScenarioCode, Functions.ScenarioCode);
        ParamObjects.SetRange(ProcedureNo, Functions.ProcedureUT);
        ParamObjects.SetFilter(ObjectType, '<>%1&<>%2', ObjectTypeEnum::Codeunit, ObjectTypeEnum::Label);
        FunctionNo := ParamObjects.Count;
        if ParamObjects.FindSet(false) then
            repeat
                FunctionNo -= 1;
                InsertParameterOnProceduresDefinition(ParamObjects, Functions, TxtProcedures, TxtLocalVar);
                if FunctionNo > 0 then
                    TxtProcedures.Append('; ')
            until ParamObjects.Next() = 0;
        TxtProcedures.AppendLine(')');
        ParamObjects.CalcFields(ObjectType);
        ParamObjects.SetRange(FeatureCode, Functions.FeatureCode);
        ParamObjects.SetRange(ScenarioCode, Functions.ScenarioCode);
        ParamObjects.SetRange(ProcedureNo, Functions.ProcedureUT);
        ParamObjects.SetFilter(ObjectType, '%1|%2', ObjectTypeEnum::Codeunit, ObjectTypeEnum::Label);
        if ParamObjects.FindSet(false) then begin
            InsertLocalVar(ParamObjects, ParamObjects.ErrorLabel, TxtLocalVar);
            TxtProcedures.AppendLine(Format(tab) + 'var');
            TxtProcedures.AppendLine(TxtLocalVar.ToText);
        end;
        TxtProcedures.AppendLine(Format(tab) + 'begin');
        TxtProcedures.AppendLine(Format(tab) + 'end;');
    end;


    local procedure InsertParameterOnProceduresDefinition(ParamObjects: Record ParameterssObjects; Functions: Record TestFunction; var TxtProcedures: TextBuilder; var TxtLocalVar: TextBuilder)
    var
        ScenarioObjects: Record ScenariosObjects;
        AllObjects: Record AllObjWithCaption;
    begin
        tab := 9;
        if ScenarioObjects.Get(ParamObjects.FeatureCode, ParamObjects.ScenarioCode, ParamObjects.ParameterNo) then begin
            if ParamObjects.IsPointer then
                TxtProcedures.Append('var ');
            TxtProcedures.Append(ScenarioObjects.ObjectName + ': ');
            case ScenarioObjects.ObjectType of
                ObjectTypeEnum::Boolean:
                    TxtProcedures.Append('Boolean');
                ObjectTypeEnum::Code:
                    TxtProcedures.Append('Code[' + Format(ScenarioObjects.FieldLenght) + ']');
                ObjectTypeEnum::Text:
                    TxtProcedures.Append('Text[' + Format(ScenarioObjects.FieldLenght) + ']');
                ObjectTypeEnum::Table:
                    begin
                        AllObjects.Get(ScenarioObjects.ObjectType, ScenarioObjects.ObjectID);
                        TxtProcedures.Append('Record "' + AllObjects."Object Name" + '"');
                    end;
                ObjectTypeEnum::Page:
                    begin
                        AllObjects.Get(ScenarioObjects.ObjectType, ScenarioObjects.ObjectID);
                        TxtProcedures.Append('TestPage "' + AllObjects."Object Name" + '"');
                    end;
            end;
        end;

    end;

    local procedure InsertLocalVar(var ParamObjects: Record ParameterssObjects; ErrorLabel: Text[50]; var TxtLocalVar: TextBuilder)
    var
        AllObjects: Record AllObjWithCaption;
        ScenarioObjects: Record ScenariosObjects;
    begin
        tab := 9;
        repeat
            TxtLocalVar.Append(Format(tab) + Format(tab));
            ScenarioObjects.Get(ParamObjects.FeatureCode, ParamObjects.ScenarioCode, ParamObjects.ParameterNo);
            TxtLocalVar.Append(ScenarioObjects.ObjectName + ': ');
            case ScenarioObjects.ObjectType of
                ObjectTypeEnum::Codeunit:
                    begin
                        AllObjects.Get(ScenarioObjects.ObjectType, ScenarioObjects.ObjectID);
                        TxtLocalVar.AppendLine('Codeunit "' + AllObjects."Object Name" + '";');
                    end;
                ObjectTypeEnum::Label:
                    TxtLocalVar.AppendLine('Label ''' + ErrorLabel + ''';');
            end;
        until ParamObjects.Next() = 0;
    end;

    var
        tab: Char;



}