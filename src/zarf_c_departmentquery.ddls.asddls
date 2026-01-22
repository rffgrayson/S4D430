@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department (Query)'
@Metadata.ignorePropagatedAnnotations: true
define view entity zarf_c_departmentquery
  as select distinct from ZARF_C_EMPLOYEEQUERY
{
      DepartmentId,
      DepartmentDescription
}
