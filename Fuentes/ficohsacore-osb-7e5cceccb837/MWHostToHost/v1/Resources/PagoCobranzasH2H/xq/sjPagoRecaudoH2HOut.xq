(:: pragma bea:global-element-parameter parameter="$sjPagoCobranzasResponse" element="ns0:sjPagoCobranzasResponse" location="../../../BusinessServices/SJS/pagoCobranzasH2H/xsd/sjPagoCobranzasH2H.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoCobranzasResponse" location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagoCobranzasH2H/xq/sjPagoRecaudoH2HOut/";

declare function xf:transformarReciboHTML($serviceId as xs:string, $dealSlip as xs:string, $customerName as xs:string) as xs:string{
	if($serviceId = "9") then (
		replace( replace( replace( replace($dealSlip,'\[','<'), '\]','>'), '@','"'), '<-nombreCliente->',$customerName)
	) else (
		$dealSlip
	)
};

declare function xf:sjPagoRecaudoH2HOut($sjPagoCobranzasResponse as element(ns0:sjPagoCobranzasResponse), $customerName as xs:string)
    as element(ns1:pagoCobranzasResponse) {
        <ns1:pagoCobranzasResponse>
            {
                for $SERVICES in $sjPagoCobranzasResponse/SERVICES
                return
                    <SERVICES>
                        {
                            for $i in distinct-values ($SERVICES/SERVICE/ID)             
                                let $SERVICESBYID := $SERVICES/SERVICE[ID = $i]
                                let $SERVICE1 := $SERVICESBYID[1]
                                return
                                    <SERVICE>
                                        <SUCCESS_INDICATOR>{ data($SERVICE1/SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                                        {
                                            for $ERROR_MESSAGE in $SERVICE1/ERROR_MESSAGE
                                            return
                                                <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                        }
                                        <ID>{ data($SERVICE1/ID) }</ID>
                                        {
                                            for $NAME in $SERVICE1/NAME
                                            return
                                                <NAME>{ data($NAME) }</NAME>
                                        }                                  
                                        {
                                        	if (count($SERVICESBYID/DEBTORS/DEBTOR) > 0) then (	                                        	
                                    			<DEBTORS>
                                    				{                                    		
                                            			for $SERVICE in $SERVICESBYID                                             
                                                			for  $DEBTOR in $SERVICE/DEBTORS/DEBTOR
                                                			return
                                                                <DEBTOR>
                                                                    {
                                                                        for $TRANSACTION_ID in $DEBTOR/TRANSACTION_ID
                                                                        return
                                                                            <TRANSACTION_ID>{ data($TRANSACTION_ID) }</TRANSACTION_ID>
                                                                    }                                                            
                                                                    <SUCCESS_INDICATOR>{ data($DEBTOR/SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
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
										                                for $PAYMENT_INFORMATION in $DEBTOR/PAYMENT_INFORMATION
										                                return
										                                    <PAYMENT_INFORMATION>
										                                    	{
			                                                                        for $PYMT_METHOD in $PAYMENT_INFORMATION/PYMT_METHOD
			                                                                        return
			                                                                            <PYMT_METHOD>{ data($PYMT_METHOD) }</PYMT_METHOD>
			                                                                    }
										                                        {
			                                                                        for $CURRENCY in $PAYMENT_INFORMATION/CURRENCY
			                                                                        return
			                                                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
			                                                                    }
			                                                                    {
			                                                                        for $AMOUNT in $PAYMENT_INFORMATION/AMOUNT
			                                                                        return
			                                                                            <AMOUNT>{ data($AMOUNT) }</AMOUNT>
			                                                                    }
			                                                                    {
			                                                                        for $LATE_FEE in $PAYMENT_INFORMATION/LATE_FEE
			                                                                        return
			                                                                            <LATE_FEE>{ data($LATE_FEE) }</LATE_FEE>
			                                                                    }
			                                                                    {
			                                                                        for $TOTAL in $PAYMENT_INFORMATION/TOTAL
			                                                                        return
			                                                                            <TOTAL>{ data($TOTAL) }</TOTAL>
			                                                                    }
										                                    </PAYMENT_INFORMATION>
										                            }
										                            {
                                                                        for $DEALSLIP in $DEBTOR/DEALSLIP
                                                                        return
                                                                            <DEALSLIP>{ xf:transformarReciboHTML(fn:string($SERVICE1/ID/text()),fn:string($DEALSLIP),$customerName) }</DEALSLIP>
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
        </ns1:pagoCobranzasResponse>
};

declare variable $sjPagoCobranzasResponse as element(ns0:sjPagoCobranzasResponse) external;
declare variable $customerName as xs:string external;

xf:sjPagoRecaudoH2HOut($sjPagoCobranzasResponse, $customerName)