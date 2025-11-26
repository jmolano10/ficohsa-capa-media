(:: pragma bea:global-element-parameter parameter="$consultaInformacionHUELLA" element="ns0:consultaInformacionHUELLA" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaInformacionHuellaRequest" location="../../../BusinessServices/OIC/consultaInformacionHUELLA/xsd/XMLSchema_1993028425.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionHuellaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionHUELLA/xq/consultaInformacionHuellaGTIn/";

declare function xf:consultaInformacionHuellaGTIn($consultaInformacionHUELLA as element(ns0:consultaInformacionHUELLA),
    $device as xs:string,
    $method as xs:string)
    as element(ns1:consultaInformacionHuellaRequest) {
        <ns1:consultaInformacionHuellaRequest>
            <DEVICE>{ $device }</DEVICE>
            <METHOD>{ $method }</METHOD>
            <RIGHT_FINGER>{ data($consultaInformacionHUELLA/RIGHT_FINGER) }</RIGHT_FINGER>
            <RIGHT_CODE>{ data($consultaInformacionHUELLA/RIGHT_CODE) }</RIGHT_CODE>
            <FINGERLEFT>{ data($consultaInformacionHUELLA/LEFT_FINGER) }</FINGERLEFT>
            <LEFTCOD>{ data($consultaInformacionHUELLA/LEFT_CODE) }</LEFTCOD>
            <CUI>{ data($consultaInformacionHUELLA/CUI) }</CUI>
        </ns1:consultaInformacionHuellaRequest>
};

declare variable $consultaInformacionHUELLA as element(ns0:consultaInformacionHUELLA) external;
declare variable $device as xs:string external;
declare variable $method as xs:string external;

xf:consultaInformacionHuellaGTIn($consultaInformacionHUELLA,
    $device,
    $method)