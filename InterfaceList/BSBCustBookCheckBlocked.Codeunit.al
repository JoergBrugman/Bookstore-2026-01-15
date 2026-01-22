codeunit 50113 "BSB Cust. Book Check Blocked" implements "BSB Cust. Book Check Step"
{
    procedure Execute(Customer: Record Customer): Text
    begin
        if Customer.Blocked <> "Customer Blocked"::" " then
            Exit(StrSubstNo('Debitor ist gesperrt im Status %1', Customer.Blocked));
    end;

    procedure GetSequence(): Integer
    begin
        exit(100);
    end;

    procedure IsEnabled(Customer: Record Customer): Boolean
    begin
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BSB Cust. Book Check Pipeline", OnRegisterCustBookCheckSteps, '', false, false)]
    local procedure "BSB Cust. Book Check Pipeline_OnRegisterCustBookCheckSteps"(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    begin
        Steps.Add(this);
    end;

}