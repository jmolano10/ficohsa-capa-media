xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autorizarLoteResponse" element="ns1:autorizarLoteResponse" location="../../../BusinessServices/MTR/autorizarLote/wsdl/autorizarLotesEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.enviosolicitudcoretask.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteGTHeaderOut/";

declare function xf:autorizarLoteGTHeaderOut($autorizarLoteResponse as element(ns1:autorizarLoteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $autorizarLoteResponse as element(ns1:autorizarLoteResponse) external;

xf:autorizarLoteGTHeaderOut($autorizarLoteResponse)