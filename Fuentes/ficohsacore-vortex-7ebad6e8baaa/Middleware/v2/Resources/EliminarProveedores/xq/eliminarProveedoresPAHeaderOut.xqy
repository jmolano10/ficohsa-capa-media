xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$eliminarTercerosResponse" element="ns0:eliminarTercerosResponse" location="../../../BusinessServices/MTR/eliminadorTerceros/wsdl/eliminadorTercerosEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EliminarProveedores/xq/eliminarProveedoresPAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.cargartercerospmsws.mtrpmsv.cidenet.com.co/";

declare function xf:eliminarProveedoresPAHeaderOut($eliminarTercerosResponse as element(ns0:eliminarTercerosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $codigo in $eliminarTercerosResponse/respuestaEliminacionTerceros/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $eliminarTercerosResponse/respuestaEliminacionTerceros/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $eliminarTercerosResponse as element(ns0:eliminarTercerosResponse) external;

xf:eliminarProveedoresPAHeaderOut($eliminarTercerosResponse)