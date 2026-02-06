xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse" element="ns1:ConsultaSaldosTarjetaCreditoResponse" location="../../../BusinessServices/ConsultaSaldosTarjetaCredito/wsdl/ConsultaSaldosTarjetaCreditoService_v2.svc.singleWsdl.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCreditoResponse" location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns2 = "http://schemas.datacontract.org/2004/07/Business.Entities";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns3 = "http://schemas.datacontract.org/2004/07/Core.Entities";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoHNOut/";

declare function xf:consultaSaldosTarjetaCreditoHNOut($consultaSaldosTarjetaCreditoResponse as element(ns1:ConsultaSaldosTarjetaCreditoResponse),
    $valSaldoActual as xs:string?)
    as element(ns0:consultaSaldosTarjetaCreditoResponse) {
        <ns0:consultaSaldosTarjetaCreditoResponse>
            {
                for $CARD_NUMBER in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:CARD_NUMBER
                return
                    <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>
            }
            {
                for $CARD_HOLDER_NAME in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:CARD_HOLDER_NAME
                return
                    <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
            }
            {
                for $LCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:LCY_MIN_PAYMENT
                return
           		 	<LCY_MIN_PAYMENT>{ data($LCY_MIN_PAYMENT) }</LCY_MIN_PAYMENT>
            }
            {
            	for $LCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:LCY_TOTAL_PAYMENT
                return
           		 	<LCY_TOTAL_PAYMENT>{ data($LCY_TOTAL_PAYMENT) }</LCY_TOTAL_PAYMENT>
            }
            {
            	for $FCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:FCY_MIN_PAYMENT
                return
            		<FCY_MIN_PAYMENT>{ data($FCY_MIN_PAYMENT) }</FCY_MIN_PAYMENT>
           	}
           	{
           		for $FCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:FCY_TOTAL_PAYMENT
                return
            		<FCY_TOTAL_PAYMENT>{ data($FCY_TOTAL_PAYMENT) }</FCY_TOTAL_PAYMENT>
            }
            {
            	for $CREDIT_LIMIT in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:CREDIT_LIMIT
                return
            		<CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</CREDIT_LIMIT>
           	}
           	{
           		for $CREDIT_LIMIT_CCY in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:CREDIT_LIMIT_CCY
                return
            		<CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</CREDIT_LIMIT_CCY>
            }
            {
		        if($valSaldoActual != '')then(
		        	 	<POINTS_EARNED>{$valSaldoActual}</POINTS_EARNED>
		       	)else()
	        }
	        {
	        	for $MAX_PAYMENT_DATE in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:MAX_PAYMENT_DATE where not($MAX_PAYMENT_DATE = ('', '00000000'))
                return
            		<MAX_PAYMENT_DATE>{ data($consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:MAX_PAYMENT_DATE) }</MAX_PAYMENT_DATE>
            }
            <LAST_CUTOFF_DATE>{ data($consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:LAST_CUTOFF_DATE) }</LAST_CUTOFF_DATE>
           {
           		let $ConsultaSaldosTarjetaCreditoRecordDetailHNL := $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:ConsultaSaldosTarjetaCreditoRecordDetail/ns2:ConsultaSaldosTarjetaCreditoRecordDetailDTO[ns2:CURRENCY = 'HNL']
           		let $ConsultaSaldosTarjetaCreditoRecordDetailUSD := $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:ConsultaSaldosTarjetaCreditoRecordDetail/ns2:ConsultaSaldosTarjetaCreditoRecordDetailDTO[ns2:CURRENCY = 'USD']
                return
		            <ns0:consultaSaldosTarjetaCreditoResponseType>
		            {
	            	  	if(not(empty($ConsultaSaldosTarjetaCreditoRecordDetailHNL))) then (
	            	  		<ns0:consultaSaldosTarjetaCreditoResponseRecordType>
			                	{
			                		for $CURRENCY in $ConsultaSaldosTarjetaCreditoRecordDetailHNL/ns2:CURRENCY
                                    return
			                    		<CURRENCY>{ data($CURRENCY) }</CURRENCY>
			                    }
			                    {
			                    	for $OVERDUE_BALANCE in $ConsultaSaldosTarjetaCreditoRecordDetailHNL/ns2:OVERDUE_BALANCE
                                    return
			                    		<OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</OVERDUE_BALANCE>
			                    }
			                    {
			                    	 for $FLOATING_BALANCE in $ConsultaSaldosTarjetaCreditoRecordDetailHNL/ns2:FLOATING_BALANCE
                                     return
			                    		<FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</FLOATING_BALANCE>
			                    }
			                    {
			                    	for $CURRENT_BALANCE in $ConsultaSaldosTarjetaCreditoRecordDetailHNL/ns2:CURRENT_BALANCE
                                        return
			                  	    	<CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>
			                    }
			                    {
			                    	for $PURCHASES_LIMIT in $ConsultaSaldosTarjetaCreditoRecordDetailHNL/ns2:PURCHASES_LIMIT
                                        return
			                    	<PURCHASES_LIMIT>{ data($PURCHASES_LIMIT) }</PURCHASES_LIMIT>
			                    }
			                    {
			                    	 for $WITHDRAWAL_LIMIT in $ConsultaSaldosTarjetaCreditoRecordDetailHNL/ns2:WITHDRAWAL_LIMIT
                                     return
			                    		<WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
			                    }
			                    {
			                    	for $PAYMENTS_TODAY in $ConsultaSaldosTarjetaCreditoRecordDetailHNL/ns2:PAYMENTS_TODAY
                                    return
			                    		<PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</PAYMENTS_TODAY>
			                	}
			                	{
			                    	for $AVAILABLE_EXTRA in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:EXTRA_AMOUNT
                                    return
                                    if ($AVAILABLE_EXTRA != '') then (
                                    	<AVAILABLE_EXTRA>{ data($AVAILABLE_EXTRA) }</AVAILABLE_EXTRA>
                                    ) else ()		
			                	}
			                    <CURRENT_BALANCE_EXTRA>0</CURRENT_BALANCE_EXTRA>
			                	{
			                    	for $AVAILABLE_INTRA in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:INTRA_AMOUNT
                                    return
			                    	if ($AVAILABLE_INTRA != '') then (
			                    		<AVAILABLE_INTRA>{ data($AVAILABLE_INTRA) }</AVAILABLE_INTRA>
			                    	) else ()
			                	}
			                    <CURRENT_BALANCE_INTRA>0</CURRENT_BALANCE_INTRA>
			                </ns0:consultaSaldosTarjetaCreditoResponseRecordType>
	            	  	) else (),
	            	  	if(not(empty($ConsultaSaldosTarjetaCreditoRecordDetailUSD))) then (
	            	  		<ns0:consultaSaldosTarjetaCreditoResponseRecordType>
			                	{
			                		for $CURRENCY in $ConsultaSaldosTarjetaCreditoRecordDetailUSD/ns2:CURRENCY
                                    return
			                    		<CURRENCY>{ data($CURRENCY) }</CURRENCY>
			                    }
			                    {
			                    	for $OVERDUE_BALANCE in $ConsultaSaldosTarjetaCreditoRecordDetailUSD/ns2:OVERDUE_BALANCE
                                    return
			                    		<OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</OVERDUE_BALANCE>
			                    }
			                    {
			                    	 for $FLOATING_BALANCE in $ConsultaSaldosTarjetaCreditoRecordDetailUSD/ns2:FLOATING_BALANCE
                                     return
			                    		<FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</FLOATING_BALANCE>
			                    }
			                    {
			                    	for $CURRENT_BALANCE in $ConsultaSaldosTarjetaCreditoRecordDetailUSD/ns2:CURRENT_BALANCE
                                        return
			                  	    	<CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>
			                    }
			                    {
			                    	for $PURCHASES_LIMIT in $ConsultaSaldosTarjetaCreditoRecordDetailUSD/ns2:PURCHASES_LIMIT
                                        return
			                    	<PURCHASES_LIMIT>{ data($PURCHASES_LIMIT) }</PURCHASES_LIMIT>
			                    }
			                    {
			                    	 for $WITHDRAWAL_LIMIT in $ConsultaSaldosTarjetaCreditoRecordDetailUSD/ns2:WITHDRAWAL_LIMIT
                                     return
			                    		<WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
			                    }
			                    {
			                    	for $PAYMENTS_TODAY in $ConsultaSaldosTarjetaCreditoRecordDetailUSD/ns2:PAYMENTS_TODAY
                                    return
			                    		<PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</PAYMENTS_TODAY>
			                	}
			                	{
			                    	for $AVAILABLE_EXTRA in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:EXTRA_AMOUNT
                                    return
                                    if ($AVAILABLE_EXTRA != '') then (
                                    	<AVAILABLE_EXTRA>{ data($AVAILABLE_EXTRA) }</AVAILABLE_EXTRA>
                                    ) else ()		
			                	}
			                    <CURRENT_BALANCE_EXTRA>0</CURRENT_BALANCE_EXTRA>
			                	{
			                    	for $AVAILABLE_INTRA in $consultaSaldosTarjetaCreditoResponse/ns1:ConsultaSaldosTarjetaCreditoResult/ns2:ConsultaSaldosTarjetaCreditoResponse/ns2:INTRA_AMOUNT
                                    return
			                    	if ($AVAILABLE_INTRA != '') then (
			                    		<AVAILABLE_INTRA>{ data($AVAILABLE_INTRA) }</AVAILABLE_INTRA>
			                    	) else ()
			                	}
			                    <CURRENT_BALANCE_INTRA>0</CURRENT_BALANCE_INTRA>
			                </ns0:consultaSaldosTarjetaCreditoResponseRecordType>
	            	  	) else ()
		            }
		            </ns0:consultaSaldosTarjetaCreditoResponseType>
            }
        </ns0:consultaSaldosTarjetaCreditoResponse>
};

declare variable $consultaSaldosTarjetaCreditoResponse as element(ns1:ConsultaSaldosTarjetaCreditoResponse) external;
declare variable $valSaldoActual as xs:string? external;
xf:consultaSaldosTarjetaCreditoHNOut($consultaSaldosTarjetaCreditoResponse,
    $valSaldoActual)