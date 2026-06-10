<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaImagenChequeRequest" location="../../procesoImagenesCheques/Resources/procesoImagenesChequesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientos/ConsultaReciboCheque/consultaReciboChequeIn/";

declare function xf:consultaReciboChequeIn($account as xs:string,
    $transactionReference as xs:string,
    $chequeNumber as xs:string)
    as element(ns0:consultaImagenChequeRequest) {
        <ns0:consultaImagenChequeRequest>
            <ACCOUNT_NUMBER>{ $account }</ACCOUNT_NUMBER>
            <CHEQUE_NUMBER>{ $chequeNumber }</CHEQUE_NUMBER>
            <TRANSACTION_REFERENCE>{ $transactionReference }</TRANSACTION_REFERENCE>
        </ns0:consultaImagenChequeRequest>
};

declare variable $account as xs:string external;
declare variable $transactionReference as xs:string external;
declare variable $chequeNumber as xs:string external;

xf:consultaReciboChequeIn($account,
    $transactionReference,
    $chequeNumber)]]></con:xquery>
    <con:dependency location="../../procesoImagenesCheques/Resources/procesoImagenesChequesTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/procesoImagenesCheques/Resources/procesoImagenesChequesTypes"/>
    </con:dependency>
</con:xqueryEntry>