codeunit 50101 "BSB Book Type AllInOne"
{
    procedure StartDeployBookHardcover()
    begin
        Message('Aus Lager entnehmen');
    end;

    procedure StartDeliverBookHardcover()
    begin
        Message('Mit UPS PREMIUM versenden');
    end;

    procedure StartDeployBooPaperback()
    begin
        Message('Print on demand');
    end;

    procedure StartDeliverBookPaperback()
    begin
        Message('Mit DPD Standard Schneckkenpost versenden');
    end;

    procedure StartDeployBookEmpty()
    begin
        message('Nicht implementiert');
    end;

    procedure StartDeliverBookEmpty()
    begin
        Message('Nicht implementiert');
    end;
}