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
//      _Deparment._Assistant.LastName as AssistantName,
        concat_with_space( _Deparment._Assistant.FirstName, 
                            _Deparment._Assistant.LastName,
                            1 ) as AssistantName,
      case EmployeeId 
        when _Deparment.HeadId then 'H'
        when _Deparment.AssistantId then 'A'
        else ''
      end as EmployeeRole,
      @EndUserText.label: 'Annual Salary'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      currency_conversion( amount => AnnualSalary, 
                             source_currency => CurrencyCode, 
                             target_currency => $projection.CurrencyCodeUSD, 
                             exchange_rate_date => $session.system_date 
                           ) as AnnualSalaryConverted,
                           
      @EndUserText.label: 'Monthly Salary'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      cast ($projection.AnnualSalaryConverted as abap.fltp) / 12.0 as MonthlySalaryConverted, 
//      CurrencyCode,
        cast ( 'USD' as /dmo/currency_code) as CurrencyCodeUSD,
//      AnnualSalary,
//      CurrencyCode,
//      CreatedBy,
//      CreatedAt,
//      LocalLastChangedBy,
//      LocalLastChangedAt,
//      LastChangedAt,
       division ( 
                    dats_days_between( EntryDate, $session.system_date), 
                    365, 
                    1 
                ) 
        as CompanyAffiliation,
      /* Associations */
      _Deparment
}
