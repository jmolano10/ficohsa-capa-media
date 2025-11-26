(:: pragma bea:global-element-parameter parameter="$createCustomerProfile" element="ns2:createCustomerProfile" location="../../xsd/MoneyTransferOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../BusinessServices/AbanksGT/CreacionCliente/xsd/CreacionCliente_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/moneyTransferOperationsTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreacionCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/MoneyTransferOperations/CreateCustomerProfile/xq/creacionClienteGTIn/";

declare function xf:creacionClienteGTIn($createCustomerProfile as element(ns2:createCustomerProfile))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                let $ID_CUSTOMER := $createCustomerProfile/ns2:ID_CUSTOMER
                return
                    <ns1:PR_ID_CUSTOMER>
                        <ns1:ID_TYPE>{ data($ID_CUSTOMER/ns2:ID_TYPE) }</ns1:ID_TYPE>
                        <ns1:ID>{ data($ID_CUSTOMER/ns2:ID) }</ns1:ID>
                        {
                            let $COUNTRY_ISSUE := $ID_CUSTOMER/ns2:COUNTRY_ISSUE
                            return
                                <ns1:COUNTRY_ISSUE>
                                    <ns1:ID_COUNTRY>{ data($COUNTRY_ISSUE/ns2:ID_COUNTRY) }</ns1:ID_COUNTRY>
                                    <ns1:NAME>{ data($COUNTRY_ISSUE/ns2:NAME) }</ns1:NAME>
                                </ns1:COUNTRY_ISSUE>
                        }
                    </ns1:PR_ID_CUSTOMER>
            }
            <ns1:PV_FIRST_NAME>{ data($createCustomerProfile/ns2:FIRST_NAME) }</ns1:PV_FIRST_NAME>
            {
                for $MIDDLE_NAME in $createCustomerProfile/ns2:MIDDLE_NAME
                return
                    <ns1:PV_MIDDLE_NAME>{ data($MIDDLE_NAME) }</ns1:PV_MIDDLE_NAME>
            }
            <ns1:PV_LAST_NAME>{ data($createCustomerProfile/ns2:LAST_NAME) }</ns1:PV_LAST_NAME>
            {
                for $LAST_NAME2 in $createCustomerProfile/ns2:LAST_NAME2
                return
                    <ns1:PV_LAST_NAME2>{ data($LAST_NAME2) }</ns1:PV_LAST_NAME2>
            }
            {
                for $MARRIED_NAME in $createCustomerProfile/ns2:MARRIED_NAME
                return
                    <ns1:PV_MARRIED_NAME>{ data($MARRIED_NAME) }</ns1:PV_MARRIED_NAME>
            }
            {
                for $DATE_OF_BIRTH in $createCustomerProfile/ns2:DATE_OF_BIRTH
                return
                    <ns1:PV_DATE_OF_BIRTH>{ data($DATE_OF_BIRTH) }</ns1:PV_DATE_OF_BIRTH>
            }
            {
                let $OCCUPATION := $createCustomerProfile/ns2:OCCUPATION
                return
                    <ns1:PR_OCCUPATION>
                        <ns1:ID_OCCUPATION>{ data($OCCUPATION/ns0:ID_OCCUPATION) }</ns1:ID_OCCUPATION>
                        {
                            for $DESCRIPTION_OCC in $OCCUPATION/ns0:DESCRIPTION_OCC
                            return
                                <ns1:DESCRIPTION_OCC>{ data($DESCRIPTION_OCC) }</ns1:DESCRIPTION_OCC>
                        }
                    </ns1:PR_OCCUPATION>
            }
            {
                let $PHONES := $createCustomerProfile/ns2:PHONES
                return
                    <ns1:PT_PHONES>
                        {
                            for $PHONE in $PHONES/ns0:PHONE
                            return
                                <ns1:PT_PHONES_ITEM>
                                    <ns1:ID_TYPE>{ data($PHONE/ns0:ID_TYPE) }</ns1:ID_TYPE>
                                    {
                                        for $PHONE_DESC in $PHONE/ns0:PHONE_DESC
                                        return
                                            <ns1:PHONE_DESC>{ data($PHONE_DESC) }</ns1:PHONE_DESC>
                                    }
                                    <ns1:NUMBER_>{ data($PHONE/ns0:NUMBER) }</ns1:NUMBER_>
                                </ns1:PT_PHONES_ITEM>
                        }
                    </ns1:PT_PHONES>
            }
            {
                let $CUSTOMER_TYPE := $createCustomerProfile/ns2:CUSTOMER_TYPE
                return
                    <ns1:PR_CUSTOMER_TYPE>
                        <ns1:ID_TYPE_CUSTOMER>{ data($CUSTOMER_TYPE/ns0:ID_TYPE_CUSTOMER) }</ns1:ID_TYPE_CUSTOMER>
                        <ns1:CUSTOMER_DESC>{ data($CUSTOMER_TYPE/ns0:CUSTOMER_DESC) }</ns1:CUSTOMER_DESC>
                    </ns1:PR_CUSTOMER_TYPE>
            }
            <ns1:PT_ADDRESSES>
                {
                    for $ADDRESSES in $createCustomerProfile/ns2:ADDRESSES
                    return
                        <ns1:PT_ADDRESSES_ITEM>
                            {
                                let $ADDRESS_TYPE := $ADDRESSES/ns0:ADDRESS_TYPE
                                return
                                    <ns1:ADDRESS_TYPE>
                                        <ns1:ID_ADDRESS>{ data($ADDRESS_TYPE/ns0:ID_ADDRESS) }</ns1:ID_ADDRESS>
                                        {
                                            for $ADDRESS_DESC in $ADDRESS_TYPE/ns0:ADDRESS_DESC
                                            return
                                                <ns1:ADDRESS_DESC>{ data($ADDRESS_DESC) }</ns1:ADDRESS_DESC>
                                        }
                                    </ns1:ADDRESS_TYPE>
                            }
                            {
                                let $STATE_ADDRESS := $ADDRESSES/ns0:STATE_ADDRESS
                                return
                                    <ns1:STATE_ADDRESS>
                                        <ns1:ID_STATE>{ data($STATE_ADDRESS/ns0:ID_STATE) }</ns1:ID_STATE>
                                        {
                                            for $STATE_DESC in $STATE_ADDRESS/ns0:STATE_DESC
                                            return
                                                <ns1:STATE_DESC>{ data($STATE_DESC) }</ns1:STATE_DESC>
                                        }
                                    </ns1:STATE_ADDRESS>
                            }
                            {
                                let $CITY_ADDRESS := $ADDRESSES/ns0:CITY_ADDRESS
                                return
                                    <ns1:CITY_ADDRESS>
                                        <ns1:ID_CITY>{ data($CITY_ADDRESS/ns0:ID_CITY) }</ns1:ID_CITY>
                                        {
                                            for $CITY_DESC in $CITY_ADDRESS/ns0:CITY_DESC
                                            return
                                                <ns1:CITY_DESC>{ data($CITY_DESC) }</ns1:CITY_DESC>
                                        }
                                    </ns1:CITY_ADDRESS>
                            }
                            <ns1:REGION>{ data($ADDRESSES/ns0:REGION) }</ns1:REGION>
                            <ns1:AVENUE>{ data($ADDRESSES/ns0:AVENUE) }</ns1:AVENUE>
                            {
                                for $STREET in $ADDRESSES/ns0:STREET
                                return
                                    <ns1:STREET>{ data($STREET) }</ns1:STREET>
                            }
                            <ns1:HOUSE_NUMBER>{ data($ADDRESSES/ns0:HOUSE_NUMBER) }</ns1:HOUSE_NUMBER>
                            {
                                for $REFERENCE in $ADDRESSES/ns0:REFERENCE
                                return
                                    <ns1:REFERENCE>{ data($REFERENCE) }</ns1:REFERENCE>
                            }
                        </ns1:PT_ADDRESSES_ITEM>
                }
            </ns1:PT_ADDRESSES>
            {
                let $NSO_INFO := $createCustomerProfile/ns2:NSO_INFO
                return
                    <ns1:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns0:TRACE
                            return
                                <ns1:TRACE>
                                    <ns1:TELLER_ID>{ data($TRACE/ns0:TELLER_ID) }</ns1:TELLER_ID>
                                    <ns1:BRANCH_ID>{ data($TRACE/ns0:BRANCH_ID) }</ns1:BRANCH_ID>
                                    <ns1:CHANNEL_CODE>{ data($TRACE/ns0:CHANNEL_CODE) }</ns1:CHANNEL_CODE>
                                    <ns1:DATE_TIME>{ data($TRACE/ns0:DATE_TIME) }</ns1:DATE_TIME>
                                    {
                                        for $QUEUE_TICKET_ID in $TRACE/ns0:QUEUE_TICKET_ID
                                        return
                                            <ns1:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns1:QUEUE_TICKET_ID>
                                    }
                                    {
                                        for $TXN_REF_NO in $TRACE/ns0:TXN_REF_NO
                                        return
                                            <ns1:TXN_REF_NO>{ data($TXN_REF_NO) }</ns1:TXN_REF_NO>
                                    }
                                    {
                                        for $DEALSLIP_ID in $TRACE/ns0:DEALSLIP_ID
                                        return
                                            <ns1:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns1:DEALSLIP_ID>
                                    }
                                </ns1:TRACE>
                        }
                        {
                            for $AUTHORIZATION in $NSO_INFO/ns0:AUTHORIZATION
                            return
                                <ns1:AUTHORIZATION>
                                    <ns1:TYPE>{ data($AUTHORIZATION/ns0:TYPE) }</ns1:TYPE>
                                    {
                                        for $KV_PAIRS in $AUTHORIZATION/ns0:KV_PAIRS
                                        return
                                            <ns1:KV_PAIRS>
                                                <ns1:PAIR>
                                                    {
                                                        for $PAIR in $KV_PAIRS/ns0:PAIR
                                                        return
                                                            <ns1:PAIR_ITEM>
                                                                <ns1:KEY>{ data($PAIR/ns0:KEY) }</ns1:KEY>
                                                                <ns1:VALUE>{ data($PAIR/ns0:VALUE) }</ns1:VALUE>
                                                            </ns1:PAIR_ITEM>
                                                    }
                                                </ns1:PAIR>
                                            </ns1:KV_PAIRS>
                                    }
                                </ns1:AUTHORIZATION>
                        }
                        {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns0:BANKNOTE_BREAKDOWN
                            return
                                <ns1:BANKNOTE_BREAKDOWN>
                                    <ns1:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns0:BANKNOTE
                                            return
                                                <ns1:BANKNOTE_ITEM>
                                                    <ns1:CURRENCY>{ data($BANKNOTE/ns0:CURRENCY) }</ns1:CURRENCY>
                                                    <ns1:BANKNOTE_VALUE>{ data($BANKNOTE/ns0:VALUE) }</ns1:BANKNOTE_VALUE>
                                                    <ns1:QUANTITY>{ data($BANKNOTE/ns0:QUANTITY) }</ns1:QUANTITY>
                                                    <ns1:TOTAL>{ data($BANKNOTE/ns0:TOTAL) }</ns1:TOTAL>
                                                </ns1:BANKNOTE_ITEM>
                                        }
                                    </ns1:BANKNOTE>
                                </ns1:BANKNOTE_BREAKDOWN>
                        }
                        {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns0:ADDITIONAL_INFO
                            return
                                <ns1:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns0:KV_PAIRS
                                        return
                                            <ns1:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns0:PAIR
                                                    return
                                                        <ns1:PAIR_ITEM>
                                                            <ns1:KEY>{ data($PAIR/ns0:KEY) }</ns1:KEY>
                                                            <ns1:VALUE>{ data($PAIR/ns0:VALUE) }</ns1:VALUE>
                                                        </ns1:PAIR_ITEM>
                                                }
                                            </ns1:KV_PAIRS>
                                    }
                                </ns1:ADDITIONAL_INFO>
                        }
                        {
                            for $CTR_REFERENCE in $NSO_INFO/ns0:CTR_REFERENCE
                            return
                                <ns1:CTR_REFERENCE>{ data($CTR_REFERENCE) }</ns1:CTR_REFERENCE>
                        }
                    </ns1:PR_NSO_INFO>
            }
        </ns1:InputParameters>
};

declare variable $createCustomerProfile as element(ns2:createCustomerProfile) external;

xf:creacionClienteGTIn($createCustomerProfile)