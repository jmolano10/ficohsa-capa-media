<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$inscripcionesRENAP" element="ns1:inscripcionesRENAP" location="../../InscripcionesRENAP/xsd/inscripcionesRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionCUI" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/inscripcionesRENAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/InscripcionesRENAPGT/xq/consultaInformacionCUIGTIn/";

declare function xf:consultaInformacionCUIGTIn($inscripcionesRENAP as element(ns1:inscripcionesRENAP))
    as element(ns0:consultaInformacionCUI) {
        &lt;ns0:consultaInformacionCUI>
            &lt;CUI>{ data($inscripcionesRENAP/CUI) }&lt;/CUI>
        &lt;/ns0:consultaInformacionCUI>
};

declare variable $inscripcionesRENAP as element(ns1:inscripcionesRENAP) external;

xf:consultaInformacionCUIGTIn($inscripcionesRENAP)</con:xquery>
    <con:dependency location="../../InscripcionesRENAP/xsd/inscripcionesRENAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/InscripcionesRENAP/xsd/inscripcionesRENAPTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes"/>
    </con:dependency>
</con:xqueryEntry>