page 90007 FieldParamObjects
{
    ApplicationArea = All;
    Caption = 'Field Parameter Objects';
    PageType = List;
    SourceTable = FieldParameterssObjects;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(FieldNo; Rec.FieldNo)
                {
                    ToolTip = 'Specifies the value of the Field Number field.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        TableFields: Record Field;
                    begin
                        TableFields.SetRange(TableNo, Rec.TableNo);
                        if Page.RunModal(Page::TableFieldList, TableFields) = Action::LookupOK then begin
                            Rec.FieldNo := TableFields."No.";
                            GetFieldName();
                        end;
                    end;
                }
                field(FieldName; FieldName)
                {

                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        GetFieldName();
    end;

    local procedure GetFieldName()
    var
        TableFields: Record Field;
    begin
        Clear(FieldName);
        if TableFields.Get(Rec.TableNo, rec.FieldNo) then
            FieldName := TableFields."Field Caption";
    end;

    var
        TableName: Text[50];
        FieldName: Text[50];
}
