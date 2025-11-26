(:: pragma bea:global-element-parameter parameter="$passbookBalanceConfirmation" element="ns1:passbookBalanceConfirmation" location="../../xsd/AccountPassbookOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns3:InputParameters" location="../../../../BusinessServices/AbanksGT/CONFSaldoLibreta/xsd/MCCONFSaldoLibreta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/accountTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/accountPassbookOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/AccountPassbookOperations/PassbookBalanceConfirmation/xq/mcCONFSaldoLibretaGTIn/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCCONFSaldoLibreta";

declare function xf:mcCONFSaldoLibretaGTIn($passbookBalanceConfirmation as element(ns1:passbookBalanceConfirmation))
    as element(ns3:InputParameters) {
        <ns3:InputParameters>
            <ns3:PV_ACCOUNT_NUMBER>{ data($passbookBalanceConfirmation/ns1:ACCOUNT_NUMBER) }</ns3:PV_ACCOUNT_NUMBER>
            {
                for $PASSBOOK in $passbookBalanceConfirmation/ns1:PASSBOOK
                where data($PASSBOOK/ns2:BALANCE) = data($PASSBOOK/ns2:BALANCE)
                return
                    <ns3:PR_PASSBOOK>
                        <ns3:ID>{ xs:decimal(data($PASSBOOK/ns2:ID)) }</ns3:ID>
                        {
                            for $LINE_NUMBER in $PASSBOOK/ns2:LINE_NUMBER
                            return
                                <ns3:LINE_NUMBER>{ xs:decimal(data($LINE_NUMBER)) }</ns3:LINE_NUMBER>
                        }
                        <ns3:BALANCE>{ data($PASSBOOK/ns2:BALANCE) }</ns3:BALANCE>
                    </ns3:PR_PASSBOOK>
            }
            {
                let $NSO_INFO := $passbookBalanceConfirmation/ns1:NSO_INFO
                return
                    <ns3:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns0:TRACE
                            return
                                <ns3:TRACE>
                                    <ns3:TELLER_ID>{ xs:decimal(data($TRACE/ns0:TELLER_ID)) }</ns3:TELLER_ID>
                                    <ns3:BRANCH_ID>{ xs:decimal(data($TRACE/ns0:BRANCH_ID)) }</ns3:BRANCH_ID>
                                    <ns3:CHANNEL_CODE>{ xs:decimal(data($TRACE/ns0:CHANNEL_CODE)) }</ns3:CHANNEL_CODE>
                                    <ns3:DATE_TIME>{ data($TRACE/ns0:DATE_TIME) }</ns3:DATE_TIME>
                                    {
                                        for $QUEUE_TICKET_ID in $TRACE/ns0:QUEUE_TICKET_ID
                                        return
                                            <ns3:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns3:QUEUE_TICKET_ID>
                                    }
                                    {
                                        for $TXN_REF_NO in $TRACE/ns0:TXN_REF_NO
                                        return
                                            <ns3:TXN_REF_NO>{ data($TXN_REF_NO) }</ns3:TXN_REF_NO>
                                    }
                                    {
                                        for $DEALSLIP_ID in $TRACE/ns0:DEALSLIP_ID
                                        return
                                            <ns3:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns3:DEALSLIP_ID>
                                    }
                                </ns3:TRACE>
                        }
                        {
                            for $AUTHORIZATION in $NSO_INFO/ns0:AUTHORIZATION
                            return
                                <ns3:AUTHORIZATION>
                                    <ns3:TYPE>{ data($AUTHORIZATION/ns0:TYPE) }</ns3:TYPE>
                                    {
                                        for $KV_PAIRS in $AUTHORIZATION/ns0:KV_PAIRS
                                        return
                                            <ns3:KV_PAIRS>
                                                <ns3:PAIR>
                                                    {
                                                        for $PAIR in $KV_PAIRS/ns0:PAIR
                                                        return
                                                            <ns3:PAIR_ITEM>
                                                                <ns3:KEY>{ data($PAIR/ns0:KEY) }</ns3:KEY>
                                                                <ns3:VALUE>{ data($PAIR/ns0:VALUE) }</ns3:VALUE>
                                                            </ns3:PAIR_ITEM>
                                                    }
                                                </ns3:PAIR>
                                            </ns3:KV_PAIRS>
                                    }
                                </ns3:AUTHORIZATION>
                        }
                        {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns0:BANKNOTE_BREAKDOWN
                            return
                                <ns3:BANKNOTE_BREAKDOWN>
                                    <ns3:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns0:BANKNOTE
                                            return
                                                <ns3:BANKNOTE_ITEM>
                                                    <ns3:CURRENCY>{ data($BANKNOTE/ns0:CURRENCY) }</ns3:CURRENCY>
                                                    <ns3:BANKNOTE_VALUE>{ data($BANKNOTE/ns0:VALUE) }</ns3:BANKNOTE_VALUE>
                                                    <ns3:QUANTITY>{ xs:decimal(data($BANKNOTE/ns0:QUANTITY)) }</ns3:QUANTITY>
                                                    <ns3:TOTAL>{ data($BANKNOTE/ns0:TOTAL) }</ns3:TOTAL>
                                                </ns3:BANKNOTE_ITEM>
                                        }
                                    </ns3:BANKNOTE>
                                </ns3:BANKNOTE_BREAKDOWN>
                        }
                        {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns0:ADDITIONAL_INFO
                            return
                                <ns3:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns0:KV_PAIRS
                                        return
                                            <ns3:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns0:PAIR
                                                    return
                                                        <ns3:PAIR_ITEM>
                                                            <ns3:KEY>{ data($PAIR/ns0:KEY) }</ns3:KEY>
                                                            <ns3:VALUE>{ data($PAIR/ns0:VALUE) }</ns3:VALUE>
                                                        </ns3:PAIR_ITEM>
                                                }
                                            </ns3:KV_PAIRS>
                                    }
                                </ns3:ADDITIONAL_INFO>
                        }
                        {
                        	for $CTR_REFERENCE in $NSO_INFO/ns0:CTR_REFERENCE
                        	return
                        		<ns3:CTR_REFERENCE>{ xs:decimal(data($CTR_REFERENCE)) }</ns3:CTR_REFERENCE>
                        }
                    </ns3:PR_NSO_INFO>
            }
        </ns3:InputParameters>
};

declare variable $passbookBalanceConfirmation as element(ns1:passbookBalanceConfirmation) external;

xf:mcCONFSaldoLibretaGTIn($passbookBalanceConfirmation)
