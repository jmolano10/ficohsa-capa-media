<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaComsionSwift/xsd/consultaComisionSwift_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaComisionSwiftResponse" location="../xsd/consultaComisionSwiftTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionSwift";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionSwiftTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisionSwift/xq/consultaComisionSwiftPAOut/";

declare function xf:consultaComisionSwiftPAOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaComisionSwiftResponse) {
        <ns1:consultaComisionSwiftResponse>
            <CHARGE_CURRENCY>{ data($outputParameters/ns0:CHARGE_CURRENCY) }</CHARGE_CURRENCY>
            <CHARGE_AMOUNT>{ data($outputParameters/ns0:CHARGE_AMOUNT) }</CHARGE_AMOUNT>
        </ns1:consultaComisionSwiftResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaComisionSwiftPAOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaComsionSwift/xsd/consultaComisionSwift_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaComsionSwift/xsd/consultaComisionSwift_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaComisionSwiftTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaComisionSwift/xsd/consultaComisionSwiftTypes"/>
    </con:dependency>
</con:xqueryEntry>