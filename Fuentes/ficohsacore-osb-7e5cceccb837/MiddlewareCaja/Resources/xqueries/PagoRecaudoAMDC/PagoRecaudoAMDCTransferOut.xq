(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns1:FUNDSTRANSFERType" location="../../xsds/PagoRecaudosAmdc/XMLSchema_-1803864288.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetallecontratorecaudoResponse" element="ns1:ConsultadetallecontratorecaudoResponse" location="../../xsds/ContratosConvenios/XMLSchema_266061745.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudoAMDCResponse" location="../../xsds/PagoRecaudoAMDC/PagoRecaudoAMDC.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAMDC/PagoRecaudoAMDCTransferOut/";

declare function xf:PagoRecaudoAMDCTransferOut($fUNDSTRANSFERType as element(),
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
                    for $LRTAXPAYNAME in $fUNDSTRANSFERType/gLRTAXPAYNAME/LRTAXPAYNAME
                    return
                        <DEBTOR_NAME>{ concat(fn:string($fUNDSTRANSFERType/LRIDENCODE/text())," - ", $LRTAXPAYNAME) }</DEBTOR_NAME>
                return
                    $result[1]
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
            <RTEFORM>NO</RTEFORM>
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
        </ns0:pagoRecaudoAMDCResponse>
};

declare variable $fUNDSTRANSFERType as element() external;
declare variable $consultadetallecontratorecaudoResponse as element(ns1:ConsultadetallecontratorecaudoResponse) external;

xf:PagoRecaudoAMDCTransferOut($fUNDSTRANSFERType,
    $consultadetallecontratorecaudoResponse)