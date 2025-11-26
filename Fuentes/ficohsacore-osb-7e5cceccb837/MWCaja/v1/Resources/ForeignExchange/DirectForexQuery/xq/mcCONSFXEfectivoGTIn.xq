(:: pragma bea:global-element-parameter parameter="$directForexQuery" element="ns3:directForexQuery" location="../../xsd/ForeignExchangeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/AbanksGT/CONSFXEfectivo/xsd/MCCONSFXEfectivo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCCONSFXEfectivo";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/ForeignExchange/DirectForexQuery/xq/mcCONSFXEfectivoGTIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/foreignExchangeTypes";

declare function xf:mcCONSFXEfectivoGTIn($directForexQuery as element(ns3:directForexQuery))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                let $CUSTOMER := $directForexQuery/ns3:CUSTOMER
                return
                    <ns0:PR_CUSTOMER>
                        {
                            for $LEGAL_ID in $CUSTOMER/ns3:LEGAL_ID
                            return
                                <ns0:LEGAL_ID>
                                    <ns0:NAME>{ data($LEGAL_ID/ns1:NAME) }</ns0:NAME>
                                    <ns0:ID>{ data($LEGAL_ID/ns1:ID) }</ns0:ID>
                                    {
                                        for $EXPIRATION_DATE in $LEGAL_ID/ns1:EXPIRATION_DATE
                                        return
                                            <ns0:EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</ns0:EXPIRATION_DATE>
                                    }
                                    {
                                        for $ISSUER in $LEGAL_ID/ns1:ISSUER
                                        return
                                            <ns0:ISSUER>{ data($ISSUER) }</ns0:ISSUER>
                                    }
                                </ns0:LEGAL_ID>
                        }
                        {
                            for $PRODUCT in $CUSTOMER/ns3:PRODUCT
                            return
                                <ns0:PRODUCT>
                                    <ns0:TYPE>{ data($PRODUCT/ns1:TYPE) }</ns0:TYPE>
                                    <ns0:ID>{ data($PRODUCT/ns1:ID) }</ns0:ID>
                                </ns0:PRODUCT>
                        }
                    </ns0:PR_CUSTOMER>
            }
            {
                let $FOREX_DETAILS := $directForexQuery/ns3:FOREX_DETAILS
                return
                    <ns0:PR_FOREX_DETAILS>
                        <ns0:TYPE>{ data($FOREX_DETAILS/ns3:TYPE) }</ns0:TYPE>
                        <ns0:CURRENCY>{ data($FOREX_DETAILS/ns3:CURRENCY) }</ns0:CURRENCY>
                        <ns0:AMOOUNT>{ data($FOREX_DETAILS/ns3:AMOUNT) }</ns0:AMOOUNT>
                    </ns0:PR_FOREX_DETAILS>
            }
            {
                let $NSO_INFO := $directForexQuery/ns3:NSO_INFO
                return
                    <ns0:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns2:TRACE
                            return
                                
                                <ns0:TRACE>
                                    <ns0:TELLER_ID>{ xs:decimal(data($TRACE/ns2:TELLER_ID)) }</ns0:TELLER_ID>
                                    <ns0:BRANCH_ID>{ xs:decimal(data($TRACE/ns2:BRANCH_ID)) }</ns0:BRANCH_ID>
                                    <ns0:CHANNEL_CODE>{ xs:decimal(data($TRACE/ns2:CHANNEL_CODE)) }</ns0:CHANNEL_CODE>
                                    <ns0:DATE_TIME>{ data($TRACE/ns2:DATE_TIME) }</ns0:DATE_TIME>
                                    {
                                        for $QUEUE_TICKET_ID in $TRACE/ns2:QUEUE_TICKET_ID
                                        return
                                            <ns0:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns0:QUEUE_TICKET_ID>
                                    }
                                    {
                                        for $TXN_REF_NO in $TRACE/ns2:TXN_REF_NO
                                        return
                                            <ns0:TXN_REF_NO>{ data($TXN_REF_NO) }</ns0:TXN_REF_NO>
                                    }
                                    {
                                        for $DEALSLIP_ID in $TRACE/ns2:DEALSLIP_ID
                                        return
                                            <ns0:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns0:DEALSLIP_ID>
                                    }
                                </ns0:TRACE>
                        }
                        {
                            for $AUTHORIZATION in $NSO_INFO/ns2:AUTHORIZATION
                            return
                                <ns0:AUTHORIZATION>
                                    <ns0:TYPE>{ data($AUTHORIZATION/ns2:TYPE) }</ns0:TYPE>
                                    {
                                        for $KV_PAIRS in $AUTHORIZATION/ns2:KV_PAIRS
                                        return
                                            <ns0:KV_PAIRS>
                                                <ns0:PAIR>
                                                    {
                                                        for $PAIR in $KV_PAIRS/ns2:PAIR
                                                        return
                                                            <ns0:PAIR_ITEM>
                                                                <ns0:KEY>{ data($PAIR/ns2:KEY) }</ns0:KEY>
                                                                <ns0:VALUE>{ data($PAIR/ns2:VALUE) }</ns0:VALUE>
                                                            </ns0:PAIR_ITEM>
                                                    }
                                                </ns0:PAIR>
                                            </ns0:KV_PAIRS>
                                    }
                                </ns0:AUTHORIZATION>
                        }
                        {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns2:BANKNOTE_BREAKDOWN
                            return
                                <ns0:BANKNOTE_BREAKDOWN>
                                    <ns0:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns2:BANKNOTE
                                            return
                                                <ns0:BANKNOTE_ITEM>
                                                    <ns0:CURRENCY>{ data($BANKNOTE/ns2:CURRENCY) }</ns0:CURRENCY>
                                                    <ns0:BANKNOTE_VALUE>{ data($BANKNOTE/ns2:VALUE) }</ns0:BANKNOTE_VALUE>
                                                    <ns0:QUANTITY>{ xs:decimal(data($BANKNOTE/ns2:QUANTITY)) }</ns0:QUANTITY>
                                                    <ns0:TOTAL>{ data($BANKNOTE/ns2:TOTAL) }</ns0:TOTAL>
                                                </ns0:BANKNOTE_ITEM>
                                        }
                                    </ns0:BANKNOTE>
                                </ns0:BANKNOTE_BREAKDOWN>
                        }
                        {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns2:ADDITIONAL_INFO
                            return
                                <ns0:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns2:KV_PAIRS
                                        return
                                            <ns0:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns2:PAIR
                                                    return
                                                        <ns0:PAIR_ITEM>
                                                            <ns0:KEY>{ data($PAIR/ns2:KEY) }</ns0:KEY>
                                                            <ns0:VALUE>{ data($PAIR/ns2:VALUE) }</ns0:VALUE>
                                                        </ns0:PAIR_ITEM>
                                                }
                                            </ns0:KV_PAIRS>
                                    }
                                </ns0:ADDITIONAL_INFO>
                        }
                        {
                            for $CTR_REFERENCE in $NSO_INFO/ns2:CTR_REFERENCE
                            return
                                <ns0:CTR_REFERENCE>{ xs:decimal(data($CTR_REFERENCE)) }</ns0:CTR_REFERENCE>
                        }
                    </ns0:PR_NSO_INFO>
            }
        </ns0:InputParameters>
};

declare variable $directForexQuery as element(ns3:directForexQuery) external;

xf:mcCONSFXEfectivoGTIn($directForexQuery)
