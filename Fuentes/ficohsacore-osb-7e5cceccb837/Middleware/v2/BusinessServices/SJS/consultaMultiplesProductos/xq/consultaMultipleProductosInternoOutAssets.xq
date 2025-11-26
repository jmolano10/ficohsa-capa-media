(:: pragma bea:local-element-parameter parameter="$ASSETS" type="ns0:consultaMultipleProductosInternoResponse/ASSETS" location="../../../../Resources/ConsultaMultipleProductosInterno/xsd/consultaMultipleProductosInternoTypes.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaMultipleProductosResponse/ns1:ASSETS" location="../xsd/sjConsultaMultipleProductos.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductos";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMultipleProductosInternoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultiplesProductos/xq/consultaMultipleProductosInternoOutAssets/";

declare function xf:consultaMultipleProductosInternoOutAssets($ASSETS as element())
    as element() {
        <ns1:ASSETS>
            {
                for $ASSET in $ASSETS/ASSET
                return
                    <ns1:ASSET>
                        <ns1:ID>{ data($ASSET/ID) }</ns1:ID>
                        {
                            for $PRODUCT_NAME in $ASSET/PRODUCT_NAME
                            return
                                <ns1:PRODUCT_NAME>{ data($PRODUCT_NAME) }</ns1:PRODUCT_NAME>
                        }
                        {
                            for $CURRENCY in $ASSET/CURRENCY
                            return
                                <ns1:CURRENCY>{ data($CURRENCY) }</ns1:CURRENCY>
                        }
                        {
                            for $RESERVE_BALANCE in $ASSET/RESERVE_BALANCE
                            return
                                <ns1:RESERVE_BALANCE>{ data($RESERVE_BALANCE) }</ns1:RESERVE_BALANCE>
                        }
                        {
                            for $LOCKED_BALANCE in $ASSET/LOCKED_BALANCE
                            return
                                <ns1:LOCKED_BALANCE>{ data($LOCKED_BALANCE) }</ns1:LOCKED_BALANCE>
                        }
                        {
                            for $VISA_FLOATING_BALANCE in $ASSET/VISA_FLOATING_BALANCE
                            return
                                <ns1:VISA_FLOATING_BALANCE>{ data($VISA_FLOATING_BALANCE) }</ns1:VISA_FLOATING_BALANCE>
                        }
                        <ns1:CASH_ADVANCE_LIMIT>{ data($ASSET/CASH_ADVANCE_LIMIT) }</ns1:CASH_ADVANCE_LIMIT>
                        <ns1:CASH_ADVANCE_AVAILABLE>{ data($ASSET/CASH_ADVANCE_AVAILABLE) }</ns1:CASH_ADVANCE_AVAILABLE>
                        {
                            for $INTEREST_BALANCE in $ASSET/INTEREST_BALANCE
                            return
                                <ns1:INTEREST_BALANCE>{ data($INTEREST_BALANCE) }</ns1:INTEREST_BALANCE>
                        }
                        {
                            for $TOTAL_BALANCE in $ASSET/TOTAL_BALANCE
                            return
                                <ns1:TOTAL_BALANCE>{ data($TOTAL_BALANCE) }</ns1:TOTAL_BALANCE>
                        }
                        {
                            for $AVAILABLE_BALANCE in $ASSET/AVAILABLE_BALANCE
                            return
                                <ns1:AVAILABLE_BALANCE>{ data($AVAILABLE_BALANCE) }</ns1:AVAILABLE_BALANCE>
                        }
                        {
                            for $OPENING_DATE in $ASSET/OPENING_DATE
                            return
                                <ns1:OPENING_DATE>{ data($OPENING_DATE) }</ns1:OPENING_DATE>
                        }
                        <ns1:TYPE>{ data($ASSET/TYPE) }</ns1:TYPE>
                        <ns1:SOURCE_BANK>{ data($ASSET/SOURCE_BANK) }</ns1:SOURCE_BANK>
                        <ns1:SUCCESS_INDICATOR>{ data($ASSET/SUCCESS_INDICATOR) }</ns1:SUCCESS_INDICATOR>
                        {
                            for $ERROR_MESSAGE in $ASSET/ERROR_MESSAGE
                            return
                                <ns1:ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ns1:ERROR_MESSAGE>
                        }
                        {
                            for $INTERNATIONAL_ACCOUNT_NUMBER in $ASSET/INTERNATIONAL_ACCOUNT_NUMBER
                            return
                                <ns1:INTERNATIONAL_ACCOUNT_NUMBER>{ data($INTERNATIONAL_ACCOUNT_NUMBER) }</ns1:INTERNATIONAL_ACCOUNT_NUMBER>
                        }
                    </ns1:ASSET>
            }
        </ns1:ASSETS>
};

declare variable $ASSETS as element() external;

xf:consultaMultipleProductosInternoOutAssets($ASSETS)