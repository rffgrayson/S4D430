@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Query)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZARF_C_EMPLOYEEQUERYP
    with parameters 
        p_target_curr : /dmo/currency_code,
        @EndUserText.label: 'Date Of Evaluation'
        @Environment.systemField: #SYSTEM_DATE
        p_date        : abap.dats 
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
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion( amount => AnnualSalary, 
                             source_currency => CurrencyCode, 
                             target_currency => $projection.CurrencyCode, 
                             exchange_rate_date => $parameters.p_date
                           ) as AnnualSalaryConverted,
                           
      @EndUserText.label: 'Monthly Salary'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast ($projection.AnnualSalaryConverted as abap.fltp) / 12.0 as MonthlySalaryConverted, 
//      CurrencyCode,
//        cast ( 'USD' as /dmo/currency_code) as CurrencyCodeUSD,
        $parameters.p_target_curr as CurrencyCode,
//      AnnualSalary,
//      CurrencyCode,
//      CreatedBy,
//      CreatedAt,
//      LocalLastChangedBy,
//      LocalLastChangedAt,
//      LastChangedAt,
       division ( 
                    dats_days_between( EntryDate, $parameters.p_date), 
                    365, 
                    1 
                ) 
        as CompanyAffiliation,
      /* Associations */
      _Deparment
}
