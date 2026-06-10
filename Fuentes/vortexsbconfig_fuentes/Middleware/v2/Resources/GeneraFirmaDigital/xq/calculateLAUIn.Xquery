<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaFirmaDigital" element="ns1:generaFirmaDigital" location="../../OperacionesPagosGlobales/xsd/operacionesPagosGlobalesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:calculateLAURequest" location="../../../BusinessServices/LAUCalculator/wsdl/lauCalculator.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/lauCalculatorTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesPagosGlobalesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraFirmaDigital/xq/calculateLAUIn/";

declare function xf:calculateLAUIn($generaFirmaDigital as element(ns1:generaFirmaDigital),
    $lauKey as xs:string)
    as element(ns0:calculateLAURequest) {
        <ns0:calculateLAURequest>
            <LAUApplicationID>{ data($generaFirmaDigital/LAU_APPLICATION_ID) }</LAUApplicationID>
            <LAUCallTime>{ data($generaFirmaDigital/LAU_CALLTIME) }</LAUCallTime>
            <LAURequestNonce>{ data($generaFirmaDigital/LAU_REQUEST_NONCE) }</LAURequestNonce>
            <LAUSigned>{ data($generaFirmaDigital/LAU_SIGNED) }</LAUSigned>
            <LAUKey>{ $lauKey }</LAUKey>
            <absPath>{ data($generaFirmaDigital/ABS_PATH) }</absPath>
            <requestBody>{ data($generaFirmaDigital/REQUEST_BODY) }</requestBody>
            <LAUVersion>{ data($generaFirmaDigital/LAU_VERSION) }</LAUVersion>
        </ns0:calculateLAURequest>
};

declare variable $generaFirmaDigital as element(ns1:generaFirmaDigital) external;
declare variable $lauKey as xs:string external;

xf:calculateLAUIn($generaFirmaDigital,
    $lauKey)]]></con:xquery>
    <con:dependency location="../../OperacionesPagosGlobales/xsd/operacionesPagosGlobalesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesPagosGlobales/xsd/operacionesPagosGlobalesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/LAUCalculator/wsdl/lauCalculator.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/LAUCalculator/wsdl/lauCalculator"/>
    </con:dependency>
</con:xqueryEntry>