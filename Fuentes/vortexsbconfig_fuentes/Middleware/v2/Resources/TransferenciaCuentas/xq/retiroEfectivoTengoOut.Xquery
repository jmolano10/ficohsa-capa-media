<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroEfectivoTengoResponse" element="ns0:RetiroEfectivoTengoResponse" location="../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasResponse" location="../xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/retiroEfectivoTengoOut/";

declare function xf:retiroEfectivoTengoOut($retiroEfectivoTengoResponse as element(ns0:RetiroEfectivoTengoResponse),
    $PAYMENTDETAILS as xs:string)
    as element(ns1:transferenciaCuentasResponse) {
        <ns1:transferenciaCuentasResponse>
            {
                for $DEBITACCTNO in $retiroEfectivoTengoResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $retiroEfectivoTengoResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBITCUSTOMER in $retiroEfectivoTengoResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <DEBIT_CUSTOMER>{ data($DEBITCUSTOMER) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDITCUSTOMER in $retiroEfectivoTengoResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $DEBITCURRENCY in $retiroEfectivoTengoResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDITCURRENCY in $retiroEfectivoTengoResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $AMOUNTDEBITED in $retiroEfectivoTengoResponse/FUNDSTRANSFERType/AMOUNTDEBITED
                return
                    <DEBIT_AMOUNT>{ substring(data($AMOUNTDEBITED), 4) }</DEBIT_AMOUNT>
            }
            {
                for $AMOUNTCREDITED in $retiroEfectivoTengoResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <CREDIT_AMOUNT>{ substring(data($AMOUNTCREDITED), 4) }</CREDIT_AMOUNT>
            }
            {
				if(fn:string($retiroEfectivoTengoResponse/Status/successIndicator/text()) = "Success") then (
            		<TRANSFER_DETAILS>{ $PAYMENTDETAILS }</TRANSFER_DETAILS>
            	) else (
            		""
            	)
            }
        </ns1:transferenciaCuentasResponse>
};

declare variable $retiroEfectivoTengoResponse as element(ns0:RetiroEfectivoTengoResponse) external;
declare variable $PAYMENTDETAILS as xs:string external;

xf:retiroEfectivoTengoOut($retiroEfectivoTengoResponse,
    $PAYMENTDETAILS)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes"/>
    </con:dependency>
    <con:dependency location="../xsd/transferenciaCuentasType.xsd">
        <con:schema ref="Middleware/v2/Resources/TransferenciaCuentas/xsd/transferenciaCuentasType"/>
    </con:dependency>
</con:xqueryEntry>