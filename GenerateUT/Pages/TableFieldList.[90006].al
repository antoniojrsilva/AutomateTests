page 90006 TableFieldList
{
    ApplicationArea = All;
    Caption = 'Field Test';
    PageType = List;
    SourceTable = "Field";
    UsageCategory = Lists;

    SourceTableView = sorting("No.", "Field Caption") order(ascending) where("No." = filter(< 2000000000), ObsoleteState = const(No), Enabled = const(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the caption of the field, that is, the name that will be shown in the user interface.';
                }
                field("DataClassification"; Rec."DataClassification")
                {
                    ToolTip = 'Specifies the data classification.';
                }
                field("Type Name"; Rec."Type Name")
                {
                    ToolTip = 'Specifies the type of data.';
                }
                field(IsPartOfPrimaryKey; Rec.IsPartOfPrimaryKey)
                {
                    ToolTip = 'Specifies the value of the IsPartOfPrimaryKey field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the type of the field in the table, which indicates the type of data it contains.';
                }
                field(Len; Rec.Len)
                {
                    ToolTip = 'Specifies the value of the Len field.';
                }
                field(OptionString; Rec.OptionString)
                {
                    ToolTip = 'Specifies the option string.';
                }
                field(RelationFieldNo; Rec.RelationFieldNo)
                {
                    ToolTip = 'Specifies the value of the RelationFieldNo field.';
                }
                field(RelationTableNo; Rec.RelationTableNo)
                {
                    ToolTip = 'Specifies the ID number of a table from which the field on the current table gets data. For example, the field can provide a lookup into another table.';
                }

            }
        }
    }
}
