(:: pragma bea:global-element-parameter parameter="$eliminarTercerosResponse" element="ns1:eliminarTercerosResponse" location="../../../BusinessServices/MTR/eliminadorTerceros/wsdl/eliminadorTercerosEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.cargartercerospmsws.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EliminarProveedores/xq/eliminarProveedoresGTHeaderOut/";

declare function xf:eliminarProveedoresGTHeaderOut($eliminarTercerosResponse as element(ns1:eliminarTercerosResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $eliminarTercerosResponse as element(ns1:eliminarTercerosResponse) external;

xf:eliminarProveedoresGTHeaderOut($eliminarTercerosResponse)