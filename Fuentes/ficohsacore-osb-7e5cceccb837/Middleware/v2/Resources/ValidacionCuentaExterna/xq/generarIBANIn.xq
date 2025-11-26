(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/generarCuentaIBAN/xsd/generarCuentaIBAN_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/generarCuentaIBAN";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionCuentaExterna/xq/generarIBANIn/";

declare function xf:generarIBANIn($swift as xs:string,
    $cuenta as xs:string,
    $pais as xs:string,
    $moneda as xs:string,
    $producto as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SWIFT>{ $swift }</ns0:PV_SWIFT>
            <ns0:PV_NUMERO_CUENTA>{ $cuenta }</ns0:PV_NUMERO_CUENTA>
            <ns0:PV_PAIS>GT</ns0:PV_PAIS>
            <ns0:PV_MONEDA_PRODUCTO>{ $moneda }</ns0:PV_MONEDA_PRODUCTO>
            <ns0:PV_TIPO_PRODUCTO>{ $producto }</ns0:PV_TIPO_PRODUCTO>
        </ns0:InputParameters>
};

declare variable $swift as xs:string external;
declare variable $cuenta as xs:string external;
declare variable $pais as xs:string external;
declare variable $moneda as xs:string external;
declare variable $producto as xs:string external;

xf:generarIBANIn($swift,
    $cuenta,
    $pais,
    $moneda,
    $producto)
