xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$autorizarLoteResponse" element="ns0:autorizarLoteResponse" location="../../../BusinessServices/MTR/autorizarLote/wsdl/autorizarLotesEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLotePAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.enviosolicitudcoretask.mtrpmsv.cidenet.com.co/";

declare function xf:autorizarLotePAHeaderOut($autorizarLoteResponse as element(ns0:autorizarLoteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $codigo in $autorizarLoteResponse/respuestaAutorizacionLotes/cabeceraRespuesta/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $autorizarLoteResponse/respuestaAutorizacionLotes/cabeceraRespuesta/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $autorizarLoteResponse as element(ns0:autorizarLoteResponse) external;

xf:autorizarLotePAHeaderOut($autorizarLoteResponse)