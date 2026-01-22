codeunit 50119 "BSB Cust. Book Check B. Compl." implements "BSB Cust. Book Check Step"
{
    procedure Execute(Customer: Record Customer): Text
    var
        BSBBook: Record "BSB Book";
    begin
        BSBBook.Get(Customer."BSB Favorite Book No.");
        if (BSBBook.Description = '') or
            (BSBBook.Author = '') or
            (BSBBook."No. of Pages" = 0) or
            (BSBBook."Date of Publishing" = 0D)
        then
            exit(StrSubstNo('Das %1 %2 ist nicht vollstäg gefüllt', BSBBook.TableCaption, BSBBook."No."))
    end;

    procedure GetSequence(): Integer
    begin
        exit(50);
    end;

    procedure IsEnabled(Customer: Record Customer): Boolean
    begin
        exit(Customer."BSB Favorite Book No." <> '');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BSB Cust. Book Check Pipeline", OnRegisterCustBookCheckSteps, '', false, false)]
    local procedure "BSB Cust. Book Check Pipeline_OnRegisterCustBookCheckSteps"(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    begin
        Steps.Add(this);
    end;

}