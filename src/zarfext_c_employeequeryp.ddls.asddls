extend view entity ZARF_C_EMPLOYEEQUERYP with
    association [1..1] to I_Country as _ZZCountryZem
    on $projection.ZzcountryZem = _ZZCountryZem.Country {
    Employee.ZzcountryZem,
    Employee.ZztitleZem,
    concat_with_space( Employee.FirstName, Employee.LastName, 1) as ZzFullNameZem,
    _ZZCountryZem.IsEuropeanUnionMember as ZZEUBasedZem
}
