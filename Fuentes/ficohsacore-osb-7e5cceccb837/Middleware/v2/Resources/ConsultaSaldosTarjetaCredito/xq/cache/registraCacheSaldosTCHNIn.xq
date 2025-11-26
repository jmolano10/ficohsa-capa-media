(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse1" element="ns1:consultaSaldosTarjetaCreditoResponse" location="../../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/registraSaldosTC/xsd/registraSaldosTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraSaldosTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/cache/registraCacheSaldosTCIn/";

declare function xf:registraCacheSaldosTCIn($consultaSaldosTarjetaCreditoResponse1 as element(ns1:consultaSaldosTarjetaCreditoResponse), $countryCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_SALDOS_TARJETA>
            {
            	for $row in $consultaSaldosTarjetaCreditoResponse1/ns1:consultaSaldosTarjetaCreditoResponseType/ns1:consultaSaldosTarjetaCreditoResponseRecordType
                	return(
		                <ns0:PT_SALDOS_TARJETA_ITEM>
		                {
		                	(
		            		    for $CARD_NUMBER in $consultaSaldosTarjetaCreditoResponse1/CARD_NUMBER
		                        return
		                            <ns0:CARD_NUMBER>{ data($CARD_NUMBER) }</ns0:CARD_NUMBER>
		                    ),
		                    (
		            		    for $CARD_HOLDER_NAME in $consultaSaldosTarjetaCreditoResponse1/CARD_HOLDER_NAME
		                        return
		                            <ns0:CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</ns0:CARD_HOLDER_NAME>
		                    ),
		                    (
		            		    for $LCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponse1/LCY_MIN_PAYMENT
		                        return
		                            <ns0:LCY_MIN_PAYMENT>{ data($LCY_MIN_PAYMENT) }</ns0:LCY_MIN_PAYMENT>
		                    ),
		                    (
		            		    for $LCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponse1/LCY_TOTAL_PAYMENT
		                        return
		                            <ns0:LCY_TOTAL_PAYMENT>{ data($LCY_TOTAL_PAYMENT) }</ns0:LCY_TOTAL_PAYMENT>
		                    ),
		                    (
		            		    for $FCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponse1/FCY_MIN_PAYMENT
		                        return
		                            <ns0:FCY_MIN_PAYMENT>{ data($FCY_MIN_PAYMENT) }</ns0:FCY_MIN_PAYMENT>
		                    ),
		                    (
		            		    for $FCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponse1/FCY_TOTAL_PAYMENT
		                        return
		                            <ns0:FCY_TOTAL_PAYMENT>{ data($FCY_TOTAL_PAYMENT) }</ns0:FCY_TOTAL_PAYMENT>
		                    ),
		                    (
		            		    for $CREDIT_LIMIT in $consultaSaldosTarjetaCreditoResponse1/CREDIT_LIMIT
		                        return
		                            <ns0:CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</ns0:CREDIT_LIMIT>
		                    ),
		                    (
		            		    for $CREDIT_LIMIT_CCY in $consultaSaldosTarjetaCreditoResponse1/CREDIT_LIMIT_CCY
		                        return
		                            <ns0:CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</ns0:CREDIT_LIMIT_CCY>
		                    ),
		                    (
		            		    for $POINTS_EARNED in $consultaSaldosTarjetaCreditoResponse1/POINTS_EARNED
		                        return
		                            <ns0:POINTS_EARNED>{ data($POINTS_EARNED) }</ns0:POINTS_EARNED>
		                    ),
		                    (
		            		    for $MAX_PAYMENT_DATE in $consultaSaldosTarjetaCreditoResponse1/MAX_PAYMENT_DATE
		                        return
		                            <ns0:MAX_PAYMENT_DATE>{ data($MAX_PAYMENT_DATE) }</ns0:MAX_PAYMENT_DATE>
		                    ),
		                    (
		            		    for $LAST_CUTOFF_DATE in $consultaSaldosTarjetaCreditoResponse1/LAST_CUTOFF_DATE
		                        return
		                            <ns0:LAST_CUTOFF_DATE>{ data($LAST_CUTOFF_DATE) }</ns0:LAST_CUTOFF_DATE>
		                    ),
		                    (: Different Currency :)
		                    (
		            		    for $CURRENCY in $row/CURRENCY
		            		    return
			            		    if(data($CURRENCY) = 'HNL')then(
			                            <ns0:ORG_TYPE>BASE</ns0:ORG_TYPE>
			                        )else(
			                        	<ns0:ORG_TYPE>ALT</ns0:ORG_TYPE>
			                        )
		                    ),
		                    (
		            		    for $CURRENCY in $row/CURRENCY
		            		    return
			            		    if(data($CURRENCY) = 'HNL')then(
			                            <ns0:ORG>340</ns0:ORG>
			                        )else(
			                        	<ns0:ORG>341</ns0:ORG>
			                        )
		                    ),
		                    (
		            		    for $CURRENCY in $row/CURRENCY
		                        return
		                            <ns0:CURRENCY>{ data($CURRENCY) }</ns0:CURRENCY>
		                    ),
		                    (
		            		    for $OVERDUE_BALANCE in $row/OVERDUE_BALANCE
		                        return
		                            <ns0:OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</ns0:OVERDUE_BALANCE>
		                    ),
		                    (
		            		    for $FLOATING_BALANCE in $row/FLOATING_BALANCE
		                        return
		                            <ns0:FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</ns0:FLOATING_BALANCE>
		                    ),
		                    (
		            		    for $CURRENT_BALANCE in $row/CURRENT_BALANCE
		                        return
		                            <ns0:CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</ns0:CURRENT_BALANCE>
		                    ),
		                    (
		            		    for $PURCHASES_LIMIT in $row/PURCHASES_LIMIT
		                        return
		                            <ns0:PURCHASES_LIMIT>{ data($PURCHASES_LIMIT) }</ns0:PURCHASES_LIMIT>
		                    ),
		                    (
		            		    for $WITHDRAWAL_LIMIT in $row/WITHDRAWAL_LIMIT
		                        return
		                            <ns0:WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</ns0:WITHDRAWAL_LIMIT>
		                    ),
		                    (
		            		    for $PAYMENTS_TODAY in $row/PAYMENTS_TODAY
		                        return
		                            <ns0:PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</ns0:PAYMENTS_TODAY>
		                    ),
		                    (
		            		    for $AVAILABLE_EXTRA in $row/AVAILABLE_EXTRA
		                        return
		                            <ns0:AVAILABLE_EXTRA>{ data($AVAILABLE_EXTRA) }</ns0:AVAILABLE_EXTRA>
		                    ),
		                    (
		            		    for $CURRENT_BALANCE_EXTRA in $row/CURRENT_BALANCE_EXTRA
		                        return
		                            <ns0:CURRENT_BALANCE_EXTRA>{ data($CURRENT_BALANCE_EXTRA) }</ns0:CURRENT_BALANCE_EXTRA>
		                    ),
		                    (
		            		    for $AVAILABLE_INTRA in $row/AVAILABLE_INTRA
		                        return
		                            <ns0:AVAILABLE_INTRA>{ data($AVAILABLE_INTRA) }</ns0:AVAILABLE_INTRA>
		                    ),
		                    (
		            		    for $CURRENT_BALANCE_INTRA in $row/CURRENT_BALANCE_INTRA
		                        return
		                            <ns0:CURRENT_BALANCE_INTRA>{ data($CURRENT_BALANCE_INTRA) }</ns0:CURRENT_BALANCE_INTRA>
		                    )
		                }
		                </ns0:PT_SALDOS_TARJETA_ITEM>)
            }
            </ns0:PT_SALDOS_TARJETA>
            <ns0:PV_COUNTRY_CODE>{ $countryCode }</ns0:PV_COUNTRY_CODE>
        </ns0:InputParameters>
};

declare variable $consultaSaldosTarjetaCreditoResponse1 as element(ns1:consultaSaldosTarjetaCreditoResponse) external;
declare variable $countryCode as xs:string external;

xf:registraCacheSaldosTCIn($consultaSaldosTarjetaCreditoResponse1, $countryCode)
