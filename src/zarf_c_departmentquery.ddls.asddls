@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department (Query)'
@Metadata.ignorePropagatedAnnotations: true
define view entity zarf_c_departmentquery
  as select from ZARF_C_EMPLOYEEQUERY
{
      DepartmentId,
      DepartmentDescription,
      avg ( CompanyAffiliation as abap.dec(11,1) ) as AverageAffiliation,
      @Semantics.amount.currencyCode: 'currencyCodeUSD'
      sum(AnnualSalaryConverted) as TotalSalary,
      CurrencyCodeUSD
      
}
group by
    DepartmentId,
    DepartmentDescription,
    CurrencyCodeUSD

