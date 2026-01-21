@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Query)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZARF_C_EMPLOYEEQUERY
  as select from ZARF_R_EMPLOYEE
{
  key EmployeeId,
      FirstName,
      LastName,
//      BirthDate,
//      EntryDate,
      DepartmentId,
      _Deparment.Description    as DepartmentDescription,
      _Deparment._Assistant.LastName as AssistantName,
      case EmployeeId 
        when _Deparment.HeadId then 'H'
        when _Deparment.AssistantId then 'A'
        else ''
      end as EmployeeRole,
//      AnnualSalary,
//      CurrencyCode,
//      CreatedBy,
//      CreatedAt,
//      LocalLastChangedBy,
//      LocalLastChangedAt,
//      LastChangedAt,
      /* Associations */
      _Deparment
}
