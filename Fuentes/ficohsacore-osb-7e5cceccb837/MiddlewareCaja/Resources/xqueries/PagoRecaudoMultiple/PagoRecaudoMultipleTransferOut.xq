xquery version "1.0" encoding "Cp1252";
(:: pragma bea:schema-type-parameter parameter="$fUNDSTRANSFERType" type="ns0:FUNDSTRANSFERType" location="../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadetallecontratorecaudoResponse" element="ns0:ConsultadetallecontratorecaudoResponse" location="../../xsds/ContratosConvenios/XMLSchema_266061745.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeusuariosdelsistemaResponse" element="ns0:ConsultadeusuariosdelsistemaResponse" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoMultipleResponse" location="../../xsds/PagoRecaudoMultiple/PagoRecaudoMultiple.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMultiple/PagoRecaudoMultipleTransferOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMultipleTypes";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:PagoRecaudoMultipleTransferOut($fUNDSTRANSFERType as element(),
    $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse),
    $consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse),
    $cuenta as xs:string)
    as element(ns1:pagoRecaudoMultipleResponse) {
        <ns1:pagoRecaudoMultipleResponse>
            {
                for $DESCRIPTION in $consultadetallecontratorecaudoResponse/WSCOLLECTIONCONDSType[1]/gWSCOLLECTIONCONDSDetailType/mWSCOLLECTIONCONDSDetailType[1]/DESCRIPTION
                return
                    <CONTRACT_NAME>{ data($DESCRIPTION) }</CONTRACT_NAME>
            }
            {
                let $result :=
                    for $LRTAXPAYNAME in $fUNDSTRANSFERType/gLRTAXPAYNAME/LRTAXPAYNAME
                    return
                        <DEBTOR_NAME>{ concat(fn:string($fUNDSTRANSFERType/LRPAYCODE/text())," - ", $LRTAXPAYNAME) }</DEBTOR_NAME>
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
            {
                for $BRANCHNAME in $consultadeusuariosdelsistemaResponse/WSUSERType[1]/gWSUSERDetailType/mWSUSERDetailType[1]/BRANCHNAME
                return
                    <BRANCH_NAME>{ data($BRANCHNAME) }</BRANCH_NAME>
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
                    let $DEBITACCTNO := fn:string($cuenta)
                    return
                    	if ( $DEBITACCTNO != "") then (
                        	<DEBIT_ACCOUNT>{ $DEBITACCTNO }</DEBIT_ACCOUNT>
                        ) else ()
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
	</ns1:pagoRecaudoMultipleResponse>
};

declare variable $fUNDSTRANSFERType as element() external;
declare variable $consultadetallecontratorecaudoResponse as element(ns0:ConsultadetallecontratorecaudoResponse) external;
declare variable $consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse) external;
declare variable $cuenta as xs:string external;

xf:PagoRecaudoMultipleTransferOut($fUNDSTRANSFERType,
    $consultadetallecontratorecaudoResponse,
    $consultadeusuariosdelsistemaResponse,
    $cuenta)