(:: pragma bea:global-element-parameter parameter="$billPayment" element="ns1:billPayment" location="../../xsd/BillOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/AbanksGT/ReversionTXN/xsd/MCReversionTXN_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCReversionTXN";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/billOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillPayment/xq/mcReversionTXNIn/";

declare function xf:mcReversionTXNIn($billPayment as element(ns1:billPayment),
    $transactionId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TRANSACTION_ID>{ data($transactionId) }</ns0:PV_TRANSACTION_ID>
            <ns0:PR_NSO_INFO>
                <ns0:TRACE>
                    <ns0:TELLER_ID>{ data($billPayment/ns1:NSO_INFO/ns2:TRACE/ns2:TELLER_ID) }</ns0:TELLER_ID>
                    <ns0:BRANCH_ID>{ data($billPayment/ns1:NSO_INFO/ns2:TRACE/ns2:BRANCH_ID) }</ns0:BRANCH_ID>
                    <ns0:CHANNEL_CODE>{ data($billPayment/ns1:NSO_INFO/ns2:TRACE/ns2:CHANNEL_CODE) }</ns0:CHANNEL_CODE>
                    <ns0:DATE_TIME>{ fn:current-dateTime() }</ns0:DATE_TIME>
                    <ns0:QUEUE_TICKET_ID>{ data($billPayment/ns1:NSO_INFO/ns2:TRACE/ns2:QUEUE_TICKET_ID) }</ns0:QUEUE_TICKET_ID>
                    <ns0:TXN_REF_NO>{ data($billPayment/ns1:NSO_INFO/ns2:TRACE/ns2:TXN_REF_NO) }</ns0:TXN_REF_NO>
                    <ns0:DEALSLIP_ID>{ data($billPayment/ns1:NSO_INFO/ns2:TRACE/ns2:DEALSLIP_ID) }</ns0:DEALSLIP_ID>
                </ns0:TRACE>
                <ns0:AUTHORIZATION>
                    <ns0:TYPE>{ data($billPayment/ns1:NSO_INFO/ns2:AUTHORIZATION/ns2:TYPE) }</ns0:TYPE>
                    <ns0:KV_PAIRS>
                        <ns0:PAIR>
                          {
                             for $pairItem in $billPayment/ns1:NSO_INFO/ns2:AUTHORIZATION/ns2:KV_PAIRS/ns2:PAIR
                             return
                            <ns0:PAIR_ITEM>
                                <ns0:KEY>{ data($pairItem/ns2:KEY) }</ns0:KEY>
                                <ns0:VALUE>{ data($pairItem/ns2:VALUE) }</ns0:VALUE>
                            </ns0:PAIR_ITEM>
                          }
                        </ns0:PAIR>
                    </ns0:KV_PAIRS>
                </ns0:AUTHORIZATION>
                <ns0:BANKNOTE_BREAKDOWN>
                    <ns0:BANKNOTE>
                      {
                         for $bankNoteItem in $billPayment/ns1:NSO_INFO/ns2:BANKNOTE_BREAKDOWN/ns2:BANKNOTE
                          return
                        <ns0:BANKNOTE_ITEM>
                            <ns0:CURRENCY>{ data($bankNoteItem/ns2:CURRENCY) }</ns0:CURRENCY>
                            <ns0:BANKNOTE_VALUE>{ data($bankNoteItem/ns2:VALUE) }</ns0:BANKNOTE_VALUE>
                            <ns0:QUANTITY>{ data($bankNoteItem/ns2:QUANTITY) }</ns0:QUANTITY>
                            <ns0:TOTAL>{ data($bankNoteItem/ns2:TOTAL) }</ns0:TOTAL>
                        </ns0:BANKNOTE_ITEM>
                      }
                    </ns0:BANKNOTE>
                </ns0:BANKNOTE_BREAKDOWN>
                <ns0:ADDITIONAL_INFO>
                    <ns0:KV_PAIRS>
                      {
                         for $pairs in $billPayment/ns1:NSO_INFO/ns2:ADDITIONAL_INFO/ns2:KV_PAIRS/ns2:PAIR
                         return
                        <ns0:PAIR_ITEM>
                            <ns0:KEY>{ data($pairs/ns2:KEY) }</ns0:KEY>
                            <ns0:VALUE>{ data($pairs/ns2:VALUE) }</ns0:VALUE>
                        </ns0:PAIR_ITEM>
                      } 
                    </ns0:KV_PAIRS>
                </ns0:ADDITIONAL_INFO>
                <ns0:CTR_REFERENCE>{ data($billPayment/ns1:NSO_INFO/ns2:CTR_REFERENCE) }</ns0:CTR_REFERENCE>
            </ns0:PR_NSO_INFO>
        </ns0:InputParameters>
};

declare variable $billPayment as element(ns1:billPayment) external;
declare variable $transactionId as xs:string external;

xf:mcReversionTXNIn($billPayment,
    $transactionId)