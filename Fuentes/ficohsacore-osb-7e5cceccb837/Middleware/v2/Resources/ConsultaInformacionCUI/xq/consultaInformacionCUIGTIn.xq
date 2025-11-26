(:: pragma bea:global-element-parameter parameter="$consultaInformacionCUI" element="ns1:consultaInformacionCUI" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionCUIRequest" location="../../../BusinessServices/OIC/consultaInformacionCUI/xsd/XMLSchema_-198101730.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionCUITypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionCUI/xq/consultaInformacionCUIGTIn/";

declare function xf:consultaInformacionCUIGTIn($consultaInformacionCUI as element(ns1:consultaInformacionCUI))
    as element(ns0:consultaInformacionCUIRequest) {
        <ns0:consultaInformacionCUIRequest>
            <PN_CUI>{ data($consultaInformacionCUI/CUI) }</PN_CUI>
        </ns0:consultaInformacionCUIRequest>
};

declare variable $consultaInformacionCUI as element(ns1:consultaInformacionCUI) external;

xf:consultaInformacionCUIGTIn($consultaInformacionCUI)