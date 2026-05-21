<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetValidProductCustomerTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension/CloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $Request as element() (:: schema-element(ns1:getValidProductCustomer) ::) external;

declare function local:format-date-FPC($fecha as xs:string) as xs:string {
  let $year := fn:substring($fecha, 1, 4)
  let $month := fn:substring($fecha, 6, 2)
  let $day := fn:substring($fecha, 9, 2)
  return fn:concat($day, '-', $month, '-',$year )
};

declare function local:funcGetValidProductCustomerToCloudCode($Request as element() (:: schema-element(ns1:getValidProductCustomer) ::)) as element() (:: schema-element(ns2:cloudCode) ::) {
    let $currentDate := xs:string(fn:current-date())
    return
    <ns2:cloudCode>
        <codigoCuenta>{fn:data($Request/AccountCode)}</codigoCuenta>
        <fechaInicialConsulta>{local:format-date-FPC($currentDate)}</fechaInicialConsulta>
        <fechaFinalConsulta>{local:format-date-FPC($currentDate)}</fechaFinalConsulta>
    </ns2:cloudCode>
};

local:funcGetValidProductCustomerToCloudCode($Request)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetValidProductCustomerTypes.xsd">
            <con:schema ref="SBHN_Pension_GetValidProductCustomer/Schemas/GetValidProductCustomerTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetValidProductCustomer/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>