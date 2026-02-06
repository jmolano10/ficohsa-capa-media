xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponseOut" element="ns0:ConsultaSaldosTarjetaCreditoResponse" location="../../../BusinessServices/VisionPlus/consultaSaldosTarjetaCredito/xsd/ConsultaSaldosTarjetaCreditoService_v2.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaSaldosTarjetaCreditoResponse" location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/Core.Entities";
declare namespace ns3 = "http://schemas.datacontract.org/2004/07/Business.Entities";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoOutPA/";

declare function xf:consultaSaldosTarjetaCreditoOutPA($consultaSaldosTarjetaCreditoResponseOut as element(ns0:ConsultaSaldosTarjetaCreditoResponse),
    $valSaldoActual as xs:string?,
    $availablePurchase as xs:string?)
    as element(ns2:consultaSaldosTarjetaCreditoResponse) {
        <ns2:consultaSaldosTarjetaCreditoResponse>
            {
                for $CARD_NUMBER in $consultaSaldosTarjetaCreditoResponseOut/ns0:ConsultaSaldosTarjetaCreditoResult/ns3:ConsultaSaldosTarjetaCreditoResponse/ns3:CARD_NUMBER
                return
                    <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>
            }
            {
                for $CARD_HOLDER_NAME in $consultaSaldosTarjetaCreditoResponseOut/ns0:ConsultaSaldosTarjetaCreditoResult/ns3:ConsultaSaldosTarjetaCreditoResponse/ns3:CARD_HOLDER_NAME
                return
                    <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
            }
            {
                for $LCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponseOut/ns0:ConsultaSaldosTarjetaCreditoResult/ns3:ConsultaSaldosTarjetaCreditoResponse/ns3:LCY_MIN_PAYMENT
                return
                    <FCY_MIN_PAYMENT>{ data($LCY_MIN_PAYMENT) }</FCY_MIN_PAYMENT>
            }
            {
                for $LCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponseOut/ns0:ConsultaSaldosTarjetaCreditoResult/ns3:ConsultaSaldosTarjetaCreditoResponse/ns3:LCY_TOTAL_PAYMENT
                return
                    <FCY_TOTAL_PAYMENT>{ data($LCY_TOTAL_PAYMENT) }</FCY_TOTAL_PAYMENT>
            }
            {
                for $CREDIT_LIMIT in $consultaSaldosTarjetaCreditoResponseOut/ns0:ConsultaSaldosTarjetaCreditoResult/ns3:ConsultaSaldosTarjetaCreditoResponse/ns3:CREDIT_LIMIT
                return
                    <CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</CREDIT_LIMIT>
            }
            {
                for $CREDIT_LIMIT_CCY in $consultaSaldosTarjetaCreditoResponseOut/ns0:ConsultaSaldosTarjetaCreditoResult/ns3:ConsultaSaldosTarjetaCreditoResponse/ns3:CREDIT_LIMIT_CCY
                return
                    <CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</CREDIT_LIMIT_CCY>
            }
            {
	        if($valSaldoActual != '')then(
	        	 	<POINTS_EARNED>{$valSaldoActual}</POINTS_EARNED>
	        	 )else()
	        }
            {
                for $MAX_PAYMENT_DATE in $consultaSaldosTarjetaCreditoResponseOut/ns0:ConsultaSaldosTarjetaCreditoResult/ns3:ConsultaSaldosTarjetaCreditoResponse/ns3:MAX_PAYMENT_DATE
                return
   					if(string($MAX_PAYMENT_DATE/text()) = '')then(   
   						 <MAX_PAYMENT_DATE>19000101</MAX_PAYMENT_DATE>                       						                                 
                    )else if(string($MAX_PAYMENT_DATE/text()) = '00000000')then(
                         <MAX_PAYMENT_DATE>19000101</MAX_PAYMENT_DATE>                    
                    )                    
                    else(
                    	<MAX_PAYMENT_DATE>{data($MAX_PAYMENT_DATE)}</MAX_PAYMENT_DATE>
                    )                       
            }
            {
				for $lastCutoffDate in $consultaSaldosTarjetaCreditoResponseOut/ns0:ConsultaSaldosTarjetaCreditoResult/ns3:ConsultaSaldosTarjetaCreditoResponse/ns3:LAST_CUTOFF_DATE
				return
   					if(string($lastCutoffDate/text()) = '')then( 
					     <LAST_CUTOFF_DATE>19000101</LAST_CUTOFF_DATE>                       					                   
                    )
					else if(string($lastCutoffDate/text()) ='00000000')then(
					     <LAST_CUTOFF_DATE>19000101</LAST_CUTOFF_DATE>                    
                    )                       
                    else(
            			<LAST_CUTOFF_DATE>{data($lastCutoffDate)}</LAST_CUTOFF_DATE>
                    )   
            }            
            {
                for $ConsultaSaldosTarjetaCreditoRecordDetail in $consultaSaldosTarjetaCreditoResponseOut/ns0:ConsultaSaldosTarjetaCreditoResult/ns3:ConsultaSaldosTarjetaCreditoResponse/ns3:ConsultaSaldosTarjetaCreditoRecordDetail
                return
                    <ns2:consultaSaldosTarjetaCreditoResponseType>
                        {
                            for $ConsultaSaldosTarjetaCreditoRecordDetailDTO in $ConsultaSaldosTarjetaCreditoRecordDetail/ns3:ConsultaSaldosTarjetaCreditoRecordDetailDTO
                            return
                                <ns2:consultaSaldosTarjetaCreditoResponseRecordType>
                                    {
                                        for $CURRENCY in $ConsultaSaldosTarjetaCreditoRecordDetailDTO/ns3:CURRENCY
                                        return
                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                    }
                                    {
                                        for $OVERDUE_BALANCE in $ConsultaSaldosTarjetaCreditoRecordDetailDTO/ns3:OVERDUE_BALANCE
                                        return
                                            <OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</OVERDUE_BALANCE>
                                    }
                                    {
                                        for $FLOATING_BALANCE in $ConsultaSaldosTarjetaCreditoRecordDetailDTO/ns3:FLOATING_BALANCE
                                        return
                                            <FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</FLOATING_BALANCE>
                                    }
                                    {
                                        for $CURRENT_BALANCE in $ConsultaSaldosTarjetaCreditoRecordDetailDTO/ns3:CURRENT_BALANCE
                                        return
                                            <CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>
                                    }
                                    {
										if($availablePurchase != '')then(
												<PURCHASES_LIMIT>{$availablePurchase}</PURCHASES_LIMIT>
										)else(
												<PURCHASES_LIMIT>0</PURCHASES_LIMIT>
										)
					        	 	}
                                    {
                                        for $WITHDRAWAL_LIMIT in $ConsultaSaldosTarjetaCreditoRecordDetailDTO/ns3:WITHDRAWAL_LIMIT
                                        return
                                            <WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
                                    }
                                    {
                                        for $PAYMENTS_TODAY in $ConsultaSaldosTarjetaCreditoRecordDetailDTO/ns3:PAYMENTS_TODAY
                                        return
                                            <PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</PAYMENTS_TODAY>
                                    }
                                </ns2:consultaSaldosTarjetaCreditoResponseRecordType>
                        }
                    </ns2:consultaSaldosTarjetaCreditoResponseType>
            }
        </ns2:consultaSaldosTarjetaCreditoResponse>
};

declare variable $consultaSaldosTarjetaCreditoResponseOut as element(ns0:ConsultaSaldosTarjetaCreditoResponse) external;
declare variable $valSaldoActual as xs:string? external;
declare variable $availablePurchase as xs:string? external;


xf:consultaSaldosTarjetaCreditoOutPA($consultaSaldosTarjetaCreditoResponseOut,
    $valSaldoActual,
    $availablePurchase)