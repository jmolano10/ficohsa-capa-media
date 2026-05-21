<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetAssetsCustomerTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:InputParameters) ::) external;

declare function local:func($request as element() (:: schema-element(ns1:InputParameters) ::)) as element() (:: schema-element(ns2:saldos) ::) {
    <ns2:saldos>
        <ns2:codigoTipoIdentificacion>{fn:data($request/PV_IDENTIFICATION_TYPE)}</ns2:codigoTipoIdentificacion>
        <ns2:numeroIdentificacion>{fn:data($request/PV_IDENTIFICACION)}</ns2:numeroIdentificacion>
    </ns2:saldos>
};

local:func($request)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetAssetsCustomerTypes.xsd">
            <con:schema ref="SBHN_Pension_GetAssetsCustomer/Schemas/GetAssetsCustomerTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>