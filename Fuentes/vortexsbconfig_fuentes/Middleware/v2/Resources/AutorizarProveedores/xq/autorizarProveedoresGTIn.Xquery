<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autorizarProveedores" element="ns1:autorizarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:autorizarTerceros" location="../../../BusinessServices/MTR/autorizadorTerceros/wsdl/autorizadorTercerosEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://servicio.autorizartercerosws.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarProveedores/xq/autorizarProveedoresGTIn/";

declare function xf:autorizarProveedoresGTIn($requestHeader as element(ns0:RequestHeader),
    $autorizarProveedores as element(ns1:autorizarProveedores))
    as element(ns2:autorizarTerceros) {
        <ns2:autorizarTerceros>
            <idCliente>{ data($autorizarProveedores/CUSTOMER_ID) }</idCliente>
            <idUsuario>{ data($autorizarProveedores/USER_ID) }</idUsuario>
            <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
            {
                let $SUPPLIERS := $autorizarProveedores/SUPPLIERS
                return
                    <terceros>
                        {
                            for $SUPPLIER in $SUPPLIERS/SUPPLIER
                            return
                                <tercero>
                                    <id>{ data($SUPPLIER/ID) }</id>
                                </tercero>
                        }
                    </terceros>
            }
        </ns2:autorizarTerceros>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $autorizarProveedores as element(ns1:autorizarProveedores) external;

xf:autorizarProveedoresGTIn($requestHeader,
    $autorizarProveedores)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MTR/autorizadorTerceros/wsdl/autorizadorTercerosEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/autorizadorTerceros/wsdl/autorizadorTercerosEndpoint"/>
    </con:dependency>
</con:xqueryEntry>