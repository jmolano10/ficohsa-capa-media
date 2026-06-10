<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$eliminarProveedores" element="ns1:eliminarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:eliminarTerceros" location="../../../BusinessServices/MTR/eliminadorTerceros/wsdl/eliminadorTercerosEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://servicio.cargartercerospmsws.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EliminarProveedores/xq/eliminarProveedoresGTIn/";

declare function xf:eliminarProveedoresGTIn($eliminarProveedores as element(ns1:eliminarProveedores),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns2:eliminarTerceros) {
        <ns2:eliminarTerceros>
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
        </ns2:eliminarTerceros>
};

declare variable $eliminarProveedores as element(ns1:eliminarProveedores) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:eliminarProveedoresGTIn($eliminarProveedores,
    $requestHeader)]]></con:xquery>
    <con:dependency location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MTR/eliminadorTerceros/wsdl/eliminadorTercerosEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/eliminadorTerceros/wsdl/eliminadorTercerosEndpoint"/>
    </con:dependency>
</con:xqueryEntry>