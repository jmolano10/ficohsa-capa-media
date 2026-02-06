xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cargarProveedores" element="ns1:cargarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:registrarTerceros" location="../../../BusinessServices/MTR/cargadorTerceros/wsdl/cargadorTercerosEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://servicio.cargartercerospmsws.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaProveedores/xq/cargaProveedoresGTIn/";

declare function xf:cargaProveedoresGTIn($requestHeader as element(ns0:RequestHeader),
    $cargarProveedores as element(ns1:cargarProveedores))
    as element(ns2:registrarTerceros) {
        <ns2:registrarTerceros>
            <idCliente>{ data($cargarProveedores/CUSTOMER_ID) }</idCliente>
            <idUsuario>{ data($cargarProveedores/USER_ID) }</idUsuario>
            <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
            {
                let $SUPPLIERS := $cargarProveedores/SUPPLIERS
                return
                    <terceros>
                        {
                            for $SUPPLIER in $SUPPLIERS/SUPPLIER
                            return
                                <tercero>
                                    <bancoDestino>{ data($SUPPLIER/DESTINATION_BANK) }</bancoDestino>
                                    <codigoProducto>{ data($SUPPLIER/ACCOUNT_NUMBER) }</codigoProducto>
                                    <codigoTercero>{ data($SUPPLIER/ID) }</codigoTercero>
                                    <identificacion>{ data($SUPPLIER/LEGAL_ID) }</identificacion>
                                    <nombre>{ data($SUPPLIER/NAME) }</nombre>
                                    {
                                        for $ACCOUNT_TYPE in $SUPPLIER/ACCOUNT_TYPE
                                        return
                                            <tipoProducto>{ data($ACCOUNT_TYPE) }</tipoProducto>
                                    }
                                </tercero>
                        }
                    </terceros>
            }
        </ns2:registrarTerceros>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $cargarProveedores as element(ns1:cargarProveedores) external;

xf:cargaProveedoresGTIn($requestHeader,
    $cargarProveedores)