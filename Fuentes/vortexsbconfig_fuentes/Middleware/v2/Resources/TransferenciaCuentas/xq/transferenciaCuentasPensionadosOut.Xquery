<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transfmodelbankentrecuentasResponse" element="ns0:TransfmodelbankentrecuentasResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasResponse" location="../xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasPensionadosOut/";

declare function xf:transferenciaCuentasPensionadosOut($transfmodelbankentrecuentasResponse as element(ns0:TransfmodelbankentrecuentasResponse),
    $PAYMENTDETAILS as xs:string)
    as element(ns1:transferenciaCuentasResponse) {
        <ns1:transferenciaCuentasResponse>
            {
                for $DEBITACCTNO in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBITCUSTOMER in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <DEBIT_CUSTOMER>{ data($DEBITCUSTOMER) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDITCUSTOMER in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $DEBITCURRENCY in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDITCURRENCY in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $DEBITAMOUNT in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/DEBITAMOUNT
                return
                    <DEBIT_AMOUNT>{ data($DEBITAMOUNT) }</DEBIT_AMOUNT>
            }
            {
                for $CREDITAMOUNT in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/CREDITAMOUNT
                return
                    <CREDIT_AMOUNT>{ data($CREDITAMOUNT) }</CREDIT_AMOUNT>
            }
            {
            	if(fn:string($transfmodelbankentrecuentasResponse/Status/successIndicator/text()) = "Success") then (
            		<TRANSFER_DETAILS>{ $PAYMENTDETAILS }</TRANSFER_DETAILS>
            	) else (
            		""
            	)
            }
            {
                for $CUSTOMERRATE in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/CUSTOMERRATE
                return
                    <EXCHANGE_RATE>{ data($CUSTOMERRATE) }</EXCHANGE_RATE>
            }
            {
                let $result :=
                    for $DATETIME in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data(fn:concat("20",$DATETIME,"00")) }</DATE_TIME>
                return
                    $result[1]
            }
        </ns1:transferenciaCuentasResponse>
};

declare variable $transfmodelbankentrecuentasResponse as element(ns0:TransfmodelbankentrecuentasResponse) external;
declare variable $PAYMENTDETAILS as xs:string external;

xf:transferenciaCuentasPensionadosOut($transfmodelbankentrecuentasResponse,
    $PAYMENTDETAILS)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd">
        <con:schema ref="Middleware/Business_Resources/Transferencias/Resources/XMLSchema_1840876228"/>
    </con:dependency>
    <con:dependency location="../xsd/transferenciaCuentasType.xsd">
        <con:schema ref="Middleware/v2/Resources/TransferenciaCuentas/xsd/transferenciaCuentasType"/>
    </con:dependency>
</con:xqueryEntry>