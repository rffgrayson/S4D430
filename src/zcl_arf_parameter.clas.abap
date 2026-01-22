CLASS zcl_arf_parameter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ARF_PARAMETER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT
*    FROM /LRN/C_Employee_Ann
      FROM zarf_c_employeequeryp(
      p_target_curr = 'JPY'
*      p_date = @sy-datum
      )
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
           departmentdescription,
           assistantname,
           \_deparment\_head-lastname AS headname,
            MonthlySalaryConverted,
            CurrencyCode,
            CompanyAffiliation
    INTO TABLE @DATA(result).

    out->write( result ).

  ENDMETHOD.
ENDCLASS.
