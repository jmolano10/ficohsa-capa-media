<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:transferenciaCuentasRequest" location="../../../../v2/Resources/TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/TransferenciaCuentasPA/";

declare function xf:TransferenciaCuentasPA($DebitAccount as xs:string,
    $CreditAccount as xs:string,
    $Currency as xs:string,
    $TransferAmount as xs:string,
    $Description as xs:string)
    as element(ns0:transferenciaCuentasRequest) {
        <ns0:transferenciaCuentasRequest>
            <DEBIT_ACCOUNT>{ $DebitAccount }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ $CreditAccount }</CREDIT_ACCOUNT>
            <CURRENCY>{ $Currency }</CURRENCY>
            <TRANSFER_AMOUNT>{ $TransferAmount }</TRANSFER_AMOUNT>
            <DESCRIPTION>{ $Description }</DESCRIPTION>
        </ns0:transferenciaCuentasRequest>
};

declare variable $DebitAccount as xs:string external;
declare variable $CreditAccount as xs:string external;
declare variable $Currency as xs:string external;
declare variable $TransferAmount as xs:string external;
declare variable $Description as xs:string external;

xf:TransferenciaCuentasPA($DebitAccount,
    $CreditAccount,
    $Currency,
    $TransferAmount,
    $Description)]]></con:xquery>
    <con:dependency location="../../../../v2/Resources/TransferenciaCuentas/xsd/transferenciaCuentasType.xsd">
        <con:schema ref="Middleware/v2/Resources/TransferenciaCuentas/xsd/transferenciaCuentasType"/>
    </con:dependency>
</con:xqueryEntry>