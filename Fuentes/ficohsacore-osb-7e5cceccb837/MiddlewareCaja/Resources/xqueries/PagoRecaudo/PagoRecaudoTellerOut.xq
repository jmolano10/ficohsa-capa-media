xquery version "1.0" encoding "Cp1252";
(:: pragma bea:schema-type-parameter parameter="$tELLERType" type="ns0:TELLERType" location="../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetallecontratorecaudoResponse" element="ns0:ConsultadetallecontratorecaudoResponse" location="../../xsds/ContratosConvenios/XMLSchema_266061745.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeusuariosdelsistemaResponse" element="ns0:ConsultadeusuariosdelsistemaResponse" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoResponse" location="../../xsds/PagoRecaudo/PagoRecaudo.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/PagoRecaudoTellerOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:PagoRecaudoTellerOut($tELLERType as element(),
    $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse),
    $consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse))
    as element(ns1:pagoRecaudoResponse) {
        <ns1:pagoRecaudoResponse>
            {
                for $DESCRIPTION in $consultadetallecontratorecaudoResponse/WSCOLLECTIONCONDSType[1]/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType[1]/DESCRIPTION
                return
                    <CONTRACT_NAME>{ data($DESCRIPTION) }</CONTRACT_NAME>
            }
            {
                let $result :=
                    for $LRTAXPAYNAME in $tELLERType/gLRTAXPAYNAME/LRTAXPAYNAME
                    return
                        <DEBTOR_NAME>{ concat(fn:string($tELLERType/LRPAYCODE/text())," - ", $LRTAXPAYNAME) }</DEBTOR_NAME>
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
                for $BRANCHNAME in $consultadeusuariosdelsistemaResponse/WSUSERType[1]/gWSUSERDetailType/mWSUSERDetailType[1]/BRANCHNAME
                return
                    <BRANCH_NAME>{ data($BRANCHNAME) }</BRANCH_NAME>
            }
            {
                for $RTEFORM in $tELLERType/RTEFORM
                return
                    <RTEFORM>{ data($RTEFORM) }</RTEFORM>
            }            
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ data($tELLERType/LRPAYTYPE) }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($tELLERType/CURRENCY1) }</PAYMENT_CURRENCY>
                {
                    let $CURRENCY1 := fn:string($tELLERType/CURRENCY1/text())
                    return
                    	if ( $CURRENCY1 = "HNL") then (
                    		<PAYMENT_AMOUNT>{ data($tELLERType/gACCOUNT1/mACCOUNT1/AMOUNTLOCAL1) }</PAYMENT_AMOUNT>
                    	) else (
                    		<PAYMENT_AMOUNT>{ data($tELLERType/gACCOUNT1/mACCOUNT1/AMOUNTFCY1) }</PAYMENT_AMOUNT>
                    	)
                        
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
        </ns1:pagoRecaudoResponse>
};

declare variable $tELLERType as element() external;
declare variable $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse) external;
declare variable $consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse) external;

xf:PagoRecaudoTellerOut($tELLERType,
    $consultadetallecontratorecaudoResponse,
    $consultadeusuariosdelsistemaResponse)