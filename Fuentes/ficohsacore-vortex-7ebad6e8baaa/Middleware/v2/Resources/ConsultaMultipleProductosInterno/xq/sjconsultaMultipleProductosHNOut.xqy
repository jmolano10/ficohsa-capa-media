xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosHNResponse" element="ns1:sjConsultaMultipleProductosHNResponse" location="../../../BusinessServices/SJS/consultaMultipleProductosHN/xsd/sjConsultaMultipleProductosHN.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMultipleProductosInternoResponse" location="../xsd/consultaMultipleProductosInternoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMultipleProductosInternoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleProductosInterno/xq/consultaMultipleProductosHNOut/";

declare function xf:consultaMultipleProductosHNOut($sjConsultaMultipleProductosHNResponse as element(ns1:sjConsultaMultipleProductosHNResponse))
    as element(ns0:consultaMultipleProductosInternoResponse) {
        <ns0:consultaMultipleProductosInternoResponse>
            {
                for $ASSETS in $sjConsultaMultipleProductosHNResponse/ns1:ASSETS
                return
                    <ASSETS>
                        {
                            for $ASSET in $ASSETS/ns1:ASSET
                            return
                                <ASSET>
                                    {
                                        for $ID in $ASSET/ns1:ID
                                        return
                                            <ID>{ data($ID) }</ID>
                                    }
                                    {
                                        for $PRODUCT_NAME in $ASSET/ns1:PRODUCT_NAME
                                        return
                                            <PRODUCT_NAME>{ data($PRODUCT_NAME) }</PRODUCT_NAME>
                                    }
                                    {
                                        for $CURRENCY in $ASSET/ns1:CURRENCY
                                        return
                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                    }
                                    {
                                        for $RESERVE_BALANCE in $ASSET/ns1:RESERVE_BALANCE
                                        return
                                            <RESERVE_BALANCE>{ data($RESERVE_BALANCE) }</RESERVE_BALANCE>
                                    }
                                    {
                                        for $LOCKED_BALANCE in $ASSET/ns1:LOCKED_BALANCE
                                        return
                                            <LOCKED_BALANCE>{ data($LOCKED_BALANCE) }</LOCKED_BALANCE>
                                    }
                                    {
                                        for $VISA_FLOATING_BALANCE in $ASSET/ns1:VISA_FLOATING_BALANCE
                                        return
                                            <VISA_FLOATING_BALANCE>{ data($VISA_FLOATING_BALANCE) }</VISA_FLOATING_BALANCE>
                                    }
                                    <CASH_ADVANCE_LIMIT>{ data($ASSET/ns1:CASH_ADVANCE_LIMIT) }</CASH_ADVANCE_LIMIT>
                                    <CASH_ADVANCE_AVAILABLE>{ data($ASSET/ns1:CASH_ADVANCE_AVAILABLE) }</CASH_ADVANCE_AVAILABLE>
                                    {
                                        for $INTEREST_BALANCE in $ASSET/ns1:INTEREST_BALANCE
                                        return
                                            <INTEREST_BALANCE>{ data($INTEREST_BALANCE) }</INTEREST_BALANCE>
                                    }
                                    {
                                        for $TOTAL_BALANCE in $ASSET/ns1:TOTAL_BALANCE
                                        return
                                            <TOTAL_BALANCE>{ data($TOTAL_BALANCE) }</TOTAL_BALANCE>
                                    }
                                    {
                                        for $AVAILABLE_BALANCE in $ASSET/ns1:AVAILABLE_BALANCE
                                        return
                                            <AVAILABLE_BALANCE>{ data($AVAILABLE_BALANCE) }</AVAILABLE_BALANCE>
                                    }
                                    {
                                        for $OPENING_DATE in $ASSET/ns1:OPENING_DATE
                                        return
                                            <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                                    }
                                    <TYPE>{ data($ASSET/ns1:TYPE) }</TYPE>
                                    <SOURCE_BANK>{ data($ASSET/ns1:SOURCE_BANK) }</SOURCE_BANK>
                                    <SUCCESS_INDICATOR>{ data($ASSET/ns1:SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                                    {
                                        for $ERROR_MESSAGE in $ASSET/ns1:ERROR_MESSAGE
                                        return
                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                    }
                                </ASSET>
                        }
                    </ASSETS>
            }
            {
                for $LIABILITIES in $sjConsultaMultipleProductosHNResponse/ns1:LIABILITIES
                return
                    <LIABILITIES>
                        {
                            for $LIABILITY in $LIABILITIES/ns1:LIABILITY
                            return
                                <LIABILITY>
                                    {
                                        for $ID in $LIABILITY/ns1:ID
                                        return
                                            <ID>{ data($ID) }</ID>
                                    }
                                    {
                                        for $PRODUCT_NAME in $LIABILITY/ns1:PRODUCT_NAME
                                        return
                                            <PRODUCT_NAME>{ data($PRODUCT_NAME) }</PRODUCT_NAME>
                                    }
                                    {
                                        for $BALANCES in $LIABILITY/ns1:BALANCES
                                        return
                                            <BALANCES>
                                                {
                                                    for $BALANCE in $BALANCES/ns1:BALANCE
                                                    return
                                                        <BALANCE>
                                                            {
                                                                for $CURRENCY in $BALANCE/ns1:CURRENCY
                                                                return
                                                                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                                            }
                                                            {
                                                                for $PRINCIPAL in $BALANCE/ns1:PRINCIPAL
                                                                return
                                                                    <PRINCIPAL>{ data($PRINCIPAL) }</PRINCIPAL>
                                                            }
                                                            {
                                                                for $INT_COMM in $BALANCE/ns1:INT_COMM
                                                                return
                                                                    <INT_COMM>{ data($INT_COMM) }</INT_COMM>
                                                            }
                                                            {
                                                                for $TOTAL in $BALANCE/ns1:TOTAL
                                                                return
                                                                    <TOTAL>{ data($TOTAL) }</TOTAL>
                                                            }
                                                            {
                                                                for $WITHDRAWAL_LIMIT in $BALANCE/ns1:WITHDRAWAL_LIMIT
                                                                return
                                                                    <WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
                                                            }
                                                        </BALANCE>
                                                }
                                            </BALANCES>
                                    }
                                    {
                                        for $NEXT_PAYMENT_DATE in $LIABILITY/ns1:NEXT_PAYMENT_DATE
                                        return
                                            <NEXT_PAYMENT_DATE>{ data($NEXT_PAYMENT_DATE) }</NEXT_PAYMENT_DATE>
                                    }
                                    {
                                        for $TSTANDING_TOTAL in $LIABILITY/ns1:TSTANDING_TOTAL
                                        return
                                            <TSTANDING_TOTAL>{ data($TSTANDING_TOTAL) }</TSTANDING_TOTAL>
                                    }
                                    {
                                        for $CANCELATION_TOTAL in $LIABILITY/ns1:CANCELATION_TOTAL
                                        return
                                            <CANCELATION_TOTAL>{ data($CANCELATION_TOTAL) }</CANCELATION_TOTAL>
                                    }
                                    {
                                        for $TOTAL_AMOUNT in $LIABILITY/ns1:TOTAL_AMOUNT
                                        return
                                            <TOTAL_AMOUNT>{ data($TOTAL_AMOUNT) }</TOTAL_AMOUNT>
                                    }
                                    <TYPE>{ data($LIABILITY/ns1:TYPE) }</TYPE>
                                    {
                                        for $OPENING_DATE in $LIABILITY/ns1:OPENING_DATE
                                        return
                                            <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                                    }
                                    <SOURCE_BANK>{ data($LIABILITY/ns1:SOURCE_BANK) }</SOURCE_BANK>
                                    <SUCCESS_INDICATOR>{ data($LIABILITY/ns1:SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                                    {
                                        for $ERROR_MESSAGE in $LIABILITY/ns1:ERROR_MESSAGE
                                        return
                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                    }
                                </LIABILITY>
                        }
                    </LIABILITIES>
            }
        </ns0:consultaMultipleProductosInternoResponse>
};

declare variable $sjConsultaMultipleProductosHNResponse as element(ns1:sjConsultaMultipleProductosHNResponse) external;

xf:consultaMultipleProductosHNOut($sjConsultaMultipleProductosHNResponse)