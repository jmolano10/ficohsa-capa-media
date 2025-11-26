(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns0:FUNDSTRANSFERType" location="../../xsds/PagoRecaudosMigracion/XMLSchema_-1578743007.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoMigracionResponse" location="../../xsds/PagoRecaudoMigracion/PagoRecaudoMigracion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMigracionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMigracion/PagoRecaudoMigracionTransferOut/";

declare function xf:PagoRecaudoMigracionTransferOut($fUNDSTRANSFERType as element())
    as element(ns1:pagoRecaudoMigracionResponse) {
        <ns1:pagoRecaudoMigracionResponse>
            {
                for $LRIDNUMBER in $fUNDSTRANSFERType/LRIDNUMBER
                return
                    <ORD_PARTY_ID>{ data($LRIDNUMBER) }</ORD_PARTY_ID>
            }
            {
                for $LRORDNAME in $fUNDSTRANSFERType/LRORDNAME
                return
                    <ORD_PARTY_NAME>{ data($LRORDNAME) }</ORD_PARTY_NAME>
            }
            {
                for $LRAPPOINTNO in $fUNDSTRANSFERType/LRAPPOINTNO
                return
                    <APPOINTMENT_NUMBER>{ data($LRAPPOINTNO) }</APPOINTMENT_NUMBER>
            }
            {
                for $LRAPPOINTDT in $fUNDSTRANSFERType/LRAPPOINTDT,
                    $LRAPPOINTTIME in $fUNDSTRANSFERType/LRAPPOINTTIME
                return
                    <APPOINTMENT_DATE_TIME>{ concat($LRAPPOINTDT , $LRAPPOINTTIME) }</APPOINTMENT_DATE_TIME>
            }
            {
                for $LRPPORTPLACE in $fUNDSTRANSFERType/LRPPORTPLACE
                return
                    <REQUEST_CITY>{ data($LRPPORTPLACE) }</REQUEST_CITY>
            }
            {
                for $LRORDPARID in $fUNDSTRANSFERType/LRORDPARID
                return
                    <REQUEST_TYPE>{ data($LRORDPARID) }</REQUEST_TYPE>
            }
            {
                for $LRPPORTVAL in $fUNDSTRANSFERType/LRPPORTVAL
                return
                    <PASSPORT_DURATION>{ data($LRPPORTVAL) }</PASSPORT_DURATION>
            }
            {
                let $result :=
                    for $INPUTTER in $fUNDSTRANSFERType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER), "_")[2] }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $fUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat("20",$DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($fUNDSTRANSFERType/LRPAYTYPE) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($fUNDSTRANSFERType/DEBITCURRENCY) }</PAYMENT_CURRENCY>
                {
                    for $DEBITAMOUNT in $fUNDSTRANSFERType/DEBITAMOUNT
                    return
                        <PAYMENT_AMOUNT>{ data($DEBITAMOUNT) }</PAYMENT_AMOUNT>
                }
                {
                    for $DEBITACCTNO in $fUNDSTRANSFERType/DEBITACCTNO
                    return
                        <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
                }
                {
                    for $CHEQUENUMBER in $fUNDSTRANSFERType/CHEQUENUMBER
                    return
                        <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
                }
            </PAYMENT_INFORMATION>
			{
				for $LRBLBATCH at $i in $fUNDSTRANSFERType/gLRBLBATCH/mLRBLBATCH/LRBLBATCH
				return
					if($LRBLBATCH = "dealslip") then (
						<BILL_DETAIL>{ data($fUNDSTRANSFERType/gLRBLREGNO/mLRBLREGNO[$i]/LRBLREGNO) }</BILL_DETAIL>
					) else ()
        	}               
        </ns1:pagoRecaudoMigracionResponse>
};

declare variable $fUNDSTRANSFERType as element() external;

xf:PagoRecaudoMigracionTransferOut($fUNDSTRANSFERType)