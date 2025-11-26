(:: pragma bea:global-element-parameter parameter="$consultaTarjetasCreditoPorClienteResponse" element="ns2:consultaTarjetasCreditoPorClienteResponse" location="../../../../Resources/ConsultaTarjetasCreditoPorCliente/xsd/consultaTarjetasCreditoPorClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse" element="ns1:consultaSaldosTarjetaCreditoResponse" location="../../../../Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:local-element-return type="ns0:ConsultaTarjetaCreditoTypeResponse/ns0:CREDIT_CARD_DETAILS/ns0:CREDIT_CARD_DETAIL" location="../../../../../Business_Resources/consultasCliente/consultaPasivosCliente/consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)

declare namespace ns0 = "ConsultaTarjetaCreditoCliente";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaTarjetasCreditoPorClienteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCClienteGT/xq/sjDatosTarjetaOut/";

declare function xf:sjDatosTarjetaOut($cardNumber as xs:string,
    $consultaSaldosTarjetaCreditoResponse as element(ns1:consultaSaldosTarjetaCreditoResponse),
    $successIndicator as xs:string)
    as element() {
        <ns0:CREDIT_CARD_DETAIL>
            <ns0:RESPONSE_HEADER>
                <ns0:SUCCESS_INDICATOR>
                    {
                        if (fn:upper-case($successIndicator) = "SUCCESS") then
                            ("SUCCESS")
                        else 
                            "ERROR"
                    }
				</ns0:SUCCESS_INDICATOR>
            </ns0:RESPONSE_HEADER>           
            <ns0:RESPONSE_BODY>
                 <ns0:CARD_NUMBER>{ $cardNumber }</ns0:CARD_NUMBER>
                {
                    for $CARD_HOLDER_NAME in $consultaSaldosTarjetaCreditoResponse/CARD_HOLDER_NAME
                    return
                        <ns0:CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</ns0:CARD_HOLDER_NAME>
                }
                {
                    for $FCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT
                    return
                        <ns0:FCY_MIN_PAYMENT>{ data($FCY_MIN_PAYMENT) }</ns0:FCY_MIN_PAYMENT>
                }
                {
                    for $FCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT
                    return
                        <ns0:FCY_TOTAL_PAYMENT>{ data($FCY_TOTAL_PAYMENT) }</ns0:FCY_TOTAL_PAYMENT>
                }
                {
                    for $CREDIT_LIMIT in $consultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT
                    return
                        <ns0:CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</ns0:CREDIT_LIMIT>
                }
                {
                    for $CREDIT_LIMIT_CCY in $consultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY
                    return
                        <ns0:CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</ns0:CREDIT_LIMIT_CCY>
                }
                {
                    for $POINTS_EARNED in $consultaSaldosTarjetaCreditoResponse/POINTS_EARNED
                    return
                        <ns0:POINTS_EARNED>{ data($POINTS_EARNED) }</ns0:POINTS_EARNED>
                }
                {
                    for $MAX_PAYMENT_DATE in $consultaSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE
                    return
                        <ns0:MAX_PAYMENT_DATE>{ data($MAX_PAYMENT_DATE) }</ns0:MAX_PAYMENT_DATE>
                }
                {
                    for $LAST_CUTOFF_DATE in $consultaSaldosTarjetaCreditoResponse/LAST_CUTOFF_DATE
                    return
                        <ns0:LAST_CUTOFF_DATE>{ data($LAST_CUTOFF_DATE) }</ns0:LAST_CUTOFF_DATE>
                }
                <ns0:BALANCE_DETAILS>
                {
                	for $balanceDetail at $i in $consultaSaldosTarjetaCreditoResponse/ns1:consultaSaldosTarjetaCreditoResponseType/ns1:consultaSaldosTarjetaCreditoResponseRecordType
                	return(
                    <ns0:BALANCE_DETAIL>
                        {
                            for $CURRENCY in $balanceDetail/CURRENCY
                            return
                                <ns0:CURRENCY>{ data($CURRENCY) }</ns0:CURRENCY>
                        }
                        {
                            for $OVERDUE_BALANCE in $balanceDetail/OVERDUE_BALANCE
                            return
                                <ns0:OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</ns0:OVERDUE_BALANCE>
                        }
                        {
                            for $FLOATING_BALANCE in $balanceDetail/FLOATING_BALANCE
                            return
                                <ns0:FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</ns0:FLOATING_BALANCE>
                        }
                        {
                            for $CURRENT_BALANCE in $balanceDetail/CURRENT_BALANCE
                            return
                                <ns0:CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</ns0:CURRENT_BALANCE>
                        }
                        {
                            for $PURCHASES_LIMIT in $balanceDetail/PURCHASES_LIMIT
                            return
                                <ns0:PURCHASES_LIMIT>{ data($PURCHASES_LIMIT) }</ns0:PURCHASES_LIMIT>
                        }
                        {
                            for $WITHDRAWAL_LIMIT in $balanceDetail/WITHDRAWAL_LIMIT
                            return
                                <ns0:WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</ns0:WITHDRAWAL_LIMIT>
                        }
                        {
                            for $PAYMENTS_TODAY in $balanceDetail/PAYMENTS_TODAY
                            return
                                <ns0:PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</ns0:PAYMENTS_TODAY>
                        }
                    </ns0:BALANCE_DETAIL>
                    )}
                </ns0:BALANCE_DETAILS>
            </ns0:RESPONSE_BODY>
        </ns0:CREDIT_CARD_DETAIL>
};

declare variable $cardNumber as xs:string external;
declare variable $consultaSaldosTarjetaCreditoResponse as element(ns1:consultaSaldosTarjetaCreditoResponse) external;
declare variable $successIndicator as xs:string external;

xf:sjDatosTarjetaOut($cardNumber,
    $consultaSaldosTarjetaCreditoResponse,
    $successIndicator)