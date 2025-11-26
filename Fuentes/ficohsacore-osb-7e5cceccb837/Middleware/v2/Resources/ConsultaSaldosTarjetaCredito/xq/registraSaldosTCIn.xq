(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTarjetaCreditoResponse" element="ns0:sjConsultaSaldosTarjetaCreditoResponse" location="../../../BusinessServices/SJS/consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/registraSaldosTC/xsd/registraSaldosTC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraSaldosTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/registraSaldosTCIn/";

declare function xf:registraSaldosTCIn($sjConsultaSaldosTarjetaCreditoResponse as element(ns0:sjConsultaSaldosTarjetaCreditoResponse), $valSaldoActual as xs:string?, $countryCode as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_SALDOS_TARJETA>
            {
            	for $saldosTCItem in $sjConsultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType
            	return(
            		<ns1:PT_SALDOS_TARJETA_ITEM>
                    {
                        for $CARD_NUMBER in $sjConsultaSaldosTarjetaCreditoResponse/CARD_NUMBER
                        return
                            <ns1:CARD_NUMBER>{ data($CARD_NUMBER) }</ns1:CARD_NUMBER>
                    }
                    {
                        for $CARD_HOLDER_NAME in $sjConsultaSaldosTarjetaCreditoResponse/CARD_HOLDER_NAME
                        return
                            <ns1:CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</ns1:CARD_HOLDER_NAME>
                    }
                    {
                        for $LCY_MIN_PAYMENT in $sjConsultaSaldosTarjetaCreditoResponse/LCY_MIN_PAYMENT
                        return
                            <ns1:LCY_MIN_PAYMENT>{ data($LCY_MIN_PAYMENT) }</ns1:LCY_MIN_PAYMENT>
                    }
                    {
                        for $LCY_TOTAL_PAYMENT in $sjConsultaSaldosTarjetaCreditoResponse/LCY_TOTAL_PAYMENT
                        return
                            <ns1:LCY_TOTAL_PAYMENT>{ data($LCY_TOTAL_PAYMENT) }</ns1:LCY_TOTAL_PAYMENT>
                    }
                    {
                        for $FCY_MIN_PAYMENT in $sjConsultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT
                        return
                            <ns1:FCY_MIN_PAYMENT>{ data($FCY_MIN_PAYMENT) }</ns1:FCY_MIN_PAYMENT>
                    }
                    {
                        for $FCY_TOTAL_PAYMENT in $sjConsultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT
                        return
                            <ns1:FCY_TOTAL_PAYMENT>{ data($FCY_TOTAL_PAYMENT) }</ns1:FCY_TOTAL_PAYMENT>
                    }
                    {
                        for $CREDIT_LIMIT in $sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT
                        return
                            <ns1:CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</ns1:CREDIT_LIMIT>
                    }
                    {
                        for $CREDIT_LIMIT_CCY in $sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY
                        return
                            <ns1:CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</ns1:CREDIT_LIMIT_CCY>
                    }
                    {
                       if($valSaldoActual != '') then (
        					<ns1:POINTS_EARNED>{ $valSaldoActual }</ns1:POINTS_EARNED>
        				) else (
        					<ns1:POINTS_EARNED>0</ns1:POINTS_EARNED>
        				)
                    }
                    
                    
                    {
                        for $MAX_PAYMENT_DATE in $sjConsultaSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE
                        return
                            <ns1:MAX_PAYMENT_DATE>{ data($MAX_PAYMENT_DATE) }</ns1:MAX_PAYMENT_DATE>
                    }
                    {
                        for $LAST_CUTOFF_DATE in $sjConsultaSaldosTarjetaCreditoResponse/LAST_CUTOFF_DATE
                        return
                            <ns1:LAST_CUTOFF_DATE>{ data($LAST_CUTOFF_DATE) }</ns1:LAST_CUTOFF_DATE>
                    }
                    {
                        for $ORG_TYPE in $saldosTCItem/ORG_TYPE
                        return
                            <ns1:ORG_TYPE>{ data($ORG_TYPE) }</ns1:ORG_TYPE>
                    }
                    {
                        for $ORG in $saldosTCItem/ORG
                        return
                            <ns1:ORG>{ data($ORG) }</ns1:ORG>
                    }
                    {
                        for $CURRENCY in $saldosTCItem/CURRENCY
                        return
                            <ns1:CURRENCY>{ data($CURRENCY) }</ns1:CURRENCY>
                    }
                    {
                        for $OVERDUE_BALANCE in $saldosTCItem/OVERDUE_BALANCE
                        return
                            <ns1:OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</ns1:OVERDUE_BALANCE>
                    }
                    {
                        for $FLOATING_BALANCE in $saldosTCItem/FLOATING_BALANCE
                        return
                            <ns1:FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</ns1:FLOATING_BALANCE>
                    }
                    {
                        for $CURRENT_BALANCE in $saldosTCItem/CURRENT_BALANCE
                        return
                            <ns1:CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</ns1:CURRENT_BALANCE>
                    }
                    {
                        for $PURCHASES_LIMIT in $saldosTCItem/PURCHASES_LIMIT
                        return
                            <ns1:PURCHASES_LIMIT>{ data($PURCHASES_LIMIT) }</ns1:PURCHASES_LIMIT>
                    }
                    {
                        for $WITHDRAWAL_LIMIT in $saldosTCItem/WITHDRAWAL_LIMIT
                        return
                            <ns1:WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</ns1:WITHDRAWAL_LIMIT>
                    }
                    {
                        for $PAYMENTS_TODAY in $saldosTCItem/PAYMENTS_TODAY
                        return
                            <ns1:PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</ns1:PAYMENTS_TODAY>
                    }
                    {
                        for $AVAILABLE_EXTRA in $saldosTCItem/AVAILABLE_EXTRA
                        return
                            <ns1:AVAILABLE_EXTRA>{ data($AVAILABLE_EXTRA) }</ns1:AVAILABLE_EXTRA>
                    }
                    {
                        for $CURRENT_BALANCE_EXTRA in $saldosTCItem/CURRENT_BALANCE_EXTRA
                        return
                            <ns1:CURRENT_BALANCE_EXTRA>{ data($CURRENT_BALANCE_EXTRA) }</ns1:CURRENT_BALANCE_EXTRA>
                    }
                    {
                        for $AVAILABLE_INTRA in $saldosTCItem/AVAILABLE_INTRA
                        return
                            <ns1:AVAILABLE_INTRA>{ data($AVAILABLE_INTRA) }</ns1:AVAILABLE_INTRA>
                    }
                    {
                        for $CURRENT_BALANCE_INTRA in $saldosTCItem/CURRENT_BALANCE_INTRA
                        return
                            <ns1:CURRENT_BALANCE_INTRA>{ data($CURRENT_BALANCE_INTRA) }</ns1:CURRENT_BALANCE_INTRA>
                    }
                    </ns1:PT_SALDOS_TARJETA_ITEM>            		
            	)
            }
            </ns1:PT_SALDOS_TARJETA>
             <ns1:PV_COUNTRY_CODE>{ $countryCode }</ns1:PV_COUNTRY_CODE>
        </ns1:InputParameters>
};

declare variable $sjConsultaSaldosTarjetaCreditoResponse as element(ns0:sjConsultaSaldosTarjetaCreditoResponse) external;
declare variable $valSaldoActual as xs:string? external;
declare variable $countryCode as xs:string external;

xf:registraSaldosTCIn($sjConsultaSaldosTarjetaCreditoResponse, $valSaldoActual, $countryCode)