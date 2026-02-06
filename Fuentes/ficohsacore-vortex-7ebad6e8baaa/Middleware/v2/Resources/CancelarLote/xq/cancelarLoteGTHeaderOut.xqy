xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$editarEstadoLoteResponse" element="ns1:editarEstadoLoteResponse" location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.editarlotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLoteGTHeaderOut/";

declare function xf:cancelarLoteGTHeaderOut($editarEstadoLoteResponse as element(ns1:editarEstadoLoteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $codigo in $editarEstadoLoteResponse/respuestaEdicionLote/cabeceraRespuesta/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $editarEstadoLoteResponse/respuestaEdicionLote/cabeceraRespuesta/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $editarEstadoLoteResponse as element(ns1:editarEstadoLoteResponse) external;

xf:cancelarLoteGTHeaderOut($editarEstadoLoteResponse)