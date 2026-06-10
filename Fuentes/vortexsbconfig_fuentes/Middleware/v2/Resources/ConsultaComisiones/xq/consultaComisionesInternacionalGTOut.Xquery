<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaComisionSwiftResponse" element="ns1:consultaComisionSwiftResponse" location="../../../../Business_Resources/consultaComisionSWIFT/consultaComisionSwiftTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisionesResponse" location="../xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionSwiftTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionInternacionalGTOut/";

declare function xf:consultaComisionesInternacionalGTOut($consultaComisionSwiftResponse as element(ns1:consultaComisionSwiftResponse))
    as element(ns0:consultaComisionesResponse) {
        <ns0:consultaComisionesResponse>
            <CURRENCY>{ data($consultaComisionSwiftResponse/CHARGE_CURRENCY) }</CURRENCY>
            <AMOUNT>{ data($consultaComisionSwiftResponse/CHARGE_AMOUNT) }</AMOUNT>
        </ns0:consultaComisionesResponse>
};

declare variable $consultaComisionSwiftResponse as element(ns1:consultaComisionSwiftResponse) external;

xf:consultaComisionesInternacionalGTOut($consultaComisionSwiftResponse)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/consultaComisionSWIFT/consultaComisionSwiftTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaComisionSWIFT/consultaComisionSwiftTypes"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaComisionesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaComisiones/xsd/consultaComisionesTypes"/>
    </con:dependency>
</con:xqueryEntry>