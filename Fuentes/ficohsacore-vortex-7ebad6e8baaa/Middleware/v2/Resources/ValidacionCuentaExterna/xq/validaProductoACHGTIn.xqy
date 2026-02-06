xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validacionCuentaExterna" element="ns1:validacionCuentaExterna" location="../xsd/validacionCuentaExternaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ValidaQueriesRequest" location="../../../BusinessServices/ACH/ValidaProductoACH/EnviadoGT/xsd/_1.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ValidaQueriesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaExternaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionCuentaExterna/xq/validaProductoACHGTIn/";

declare function xf:validaProductoACHGTIn($validacionCuentaExterna as element(ns1:validacionCuentaExterna),
    $Operacion as xs:string,
    $BancoOrigen as xs:string,
    $Producto as xs:string,
    $Currency as xs:string,
    $BancoDestino as xs:string,
    $uuid as xs:string)
    as element(ns0:ValidaQueriesRequest) {
        <ns0:ValidaQueriesRequest>
            <Destination>{ $BancoDestino }</Destination>
            <Type>{ $Operacion }</Type>
            <Payload>
                <Account>{ data($validacionCuentaExterna/ACCOUNT_NUMBER) }</Account>
                <Currency>{ $Currency }</Currency>
                <Product>{ $Producto }</Product>
            </Payload>
            <Source>{ $BancoOrigen }</Source>
            <UUID>{ $uuid }</UUID>
        </ns0:ValidaQueriesRequest>
};

declare variable $validacionCuentaExterna as element(ns1:validacionCuentaExterna) external;
declare variable $Operacion as xs:string external;
declare variable $BancoOrigen as xs:string external;
declare variable $Producto as xs:string external;
declare variable $Currency as xs:string external;
declare variable $BancoDestino as xs:string external;
declare variable $uuid as xs:string external;

xf:validaProductoACHGTIn($validacionCuentaExterna,
    $Operacion,
    $BancoOrigen,
    $Producto,
    $Currency,
    $BancoDestino,
    $uuid)