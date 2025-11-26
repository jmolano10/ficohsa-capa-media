(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/TransaccionesAsincronas/DB/RegistrarPagoTCCB/xsd/registraPagoTCCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoTCCB";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/registrarTransaccionTCCB_dbIn/";

declare function xf:registrarTransaccionTCCB_dbIn($cardNumber as xs:string,
    $merchantNumber as xs:string,
    $currencyType as xs:string,
    $org as xs:string,
    $transactionCurrency as xs:string,
    $exchangeRate as xs:string,
    $userName as xs:string,
    $channelSequence as xs:string,
    $paymentAmount as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string,
    $validDate as xs:string,
    $uuid as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_MERCHANTNUMBER>{ $merchantNumber }</ns0:PV_MERCHANTNUMBER>
            <ns0:PV_NUMEROTARJETA>{ $cardNumber }</ns0:PV_NUMEROTARJETA>
            <ns0:PV_TIPOOPERACION>C</ns0:PV_TIPOOPERACION>
            <ns0:PN_TIPOMONEDA>{ data($currencyType) }</ns0:PN_TIPOMONEDA>
            <ns0:PN_ORGANIZACION>{ data($org) }</ns0:PN_ORGANIZACION>
            <ns0:PV_MONEDATRANSACCION>{ $transactionCurrency }</ns0:PV_MONEDATRANSACCION>
            <ns0:PN_TASACAMBIO>{ data($exchangeRate) }</ns0:PN_TASACAMBIO>
            <ns0:PN_TIPOTRANSACCION>1</ns0:PN_TIPOTRANSACCION>
            <ns0:PV_CODIGOUSUARIO>{ $userName }</ns0:PV_CODIGOUSUARIO>
            <ns0:PV_SECUENCIAORIGEN>{ $channelSequence }</ns0:PV_SECUENCIAORIGEN>
            <ns0:PN_VALOREFECTIVO>{ data($paymentAmount) }</ns0:PN_VALOREFECTIVO>
            <ns0:PD_FECHAVALIDA>{ data($validDate) }</ns0:PD_FECHAVALIDA>
            <ns0:PV_BANCOORIGEN>{ $sourceBank }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ $destinationBank }</ns0:PV_BANCODESTINO>
            <ns0:PV_UUID>{ $uuid }</ns0:PV_UUID>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $merchantNumber as xs:string external;
declare variable $currencyType as xs:string external;
declare variable $org as xs:string external;
declare variable $transactionCurrency as xs:string external;
declare variable $exchangeRate as xs:string external;
declare variable $userName as xs:string external;
declare variable $channelSequence as xs:string external;
declare variable $paymentAmount as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $validDate as xs:string external;
declare variable $uuid as xs:string external;

xf:registrarTransaccionTCCB_dbIn($cardNumber,
    $merchantNumber,
    $currencyType,
    $org,
    $transactionCurrency,
    $exchangeRate,
    $userName,
    $channelSequence,
    $paymentAmount,
    $sourceBank,
    $destinationBank,
    $validDate,
    $uuid)
