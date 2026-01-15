permissionset 50100 "BSB BOOKSTORE, EDIT"
{
    // Assignable = true;
    Caption = 'Create and Modify Books etc.';
    Permissions =
        tabledata "BSB Book" = RIMD,
        table "BSB Book" = X;
}