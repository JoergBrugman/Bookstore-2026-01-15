codeunit 50118 "BSB Cust. Book Check B.Blocked" implements "BSB Cust. Book Check Step"
{
    procedure Execute(Customer: Record Customer): Text
    var
        BSBBook: Record "BSB Book";
    begin
        BSBBook.Get(Customer."BSB Favorite Book No.");
        if BSBBook.Blocked then
            exit(StrSubstNo('Das %1 %2 ist gesperrt', BSBBook.TableCaption, BSBBook."No."));
    end;

    procedure GetSequence(): Integer
    begin
        exit(200);
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