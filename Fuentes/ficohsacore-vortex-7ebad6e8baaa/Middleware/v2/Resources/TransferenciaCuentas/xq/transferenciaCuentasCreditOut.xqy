xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transfentrecuentasinstrcreditoResponse" element="ns0:TransfentrecuentasinstrcreditoResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasResponse" location="../xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasCreditOut/";

declare function xf:transferenciaCuentasCreditOut($transfentrecuentasinstrcreditoResponse as element(ns0:TransfentrecuentasinstrcreditoResponse),
    $PAYMENTDETAILS as xs:string)
    as element(ns1:transferenciaCuentasResponse) {
        <ns1:transferenciaCuentasResponse>
            {
                for $DEBITACCTNO in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBITCUSTOMER in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <DEBIT_CUSTOMER>{ data($DEBITCUSTOMER) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDITCUSTOMER in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $DEBITCURRENCY in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDITCURRENCY in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $AMOUNTDEBITED in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/AMOUNTDEBITED
                return
                    <DEBIT_AMOUNT>{ substring(data($AMOUNTDEBITED), 4) }</DEBIT_AMOUNT>
            }
            {
                for $AMOUNTCREDITED in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <CREDIT_AMOUNT>{ substring(data($AMOUNTCREDITED), 4) }</CREDIT_AMOUNT>
            }
            {
				if(fn:string($transfentrecuentasinstrcreditoResponse/Status/successIndicator/text()) = "Success") then (
            		<TRANSFER_DETAILS>{ $PAYMENTDETAILS }</TRANSFER_DETAILS>
            	) else (
            		""
            	)
            }
            {
                let $LRCUSTRATE := fn:string($transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/LRCUSTRATE/text())
                let $CREDITCURRENCY := fn:string($transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/CREDITCURRENCY/text())
                let $DEBITCURRENCY := fn:string($transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/DEBITCURRENCY/text())
                let $SUCCESSINDICATOR := fn:string($transfentrecuentasinstrcreditoResponse/Status/successIndicator/text())
                return
	                if ($CREDITCURRENCY != "" and $DEBITCURRENCY != "" and $CREDITCURRENCY = $DEBITCURRENCY) then (
	                	<EXCHANGE_RATE>1.0000</EXCHANGE_RATE>
	                ) else if($SUCCESSINDICATOR = "Success") then (
	                	<EXCHANGE_RATE>{ data($LRCUSTRATE) }</EXCHANGE_RATE>
	                ) else (
	                	""
	                )
            }
            {
                let $result :=
                    for $DATETIME in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data(fn:concat("20",$DATETIME,"00")) }</DATE_TIME>
                return
                    $result[1]
            }
        </ns1:transferenciaCuentasResponse>
};

declare variable $transfentrecuentasinstrcreditoResponse as element(ns0:TransfentrecuentasinstrcreditoResponse) external;
declare variable $PAYMENTDETAILS as xs:string external;

xf:transferenciaCuentasCreditOut($transfentrecuentasinstrcreditoResponse,
    $PAYMENTDETAILS)