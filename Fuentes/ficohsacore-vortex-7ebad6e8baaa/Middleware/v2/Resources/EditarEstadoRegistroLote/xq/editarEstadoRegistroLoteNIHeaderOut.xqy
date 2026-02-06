xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$editarValidezRegistroLoteResponse" element="ns1:editarValidezRegistroLoteResponse" location="../../../BusinessServices/MTR/editorRegistroLote/wsdl/editorRegistroLoteEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.editarregistrolotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EditarEstadoRegistroLote/xq/editarEstadoRegistroLoteHeaderNIOut/";

declare function xf:editarEstadoRegistroLoteHeaderNIOut($editarValidezRegistroLoteResponse as element(ns1:editarValidezRegistroLoteResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $editarValidezRegistroLoteResponse as element(ns1:editarValidezRegistroLoteResponse) external;

xf:editarEstadoRegistroLoteHeaderNIOut($editarValidezRegistroLoteResponse)