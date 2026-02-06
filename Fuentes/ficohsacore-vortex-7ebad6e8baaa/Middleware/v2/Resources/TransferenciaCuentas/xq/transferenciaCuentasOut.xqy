xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaentrecuentasResponse" element="ns0:TransferenciaentrecuentasResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasResponse" location="../xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasOut/";

declare function xf:transferenciaCuentasOut($transferenciaentrecuentasResponse as element(ns0:TransferenciaentrecuentasResponse),
    $PAYMENTDETAILS as xs:string)
    as element(ns1:transferenciaCuentasResponse) {
        <ns1:transferenciaCuentasResponse>
            {
                for $DEBITACCTNO in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBITCUSTOMER in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <DEBIT_CUSTOMER>{ data($DEBITCUSTOMER) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDITCUSTOMER in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $DEBITCURRENCY in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDITCURRENCY in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $AMOUNTDEBITED in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/AMOUNTDEBITED
                return
                    <DEBIT_AMOUNT>{ substring(data($AMOUNTDEBITED), 4) }</DEBIT_AMOUNT>
            }
            {
                for $AMOUNTCREDITED in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <CREDIT_AMOUNT>{ substring(data($AMOUNTCREDITED), 4) }</CREDIT_AMOUNT>
            }
            {
            	if(fn:string($transferenciaentrecuentasResponse/Status/successIndicator/text()) = "Success") then (
            		<TRANSFER_DETAILS>{ data($PAYMENTDETAILS) }</TRANSFER_DETAILS>
            	) else (
            		""
            	)
            }
            {
                let $LRCUSTRATE := fn:string($transferenciaentrecuentasResponse/FUNDSTRANSFERType/LRCUSTRATE/text())
                let $CREDITCURRENCY := fn:string($transferenciaentrecuentasResponse/FUNDSTRANSFERType/CREDITCURRENCY/text())
                let $DEBITCURRENCY := fn:string($transferenciaentrecuentasResponse/FUNDSTRANSFERType/DEBITCURRENCY/text())
                let $SUCCESSINDICATOR := fn:string($transferenciaentrecuentasResponse/Status/successIndicator/text())
                return
	                if ($CREDITCURRENCY != "" and $DEBITCURRENCY != "" and $CREDITCURRENCY = $DEBITCURRENCY) then (
	                	<EXCHANGE_RATE>1.0000</EXCHANGE_RATE>
	                ) else if ($SUCCESSINDICATOR = "Success") then (
	                	<EXCHANGE_RATE>{ data($LRCUSTRATE) }</EXCHANGE_RATE>
	                ) else (
	                	""
	                )
            }
            {
                let $result :=
                    for $DATETIME in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data(fn:concat("20",$DATETIME,"00")) }</DATE_TIME>
                return
                    $result[1]
            }
        </ns1:transferenciaCuentasResponse>
};

declare variable $transferenciaentrecuentasResponse as element(ns0:TransferenciaentrecuentasResponse) external;
declare variable $PAYMENTDETAILS as xs:string external;

xf:transferenciaCuentasOut($transferenciaentrecuentasResponse,
    $PAYMENTDETAILS)