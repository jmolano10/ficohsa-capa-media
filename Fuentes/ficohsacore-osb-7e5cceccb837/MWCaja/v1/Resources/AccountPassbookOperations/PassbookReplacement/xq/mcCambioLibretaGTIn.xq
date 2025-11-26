(:: pragma bea:global-element-parameter parameter="$passbookReplacement" element="ns2:passbookReplacement" location="../../xsd/AccountPassbookOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../BusinessServices/AbanksGT/CambioLibreta/xsd/MCCambioLibreta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/accountPassbookOperationsTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCCambioLibreta";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/AccountPassbookOperations/PassbookReplacement/xq/mcCambioLibretaGTIn/";

declare function xf:mcCambioLibretaGTIn($passbookReplacement as element(ns2:passbookReplacement))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_ACCOUNT_NUMBER>{ data($passbookReplacement/ns2:ACCOUNT_NUMBER) }</ns1:PV_ACCOUNT_NUMBER>
            <ns1:PN_OLD_PASSBOOK_ID>{ data($passbookReplacement/ns2:OLD_PASSBOOK_ID) }</ns1:PN_OLD_PASSBOOK_ID>
            <ns1:PN_NEW_PASSBOOK_ID>{ data($passbookReplacement/ns2:NEW_PASSBOOK_ID) }</ns1:PN_NEW_PASSBOOK_ID>
            {
                let $NSO_INFO := $passbookReplacement/ns2:NSO_INFO
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

declare variable $passbookReplacement as element(ns2:passbookReplacement) external;

xf:mcCambioLibretaGTIn($passbookReplacement)
