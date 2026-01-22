@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department (Query)'
@Metadata.ignorePropagatedAnnotations: true
define view entity zarf_c_departmentquery
    with parameters 
        p_target_curr : /dmo/currency_code,
        @EndUserText.label: 'Date Of Evaluation'
        @Environment.systemField: #SYSTEM_DATE
        p_date        : abap.dats 
  as select from ZARF_C_EMPLOYEEQUERYP( 
                                p_target_curr: $parameters.p_target_curr, 
                                p_date:$parameters.p_date  
                                ) as e  
                right outer join ZARF_R_DEPARTMENT as d
                on e.DepartmentId = d.Id
{   
      d.Id,
      d.Description,
      avg ( e.CompanyAffiliation as abap.dec(11,1) ) as AverageAffiliation,
      @Semantics.amount.currencyCode: 'currencyCode'
      sum(e.AnnualSalaryConverted) as TotalSalary,
      e.CurrencyCode
      
}
group by
    d.Id,
    d.Description,
    e.CurrencyCode

