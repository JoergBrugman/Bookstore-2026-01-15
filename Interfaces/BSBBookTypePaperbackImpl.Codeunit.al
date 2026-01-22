codeunit 50102 "BSB Book Type Paperback Impl." implements "BSB Book Type Process V2"
{
    procedure StartDeployBook()
    begin
        Message('Print on demand');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit DPD Standard Schneckkenpost versenden');
    end;

    procedure CheckBook()
    begin
        Message('Qualitätsprüfung durchführen');
    end;
}
