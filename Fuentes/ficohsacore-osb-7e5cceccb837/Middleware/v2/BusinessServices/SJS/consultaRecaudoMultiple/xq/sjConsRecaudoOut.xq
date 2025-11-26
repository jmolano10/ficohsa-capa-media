(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../../OSB/consultaRecaudo_v2/xsd/XMLSchema_-281893006.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoResponse1" element="ns1:consultaRecaudoResponse" location="../../../OSB/consultaRecaudo_v2/xsd/XMLSchema_-845053526.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$dEBTOR1" type="ns0:consultaRecaudoMultiple/AGREEMENTS/AGREEMENT/DEBTORS/DEBTOR" location="../xsd/sjConsultaRecaudoMultipleTypes.xsd" ::)
(:: pragma bea:schema-type-return type="ns0:debtorsResponseType" location="../xsd/sjConsultaRecaudoMultipleTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRecaudoMultipleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRecaudoMultiple/xq/sjConsRecaudoOut2/";

declare function xf:sjConsRecaudoOut2($responseHeader1 as element(ns2:ResponseHeader),
    $consultaRecaudoResponse1 as element(ns1:consultaRecaudoResponse),
    $dEBTOR1 as element(),
    $localCurrency as xs:string)
    as element() {
        <ns0:debtorsResponseType>
            <DEBTOR>
                <SUCCESS_INDICATOR>{ data($responseHeader1/successIndicator) }</SUCCESS_INDICATOR>
                {
                    let $result :=
                        for $messages in $responseHeader1/messages
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
                    if (data($responseHeader1/successIndicator) = "Success") then (
                	<NAME>{ data($consultaRecaudoResponse1/DEBTOR_NAME) }</NAME>,
                	for $BILLS in $consultaRecaudoResponse1/BILLS
		            	return
		                <BILLS>
		                {
			                for $BILL_RECORD in $BILLS/BILL_RECORD
			                    return
		                    		<BILL>
			                            <ID>{ data($BILL_RECORD/BILL_NUMBER) }</ID>
			                            {
			                                for $BILL_DESCRIPTION in $BILL_RECORD/BILL_DESCRIPTION
			                                return
			                                    <DESCRIPTION>{ data($BILL_DESCRIPTION) }</DESCRIPTION>
			                            }
			                            <ISSUE_DATE>
			                            { 
			                            	let $strDate := fn:string($BILL_RECORD/BILL_DATE/text())
			                            	return
			                            		if ($strDate != "") then (
			                            			fn:concat(fn:substring($strDate,1,4),"-",fn:substring($strDate,5,2),"-",fn:substring($strDate,7,2))
			                            		) else (
			                            			""
			                            		)
			                            }
			                            </ISSUE_DATE>
			                            <DUE_DATE>
			                            { 
			                            	let $strDate := fn:string($BILL_RECORD/DUE_DATE/text())
			                            	return
			                            		if ($strDate != "") then (
			                            			fn:concat(fn:substring($strDate,1,4),"-",fn:substring($strDate,5,2),"-",fn:substring($strDate,7,2))
			                            		) else (
			                            			""
			                            		) 
			                            }
			                            </DUE_DATE>
	                                    <BALANCES>
	                                    {
	                                    	if (fn:string($dEBTOR1/CURRENCY/text()) = ($localCurrency,"")) then (
	                                        	<BALANCE>
	                                        		<CURRENCY>{ $localCurrency }</CURRENCY>
	                                        		<AMOUNT>{ fn:number(data($BILL_RECORD/BILL_AMOUNT)) }</AMOUNT>
	                                        		<LATE_FEE>{ fn:number(data($BILL_RECORD/LATE_FEE)) }</LATE_FEE>
	                                        		<TOTAL>{ fn:number(data($BILL_RECORD/TOTAL_AMOUNT_LOC)) }</TOTAL>
	                                        	</BALANCE>
	                                    	) else ()
	                                    }
	                                    {
	                                    	if (fn:string($dEBTOR1/CURRENCY/text()) != $localCurrency and
	                                    		$localCurrency != "USD") then (
	                                        	<BALANCE>
	                                        		<CURRENCY>USD</CURRENCY>
	                                        		<AMOUNT>{ fn:number(data($BILL_RECORD/BILL_AMOUNT)) }</AMOUNT>
	                                        		<LATE_FEE>{ fn:number(data($BILL_RECORD/LATE_FEE)) }</LATE_FEE>
	                                        		<TOTAL>{ fn:number(data($BILL_RECORD/TOTAL_AMOUNT_USD)) }</TOTAL>
	                                        	</BALANCE>
	                                        ) else ()
	                                    }
	                                    </BALANCES>
									</BILL>
			                }	
			                </BILLS>    
	                ) else ()
                }
                {
                    for $BILL_DETAIL in $consultaRecaudoResponse1/BILL_DETAIL
                    return
                        <DEALSLIP>{ data($BILL_DETAIL) }</DEALSLIP>
                }
            </DEBTOR>
        </ns0:debtorsResponseType>
};

declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $consultaRecaudoResponse1 as element(ns1:consultaRecaudoResponse) external;
declare variable $dEBTOR1 as element() external;
declare variable $localCurrency as xs:string external;

xf:sjConsRecaudoOut2($responseHeader1,
    $consultaRecaudoResponse1,
    $dEBTOR1,
    $localCurrency)