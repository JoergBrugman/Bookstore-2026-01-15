interface "BSB Cust. Book Check Step"
{
    /// <summary>
    /// Performs the check.  
    /// </summary>
    /// <param name="Customer">Record Customer.</param>
    /// <returns>Return value of type Text.</returns>
    procedure Execute(Customer: Record Customer): Text;
    /// <summary>
    /// Returns the priority of the check as an integer. 
    /// Here, a low number has a high priority and larger numbers have a lower priority.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetSequence(): Integer;
    /// <summary>
    /// Determines whether the check should be performed. 
    /// </summary>
    /// <param name="Customer">Record Customer.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsEnabled(Customer: Record Customer): Boolean;
}