(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/iNSTransaccionRedencion/xsd/INSTransaccionRedencion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/INSTransaccionRedencion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RedencionPuntosLealtad/xq/insTransaccionRedencion/";

declare function xf:insTransaccionRedencion($numeroTarjeta as xs:string,
    $monto as xs:string,
    $comercio as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:NumeroTarjeta>{ data($numeroTarjeta) }</ns0:NumeroTarjeta>
            <ns0:Monto>{ data($monto) }</ns0:Monto>
            <ns0:Comercio>{ data($comercio) }</ns0:Comercio>
            <ns0:Descripcion>DESC 35</ns0:Descripcion>
        </ns0:InputParameters>
};

declare variable $numeroTarjeta as xs:string external;
declare variable $monto as xs:string external;
declare variable $comercio as xs:string external;

xf:insTransaccionRedencion($numeroTarjeta,
    $monto,
    $comercio)