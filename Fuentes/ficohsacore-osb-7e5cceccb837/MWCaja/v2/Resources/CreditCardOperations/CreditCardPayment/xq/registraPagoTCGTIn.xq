(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../../Middleware/v3/BusinessServices/PAGOSWSTC/registraPagoTC/xsd/registraPagoTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoTC";
declare namespace xf = "http://tempuri.org/MWCaja/v2/Resources/CreditCardOperations/CreditCardPayment/xq/registraPagoTCGTIn/";

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

declare function xf:registraPagoTCGTIn($sourceBranch as xs:decimal,
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
            <ns0:PN_AGENCIAORIGEN>{ $sourceBranch }</ns0:PN_AGENCIAORIGEN>
            <ns0:PV_MERCHANTNUMBER>{ $merchantNumber }</ns0:PV_MERCHANTNUMBER>
            <ns0:PV_NUMEROTARJETA>{ $cardNumber }</ns0:PV_NUMEROTARJETA>
            <ns0:PV_TIPOOPERACION>C</ns0:PV_TIPOOPERACION>
            <ns0:PN_TIPOMONEDA>{ convertCurrency($currencyType) }</ns0:PN_TIPOMONEDA>
            <ns0:PN_ORGANIZACION>{ $org }</ns0:PN_ORGANIZACION>
            <ns0:PV_MONEDATRANSACCION>{ $transactionCurrency }</ns0:PV_MONEDATRANSACCION>
            <ns0:PN_TASACAMBIO>{ $exchangeRate }</ns0:PN_TASACAMBIO>
            <ns0:PN_TIPOTRANSACCION>1</ns0:PN_TIPOTRANSACCION>
            <ns0:PV_CODIGOUSUARIO>{ $userName }</ns0:PV_CODIGOUSUARIO>
            <ns0:PV_SECUENCIAMOVIMIENTO>{ $referenceNumber }</ns0:PV_SECUENCIAMOVIMIENTO>
            <ns0:PV_SECUENCIAORIGEN>{ $channelSequence }</ns0:PV_SECUENCIAORIGEN>
            {
            	if($cashAmount > 0) then (
            		<ns0:PN_VALOREFECTIVO>{ $cashAmount }</ns0:PN_VALOREFECTIVO>
            	) else()
            }
            {
            	if($checkAmount > 0) then (
            		<ns0:PN_VALORCHEQUES>{ $checkAmount }</ns0:PN_VALORCHEQUES>
            	) else ()
            }
            {
            	if($checkAmount > 0 and $checkNumber > 0) then (
            		<ns0:PN_NUMERODOCUMENTO>{ $checkNumber }</ns0:PN_NUMERODOCUMENTO>
            	) else ()
            }
            <ns0:PD_FECHAVALIDA>{ $validDate }</ns0:PD_FECHAVALIDA>
            {
            	if($checkAmount > 0 and $checkNumber > 0 and $checkType >= 0) then (
            		<ns0:PN_TIPOCHEQUE>{ $checkType }</ns0:PN_TIPOCHEQUE>
            	) else ()
            }
            <ns0:PV_BANCOORIGEN>{ $sourceBank }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ $destinationBank }</ns0:PV_BANCODESTINO>
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

xf:registraPagoTCGTIn($sourceBranch,
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