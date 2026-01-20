CLASS zcl_arf_path_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ARF_PATH_EXPR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT
    FROM zarf_c_employeequery
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
           DepartmentDescription,
           AssistantName,
           \_deparment\_head-lastname AS headname
    INTO TABLE @DATA(result).

    out->write( result ).

  ENDMETHOD.
ENDCLASS.
