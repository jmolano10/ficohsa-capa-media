(:: pragma bea:global-element-parameter parameter="$billQuery" element="ns0:billQuery" location="../../xsd/BillOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../BusinessServices/AbanksGT/ConsFactura/xsd/MCConsFactura_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/billOperationsTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsFactura";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillQuery/xq/mcConsFacturaGTIn/";

declare function xf:mcConsFacturaGTIn($billQuery as element(ns0:billQuery))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_CONTRACT_ID>{ data($billQuery/ns0:CONTRACT_ID) }</ns2:PV_CONTRACT_ID>
            <ns2:PV_DEBTOR_CODE>{ data($billQuery/ns0:DEBTOR_CODE) }</ns2:PV_DEBTOR_CODE>
            <ns2:PV_CURRENCY>{ data($billQuery/ns0:CURRENCY) }</ns2:PV_CURRENCY>
            {
                for $BILLS_TO_QUERY in $billQuery/ns0:BILLS_TO_QUERY
                return
                    <ns2:PR_BILL_TO_QUERY>
                        <ns2:BILL_ID>
                            {
                                for $BILL_ID in $BILLS_TO_QUERY/ns0:BILL_ID
                                return
                                    <ns2:BILL_ID_ITEM>{ data($BILL_ID) }</ns2:BILL_ID_ITEM>
                            }
                        </ns2:BILL_ID>
                    </ns2:PR_BILL_TO_QUERY>
            }
            {
                for $EXTRA_INFO in $billQuery/ns0:EXTRA_INFO
                return
                    <ns2:PR_EXTRA_INFO>
                        <ns2:PAIR>
                            {
                                for $PAIR in $EXTRA_INFO/ns1:PAIR
                                return
                                    <ns2:PAIR_ITEM>
                                        {
                                            for $KEY in $PAIR/ns1:KEY
                                            return
                                                <ns2:KEY>{ data($KEY) }</ns2:KEY>
                                        }
                                        {
                                            for $VALUE in $PAIR/ns1:VALUE
                                            return
                                                <ns2:VALUE>{ data($VALUE) }</ns2:VALUE>
                                        }
                                    </ns2:PAIR_ITEM>
                            }
                        </ns2:PAIR>
                    </ns2:PR_EXTRA_INFO>
            }
            {
                let $NSO_INFO := $billQuery/ns0:NSO_INFO
                return
                    <ns2:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns1:TRACE
                            return
                                <ns2:TRACE>
                                    <ns2:TELLER_ID>{ data($TRACE/ns1:TELLER_ID) }</ns2:TELLER_ID>
                                    <ns2:BRANCH_ID>{ data($TRACE/ns1:BRANCH_ID) }</ns2:BRANCH_ID>
                                    <ns2:CHANNEL_CODE>{ data($TRACE/ns1:CHANNEL_CODE) }</ns2:CHANNEL_CODE>
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
                                                                {
                                                                    for $KEY in $PAIR/ns1:KEY
                                                                    return
                                                                        <ns2:KEY>{ data($KEY) }</ns2:KEY>
                                                                }
                                                                {
                                                                    for $VALUE in $PAIR/ns1:VALUE
                                                                    return
                                                                        <ns2:VALUE>{ data($VALUE) }</ns2:VALUE>
                                                                }
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
                                                    <ns2:QUANTITY>{ data($BANKNOTE/ns1:QUANTITY) }</ns2:QUANTITY>
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
                                                            {
                                                                for $KEY in $PAIR/ns1:KEY
                                                                return
                                                                    <ns2:KEY>{ data($KEY) }</ns2:KEY>
                                                            }
                                                            {
                                                                for $VALUE in $PAIR/ns1:VALUE
                                                                return
                                                                    <ns2:VALUE>{ data($VALUE) }</ns2:VALUE>
                                                            }
                                                        </ns2:PAIR_ITEM>
                                                }
                                            </ns2:KV_PAIRS>
                                    }
                                </ns2:ADDITIONAL_INFO>
                        }
                        {
                        	for $CTR_REFERENCE in $NSO_INFO/ns1:CTR_REFERENCE
                        	return
                        		<ns2:CTR_REFERENCE>{ data($CTR_REFERENCE) }</ns2:CTR_REFERENCE>
                        }
                        
                    </ns2:PR_NSO_INFO>
            }
        </ns2:InputParameters>
};

declare variable $billQuery as element(ns0:billQuery) external;

xf:mcConsFacturaGTIn($billQuery)
