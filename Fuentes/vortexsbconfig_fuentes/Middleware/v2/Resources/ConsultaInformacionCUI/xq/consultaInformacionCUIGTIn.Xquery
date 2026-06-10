<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaInformacionCUI" element="ns1:consultaInformacionCUI" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionCUIRequest" location="../../../BusinessServices/OIC/consultaInformacionCUI/xsd/XMLSchema_-198101730.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionCUITypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionCUI/xq/consultaInformacionCUIGTIn/";

declare function xf:consultaInformacionCUIGTIn($consultaInformacionCUI as element(ns1:consultaInformacionCUI))
    as element(ns0:consultaInformacionCUIRequest) {
        &lt;ns0:consultaInformacionCUIRequest>
            &lt;PN_CUI>{ data($consultaInformacionCUI/CUI) }&lt;/PN_CUI>
        &lt;/ns0:consultaInformacionCUIRequest>
};

declare variable $consultaInformacionCUI as element(ns1:consultaInformacionCUI) external;

xf:consultaInformacionCUIGTIn($consultaInformacionCUI)</con:xquery>
    <con:dependency location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/OIC/consultaInformacionCUI/xsd/XMLSchema_-198101730.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OIC/consultaInformacionCUI/xsd/XMLSchema_-198101730"/>
    </con:dependency>
</con:xqueryEntry>