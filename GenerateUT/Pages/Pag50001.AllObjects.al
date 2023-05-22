page 50010 "All Objects for me"
{
    ApplicationArea = All;
    Caption = 'All Objects';
    PageType = List;
    SourceTable = AllObjWithCaption;
    SourceTableView = where("Object Type" = filter('Codeunit'), "Object ID" = filter(>= 130000 & < 140000));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("App Package ID"; Rec."App Package ID")
                {
                    ToolTip = 'Specifies the value of the App Package ID field.';
                }
                field("App Runtime Package ID"; Rec."App Runtime Package ID")
                {
                    ToolTip = 'Specifies the value of the App Runtime Package ID field.';
                }
                field("Object Caption"; Rec."Object Caption")
                {
                    ToolTip = 'Specifies the caption of the object.';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the object ID.';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the name of the object.';
                }
                field("Object Subtype"; Rec."Object Subtype")
                {
                    ToolTip = 'Specifies the subtype of the object.';
                }
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the object type.';
                }
            }
        }
    }
}
