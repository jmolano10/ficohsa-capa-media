<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns0:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasRequest" location="../../TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/transferenciaCuentasIn/";

declare function xf:transferenciaCuentasIn($retiroTarjetaCredito as element(ns0:retiroTarjetaCredito),
    $debitAccount as xs:string)
    as element(ns1:transferenciaCuentasRequest) {
        <ns1:transferenciaCuentasRequest>
            <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ data($retiroTarjetaCredito/DISBURSEMENT[1]/VALUE) }</CREDIT_ACCOUNT>
            <CURRENCY>{ data($retiroTarjetaCredito/CURRENCY) }</CURRENCY>
            <TRANSFER_AMOUNT>{ string($retiroTarjetaCredito/AMOUNT/text()) }</TRANSFER_AMOUNT>
            <DESCRIPTION></DESCRIPTION>
            <TRANSFER_DETAILS>{"[WDTC]"}</TRANSFER_DETAILS>            
        </ns1:transferenciaCuentasRequest>
};

declare variable $retiroTarjetaCredito as element(ns0:retiroTarjetaCredito) external;
declare variable $debitAccount as xs:string external;

xf:transferenciaCuentasIn($retiroTarjetaCredito,
    $debitAccount)]]></con:xquery>
    <con:dependency location="../xsd/retiroTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroTarjetaCredito/xsd/retiroTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../TransferenciaCuentas/xsd/transferenciaCuentasType.xsd">
        <con:schema ref="Middleware/v2/Resources/TransferenciaCuentas/xsd/transferenciaCuentasType"/>
    </con:dependency>
</con:xqueryEntry>