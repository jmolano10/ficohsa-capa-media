xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/MasterData/conRegistraPagoTCRG/xsd/conRegistraPagoTCRG_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conRegistraPagoTCRG";
declare namespace xf = "http://tempuri.org/Middleware/v4/Resources/PagoTarjetaCredito/xq/registraPagoTCMasterDataHNIn/";

declare function xf:registraPagoTCMasterDataHNIn($cardNumber as xs:string,
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
    $merchantNumber as xs:string,
    $country as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $country }</ns0:Pais>
            <ns0:MerchantNumber>{ $merchantNumber }</ns0:MerchantNumber>
            <ns0:NumTarjeta>{ $cardNumber }</ns0:NumTarjeta>
            <ns0:TipoOperacion>C</ns0:TipoOperacion>
            <ns0:TipoMoneda>{ data($currencyType) }</ns0:TipoMoneda>
            <ns0:Organizacion>{ data($org) }</ns0:Organizacion>
            <ns0:MonedaTransaccion>{ $transactionCurrency }</ns0:MonedaTransaccion>
            <ns0:TasaCambio>{ data($exchangeRate) }</ns0:TasaCambio>
            <ns0:TipoTransaccion>1</ns0:TipoTransaccion>
            <ns0:CodigoUsuario>{ $userName }</ns0:CodigoUsuario>
            <ns0:SecuenciaMovimiento>{ $referenceNumber }</ns0:SecuenciaMovimiento>
            <ns0:SecuenciaOrigen>{ $channelSequence }</ns0:SecuenciaOrigen>
            <ns0:ValorEfectivo>{ data($paymentAmount) }</ns0:ValorEfectivo>
            <ns0:FechaValida>{ $validDate }</ns0:FechaValida>
            <ns0:BancoOrigen>{ $sourceBank }</ns0:BancoOrigen>
            <ns0:BancoDestino>{ $destinationBank }</ns0:BancoDestino>
            <ns0:CodigoError>0</ns0:CodigoError>
            <ns0:MensajeError>temp</ns0:MensajeError>
        </ns0:InputParameters>
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
declare variable $country as xs:string external;

xf:registraPagoTCMasterDataHNIn($cardNumber,
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
    $merchantNumber,
    $country)