xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:transferenciaCuentasRequest" location="../../TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntajeCredito/xq/transferenciaCuentasIn/";

declare function xf:transferenciaCuentasIn($debitAccount as xs:string,
    $creditAccount as xs:string,
    $currency as xs:string,
    $transferAmount as xs:string,
    $description as xs:string,
    $transactionType as xs:string)
    as element(ns0:transferenciaCuentasRequest) {
        <ns0:transferenciaCuentasRequest>
            <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ $creditAccount }</CREDIT_ACCOUNT>
            <CURRENCY>{ $currency }</CURRENCY>
            <TRANSFER_AMOUNT>{ $transferAmount }</TRANSFER_AMOUNT>
            <DEBIT_CREDIT>DEBIT</DEBIT_CREDIT>
            <DESCRIPTION>{ $description }</DESCRIPTION>
            <TRANSFER_DETAILS>{ fn:concat("[", $transactionType, "]") }</TRANSFER_DETAILS>
        </ns0:transferenciaCuentasRequest>
};

declare variable $debitAccount as xs:string external;
declare variable $creditAccount as xs:string external;
declare variable $currency as xs:string external;
declare variable $transferAmount as xs:string external;
declare variable $description as xs:string external;
declare variable $transactionType as xs:string external;

xf:transferenciaCuentasIn($debitAccount,
    $creditAccount,
    $currency,
    $transferAmount,
    $description,
    $transactionType)