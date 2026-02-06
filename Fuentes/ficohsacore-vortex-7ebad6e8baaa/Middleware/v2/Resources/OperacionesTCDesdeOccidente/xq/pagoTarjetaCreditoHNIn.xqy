xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:pagoTarjetaCredito" location="../../../../v3/Resources/PagoTarjetaCredito/xsd/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesTCDesdeOccidente/xq/pagoTarjetaCreditoHNIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";

declare function xf:pagoTarjetaCreditoHNIn($creditCardNumber as xs:string,
    $balanceCurrency as xs:string,
    $transactionCurrency as xs:string,
    $paymentAmount as xs:string,
    $debitAccount as xs:string)
    as element(ns0:pagoTarjetaCredito) {
        <ns0:pagoTarjetaCredito>
            <CREDIT_CARD_NUMBER>{ $creditCardNumber }</CREDIT_CARD_NUMBER>
            <BALANCE_CURRENCY>{ $balanceCurrency }</BALANCE_CURRENCY>
            <TRANSACTION_CURRENCY>{ $transactionCurrency }</TRANSACTION_CURRENCY>
            <PAYMENT_AMOUNT>{ $paymentAmount }</PAYMENT_AMOUNT>
            <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
        </ns0:pagoTarjetaCredito>
};

declare variable $creditCardNumber as xs:string external;
declare variable $balanceCurrency as xs:string external;
declare variable $transactionCurrency as xs:string external;
declare variable $paymentAmount as xs:string external;
declare variable $debitAccount as xs:string external;

xf:pagoTarjetaCreditoHNIn($creditCardNumber,
    $balanceCurrency,
    $transactionCurrency,
    $paymentAmount,
    $debitAccount)