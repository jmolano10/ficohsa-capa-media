(:: pragma bea:global-element-parameter parameter="$inscripcionesRENAP" element="ns1:inscripcionesRENAP" location="../../InscripcionesRENAP/xsd/inscripcionesRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionCUI" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/inscripcionesRENAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/InscripcionesRENAPGT/xq/consultaInformacionCUIGTIn/";

declare function xf:consultaInformacionCUIGTIn($inscripcionesRENAP as element(ns1:inscripcionesRENAP))
    as element(ns0:consultaInformacionCUI) {
        <ns0:consultaInformacionCUI>
            <CUI>{ data($inscripcionesRENAP/CUI) }</CUI>
        </ns0:consultaInformacionCUI>
};

declare variable $inscripcionesRENAP as element(ns1:inscripcionesRENAP) external;

xf:consultaInformacionCUIGTIn($inscripcionesRENAP)