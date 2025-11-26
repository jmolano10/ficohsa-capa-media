(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns0:ResponseHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoResponse" element="ns2:consultaRecaudoResponse" location="../../../../Resources/ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$dEBTOR1" type="ns1:consultaRecaudoMultiple/AGREEMENTS/AGREEMENT/DEBTORS/DEBTOR" location="../xsd/sjConsultaRecaudoMultipleTypesGT.xsd" ::)
(:: pragma bea:schema-type-return type="ns1:debtorsResponseType" location="../../consultaRecaudoMultiple/xsd/sjConsultaRecaudoMultipleTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRecaudoMultipleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRecaudoMultipleGT/xq/sjConsRecaudoGTOut/";


declare function local:to_date($strDate as xs:string?) as xs:date 
{
   if ($strDate != "") then (
        fn-bea:date-from-string-with-format("yyyyMMdd", $strDate)
    ) else ("")
    
};

declare function xf:sjConsRecaudoGTOut($responseHeader as element(ns0:ResponseHeader),
    $consultaRecaudoResponse as element(ns2:consultaRecaudoResponse),
    $dEBTOR1 as element())
    as element() {
        <ns1:debtorsResponseType>
            <DEBTOR>
                <SUCCESS_INDICATOR>
                {
                    if (data($responseHeader/successIndicator) = "SUCCESS") then
                        ("Success")
                    else 
                        ("ERROR")
                }
                </SUCCESS_INDICATOR>
                {
                    let $result :=
                    for $messages in $responseHeader/messages
                    	return
                		<ERROR_MESSAGE>{ data($messages) }</ERROR_MESSAGE>
                    return
                    	$result[1]
                }
                {
                    for $TRACE in $dEBTOR1/TRACE
                    return
                		<TRACE>{ data($TRACE) }</TRACE>
                }
                <CODE>{ data($dEBTOR1/CODE) }</CODE>
                {
	                if (data($responseHeader/successIndicator) = "SUCCESS") then (
	                    <NAME>{ data($consultaRecaudoResponse/DEBTOR_NAME) }</NAME>,
						for $BILLS in $consultaRecaudoResponse/BILLS
	                        return
								<BILLS>
	                            {
	                                for $BILL_RECORD in $BILLS/BILL_RECORD
	                                return
	                                <BILL>
	                                    <ID>{  data($BILL_RECORD/BILL_NUMBER)}</ID>
	                                    {
	                                        for $BILL_DESCRIPTION in $BILL_RECORD/BILL_DESCRIPTION
	                                        return
	                                    		<DESCRIPTION>{ data($BILL_DESCRIPTION) }</DESCRIPTION>
	                                    }
	                                    <ISSUE_DATE>
	                                    {
	                                        local:to_date(fn:string($BILL_RECORD/BILL_DATE/text()))
	                                    }
	                                    </ISSUE_DATE>
	                                    <DUE_DATE>
	                                    { 
	                                        local:to_date(fn:string($BILL_RECORD/DUE_DATE/text()))                       
	                                    }
	                                    </DUE_DATE>
										    <BALANCE>
												<CURRENCY>{ data($dEBTOR1/CURRENCY) }</CURRENCY>
	   											<AMOUNT>{ data($BILL_RECORD/BILL_AMOUNT) }</AMOUNT>
	   											<LATE_FEE>{ data($BILL_RECORD/LATE_FEE) }</LATE_FEE>
										        <TOTAL_AMOUNT_USD>{ data($BILL_RECORD/TOTAL_AMOUNT_USD) }</TOTAL_AMOUNT_USD>
										        <TOTAL_AMOUNT_LOC>{ data($BILL_RECORD/TOTAL_AMOUNT_LOC) }</TOTAL_AMOUNT_LOC>
										    </BALANCE>
									</BILL>
	                            }
								</BILLS>
	                ) else ()
                }
                {
                    for $BILL_DETAIL in $consultaRecaudoResponse/BILL_DETAIL
                    return
                        <DEALSLIP>{ data($BILL_DETAIL) }</DEALSLIP>
                }
            </DEBTOR>
        </ns1:debtorsResponseType>
};

declare variable $responseHeader as element(ns0:ResponseHeader) external;
declare variable $consultaRecaudoResponse as element(ns2:consultaRecaudoResponse) external;
declare variable $dEBTOR1 as element() external;

xf:sjConsRecaudoGTOut($responseHeader,
    $consultaRecaudoResponse,
    $dEBTOR1)