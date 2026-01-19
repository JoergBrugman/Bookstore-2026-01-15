page 50101 "BSB Book List"
{
    Caption = 'Books';
    PageType = List;
    SourceTable = "BSB Book";
    Editable = false;
    CardPageId = "BSB Book Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.") { }
                field(Description; Rec.Description) { }
                field(Type; Rec."Type") { }
                field(ISBN; Rec.ISBN) { }
                field(Author; Rec.Author) { }
                field("No. of Pages"; Rec."No. of Pages") { Visible = false; }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links) { }
            systempart(Notes; Notes) { }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ClassicImpl)
            {
                Caption = 'Classic Impl.';
                Image = Process;
                ToolTip = 'Classic Impl.';

                trigger OnAction()
                var
                    BSBBookTypeAllInOne: Codeunit "BSB Book Type AllInOne";
                    IsHandled: Boolean;
                begin
                    OnBeforeHandleBookType(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            begin
                                BSBBookTypeAllInOne.StartDeployBookHardcover();
                                BSBBookTypeAllInOne.StartDeliverBookHardcover();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                BSBBookTypeAllInOne.StartDeployBooPaperback();
                                BSBBookTypeAllInOne.StartDeliverBookPaperback();
                            end;
                        "BSB Book Type"::" ":
                            begin
                                BSBBookTypeAllInOne.StartDeployBookEmpty();
                                BSBBookTypeAllInOne.StartDeliverBookEmpty();
                            end;
                    end;
                end;
            }
        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeHandleBookType(var Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}
