(:: pragma bea:global-element-return element="ns0:registrarTransaccionTCDB" location="../../../BusinessServices/OSB/RegistrarTransaccionTCDB_v2/xsd/XMLSchema_-967633365.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarTransaccionTCDBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTC/xq/registrarTransaccionTCDBIn/";

declare function xf:registrarTransaccionTCDBIn($cardNumber as xs:string,
    $currencyType as xs:string,
    $org as xs:string,
    $transactionCurrency as xs:string,
    $exchangeRate as xs:string,
    $userName as xs:string,
    $referenceNumber as xs:string,
    $channelSequence as xs:string,
    $paymentAmount as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string,
    $validDate as xs:string,
    $merchantNumber as xs:string)
    as element(ns0:registrarTransaccionTCDB) {
        <ns0:registrarTransaccionTCDB>
            <MERCHANTNUMBER>{ $merchantNumber }</MERCHANTNUMBER>
            <NUMEROTARJETA>{ $cardNumber }</NUMEROTARJETA>
            <TIPOMONEDA>{ $currencyType }</TIPOMONEDA>
            <ORGANIZACION>{ $org }</ORGANIZACION>
            <MONEDATRANSACCION>{ $transactionCurrency }</MONEDATRANSACCION>
            <TASACAMBIO>{ $exchangeRate }</TASACAMBIO>
            <CODIGOUSUARIO>{ $userName }</CODIGOUSUARIO>
            <SECUENCIAMOVIMIENTO>{ $referenceNumber }</SECUENCIAMOVIMIENTO>
            <SECUENCIAORIGEN>{ $channelSequence }</SECUENCIAORIGEN>
            <VALOREFECTIVO>{ $paymentAmount }</VALOREFECTIVO>
            <FECHAVALIDA>{ $validDate }</FECHAVALIDA>
            <BANCOORIGEN>{ $sourceBank }</BANCOORIGEN>
            <BANCODESTINO>{ $destinationBank }</BANCODESTINO>
        </ns0:registrarTransaccionTCDB>
};

declare variable $cardNumber as xs:string external;
declare variable $currencyType as xs:string external;
declare variable $org as xs:string external;
declare variable $transactionCurrency as xs:string external;
declare variable $exchangeRate as xs:string external;
declare variable $userName as xs:string external;
declare variable $referenceNumber as xs:string external;
declare variable $channelSequence as xs:string external;
declare variable $paymentAmount as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $validDate as xs:string external;
declare variable $merchantNumber as xs:string external;

xf:registrarTransaccionTCDBIn($cardNumber,
    $currencyType,
    $org,
    $transactionCurrency,
    $exchangeRate,
    $userName,
    $referenceNumber,
    $channelSequence,
    $paymentAmount,
    $sourceBank,
    $destinationBank,
    $validDate,
    $merchantNumber)