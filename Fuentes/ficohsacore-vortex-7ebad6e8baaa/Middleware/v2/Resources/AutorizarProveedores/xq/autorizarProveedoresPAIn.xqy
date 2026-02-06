xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autorizarProveedores" element="ns1:autorizarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:autorizarTerceros" location="../../../BusinessServices/MTR/autorizadorTerceros/wsdl/autorizadorTercerosEndpoint.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarProveedores/xq/autorizarProveedoresPAIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.autorizartercerosws.mtrpmsv.cidenet.com.co/";

declare function xf:autorizarProveedoresPAIn($requestHeader as element(ns2:RequestHeader),
    $autorizarProveedores as element(ns1:autorizarProveedores))
    as element(ns0:autorizarTerceros) {
        <ns0:autorizarTerceros>
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
        </ns0:autorizarTerceros>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $autorizarProveedores as element(ns1:autorizarProveedores) external;

xf:autorizarProveedoresPAIn($requestHeader,
    $autorizarProveedores)