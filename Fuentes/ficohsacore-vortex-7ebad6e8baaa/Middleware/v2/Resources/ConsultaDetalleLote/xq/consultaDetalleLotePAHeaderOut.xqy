xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarDetalleLoteResponse" element="ns0:consultarDetalleLoteResponse" location="../../../BusinessServices/MTR/consultorDetalleLote/wsdl/consultorDetalleLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleLote/xq/consultaDetalleLotePAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.consultadetallelotepmsws.mtrpmsv.cidenet.com.co/";

declare function xf:consultaDetalleLotePAHeaderOut($consultarDetalleLoteResponse as element(ns0:consultarDetalleLoteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $codigo in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/cabeceraRespuesta/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $consultarDetalleLoteResponse/respuestaConsultaDetalleLote/cabeceraRespuesta/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultarDetalleLoteResponse as element(ns0:consultarDetalleLoteResponse) external;

xf:consultaDetalleLotePAHeaderOut($consultarDetalleLoteResponse)