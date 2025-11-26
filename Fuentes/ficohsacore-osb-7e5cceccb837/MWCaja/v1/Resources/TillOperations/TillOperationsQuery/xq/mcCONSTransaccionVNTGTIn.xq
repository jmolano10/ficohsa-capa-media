(:: pragma bea:global-element-parameter parameter="$tillOperationsQuery" element="ns0:tillOperationsQuery" location="../../xsd/TillOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../BusinessServices/AbanksGT/CONSTransaccionVNT/xsd/MCCONSTransaccionVNT_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/TillOperationsTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSGT/MGC_K_OPERACIONES_VENTANILLA/MC_CONS_TRANSACCION_VNT/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/TillOperations/TillOperationsQuery/xq/mcCONSTransaccionVNTGTIn/";

declare function xf:mcCONSTransaccionVNTGTIn($tillOperationsQuery as element(ns0:tillOperationsQuery))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            {
                let $NSO_INFO := $tillOperationsQuery/ns0:NSO_INFO
                return
                    <ns2:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns1:TRACE
                            return
                                <ns2:TRACE>
                                    <ns2:TELLER_ID>{ xs:decimal(data($TRACE/ns1:TELLER_ID)) }</ns2:TELLER_ID>
                                    <ns2:BRANCH_ID>{ xs:decimal(data($TRACE/ns1:BRANCH_ID)) }</ns2:BRANCH_ID>
                                    <ns2:CHANNEL_CODE>{ xs:decimal(data($TRACE/ns1:CHANNEL_CODE)) }</ns2:CHANNEL_CODE>
                                    <ns2:DATE_TIME>{ data($TRACE/ns1:DATE_TIME) }</ns2:DATE_TIME>
                                    {
                                        for $QUEUE_TICKET_ID in $TRACE/ns1:QUEUE_TICKET_ID
                                        return
                                            <ns2:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns2:QUEUE_TICKET_ID>
                                    }
                                    {
                                        for $TXN_REF_NO in $TRACE/ns1:TXN_REF_NO
                                        return
                                            <ns2:TXN_REF_NO>{ data($TXN_REF_NO) }</ns2:TXN_REF_NO>
                                    }
                                    {
                                        for $DEALSLIP_ID in $TRACE/ns1:DEALSLIP_ID
                                        return
                                            <ns2:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns2:DEALSLIP_ID>
                                    }
                                </ns2:TRACE>
                        }
                        {
                            for $AUTHORIZATION in $NSO_INFO/ns1:AUTHORIZATION
                            return
                                <ns2:AUTHORIZATION>
                                    <ns2:TYPE>{ data($AUTHORIZATION/ns1:TYPE) }</ns2:TYPE>
                                    {
                                        for $KV_PAIRS in $AUTHORIZATION/ns1:KV_PAIRS
                                        return
                                            <ns2:KV_PAIRS>
                                                <ns2:PAIR>
                                                    {
                                                        for $PAIR in $KV_PAIRS/ns1:PAIR
                                                        return
                                                            <ns2:PAIR_ITEM>
                                                                <ns2:KEY>{ data($PAIR/ns1:KEY) }</ns2:KEY>
                                                                <ns2:VALUE>{ data($PAIR/ns1:VALUE) }</ns2:VALUE>
                                                            </ns2:PAIR_ITEM>
                                                    }
                                                </ns2:PAIR>
                                            </ns2:KV_PAIRS>
                                    }
                                </ns2:AUTHORIZATION>
                        }
                        {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns1:BANKNOTE_BREAKDOWN
                            return
                                <ns2:BANKNOTE_BREAKDOWN>
                                    <ns2:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns1:BANKNOTE
                                            return
                                                <ns2:BANKNOTE_ITEM>
                                                    <ns2:CURRENCY>{ data($BANKNOTE/ns1:CURRENCY) }</ns2:CURRENCY>
                                                    <ns2:BANKNOTE_VALUE>{ data($BANKNOTE/ns1:VALUE) }</ns2:BANKNOTE_VALUE>
                                                    <ns2:QUANTITY>{ xs:decimal(data($BANKNOTE/ns1:QUANTITY)) }</ns2:QUANTITY>
                                                    <ns2:TOTAL>{ data($BANKNOTE/ns1:TOTAL) }</ns2:TOTAL>
                                                </ns2:BANKNOTE_ITEM>
                                        }
                                    </ns2:BANKNOTE>
                                </ns2:BANKNOTE_BREAKDOWN>
                        }
                        {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns1:ADDITIONAL_INFO
                            return
                                <ns2:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns1:KV_PAIRS
                                        return
                                            <ns2:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns1:PAIR
                                                    return
                                                        <ns2:PAIR_ITEM>
                                                            <ns2:KEY>{ data($PAIR/ns1:KEY) }</ns2:KEY>
                                                            <ns2:VALUE>{ data($PAIR/ns1:VALUE) }</ns2:VALUE>
                                                        </ns2:PAIR_ITEM>
                                                }
                                            </ns2:KV_PAIRS>
                                    }
                                </ns2:ADDITIONAL_INFO>
                        }
                        {
                            for $CTR_REFERENCE in $NSO_INFO/ns1:CTR_REFERENCE
                            return
                                <ns2:CTR_REFERENCE>{ xs:decimal(data($CTR_REFERENCE)) }</ns2:CTR_REFERENCE>
                        }
                    </ns2:PR_NSO_INFO>
            }
        </ns2:InputParameters>
};

declare variable $tillOperationsQuery as element(ns0:tillOperationsQuery) external;

xf:mcCONSTransaccionVNTGTIn($tillOperationsQuery)
