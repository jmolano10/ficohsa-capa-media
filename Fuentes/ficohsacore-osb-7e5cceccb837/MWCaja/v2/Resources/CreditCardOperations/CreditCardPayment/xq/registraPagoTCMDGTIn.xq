(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../../Middleware/v3/BusinessServices/MasterData/conRegistraPagoTCRG/xsd/conRegistraPagoTCRG_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conRegistraPagoTCRG";
declare namespace xf = "http://tempuri.org/MWCaja/v2/Resources/CreditCardOperations/CreditCardPayment/xq/registraPagoTCMDGTIn/";

declare function convertCurrency($currency as xs:string) as xs:decimal {
	if ($currency = "HNL") then
		1
	else if  ($currency = "USD") then
		2
	else if  ($currency = "EUR") then
		3
	else if  ($currency = "GTQ") then
		13
	else 
		0
};

declare function xf:registraPagoTCMDGTIn($sourceBranch as xs:decimal,
    $merchantNumber as xs:string,
    $cardNumber as xs:string,
    $currencyType as xs:string,
    $org as xs:decimal,
    $transactionCurrency as xs:string,
    $exchangeRate as xs:decimal,
    $userName as xs:string,
    $referenceNumber as xs:decimal,
    $channelSequence as xs:string,
    $cashAmount as xs:decimal,
    $checkAmount as xs:decimal,
    $checkNumber as xs:decimal,
    $validDate as xs:dateTime,
    $checkType as xs:decimal,
    $sourceBank as xs:string,
    $destinationBank as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	{ if (data($sourceBank) = 'HN01') 
            then
            	<ns0:Pais>HND</ns0:Pais>
            else 
            	''
            }
            { if (data($sourceBank) = 'GT01') 
            then
            	<ns0:Pais>GTM</ns0:Pais>
            else 
            	''
            }
            <ns0:AgenciaOrigen>{ $sourceBranch }</ns0:AgenciaOrigen>
            <ns0:MerchantNumber>{ $merchantNumber }</ns0:MerchantNumber>
            <ns0:NumTarjeta>{ $cardNumber }</ns0:NumTarjeta>
            <ns0:TipoOperacion>C</ns0:TipoOperacion>
            <ns0:TipoMoneda>{ convertCurrency($currencyType) }</ns0:TipoMoneda>
            <ns0:Organizacion>{ $org }</ns0:Organizacion>
            <ns0:MonedaTransaccion>{ $transactionCurrency }</ns0:MonedaTransaccion>
            <ns0:TasaCambio>{ $exchangeRate }</ns0:TasaCambio>
            <ns0:TipoTransaccion>1</ns0:TipoTransaccion>
            <ns0:CodigoUsuario>{ $userName }</ns0:CodigoUsuario>
            <ns0:SecuenciaMovimiento>{ $referenceNumber }</ns0:SecuenciaMovimiento>
            <ns0:SecuenciaOrigen>{ $channelSequence }</ns0:SecuenciaOrigen>
            {
            	if($cashAmount > 0) then (
            		<ns0:ValorEfectivo>{ $cashAmount }</ns0:ValorEfectivo>
            	) else()
            }
            {
            	if($checkAmount > 0) then (
            		<ns0:ValorCheques>{ $checkAmount }</ns0:ValorCheques>
            	) else ()
            }
            {
            	if($checkAmount > 0 and $checkNumber > 0) then (
            		<ns0:NumDocumento>{ $checkNumber }</ns0:NumDocumento>
            	) else ()
            }
            <ns0:FechaValida>{ $validDate }</ns0:FechaValida>
            {
            	if($checkAmount > 0 and $checkNumber > 0 and $checkType >= 0) then (
            		<ns0:TipoCheque>{ $checkType }</ns0:TipoCheque>
            	) else ()
            }
            <ns0:BancoOrigen>{ $sourceBank }</ns0:BancoOrigen>
            <ns0:BancoDestino>{ $destinationBank }</ns0:BancoDestino>
            <ns0:CodigoError>0</ns0:CodigoError>
            <ns0:MensajeError>temp</ns0:MensajeError>
        </ns0:InputParameters>
};

declare variable $sourceBranch as xs:decimal external;
declare variable $merchantNumber as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $currencyType as xs:string external;
declare variable $org as xs:decimal external;
declare variable $transactionCurrency as xs:string external;
declare variable $exchangeRate as xs:decimal external;
declare variable $userName as xs:string external;
declare variable $referenceNumber as xs:decimal external;
declare variable $channelSequence as xs:string external;
declare variable $cashAmount as xs:decimal external;
declare variable $checkAmount as xs:decimal external;
declare variable $checkNumber as xs:decimal external;
declare variable $validDate as xs:dateTime external;
declare variable $checkType as xs:decimal external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;

xf:registraPagoTCMDGTIn($sourceBranch,
    $merchantNumber,
    $cardNumber,
    $currencyType,
    $org,
    $transactionCurrency,
    $exchangeRate,
    $userName,
    $referenceNumber,
    $channelSequence,
    $cashAmount,
    $checkAmount,
    $checkNumber,
    $validDate,
    $checkType,
    $sourceBank,
    $destinationBank)