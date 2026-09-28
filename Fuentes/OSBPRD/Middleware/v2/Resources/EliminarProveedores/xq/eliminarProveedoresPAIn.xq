xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$eliminarProveedores" element="ns1:eliminarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:eliminarTerceros" location="../../../BusinessServices/MTR/eliminadorTerceros/wsdl/eliminadorTercerosEndpoint.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EliminarProveedores/xq/eliminarProveedoresPAIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.cargartercerospmsws.mtrpmsv.cidenet.com.co/";

declare function xf:eliminarProveedoresPAIn($eliminarProveedores as element(ns1:eliminarProveedores),
    $requestHeader as element(ns2:RequestHeader))
    as element(ns0:eliminarTerceros) {
        <ns0:eliminarTerceros>
            <idCliente>{ data($eliminarProveedores/CUSTOMER_ID) }</idCliente>
            <idUsuario>{ data($requestHeader/Authentication/UserName) }</idUsuario>
            <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
            {
                let $SUPPLIERS := $eliminarProveedores/SUPPLIERS
                return
                    <terceros>
                        {
                            for $SUPPLIER in $SUPPLIERS/SUPPLIER
                            return
                                <tercero>
                                    <codigoTercero>{ data($SUPPLIER/ID) }</codigoTercero>
                                </tercero>
                        }
                    </terceros>
            }
        </ns0:eliminarTerceros>
};

declare variable $eliminarProveedores as element(ns1:eliminarProveedores) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:eliminarProveedoresPAIn($eliminarProveedores,
    $requestHeader)