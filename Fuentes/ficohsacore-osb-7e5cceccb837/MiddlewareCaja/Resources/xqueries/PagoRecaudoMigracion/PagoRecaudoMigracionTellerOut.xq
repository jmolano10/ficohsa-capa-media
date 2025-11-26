(:: pragma bea:schema-type-parameter parameter="$tELLERType" type="ns0:TELLERType" location="../../xsds/PagoRecaudosMigracion/XMLSchema_-1578743007.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoMigracionResponse" location="../../xsds/PagoRecaudoMigracion/PagoRecaudoMigracion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMigracionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMigracion/PagoRecaudoMigracionTellerOut/";

declare function xf:PagoRecaudoMigracionTellerOut($tELLERType as element())
    as element(ns1:pagoRecaudoMigracionResponse) {
        <ns1:pagoRecaudoMigracionResponse>
            {
                for $LRIDNUMBER in $tELLERType/LRIDNUMBER
                return
                    <ORD_PARTY_ID>{ data($LRIDNUMBER) }</ORD_PARTY_ID>
            }
            {
                for $LRORDNAME in $tELLERType/LRORDNAME
                return
                    <ORD_PARTY_NAME>{ data($LRORDNAME) }</ORD_PARTY_NAME>
            }
            {
                for $LRAPPOINTNO in $tELLERType/LRAPPOINTNO
                return
                    <APPOINTMENT_NUMBER>{ data($LRAPPOINTNO) }</APPOINTMENT_NUMBER>
            }
            {
                for $LRAPPOINTDT in $tELLERType/LRAPPOINTDT,
                    $LRAPPOINTTIME in $tELLERType/LRAPPOINTTIME
                return
                    <APPOINTMENT_DATE_TIME>{ concat($LRAPPOINTDT , $LRAPPOINTTIME) }</APPOINTMENT_DATE_TIME>
            }
            {
                for $LRPPORTPLACE in $tELLERType/LRPPORTPLACE
                return
                    <REQUEST_CITY>{ data($LRPPORTPLACE) }</REQUEST_CITY>
            }
            {
                for $LRORDPARID in $tELLERType/LRORDPARID
                return
                    <REQUEST_TYPE>{ data($LRORDPARID) }</REQUEST_TYPE>
            }
            {
                for $LRPPORTVAL in $tELLERType/LRPPORTVAL
                return
                    <PASSPORT_DURATION>{ data($LRPPORTVAL) }</PASSPORT_DURATION>
            }
            {
                let $result :=
                    for $INPUTTER in $tELLERType/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER), "_")[2] }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $tELLERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat("20",$DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($tELLERType/LRPAYTYPE) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($tELLERType/CURRENCY2) }</PAYMENT_CURRENCY>
                {
                    for $AMOUNTLOCAL2 in $tELLERType/AMOUNTLOCAL2
                    return
                        <PAYMENT_AMOUNT>{ data($AMOUNTLOCAL2) }</PAYMENT_AMOUNT>
                }
                {
                    for $CHEQUEACCTNO in $tELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUEACCTNO
                    return
                        <DEBIT_ACCOUNT>{ data($CHEQUEACCTNO) }</DEBIT_ACCOUNT>
                }
                {
                    for $CHEQUENUMBER in $tELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUENUMBER
                    return
                        <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
                }
                {
                    for $CHEQUEBANKCDE in $tELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUEBANKCDE
                    return
                        <BANK_CODE>{ data($CHEQUEBANKCDE) }</BANK_CODE>
                }
            </PAYMENT_INFORMATION>
			{
				for $LRBLBATCH at $i in $tELLERType/gLRBLBATCH/mLRBLBATCH/LRBLBATCH
				return
					if($LRBLBATCH = "dealslip") then (
						<BILL_DETAIL>{ data($tELLERType/gLRBLREGNO/mLRBLREGNO[$i]/LRBLREGNO) }</BILL_DETAIL>
					) else ()
        	}                
        </ns1:pagoRecaudoMigracionResponse>
};

declare variable $tELLERType as element() external;

xf:PagoRecaudoMigracionTellerOut($tELLERType)