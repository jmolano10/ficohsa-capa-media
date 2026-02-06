xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns0:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasRequest" location="../../TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/transferenciaCuentasIn/";

declare function xf:transferenciaCuentasIn($retiroTarjetaCredito as element(ns0:retiroTarjetaCredito),
    $debitAccount as xs:string,
    $description as xs:string)
    as element(ns1:transferenciaCuentasRequest) {
        <ns1:transferenciaCuentasRequest>
            <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ data($retiroTarjetaCredito/DISBURSEMENT[1]/VALUE) }</CREDIT_ACCOUNT>
            <CURRENCY>{ data($retiroTarjetaCredito/CURRENCY) }</CURRENCY>
            <TRANSFER_AMOUNT>{ string($retiroTarjetaCredito/AMOUNT/text()) }</TRANSFER_AMOUNT>
            <DESCRIPTION>{ $description }</DESCRIPTION>
            <TRANSFER_DETAILS>WDTC</TRANSFER_DETAILS>
        </ns1:transferenciaCuentasRequest>
};

declare variable $retiroTarjetaCredito as element(ns0:retiroTarjetaCredito) external;
declare variable $debitAccount as xs:string external;
declare variable $description as xs:string external;

xf:transferenciaCuentasIn($retiroTarjetaCredito,
    $debitAccount,
    $description)