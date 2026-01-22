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
                    BSBBookTypeDefaultImpl: Codeunit "BSB Book Type Default Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    IsHandled: Boolean;
                begin
                    // Handled-Event Pattern, mit dem Dependeny-Apps das Angebot/die Möglickeit haben,
                    // die Behandlung (z.B. des eBook) selber zu übernehmen.
                    OnBeforeHandleBookType(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            begin
                                BSBBookTypeHardcoverImpl.StartDeployBook();
                                BSBBookTypeHardcoverImpl.StartDeliverBook();
                            end;
                        "BSB Book Type"::Paperback:
                            begin
                                BSBBookTypePaperbackImpl.StartDeployBook();
                                BSBBookTypePaperbackImpl.StartDeliverBook();
                            end;
                        else begin
                            BSBBookTypeDefaultImpl.StartDeployBook();
                            BSBBookTypeDefaultImpl.StartDeliverBook();
                        end;
                    end;
                end;
            }
            action(InterfaceImpl)
            {
                Caption = 'Interface Impl.';
                Image = Process;
                ToolTip = 'Interface Impl.';

                trigger OnAction()
                var
                    BSBBookTypeDefaultImpl: Codeunit "BSB Book Type Default Impl.";
                    BSBBookTypeHardcoverImpl: Codeunit "BSB Book Type Hardcover Impl.";
                    BSBBookTypePaperbackImpl: Codeunit "BSB Book Type Paperback Impl.";
                    BSBBookTypeProcess: Interface "BSB Book Type Process";
                    IsHandled: Boolean;
                begin
                    // Handled-Event Pattern, mit dem Dependeny-Apps das Angebot/die Möglickeit haben,
                    // die Behandlung (z.B. des eBook) selber zu übernehmen.
                    OnBeforeHandleBookType(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "BSB Book Type"::Hardcover:
                            BSBBookTypeProcess := BSBBookTypeHardcoverImpl;
                        "BSB Book Type"::Paperback:
                            BSBBookTypeProcess := BSBBookTypePaperbackImpl;
                        else
                            BSBBookTypeProcess := BSBBookTypeDefaultImpl;
                    end;
                    BSBBookTypeProcess.StartDeployBook();
                    BSBBookTypeProcess.StartDeliverBook();
                end;
            }
        }
        area(Promoted)
        {
            actionref(ClassicImpl_Promoted; ClassicImpl) { }
            actionref(InterfaceImpl_Promoted; InterfaceImpl) { }
        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeHandleBookType(var Rec: Record "BSB Book"; var IsHandled: Boolean)
    begin
    end;
}
