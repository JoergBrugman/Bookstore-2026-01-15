codeunit 50110 "BSB Cust. Book Check Pipeline"
{
    procedure ProcessPipeline(Customer: Record Customer)
    var
        Step: Interface "BSB Cust. Book Check Step";
        Steps: List of [Interface "BSB Cust. Book Check Step"];
    begin
        CollectSteps(Steps);
        SortSteps(Steps);

        foreach Step in Steps do
            if Step.IsEnabled(Customer) then
                Message(Step.Execute(Customer));
    end;

    local procedure CollectSteps(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    begin
        OnRegisterCustBookCheckSteps(Steps);
    end;

    local procedure SortSteps(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    begin
        ;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRegisterCustBookCheckSteps(var Steps: List of [Interface "BSB Cust. Book Check Step"])
    begin
    end;

}