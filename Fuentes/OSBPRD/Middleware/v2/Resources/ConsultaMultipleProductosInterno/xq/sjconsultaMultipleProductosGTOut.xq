(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosGTResponse" element="ns0:sjConsultaMultipleProductosGTResponse" location="../../../BusinessServices/SJS/consultaMultipleProductosGT/xsd/sjConsultaMultipleProductosGT.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMultipleProductosInternoResponse" location="../xsd/consultaMultipleProductosInternoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosGT";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMultipleProductosInternoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleProductosInterno/xq/sjconsultaMultipleProductosGTOut/";

declare function xf:sjconsultaMultipleProductosGTOut($sjConsultaMultipleProductosGTResponse as element(ns0:sjConsultaMultipleProductosGTResponse))
    as element(ns1:consultaMultipleProductosInternoResponse) {
        <ns1:consultaMultipleProductosInternoResponse>
            {
                for $ASSETS in $sjConsultaMultipleProductosGTResponse/ns0:ASSETS
                return
                    <ASSETS>
                        {
                            for $ASSET in $ASSETS/ns0:ASSET
                            return
                                <ASSET>
                                    {
                                        for $ID in $ASSET/ns0:ID
                                        return
                                            <ID>{ data($ID) }</ID>
                                    }
                                    {
                                        for $PRODUCT_NAME in $ASSET/ns0:PRODUCT_NAME
                                        return
                                            <PRODUCT_NAME>{ data($PRODUCT_NAME) }</PRODUCT_NAME>
                                    }
                                    {
                                        for $CURRENCY in $ASSET/ns0:CURRENCY
                                        return
                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                    }
                                    {
                                        for $RESERVE_BALANCE in $ASSET/ns0:RESERVE_BALANCE
                                        return
                                            <RESERVE_BALANCE>{ data($RESERVE_BALANCE) }</RESERVE_BALANCE>
                                    }
                                    {
                                        for $LOCKED_BALANCE in $ASSET/ns0:LOCKED_BALANCE
                                        return
                                            <LOCKED_BALANCE>{ data($LOCKED_BALANCE) }</LOCKED_BALANCE>
                                    }
                                    {
                                        for $VISA_FLOATING_BALANCE in $ASSET/ns0:VISA_FLOATING_BALANCE
                                        return
                                            <VISA_FLOATING_BALANCE>{ data($VISA_FLOATING_BALANCE) }</VISA_FLOATING_BALANCE>
                                    }
                                    {
                                        for $INTEREST_BALANCE in $ASSET/ns0:INTEREST_BALANCE
                                        return
                                            <INTEREST_BALANCE>{ data($INTEREST_BALANCE) }</INTEREST_BALANCE>
                                    }
                                    {
                                        for $TOTAL_BALANCE in $ASSET/ns0:TOTAL_BALANCE
                                        return
                                            <TOTAL_BALANCE>{ data($TOTAL_BALANCE) }</TOTAL_BALANCE>
                                    }
                                    {
                                        for $AVAILABLE_BALANCE in $ASSET/ns0:AVAILABLE_BALANCE
                                        return
                                            <AVAILABLE_BALANCE>{ data($AVAILABLE_BALANCE) }</AVAILABLE_BALANCE>
                                    }
                                    {
                                        for $OPENING_DATE in $ASSET/ns0:OPENING_DATE
                                        return
                                            <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                                    }
                                    <TYPE>{ data($ASSET/ns0:TYPE) }</TYPE>
                                    <SOURCE_BANK>{ data($ASSET/ns0:SOURCE_BANK) }</SOURCE_BANK>
                                    <SUCCESS_INDICATOR>{ data($ASSET/ns0:SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                                    {
                                        for $ERROR_MESSAGE in $ASSET/ns0:ERROR_MESSAGE
                                        return
                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                    }
                                </ASSET>
                        }
                    </ASSETS>
            }
            {
                for $LIABILITIES in $sjConsultaMultipleProductosGTResponse/ns0:LIABILITIES
                return
                    <LIABILITIES>
                        {
                            for $LIABILITY in $LIABILITIES/ns0:LIABILITY
                            return
                                <LIABILITY>
                                    {
                                        for $ID in $LIABILITY/ns0:ID
                                        return
                                            <ID>{ data($ID) }</ID>
                                    }
                                    {
                                        for $PRODUCT_NAME in $LIABILITY/ns0:PRODUCT_NAME
                                        return
                                            <PRODUCT_NAME>{ data($PRODUCT_NAME) }</PRODUCT_NAME>
                                    }
                                    {
                                        for $BALANCES in $LIABILITY/ns0:BALANCES
                                        return
                                            <BALANCES>
                                                {
                                                    for $BALANCE in $BALANCES/ns0:BALANCE
                                                    return
                                                        <BALANCE>
                                                            {
                                                                for $CURRENCY in $BALANCE/ns0:CURRENCY
                                                                return
                                                                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                                            }
                                                            {
                                                                for $PRINCIPAL in $BALANCE/ns0:PRINCIPAL
                                                                return
                                                                    <PRINCIPAL>{ data($PRINCIPAL) }</PRINCIPAL>
                                                            }
                                                            {
                                                                for $INT_COMM in $BALANCE/ns0:INT_COMM
                                                                return
                                                                    <INT_COMM>{ data($INT_COMM) }</INT_COMM>
                                                            }
                                                            {
                                                                for $TOTAL in $BALANCE/ns0:TOTAL
                                                                return
                                                                    <TOTAL>{ data($TOTAL) }</TOTAL>
                                                            }
                                                            {
                                                                for $WITHDRAWAL_LIMIT in $BALANCE/ns0:WITHDRAWAL_LIMIT
                                                                return
                                                                    <WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
                                                            }
                                                        </BALANCE>
                                                }
                                            </BALANCES>
                                    }
                                    {
                                        for $NEXT_PAYMENT_DATE in $LIABILITY/ns0:NEXT_PAYMENT_DATE
                                        return
                                            <NEXT_PAYMENT_DATE>{ data($NEXT_PAYMENT_DATE) }</NEXT_PAYMENT_DATE>
                                    }
                                    {
                                        for $TSTANDING_TOTAL in $LIABILITY/ns0:TSTANDING_TOTAL
                                        return
                                            <TSTANDING_TOTAL>{ data($TSTANDING_TOTAL) }</TSTANDING_TOTAL>
                                    }
                                    {
                                        for $CANCELATION_TOTAL in $LIABILITY/ns0:CANCELATION_TOTAL
                                        return
                                            <CANCELATION_TOTAL>{ data($CANCELATION_TOTAL) }</CANCELATION_TOTAL>
                                    }
                                    {
                                        for $TOTAL_AMOUNT in $LIABILITY/ns0:TOTAL_AMOUNT
                                        return
                                            <TOTAL_AMOUNT>{ data($TOTAL_AMOUNT) }</TOTAL_AMOUNT>
                                    }
                                    <TYPE>{ data($LIABILITY/ns0:TYPE) }</TYPE>
                                    {
                                        for $OPENING_DATE in $LIABILITY/ns0:OPENING_DATE
                                        return
                                            <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                                    }
                                    <SOURCE_BANK>{ data($LIABILITY/ns0:SOURCE_BANK) }</SOURCE_BANK>
                                    <SUCCESS_INDICATOR>{ data($LIABILITY/ns0:SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                                    {
                                        for $ERROR_MESSAGE in $LIABILITY/ns0:ERROR_MESSAGE
                                        return
                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                    }
                                </LIABILITY>
                        }
                    </LIABILITIES>
            }
        </ns1:consultaMultipleProductosInternoResponse>
};

declare variable $sjConsultaMultipleProductosGTResponse as element(ns0:sjConsultaMultipleProductosGTResponse) external;

xf:sjconsultaMultipleProductosGTOut($sjConsultaMultipleProductosGTResponse)