(:: pragma bea:global-element-parameter parameter="$pagoRemesasResponse" element="ns0:pagoRemesasResponse" location="../../PagoRemesa/xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRemesasResponse" location="../xsd/pagoRemesaCB.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasCBTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCB/xq/pagoRemesaCBOut/";

declare function xf:pagoRemesaCBOut($pagoRemesasResponse as element(ns0:pagoRemesasResponse))
    as element(ns1:pagoRemesasResponse) {
        <ns1:pagoRemesasResponse>
            {
                let $REMITTANCE_INFO := $pagoRemesasResponse/REMITTANCE_INFO
                return
                    <REMITTANCE_INFO>
                        {
                            for $COMPANY_NAME in $REMITTANCE_INFO/COMPANY_NAME
                            return
                                <COMPANY_NAME>{ data($COMPANY_NAME) }</COMPANY_NAME>
                        }
                        {
                            for $ID in $REMITTANCE_INFO/ID
                            return
                                <ID>{ data($ID) }</ID>
                        }
                        {
                            for $AMOUNT in $REMITTANCE_INFO/AMOUNT
                            return
                                <AMOUNT>{ data($AMOUNT) }</AMOUNT>
                        }
                        {
                            for $CURRENCY in $REMITTANCE_INFO/CURRENCY
                            return
                                <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                        }
                        {
                            for $VALUE_DATE in $REMITTANCE_INFO/VALUE_DATE
                            return
                                <VALUE_DATE>{ data($VALUE_DATE) }</VALUE_DATE>
                        }
                        {
                            for $ORD_PARTY_NAME in $REMITTANCE_INFO/ORD_PARTY_NAME
                            return
                                <ORD_PARTY_NAME>{ data($ORD_PARTY_NAME) }</ORD_PARTY_NAME>
                        }
                        {
                            for $PRICE in $REMITTANCE_INFO/PRICE
                            return
                                <PRICE>{ data($PRICE) }</PRICE>
                        }
                        {
                            for $COUNTRY_OF_ORIGIN in $REMITTANCE_INFO/COUNTRY_OF_ORIGIN
                            return
                                <COUNTRY_OF_ORIGIN>{ data($COUNTRY_OF_ORIGIN) }</COUNTRY_OF_ORIGIN>
                        }
                    </REMITTANCE_INFO>
            }
            {
                let $BENEFICIARY_INFO := $pagoRemesasResponse/BENEFICIARY_INFO
                return
                    <BENEFICIARY_INFO>
                        {
                            for $NAME in $BENEFICIARY_INFO/NAME
                            return
                                <NAME>{ data($NAME) }</NAME>
                        }
                        {
                            for $ID in $BENEFICIARY_INFO/ID
                            return
                                <ID>{ data($ID) }</ID>
                        }
                        {
                            for $ADDRESS in $BENEFICIARY_INFO/ADDRESS
                            return
                                <ADDRESS>{ data($ADDRESS) }</ADDRESS>
                        }
                        {
                            for $COUNTRY in $BENEFICIARY_INFO/COUNTRY
                            return
                                <COUNTRY>{ data($COUNTRY) }</COUNTRY>
                        }
                        {
                            for $CITY in $BENEFICIARY_INFO/CITY
                            return
                                <CITY>{ data($CITY) }</CITY>
                        }
                        {
                            for $PHONE_NUMBER in $BENEFICIARY_INFO/PHONE_NUMBER
                            return
                                <PHONE_NUMBER>{ data($PHONE_NUMBER) }</PHONE_NUMBER>
                        }
                    </BENEFICIARY_INFO>
            }
            {
                for $INPUTTER in $pagoRemesasResponse/INPUTTER
                return
                    <INPUTTER>{ data($INPUTTER) }</INPUTTER>
            }
            {
                for $DATE_TIME in $pagoRemesasResponse/DATE_TIME
                return
                    <DATE_TIME>{ data($DATE_TIME) }</DATE_TIME>
            }
            {
                for $EXCHANGE_RATE in $pagoRemesasResponse/EXCHANGE_RATE
                return
                    <EXCHANGE_RATE>{ data($EXCHANGE_RATE) }</EXCHANGE_RATE>
            }
        </ns1:pagoRemesasResponse>
};

declare variable $pagoRemesasResponse as element(ns0:pagoRemesasResponse) external;

xf:pagoRemesaCBOut($pagoRemesasResponse)
