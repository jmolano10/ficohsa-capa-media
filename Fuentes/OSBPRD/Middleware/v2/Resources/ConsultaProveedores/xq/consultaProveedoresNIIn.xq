(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultarProveedores" element="ns1:consultarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultarTerceros" location="../../../BusinessServices/MTR/consultorTerceros/wsdl/consultorTercerosEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://servicio.consultatercerospmsws.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProveedores/xq/consultaProveedoresNIIn/";

declare function xf:consultaProveedoresNIIn($requestHeader as element(ns0:RequestHeader),
    $consultarProveedores as element(ns1:consultarProveedores))
    as element(ns2:consultarTerceros) {
        <ns2:consultarTerceros>
            <idCliente>{ data($consultarProveedores/CUSTOMER_ID) }</idCliente>
            <idUsuario>{ data($requestHeader/Authentication/UserName) }</idUsuario>
            <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
            <activo>
                {
                    let $activo  := (data($consultarProveedores/SUPPLIER_STATUS))  
                    return
                        if ($activo = 'AUT') then
                            ('S')
                        else 
                            'N'
                }
</activo>
        </ns2:consultarTerceros>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultarProveedores as element(ns1:consultarProveedores) external;

xf:consultaProveedoresNIIn($requestHeader,
    $consultarProveedores)