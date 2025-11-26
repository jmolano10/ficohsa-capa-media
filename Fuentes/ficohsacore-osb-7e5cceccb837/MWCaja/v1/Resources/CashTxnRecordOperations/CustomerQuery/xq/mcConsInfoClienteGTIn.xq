(:: pragma bea:global-element-parameter parameter="$customerQuery" element="ns3:customerQuery" location="../../xsd/CashTxnRecordOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../BusinessServices/AbanksGT/ConsInfoCliente/xsd/MCConsInfoCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsInfoCliente";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CashTxnRecordOperations/CustomerQuery/xq/mcConsInfoClienteGTIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/cashTxnRecordOperationsTypes";

declare function xf:mcConsInfoClienteGTIn($customerQuery as element(ns3:customerQuery))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                let $LEGAL_ID := $customerQuery/ns3:LEGAL_ID
                return
                    <ns1:PR_LEGAL_ID>
                        <ns1:NAME>{ data($LEGAL_ID/ns0:NAME) }</ns1:NAME>
                        <ns1:ID>{ data($LEGAL_ID/ns0:ID) }</ns1:ID>
                        {
                            for $EXPIRATION_DATE in $LEGAL_ID/ns0:EXPIRATION_DATE
                            return
                                <ns1:EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</ns1:EXPIRATION_DATE>
                        }
                        {
                            for $ISSUER in $LEGAL_ID/ns0:ISSUER
                            return
                                <ns1:ISSUER>{ data($ISSUER) }</ns1:ISSUER>
                        }
                    </ns1:PR_LEGAL_ID>
            }
            {
                let $NSO_INFO := $customerQuery/ns3:NSO_INFO
                return
                    <ns1:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns2:TRACE
                            return
                                <ns1:TRACE>
                                    <ns1:TELLER_ID>{ xs:decimal(data($TRACE/ns2:TELLER_ID)) }</ns1:TELLER_ID>
                                    <ns1:BRANCH_ID>{ xs:decimal(data($TRACE/ns2:BRANCH_ID)) }</ns1:BRANCH_ID>
                                    <ns1:CHANNEL_CODE>{ xs:decimal(data($TRACE/ns2:CHANNEL_CODE)) }</ns1:CHANNEL_CODE>
                                    <ns1:DATE_TIME>{ data($TRACE/ns2:DATE_TIME) }</ns1:DATE_TIME>
                                    {
                                        for $QUEUE_TICKET_ID in $TRACE/ns2:QUEUE_TICKET_ID
                                        return
                                            <ns1:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns1:QUEUE_TICKET_ID>
                                    }
                                    {
                                        for $TXN_REF_NO in $TRACE/ns2:TXN_REF_NO
                                        return
                                            <ns1:TXN_REF_NO>{ data($TXN_REF_NO) }</ns1:TXN_REF_NO>
                                    }
                                    {
                                        for $DEALSLIP_ID in $TRACE/ns2:DEALSLIP_ID
                                        return
                                            <ns1:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns1:DEALSLIP_ID>
                                    }
                                </ns1:TRACE>
                        }
                        {
                            for $AUTHORIZATION in $NSO_INFO/ns2:AUTHORIZATION
                            return
                                <ns1:AUTHORIZATION>
                                    <ns1:TYPE>{ data($AUTHORIZATION/ns2:TYPE) }</ns1:TYPE>
                                    {
                                        for $KV_PAIRS in $AUTHORIZATION/ns2:KV_PAIRS
                                        return
                                            <ns1:KV_PAIRS>
                                                <ns1:PAIR>
                                                    {
                                                        for $PAIR in $KV_PAIRS/ns2:PAIR
                                                        return
                                                            <ns1:PAIR_ITEM>
                                                                <ns1:KEY>{ data($PAIR/ns2:KEY) }</ns1:KEY>
                                                                <ns1:VALUE>{ data($PAIR/ns2:VALUE) }</ns1:VALUE>
                                                            </ns1:PAIR_ITEM>
                                                    }
                                                </ns1:PAIR>
                                            </ns1:KV_PAIRS>
                                    }
                                </ns1:AUTHORIZATION>
                        }
                        {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns2:BANKNOTE_BREAKDOWN
                            return
                                <ns1:BANKNOTE_BREAKDOWN>
                                    <ns1:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns2:BANKNOTE
                                            return
                                                <ns1:BANKNOTE_ITEM>
                                                    <ns1:CURRENCY>{ data($BANKNOTE/ns2:CURRENCY) }</ns1:CURRENCY>
                                                    <ns1:BANKNOTE_VALUE>{ data($BANKNOTE/ns2:VALUE) }</ns1:BANKNOTE_VALUE>
                                                    <ns1:QUANTITY>{ xs:decimal(data($BANKNOTE/ns2:QUANTITY)) }</ns1:QUANTITY>
                                                    <ns1:TOTAL>{ data($BANKNOTE/ns2:TOTAL) }</ns1:TOTAL>
                                                </ns1:BANKNOTE_ITEM>
                                        }
                                    </ns1:BANKNOTE>
                                </ns1:BANKNOTE_BREAKDOWN>
                        }
                        {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns2:ADDITIONAL_INFO
                            return
                                <ns1:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns2:KV_PAIRS
                                        return
                                            <ns1:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns2:PAIR
                                                    return
                                                        <ns1:PAIR_ITEM>
                                                            <ns1:KEY>{ data($PAIR/ns2:KEY) }</ns1:KEY>
                                                            <ns1:VALUE>{ data($PAIR/ns2:VALUE) }</ns1:VALUE>
                                                        </ns1:PAIR_ITEM>
                                                }
                                            </ns1:KV_PAIRS>
                                    }
                                </ns1:ADDITIONAL_INFO>
                        }
                        {
                            for $CTR_REFERENCE in $NSO_INFO/ns2:CTR_REFERENCE
                            return
                                <ns1:CTR_REFERENCE>{ xs:decimal(data($CTR_REFERENCE)) }</ns1:CTR_REFERENCE>
                        }
                    </ns1:PR_NSO_INFO>
            }
        </ns1:InputParameters>
};

declare variable $customerQuery as element(ns3:customerQuery) external;

xf:mcConsInfoClienteGTIn($customerQuery)
