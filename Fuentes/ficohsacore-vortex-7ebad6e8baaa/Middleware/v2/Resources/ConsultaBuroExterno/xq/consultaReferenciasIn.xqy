xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaBuroExterno" element="ns1:consultaBuroExterno" location="../xsd/consultaBuroExternoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaReferencias" location="../../../BusinessServices/APC/wsdl/APC.asmx.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaBuroExternoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBuroExterno/xq/consultaReferenciasIn/";

declare function xf:consultaReferenciasIn($consultaBuroExterno as element(ns1:consultaBuroExterno))
    as element(ns0:ConsultaReferencias) {
        <ns0:ConsultaReferencias>
            <ns0:_request>
                <ns0:TipoIdentificacion>{ data($consultaBuroExterno/ID_TYPE) }</ns0:TipoIdentificacion>
                <ns0:NumeroIdentificacion>{ data($consultaBuroExterno/ID_VALUE) }</ns0:NumeroIdentificacion>
            </ns0:_request>
        </ns0:ConsultaReferencias>
};

declare variable $consultaBuroExterno as element(ns1:consultaBuroExterno) external;

xf:consultaReferenciasIn($consultaBuroExterno)