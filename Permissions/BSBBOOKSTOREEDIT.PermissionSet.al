permissionset 50100 "BSB BOOKSTORE, EDIT"
{
    // Assignable = true;
    Caption = 'Create and Modify Books etc.';
    Permissions =
        tabledata "BSB Book" = RIMD,
        table "BSB Book" = X,
        table "BSB AL Issue" = X,
        tabledata "BSB AL Issue" = RIMD,
        table "BSB Internal Log" = X,
        tabledata "BSB Internal Log" = RIMD;
}