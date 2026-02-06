xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse1" element="ns0:consultaSaldosTarjetaCreditoResponse" location="../../../tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$mFICOLISTCLIENTCARDCPDetailType1" type="ns1:TarjetasdecreditoporclienteResponse/FICOLISTCLIENTCARDCPType/gFICOLISTCLIENTCARDCPDetailType/mFICOLISTCLIENTCARDCPDetailType" location="../../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:local-element-return type="ns2:ConsultaTarjetaCreditoTypeResponse/ns2:CREDIT_CARD_DETAILS/ns2:CREDIT_CARD_DETAIL" location="ConsultaTarjetaCreditoCliente.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns2 = "ConsultaTarjetaCreditoCliente";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaTC/consultaSaldosTCClienteOut2/";

declare function xf:consultaSaldosTCClienteOut2($consultaSaldosTarjetaCreditoResponse1 as element(ns0:consultaSaldosTarjetaCreditoResponse),
    $mFICOLISTCLIENTCARDCPDetailType1 as element(),
    $successIndicator as xs:string)
    as element() {
        <ns2:CREDIT_CARD_DETAIL>
            <ns2:RESPONSE_HEADER>
                <ns2:SUCCESS_INDICATOR>{ $successIndicator }</ns2:SUCCESS_INDICATOR>
            </ns2:RESPONSE_HEADER>
            <ns2:RESPONSE_BODY>
                {
                    for $CARDNO in $mFICOLISTCLIENTCARDCPDetailType1/CARDNO
                    return
                        <ns2:CARD_NUMBER>{ data($CARDNO) }</ns2:CARD_NUMBER>
                }
                {
                    for $CARDNAME in $consultaSaldosTarjetaCreditoResponse1/CARD_HOLDER_NAME
                    return
                        <ns2:CARD_HOLDER_NAME>{ data($CARDNAME) }</ns2:CARD_HOLDER_NAME>
                }
                {
                    for $STATUS in $mFICOLISTCLIENTCARDCPDetailType1/STATUS
                    return
                        <ns2:STATUS>{ data($STATUS) }</ns2:STATUS>
                }
                {
                    for $CATEGORY in $mFICOLISTCLIENTCARDCPDetailType1/CATEGORY
                    return
                        <ns2:CATEGORY>{ data($CATEGORY) }</ns2:CATEGORY>
                }
                {
                    for $LCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponse1/LCY_MIN_PAYMENT
                    return
                        <ns2:LCY_MIN_PAYMENT>{ data($LCY_MIN_PAYMENT) }</ns2:LCY_MIN_PAYMENT>
                }
                {
                    for $LCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponse1/LCY_TOTAL_PAYMENT
                    return
                        <ns2:LCY_TOTAL_PAYMENT>{ data($LCY_TOTAL_PAYMENT) }</ns2:LCY_TOTAL_PAYMENT>
                }
                {
                    for $FCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponse1/FCY_MIN_PAYMENT
                    return
                        <ns2:FCY_MIN_PAYMENT>{ data($FCY_MIN_PAYMENT) }</ns2:FCY_MIN_PAYMENT>
                }
                {
                    for $FCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponse1/FCY_TOTAL_PAYMENT
                    return
                        <ns2:FCY_TOTAL_PAYMENT>{ data($FCY_TOTAL_PAYMENT) }</ns2:FCY_TOTAL_PAYMENT>
                }
                {
                    for $CREDIT_LIMIT in $consultaSaldosTarjetaCreditoResponse1/CREDIT_LIMIT
                    return
                        <ns2:CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</ns2:CREDIT_LIMIT>
                }
                {
                    for $CREDIT_LIMIT_CCY in $consultaSaldosTarjetaCreditoResponse1/CREDIT_LIMIT_CCY
                    return
                        <ns2:CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</ns2:CREDIT_LIMIT_CCY>
                }
                {
                    for $POINTS_EARNED in $consultaSaldosTarjetaCreditoResponse1/POINTS_EARNED
                    return
                        <ns2:POINTS_EARNED>{ data($POINTS_EARNED) }</ns2:POINTS_EARNED>
                }
                {
                    for $MAX_PAYMENT_DATE in $consultaSaldosTarjetaCreditoResponse1/MAX_PAYMENT_DATE
                    return
                        <ns2:MAX_PAYMENT_DATE>{ data($MAX_PAYMENT_DATE) }</ns2:MAX_PAYMENT_DATE>
                }
                {
                    for $LAST_CUTOFF_DATE in $consultaSaldosTarjetaCreditoResponse1/LAST_CUTOFF_DATE
                    return
                        <ns2:LAST_CUTOFF_DATE>{ data($LAST_CUTOFF_DATE) }</ns2:LAST_CUTOFF_DATE>
                }
                {
                    for $consultaSaldosTarjetaCreditoResponseType in $consultaSaldosTarjetaCreditoResponse1/ns0:consultaSaldosTarjetaCreditoResponseType
                    return
                        <ns2:BALANCE_DETAILS>
                            {
                                for $consultaSaldosTarjetaCreditoResponseRecordType in $consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType
                                return
                                    <ns2:BALANCE_DETAIL>
                                        {
                                            for $CURRENCY in $consultaSaldosTarjetaCreditoResponseRecordType/CURRENCY
                                            return
                                                <ns2:CURRENCY>{ data($CURRENCY) }</ns2:CURRENCY>
                                        }
                                        {
                                            for $OVERDUE_BALANCE in $consultaSaldosTarjetaCreditoResponseRecordType/OVERDUE_BALANCE
                                            return
                                                <ns2:OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</ns2:OVERDUE_BALANCE>
                                        }
                                        {
                                            for $FLOATING_BALANCE in $consultaSaldosTarjetaCreditoResponseRecordType/FLOATING_BALANCE
                                            return
                                                <ns2:FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</ns2:FLOATING_BALANCE>
                                        }
                                        {
                                            for $CURRENT_BALANCE in $consultaSaldosTarjetaCreditoResponseRecordType/CURRENT_BALANCE
                                            return
                                                <ns2:CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</ns2:CURRENT_BALANCE>
                                        }
                                        {
                                            for $PURCHASES_LIMIT in $consultaSaldosTarjetaCreditoResponseRecordType/PURCHASES_LIMIT
                                            return
                                                <ns2:PURCHASES_LIMIT>{ data($PURCHASES_LIMIT) }</ns2:PURCHASES_LIMIT>
                                        }
                                        {
                                            for $WITHDRAWAL_LIMIT in $consultaSaldosTarjetaCreditoResponseRecordType/WITHDRAWAL_LIMIT
                                            return
                                                <ns2:WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</ns2:WITHDRAWAL_LIMIT>
                                        }
                                        {
                                            for $PAYMENTS_TODAY in $consultaSaldosTarjetaCreditoResponseRecordType/PAYMENTS_TODAY
                                            return
                                                <ns2:PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</ns2:PAYMENTS_TODAY>
                                        }
                                    </ns2:BALANCE_DETAIL>
                            }
                        </ns2:BALANCE_DETAILS>
                }
            </ns2:RESPONSE_BODY>
        </ns2:CREDIT_CARD_DETAIL>
};

declare variable $consultaSaldosTarjetaCreditoResponse1 as element(ns0:consultaSaldosTarjetaCreditoResponse) external;
declare variable $mFICOLISTCLIENTCARDCPDetailType1 as element() external;
declare variable $successIndicator as xs:string external;

xf:consultaSaldosTCClienteOut2($consultaSaldosTarjetaCreditoResponse1,
    $mFICOLISTCLIENTCARDCPDetailType1,
    $successIndicator)