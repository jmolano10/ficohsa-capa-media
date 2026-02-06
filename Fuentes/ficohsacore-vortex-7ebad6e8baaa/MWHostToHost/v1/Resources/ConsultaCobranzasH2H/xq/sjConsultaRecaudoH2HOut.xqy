xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaCobranzasResponse" element="ns0:sjConsultaCobranzasResponse" location="../../../BusinessServices/SJS/consultaCobranzasH2H/xsd/sjConsultaCobranzasH2H.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCobranzasResponse" location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaCobranzasH2H/xq/sjConsultaRecaudoH2HOut/";

declare function xf:transformarReciboHTML($serviceId as xs:string, $dealSlip as xs:string) as xs:string{
	if($serviceId = "9") then (
		replace( replace( replace($dealSlip,'\[','<'), '\]','>'), '@','"')
	) else (
		$dealSlip
	)
};

declare function xf:sjConsultaRecaudoH2HOut($sjConsultaCobranzasResponse as element(ns0:sjConsultaCobranzasResponse))
    as element(ns1:consultaCobranzasResponse) {
        <ns1:consultaCobranzasResponse>
            {
                for $SERVICES in $sjConsultaCobranzasResponse/SERVICES
                return
                    <SERVICES>
                        {
                            for $id in distinct-values($SERVICES/SERVICE/ID)
                            	let $servicesById := $SERVICES/SERVICE[ ID = $id ]
                            	let $service1 := $servicesById[1]
                            	return
                                <SERVICE>
                                    {
                                        for $SUCCESS_INDICATOR in $service1/SUCCESS_INDICATOR
                                        return
                                            <SUCCESS_INDICATOR>{ data($SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                                    }
                                    {
                                        for $ERROR_MESSAGE in $service1/ERROR_MESSAGE
                                        return
                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                    }
                                    {
                                        for $ID in $service1/ID
                                        return
                                            <ID>{ data($ID) }</ID>
                                    }
                                    {
                                        for $NAME in $service1/NAME
                                        return
                                            <NAME>{ data($NAME) }</NAME>
                                    }
                                    {
                                    	if (count($servicesById/DEBTORS/DEBTOR) > 0) then (	 
		                                    <DEBTORS>
		                                        {
		                                        	for $SERVICE in $servicesById
		                                                for $DEBTOR in $SERVICE/DEBTORS/DEBTOR
		                                                return
		                                                <DEBTOR>
		                                                    {
		                                                        for $SUCCESS_INDICATOR in $DEBTOR/SUCCESS_INDICATOR
		                                                        return
		                                                            <SUCCESS_INDICATOR>{ data($SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
		                                                    }
		                                                    {
		                                                        for $ERROR_MESSAGE in $DEBTOR/ERROR_MESSAGE
		                                                        return
		                                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
		                                                    }
		                                                    {
		                                                        for $TRACE in $DEBTOR/TRACE
		                                                        return
		                                                            <TRACE>{ data($TRACE) }</TRACE>
		                                                    }
		                                                    {
		                                                        for $CODE in $DEBTOR/CODE
		                                                        return
		                                                            <CODE>{ data($CODE) }</CODE>
		                                                    }
		                                                    {
		                                                        for $NAME in $DEBTOR/NAME
		                                                        return
		                                                            <NAME>{ data($NAME) }</NAME>
		                                                    }
		                                                    {
		                                                        for $BILLS in $DEBTOR/BILLS
		                                                        return
		                                                            <BILLS>
		                                                                {
		                                                                    for $BILL in $BILLS/BILL
		                                                                    return
		                                                                        <BILL>
		                                                                            {
		                                                                                for $ID in $BILL/ID
		                                                                                return
		                                                                                    <ID>{ data($ID) }</ID>
		                                                                            }
		                                                                            {
		                                                                                for $ISSUE_DATE in $BILL/ISSUE_DATE
		                                                                                return
		                                                                                    <ISSUE_DATE>{ data($ISSUE_DATE) }</ISSUE_DATE>
		                                                                            }
		                                                                            {
		                                                                                for $DUE_DATE in $BILL/DUE_DATE
		                                                                                return
		                                                                                    <DUE_DATE>{ data($DUE_DATE) }</DUE_DATE>
		                                                                            }
		                                                                            {
		                                                                                for $BALANCES in $BILL/BALANCES
		                                                                                return
		                                                                                    <BALANCES>
		                                                                                        {
		                                                                                            for $BALANCE in $BALANCES/BALANCE
		                                                                                            return
		                                                                                                <BALANCE>
		                                                                                                    {
		                                                                                                        for $CURRENCY in $BALANCE/CURRENCY
		                                                                                                        return
		                                                                                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
		                                                                                                    }
		                                                                                                    {
		                                                                                                        for $AMOUNT in $BALANCE/AMOUNT
		                                                                                                        return
		                                                                                                            <AMOUNT>{ data($AMOUNT) }</AMOUNT>
		                                                                                                    }
		                                                                                                    {
		                                                                                                        for $LATE_FEE in $BALANCE/LATE_FEE
		                                                                                                        return
		                                                                                                            <LATE_FEE>{ data($LATE_FEE) }</LATE_FEE>
		                                                                                                    }
		                                                                                                    {
		                                                                                                        for $TOTAL in $BALANCE/TOTAL
		                                                                                                        return
		                                                                                                            <TOTAL>{ data($TOTAL) }</TOTAL>
		                                                                                                    }
		                                                                                                </BALANCE>
		                                                                                        }
		                                                                                    </BALANCES>
		                                                                            }
		                                                                        </BILL>
		                                                                }
		                                                            </BILLS>
		                                                    }
		                                                    {
		                                                        for $DEALSLIP in $DEBTOR/DEALSLIP
		                                                        return
		                                                            <DEALSLIP>{ xf:transformarReciboHTML(fn:string($service1/ID/text()),fn:string($DEALSLIP)) }</DEALSLIP>
		                                                    }
		                                                </DEBTOR>
		                                        }
		                                    </DEBTORS>
		                                ) else ()
			                       }
                                </SERVICE>
                        }
                    </SERVICES>
            }
        </ns1:consultaCobranzasResponse>
};

declare variable $sjConsultaCobranzasResponse as element(ns0:sjConsultaCobranzasResponse) external;

xf:sjConsultaRecaudoH2HOut($sjConsultaCobranzasResponse)