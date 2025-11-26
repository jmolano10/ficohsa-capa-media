(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/RegistrarTxnCaja/RegistrarTxnCaja_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarTxnCaja";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/RegistrarPagoTarjetaCreditoIn_StringParams/";

declare function xf:RegistrarPagoTarjetaCreditoIn_StringParams($UUID as xs:string,
    $TellerID as xs:string,
    $TipoTransaccionCaja as xs:decimal,
    $Moneda as xs:string,
    $Monto as xs:decimal,
    $IDTransaccion as xs:string,
    $FechaT24 as xs:string,
    $Autorizador as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDUNICO>{ $UUID }</ns0:PV_IDUNICO>
            <ns0:PV_IDCAJERO>{ $TellerID }</ns0:PV_IDCAJERO>
            <ns0:PN_TXNCAJA>{ $TipoTransaccionCaja }</ns0:PN_TXNCAJA>
            <ns0:PV_MONEDA>{ $Moneda }</ns0:PV_MONEDA>
            <ns0:PN_MONTO>{ $Monto }</ns0:PN_MONTO>
            <ns0:PV_TXNIDT24>{ $IDTransaccion }</ns0:PV_TXNIDT24>
            <ns0:PD_FECHAT24>{ fn:concat(fn:substring($FechaT24,1,4),"-",fn:substring($FechaT24,5,2),"-",fn:substring($FechaT24,7,2)) }</ns0:PD_FECHAT24>
            <ns0:PV_AUTORIZADOR>{ $Autorizador }</ns0:PV_AUTORIZADOR>
        </ns0:InputParameters>
};

declare variable $UUID as xs:string external;
declare variable $TellerID as xs:string external;
declare variable $TipoTransaccionCaja as xs:decimal external;
declare variable $Moneda as xs:string external;
declare variable $Monto as xs:decimal external;
declare variable $IDTransaccion as xs:string external;
declare variable $FechaT24 as xs:string external;
declare variable $Autorizador as xs:string external;

xf:RegistrarPagoTarjetaCreditoIn_StringParams($UUID,
    $TellerID,
    $TipoTransaccionCaja,
    $Moneda,
    $Monto,
    $IDTransaccion,
    $FechaT24,
    $Autorizador)
