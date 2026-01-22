codeunit 50101 "BSB Book Type Hardcover Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Aus Lager entnehmen');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit UPS PREMIUM versenden');
    end;
}