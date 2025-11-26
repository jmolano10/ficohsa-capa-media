(:: pragma bea:global-element-parameter parameter="$transferenciaIntergrupalInsertResponse" element="ns0:TransferenciaIntergrupalInsertResponse" location="../../../v2/BusinessServices/T24/TransferenciaIntergrupal/xsd/TransferenciaIntergrupalTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasResponse" location="../../../v2/Resources/TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/transferenciaIntergrupalBodyOut/";

declare function xf:transferenciaIntergrupalBodyOut($PAYMENTDETAILS as xs:string,
    $transferenciaIntergrupalInsertResponse as element(ns0:TransferenciaIntergrupalInsertResponse))
    as element(ns1:transferenciaCuentasResponse) {
        <ns1:transferenciaCuentasResponse>
            {
                for $DEBITACCTNO in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $DEBITCUSTOMER in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/DEBITCUSTOMER
                return
                    <DEBIT_CUSTOMER>{ data($DEBITCUSTOMER) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDITCUSTOMER in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $DEBITCURRENCY in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $CREDITCURRENCY in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $AMOUNTDEBITED in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/AMOUNTDEBITED
                return
                    <DEBIT_AMOUNT>{ substring(data($AMOUNTDEBITED), 4) }</DEBIT_AMOUNT>
            }
            {                    
                for $AMOUNTCREDITED in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/AMOUNTCREDITED
                return
                    <CREDIT_AMOUNT>{ substring(data($AMOUNTCREDITED), 4) }</CREDIT_AMOUNT>                    
            }
            {
				if(fn:string($transferenciaIntergrupalInsertResponse/Status/successIndicator/text()) = "Success") 
				then (<TRANSFER_DETAILS>{ data($PAYMENTDETAILS) }</TRANSFER_DETAILS>) 
            	else ("")
            }     
            {
                let $LRCUSTRATE := fn:string($transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/LRCUSTRATE/text())
                let $CREDITCURRENCY := fn:string($transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/CREDITCURRENCY/text())
                let $DEBITCURRENCY := fn:string($transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/DEBITCURRENCY/text())
                let $SUCCESSINDICATOR := fn:string($transferenciaIntergrupalInsertResponse/Status/successIndicator/text())
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
                    for $DATETIME in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data(fn:concat("20",$DATETIME,"00")) }</DATE_TIME>
                return
                    $result[1]
            }            
        </ns1:transferenciaCuentasResponse>
};

declare variable $PAYMENTDETAILS as xs:string external;
declare variable $transferenciaIntergrupalInsertResponse as element(ns0:TransferenciaIntergrupalInsertResponse) external;

xf:transferenciaIntergrupalBodyOut($PAYMENTDETAILS,
    $transferenciaIntergrupalInsertResponse)
