codeunit 50122 "BSB Notif. Subscriber Store"
{
    var
        CredLimitNotif: Notification;
        CredLimitNotifIDTxt: label '63d43e33-b09b-4ee5-af6c-3d0d917b2b81', Locked = true;
        CredLimitNotifMsg: Label '%1 %2 of %3 %4 %5 is lager than %6', Comment = '"DEU"=%1 %2 of %3 %4 %5 is ist größer als %6';

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure CheckCreditLimit(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        if Rec."Bill-to Customer No." = '' then
            exit;
        Customer.SetAutoCalcFields("Balance (LCY)");
        Customer.Get(Rec."Bill-to Customer No.");
        if Customer."Credit Limit (LCY)" = 0 then
            exit;
        if Customer."Balance (LCY)" > Customer."Credit Limit (LCY)" then begin
            CredLimitNotif.Id := CredLimitNotifIDTxt;
            CredLimitNotif.Scope := CredLimitNotif.Scope::LocalScope;
            CredLimitNotif.Message(
                StrSubstNo(CredLimitNotifMsg,
                Customer.FieldCaption("Balance (LCY)"),
                Customer."Balance (LCY)",
                Customer.TableCaption,
                Customer."No.",
                Customer.Name,
                Customer."Credit Limit (LCY)")

            );
            CredLimitNotif.Send();
        end;
    end;
}