(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns1:ResponseHeader" location="../../../../Resources/EsquemasGenerales/headerElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoResponse" element="ns2:consultaRecaudoResponse" location="../../../OSB/consultaRecaudo_v2/xsd/XMLSchema_-844801591.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaCobranzasResponse/SERVICES/SERVICE/DEBTORS/DEBTOR" location="../xsd/sjConsultaCobranzasH2H.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/consultaCobranzasH2H/xq/consultaRecaudosOut/";

declare function xf:consultaRecaudosOut($trace as xs:string,
    $code as xs:string,
    $localCurrency as xs:string,
    $requestCurrency as xs:string,
    $responseHeader as element(ns1:ResponseHeader),
    $consultaRecaudoResponse as element(ns2:consultaRecaudoResponse))
    as element() {
        <DEBTOR>
            {
            
                let $successIndicator := string($responseHeader/successIndicator/text())
                return(
                    <SUCCESS_INDICATOR>{ $successIndicator }</SUCCESS_INDICATOR>,
                    if (upper-case($successIndicator) = 'SUCCESS')then(

                        <TRACE>{ $trace }</TRACE>,
                        <CODE>{ $code }</CODE>,

                        for $DEBTOR_NAME in $consultaRecaudoResponse/DEBTOR_NAME
                        return
                            <NAME>{ data($DEBTOR_NAME) }</NAME>,

                        for $BILLS in $consultaRecaudoResponse/BILLS
                        return
                            <BILLS>
                                {
                                    for $BILL_RECORD in $BILLS/BILL_RECORD
                                    return
                                        <BILL>
                                            {
                                                for $BILL_NUMBER in $BILL_RECORD/BILL_NUMBER
                                                return
                                                    <ID>{ data($BILL_NUMBER) }</ID>
                                            }
                                            {
                                            let $ISSUE_DATE := string($BILL_RECORD/ISSUE_DATE/text())
                        					return
                            					if( $ISSUE_DATE != '' ) then (
                                					<ISSUE_DATE>{ fn-bea:date-from-string-with-format('yyyyMMdd', data($ISSUE_DATE)) }</ISSUE_DATE>
                            						) else ()
                                            }
                                            {
                                            let $DUE_DATE := string($BILL_RECORD/DUE_DATE/text())
                        					return
                            					if( $DUE_DATE != '' ) then (
                                					<DUE_DATE>{ fn-bea:date-from-string-with-format('yyyyMMdd', data($DUE_DATE)) }</DUE_DATE>
                            						) else ()
                                            }
                                            <BALANCES>
                                            
                                            	{
                                            		let $balances := (
                                            			<BALANCE>
                                                    		<CURRENCY>{ $localCurrency }</CURRENCY>
                                                    		<TOTAL>{ round-half-to-even(xs:double($BILL_RECORD/TOTAL_AMOUNT_LOC), 2) }</TOTAL>
                                                		</BALANCE>,
                                                		<BALANCE>
                                                    		<CURRENCY>USD</CURRENCY>
                                                    		<TOTAL>{ round-half-to-even(xs:double($BILL_RECORD/TOTAL_AMOUNT_USD), 2) }</TOTAL>
                                                		</BALANCE> )
                                                	return 
                                                		if($requestCurrency = "" ) then ( 
                                                			$balances 
                                                		) else ( 
                                                			$balances[CURRENCY = $requestCurrency] 
                                                		)  
                                            	}
                                            </BALANCES>
                                        </BILL>
                                }
                            </BILLS>,

                        let $BILL_DETAIL := string($consultaRecaudoResponse/BILL_DETAIL/text())
                        return
                            if( $BILL_DETAIL != '' )then(
                                <DEALSLIP>{ $BILL_DETAIL }</DEALSLIP>
                            ) else ()
                    )else(
                        for $message in $responseHeader/messages[1]
                        return
                            if ( string($message/text()) != '' )then (
                                <ERROR_MESSAGE>{ string-join($responseHeader/messages, '. ') }</ERROR_MESSAGE>
                            )else(),
                        <TRACE>{ $trace }</TRACE>,
                        <CODE>{ $code }</CODE>
                    )
                )

            }
        </DEBTOR>
};

declare variable $trace as xs:string external;
declare variable $code as xs:string external;
declare variable $localCurrency as xs:string external;
declare variable $requestCurrency as xs:string external;
declare variable $responseHeader as element(ns1:ResponseHeader) external;
declare variable $consultaRecaudoResponse as element(ns2:consultaRecaudoResponse) external;

xf:consultaRecaudosOut($trace,
    $code,
    $localCurrency,
    $requestCurrency,
    $responseHeader,
    $consultaRecaudoResponse)