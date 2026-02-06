xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$editarEstadoLoteResponse" element="ns0:editarEstadoLoteResponse" location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLotePAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.editarlotews.mtrpmsv.cidenet.com.co/";

declare function xf:cancelarLotePAHeaderOut($editarEstadoLoteResponse as element(ns0:editarEstadoLoteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
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
        </ns1:ResponseHeader>
};

declare variable $editarEstadoLoteResponse as element(ns0:editarEstadoLoteResponse) external;

xf:cancelarLotePAHeaderOut($editarEstadoLoteResponse)