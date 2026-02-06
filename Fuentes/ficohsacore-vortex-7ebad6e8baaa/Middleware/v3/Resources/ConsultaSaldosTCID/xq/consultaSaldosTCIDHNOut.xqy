xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse" element="ns0:consultaSaldosTarjetaCreditoResponse" location="../../../../v2/Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldosTarjetaCreditoResponse" location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaSaldosTCID/xq/consultaSaldosTCIDHNOut/";

declare function xf:consultaSaldosTCIDHNOut($consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse))
    as element(ns1:consultaSaldosTarjetaCreditoResponse) {
        <ns1:consultaSaldosTarjetaCreditoResponse>
            {
                for $CARD_NUMBER in $consultaSaldosTarjetaCreditoResponse/CARD_NUMBER
                return
                    <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>
            }
            {
                for $CARD_HOLDER_NAME in $consultaSaldosTarjetaCreditoResponse/CARD_HOLDER_NAME
                return
                    <CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
            }
            {
                for $LCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponse/LCY_MIN_PAYMENT
                return
                    <LCY_MIN_PAYMENT>{ data($LCY_MIN_PAYMENT) }</LCY_MIN_PAYMENT>
            }
            {
                for $LCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponse/LCY_TOTAL_PAYMENT
                return
                    <LCY_TOTAL_PAYMENT>{ data($LCY_TOTAL_PAYMENT) }</LCY_TOTAL_PAYMENT>
            }
            {
                for $FCY_MIN_PAYMENT in $consultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT
                return
                    <FCY_MIN_PAYMENT>{ data($FCY_MIN_PAYMENT) }</FCY_MIN_PAYMENT>
            }
            {
                for $FCY_TOTAL_PAYMENT in $consultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT
                return
                    <FCY_TOTAL_PAYMENT>{ data($FCY_TOTAL_PAYMENT) }</FCY_TOTAL_PAYMENT>
            }
            {
                for $CREDIT_LIMIT in $consultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT
                return
                    <CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</CREDIT_LIMIT>
            }
            {
                for $CREDIT_LIMIT_CCY in $consultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY
                return
                    <CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</CREDIT_LIMIT_CCY>
            }
            {
                for $POINTS_EARNED in $consultaSaldosTarjetaCreditoResponse/POINTS_EARNED
                return
                    <POINTS_EARNED>{ data($POINTS_EARNED) }</POINTS_EARNED>
            }
            {
                for $MAX_PAYMENT_DATE in $consultaSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE
                return
                    <MAX_PAYMENT_DATE>{ data($MAX_PAYMENT_DATE) }</MAX_PAYMENT_DATE>
            }
            {
                for $LAST_CUTOFF_DATE in $consultaSaldosTarjetaCreditoResponse/LAST_CUTOFF_DATE
                return
                    <LAST_CUTOFF_DATE>{ data($LAST_CUTOFF_DATE) }</LAST_CUTOFF_DATE>
            }
            {
                for $consultaSaldosTarjetaCreditoResponseType in $consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType
                return
                    <ns1:consultaSaldosTarjetaCreditoIDResponseType>
                        {
                            for $consultaSaldosTarjetaCreditoResponseRecordType in $consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType
                            return(
                                <ns1:consultaSaldosTarjetaCreditoResponseRecordType>
                                    {
                                        for $CURRENCY in $consultaSaldosTarjetaCreditoResponseRecordType/CURRENCY
                                        return
                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                    }
                                    {
                                        for $OVERDUE_BALANCE in $consultaSaldosTarjetaCreditoResponseRecordType/OVERDUE_BALANCE
                                        return
                                            <OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</OVERDUE_BALANCE>
                                    }
                                    {
                                        for $FLOATING_BALANCE in $consultaSaldosTarjetaCreditoResponseRecordType/FLOATING_BALANCE
                                        return
                                            <FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</FLOATING_BALANCE>
                                    }
                                    {
                                        for $CURRENT_BALANCE in $consultaSaldosTarjetaCreditoResponseRecordType/CURRENT_BALANCE
                                        return
                                            <CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>
                                    }
                                    {
                                        for $PURCHASES_LIMIT in $consultaSaldosTarjetaCreditoResponseRecordType/PURCHASES_LIMIT
                                        return
                                            <PURCHASES_LIMIT>{ data($PURCHASES_LIMIT) }</PURCHASES_LIMIT>
                                    }
                                    {
                                        for $WITHDRAWAL_LIMIT in $consultaSaldosTarjetaCreditoResponseRecordType/WITHDRAWAL_LIMIT
                                        return
                                            <WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
                                    }
                                    {
                                        for $PAYMENTS_TODAY in $consultaSaldosTarjetaCreditoResponseRecordType/PAYMENTS_TODAY
                                        return
                                            <PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</PAYMENTS_TODAY>
                                    }
                                    {
                                        for $AVAILABLE_EXTRA in $consultaSaldosTarjetaCreditoResponseRecordType/AVAILABLE_EXTRA
                                        return
                                            <AVAILABLE_EXTRA>{ data($AVAILABLE_EXTRA) }</AVAILABLE_EXTRA>
                                    }
                                    {
                                        for $CURRENT_BALANCE_EXTRA in $consultaSaldosTarjetaCreditoResponseRecordType/CURRENT_BALANCE_EXTRA
                                        return
                                            <CURRENT_BALANCE_EXTRA>{ data($CURRENT_BALANCE_EXTRA) }</CURRENT_BALANCE_EXTRA>
                                    }
                                    {
                                        for $AVAILABLE_INTRA in $consultaSaldosTarjetaCreditoResponseRecordType/AVAILABLE_INTRA
                                        return
                                            <AVAILABLE_INTRA>{ data($AVAILABLE_INTRA) }</AVAILABLE_INTRA>
                                    }
                                    {
                                        for $CURRENT_BALANCE_INTRA in $consultaSaldosTarjetaCreditoResponseRecordType/CURRENT_BALANCE_INTRA
                                        return
                                            <CURRENT_BALANCE_INTRA>{ data($CURRENT_BALANCE_INTRA) }</CURRENT_BALANCE_INTRA>
                                    }
                                </ns1:consultaSaldosTarjetaCreditoResponseRecordType>
                                )
                        }
                    </ns1:consultaSaldosTarjetaCreditoIDResponseType>
            }
        </ns1:consultaSaldosTarjetaCreditoResponse>
};

declare variable $consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse) external;

xf:consultaSaldosTCIDHNOut($consultaSaldosTarjetaCreditoResponse)