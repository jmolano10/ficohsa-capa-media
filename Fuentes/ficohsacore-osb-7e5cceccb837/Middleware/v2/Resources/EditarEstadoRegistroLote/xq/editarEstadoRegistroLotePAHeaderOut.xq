xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$editarValidezRegistroLoteResponse" element="ns0:editarValidezRegistroLoteResponse" location="../../../BusinessServices/MTR/editorRegistroLote/wsdl/editorRegistroLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EditarEstadoRegistroLote/xq/editarEstadoRegistroLotePAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.editarregistrolotews.mtrpmsv.cidenet.com.co/";

declare function xf:editarEstadoRegistroLotePAHeaderOut($editarValidezRegistroLoteResponse as element(ns0:editarValidezRegistroLoteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $codigo in $editarValidezRegistroLoteResponse/respuestaEditarRegistroLote/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensajes in $editarValidezRegistroLoteResponse/respuestaEditarRegistroLote/mensajes[1]
                return
                    <messages>{ string-join($editarValidezRegistroLoteResponse/respuestaEditarRegistroLote/mensajes, '. ') }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $editarValidezRegistroLoteResponse as element(ns0:editarValidezRegistroLoteResponse) external;

xf:editarEstadoRegistroLotePAHeaderOut($editarValidezRegistroLoteResponse)