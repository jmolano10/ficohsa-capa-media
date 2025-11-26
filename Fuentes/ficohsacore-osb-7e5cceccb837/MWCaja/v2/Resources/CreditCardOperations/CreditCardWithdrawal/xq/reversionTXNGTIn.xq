(:: pragma bea:global-element-parameter parameter="$creditCardWithdrawal" element="ns2:creditCardWithdrawal" location="../../../../../v1/Resources/CreditCardOperations/xsd/CreditCardOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../v1/BusinessServices/AbanksGT/ReversionTXN/xsd/MCReversionTXN_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCReversionTXN";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/creditCardOperationsTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v2/Resources/CreditCardOperations/CreditCardWithdrawal/xq/reversa/";

declare function xf:reversa($transacionId as xs:string,
    $creditCardWithdrawal as element(ns2:creditCardWithdrawal))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TRANSACTION_ID>{ $transacionId }</ns0:PV_TRANSACTION_ID>
            {
	            let $NSO_INFO := $creditCardWithdrawal/ns2:NSO_INFO
	            return
		            <ns0:PR_NSO_INFO>
		            {
		            	 let $TRACE := $NSO_INFO/ns1:TRACE
                         return
			                <ns0:TRACE>
			                    <ns0:TELLER_ID>{ data($TRACE/ns1:TELLER_ID) }</ns0:TELLER_ID>
			                    <ns0:BRANCH_ID>{ data($TRACE/ns1:BRANCH_ID) }</ns0:BRANCH_ID>
			                    <ns0:CHANNEL_CODE>{ data($TRACE/ns1:CHANNEL_CODE) }</ns0:CHANNEL_CODE>
			                    <ns0:DATE_TIME>{ data($TRACE/ns1:DATE_TIME) }</ns0:DATE_TIME>
			                    <ns0:QUEUE_TICKET_ID>{ data($TRACE/ns1:QUEUE_TICKET_ID) }</ns0:QUEUE_TICKET_ID>
			                    <ns0:TXN_REF_NO>{ $transacionId }</ns0:TXN_REF_NO>
			                    <ns0:DEALSLIP_ID>{ data($TRACE/ns1:DEALSLIP_ID) }</ns0:DEALSLIP_ID>
			                </ns0:TRACE>
			      	}
			      	{
                        for $AUTHORIZATION in $NSO_INFO/ns1:AUTHORIZATION
                        return
                            <ns0:AUTHORIZATION>
                                <ns0:TYPE>{ data($AUTHORIZATION/ns1:TYPE) }</ns0:TYPE>
                                {
                                    for $KV_PAIRS in $AUTHORIZATION/ns1:KV_PAIRS
                                    return
                                        <ns0:KV_PAIRS>
                                            <ns0:PAIR>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns1:PAIR
                                                    return
                                                        <ns0:PAIR_ITEM>
                                                            <ns0:KEY>{ data($PAIR/ns1:KEY) }</ns0:KEY>
                                                            <ns0:VALUE>{ data($PAIR/ns1:VALUE) }</ns0:VALUE>
                                                        </ns0:PAIR_ITEM>
                                                }
                                            </ns0:PAIR>
                                        </ns0:KV_PAIRS>
                                 }
                                </ns0:AUTHORIZATION>
                     }
                     {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns1:BANKNOTE_BREAKDOWN
                            return
                                <ns0:BANKNOTE_BREAKDOWN>
                                    <ns0:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns1:BANKNOTE
                                            return
                                                <ns0:BANKNOTE_ITEM>
                                                    <ns0:CURRENCY>{ data($BANKNOTE/ns1:CURRENCY) }</ns0:CURRENCY>
                                                    <ns0:BANKNOTE_VALUE>{ data($BANKNOTE/ns1:VALUE) }</ns0:BANKNOTE_VALUE>
                                                    <ns0:QUANTITY>{ xs:decimal(data($BANKNOTE/ns1:QUANTITY)) }</ns0:QUANTITY>
                                                    <ns0:TOTAL>{ data($BANKNOTE/ns1:TOTAL) }</ns0:TOTAL>
                                                </ns0:BANKNOTE_ITEM>
                                        }
                                    </ns0:BANKNOTE>
                                </ns0:BANKNOTE_BREAKDOWN>
                     }
                     {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns1:ADDITIONAL_INFO
                            return
                                <ns0:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns1:KV_PAIRS
                                        return
                                            <ns0:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns1:PAIR
                                                    return
                                                        <ns0:PAIR_ITEM>
                                                            <ns0:KEY>{ data($PAIR/ns1:KEY) }</ns0:KEY>
                                                            <ns0:VALUE>{ data($PAIR/ns1:VALUE) }</ns0:VALUE>
                                                        </ns0:PAIR_ITEM>
                                                }
                                            </ns0:KV_PAIRS>
                                    }
                                </ns0:ADDITIONAL_INFO>
                       }
                       {
                            for $CTR_REFERENCE in $NSO_INFO/ns1:CTR_REFERENCE
                            return
                                <ns0:CTR_REFERENCE>{ xs:decimal(data($CTR_REFERENCE)) }</ns0:CTR_REFERENCE>
                       }
		            </ns0:PR_NSO_INFO>
         }
        </ns0:InputParameters>
};

declare variable $transacionId as xs:string external;
declare variable $creditCardWithdrawal as element(ns2:creditCardWithdrawal) external;

xf:reversa($transacionId,
    $creditCardWithdrawal)
