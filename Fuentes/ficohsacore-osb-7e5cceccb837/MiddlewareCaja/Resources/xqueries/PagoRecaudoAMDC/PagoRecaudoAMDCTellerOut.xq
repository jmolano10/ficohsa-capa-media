(:: pragma bea:schema-type-parameter parameter="$tELLERType" type="ns1:TELLERType" location="../../xsds/PagoRecaudosAmdc/XMLSchema_-1803864288.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetallecontratorecaudoResponse" element="ns1:ConsultadetallecontratorecaudoResponse" location="../../xsds/ContratosConvenios/XMLSchema_266061745.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudoAMDCResponse" location="../../xsds/PagoRecaudoAMDC/PagoRecaudoAMDC.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAMDC/PagoRecaudoAMDCTellerOut/";

declare function xf:PagoRecaudoAMDCTellerOut($tELLERType as element(),
    $consultadetallecontratorecaudoResponse as element(ns1:ConsultadetallecontratorecaudoResponse))
    as element(ns0:pagoRecaudoAMDCResponse) {
        <ns0:pagoRecaudoAMDCResponse>
            {
                for $DESCRIPTION in $consultadetallecontratorecaudoResponse/WSCOLLECTIONCONDSType[1]/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType[1]/DESCRIPTION
                return
                    <CONTRACT_NAME>{ data($DESCRIPTION) }</CONTRACT_NAME>
            }
            {
                let $result :=
                    for $LRTAXPAYNAME in $tELLERType/gLRTAXPAYNAME/LRTAXPAYNAME
                    return
                        <DEBTOR_NAME>{ concat(fn:string($tELLERType/LRIDENCODE/text())," - ", $LRTAXPAYNAME) }</DEBTOR_NAME>
                return
                    $result[1]
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
            {
                for $RTEFORM in $tELLERType/RTEFORM
                return
                    <RTEFORM>{ data($RTEFORM) }</RTEFORM>
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
        </ns0:pagoRecaudoAMDCResponse>
};

declare variable $tELLERType as element() external;
declare variable $consultadetallecontratorecaudoResponse as element(ns1:ConsultadetallecontratorecaudoResponse) external;

xf:PagoRecaudoAMDCTellerOut($tELLERType,
    $consultadetallecontratorecaudoResponse)