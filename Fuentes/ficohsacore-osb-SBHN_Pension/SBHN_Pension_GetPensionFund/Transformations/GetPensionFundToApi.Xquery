<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/GetPensionFundTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:getPensionFund) ::) external;

declare function local:func($request as element() (:: schema-element(ns1:getPensionFund) ::)) as element() (:: schema-element(ns2:cuentasFondosPensiones) ::) {
    &lt;ns2:cuentasFondosPensiones>
        &lt;ns2:codigoCuenta>{fn:data($request/AccountCode)}&lt;/ns2:codigoCuenta>
    &lt;/ns2:cuentasFondosPensiones>
};

local:func($request)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetPensionFundTypes.xsd">
            <con:schema ref="SBHN_Pension_GetPensionFund/Schemas/GetPensionFundTypes"/>
        </con:importSchema>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>