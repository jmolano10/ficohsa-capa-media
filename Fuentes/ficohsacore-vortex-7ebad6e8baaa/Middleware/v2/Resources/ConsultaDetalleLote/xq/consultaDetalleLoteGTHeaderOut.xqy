xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarDetalleLoteResponse" element="ns1:consultarDetalleLoteResponse" location="../../../BusinessServices/MTR/consultorDetalleLote/wsdl/consultorDetalleLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.consultadetallelotepmsws.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleLote/xq/consultaDetalleLoteGTHeaderOut/";

declare function xf:consultaDetalleLoteGTHeaderOut($consultarDetalleLoteResponse as element(ns1:consultarDetalleLoteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $consultarDetalleLoteResponse as element(ns1:consultarDetalleLoteResponse) external;

xf:consultaDetalleLoteGTHeaderOut($consultarDetalleLoteResponse)