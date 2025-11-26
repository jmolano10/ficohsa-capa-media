(:: pragma bea:local-element-parameter parameter="$LIABILITIES" type="ns0:consultaMultipleProductosInternoResponse/LIABILITIES" location="../../../../Resources/ConsultaMultipleProductosInterno/xsd/consultaMultipleProductosInternoTypes.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaMultipleProductosResponse/ns1:LIABILITIES" location="../xsd/sjConsultaMultipleProductos.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMultipleProductosInternoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductos";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultiplesProductos/xq/consultaMultipleProductosInternoOutLiabilities/";

declare function xf:consultaMultipleProductosInternoOutLiabilities($LIABILITIES as element())
    as element() {
        <ns1:LIABILITIES>
            {
                for $LIABILITY in $LIABILITIES/LIABILITY
                return
                    <ns1:LIABILITY>
                        <ns1:ID>{ data($LIABILITY/ID) }</ns1:ID>
                        {
                            for $PRODUCT_NAME in $LIABILITY/PRODUCT_NAME
                            return
                                <ns1:PRODUCT_NAME>{ data($PRODUCT_NAME) }</ns1:PRODUCT_NAME>
                        }
                        {
                            for $BALANCES in $LIABILITY/BALANCES
                            return
                                <ns1:BALANCES>
                                    {
                                        for $BALANCE in $BALANCES/BALANCE
                                        return
                                            <ns1:BALANCE>
                                                {
                                                    for $CURRENCY in $BALANCE/CURRENCY
                                                    return
                                                        <ns1:CURRENCY>{ data($CURRENCY) }</ns1:CURRENCY>
                                                }
                                                {
                                                    for $PRINCIPAL in $BALANCE/PRINCIPAL
                                                    return
                                                        <ns1:PRINCIPAL>{ data($PRINCIPAL) }</ns1:PRINCIPAL>
                                                }
                                                {
                                                    for $INT_COMM in $BALANCE/INT_COMM
                                                    return
                                                        <ns1:INT_COMM>{ data($INT_COMM) }</ns1:INT_COMM>
                                                }
                                                {
                                                    for $TOTAL in $BALANCE/TOTAL
                                                    return
                                                        <ns1:TOTAL>{ data($TOTAL) }</ns1:TOTAL>
                                                }
                                                {
                                                    for $WITHDRAWAL_LIMIT in $BALANCE/WITHDRAWAL_LIMIT
                                                    return
                                                        <ns1:WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</ns1:WITHDRAWAL_LIMIT>
                                                }
                                            </ns1:BALANCE>
                                    }
                                </ns1:BALANCES>
                        }
                        {
                            for $NEXT_PAYMENT_DATE in $LIABILITY/NEXT_PAYMENT_DATE
                            return
                                <ns1:NEXT_PAYMENT_DATE>{ data($NEXT_PAYMENT_DATE) }</ns1:NEXT_PAYMENT_DATE>
                        }
                        {
                            for $TSTANDING_TOTAL in $LIABILITY/TSTANDING_TOTAL
                            return
                                <ns1:TSTANDING_TOTAL>{ data($TSTANDING_TOTAL) }</ns1:TSTANDING_TOTAL>
                        }
                        {
                            for $CANCELATION_TOTAL in $LIABILITY/CANCELATION_TOTAL
                            return
                                <ns1:CANCELATION_TOTAL>{ data($CANCELATION_TOTAL) }</ns1:CANCELATION_TOTAL>
                        }
                        {
                            for $TOTAL_AMOUNT in $LIABILITY/TOTAL_AMOUNT
                            return
                                <ns1:TOTAL_AMOUNT>{ data($TOTAL_AMOUNT) }</ns1:TOTAL_AMOUNT>
                        }
                        <ns1:TYPE>{ data($LIABILITY/TYPE) }</ns1:TYPE>
                        {
                            for $OPENING_DATE in $LIABILITY/OPENING_DATE
                            return
                                <ns1:OPENING_DATE>{ data($OPENING_DATE) }</ns1:OPENING_DATE>
                        }
                        <ns1:SOURCE_BANK>{ data($LIABILITY/SOURCE_BANK) }</ns1:SOURCE_BANK>
                        <ns1:SUCCESS_INDICATOR>{ data($LIABILITY/SUCCESS_INDICATOR) }</ns1:SUCCESS_INDICATOR>
                        {
                            for $ERROR_MESSAGE in $LIABILITY/ERROR_MESSAGE
                            return
                                <ns1:ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ns1:ERROR_MESSAGE>
                        }
                    </ns1:LIABILITY>
            }
        </ns1:LIABILITIES>
};

declare variable $LIABILITIES as element() external;

xf:consultaMultipleProductosInternoOutLiabilities($LIABILITIES)