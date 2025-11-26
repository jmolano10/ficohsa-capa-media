(:: pragma bea:global-element-parameter parameter="$cashRequest" element="ns2:cashRequest" location="../../xsd/BranchCashMgmtTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../BusinessServices/AbanksGT/SolicitudEfectivo/xsd/MCSolicitudEfectivo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/branchCashMgmtTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCSolicitudEfectivo";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BranchCashMgmt/CashRequest/xq/mcSolicitudEfectivoGTInGTInGTIn/";

declare function xf:mcSolicitudEfectivoGTInGTIn($cashRequest as element(ns2:cashRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                let $OTHER_PARTY := $cashRequest/ns2:OTHER_PARTY
                return
                    <ns1:PR_OTHER_PARTY>
                        <ns1:TYPE>{ data($OTHER_PARTY/ns0:TYPE) }</ns1:TYPE>
                        {
                        	for $ID in $OTHER_PARTY/ns0:ID
                        	return
                        		<ns1:ID>{ data($ID) }</ns1:ID>		 		
                        }
                        
                    </ns1:PR_OTHER_PARTY>
            }
            {
                let $PAYMENT := $cashRequest/ns2:PAYMENT
                return
                    <ns1:PR_PAYMENT>
                        <ns1:PAY_ITEM>
                            {
                                for $PAY_ITEM in $PAYMENT/ns0:PAY_ITEM
                                return
                                    <ns1:PAY_ITEM_ITEM>
                                        <ns1:TYPE>{ data($PAY_ITEM/ns0:TYPE) }</ns1:TYPE>
                                        <ns1:CURRENCY>{ data($PAY_ITEM/ns0:CURRENCY) }</ns1:CURRENCY>
                                        {
                                            for $AMOUNT in $PAY_ITEM/ns0:AMOUNT
                                            return
                                                <ns1:AMOUNT>{ data($AMOUNT) }</ns1:AMOUNT>
                                        }
                                        {
                                            for $MORE_INFO in $PAY_ITEM/ns0:MORE_INFO
                                            return
                                                <ns1:MORE_INFO>
                                                    {
                                                        for $ACCOUNT in $MORE_INFO/ns0:ACCOUNT
                                                        return
                                                            <ns1:ACCOUNT_VNUMBER>{ xs:decimal(data($ACCOUNT/ns0:NUMBER)) }</ns1:ACCOUNT_VNUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK
                                                        return
                                                            <ns1:CHECK_CHECK_NUMBER>{ data($CHECK/ns0:CHECK_NUMBER) }</ns1:CHECK_CHECK_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK,
                                                            $ACCOUNT_NUMBER in $CHECK/ns0:ACCOUNT_NUMBER
                                                        return
                                                            <ns1:CHECK_ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns1:CHECK_ACCOUNT_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK,
                                                            $BANK_CODE in $CHECK/ns0:BANK_CODE
                                                        return
                                                            <ns1:CHECK_BANK_CODE>{ data($BANK_CODE) }</ns1:CHECK_BANK_CODE>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK,
                                                            $BANK_DESCRIPTION in $CHECK/ns0:BANK_DESCRIPTION
                                                        return
                                                            <ns1:CHECK_BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns1:CHECK_BANK_DESCRIPTION>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD,
                                                            $CARD_NUMBER in $CREDIT_CARD/ns0:CARD_NUMBER
                                                        return
                                                            <ns1:CREDIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns1:CREDIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD
                                                        return
                                                            <ns1:CREDIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($CREDIT_CARD/ns0:EXPIRATION_DATE)) }</ns1:CREDIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD
                                                        return
                                                            <ns1:CREDIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($CREDIT_CARD/ns0:VERIFICATION_CODE)) }</ns1:CREDIT_CARD_VERIFICATION_CODE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD,
                                                            $CARD_NUMBER in $DEBIT_CARD/ns0:CARD_NUMBER
                                                        return
                                                            <ns1:DEBIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns1:DEBIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD
                                                        return
                                                            <ns1:DEBIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($DEBIT_CARD/ns0:EXPIRATION_DATE)) }</ns1:DEBIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD
                                                        return
                                                            <ns1:DEBIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($DEBIT_CARD/ns0:VERIFICATION_CODE)) }</ns1:DEBIT_CARD_VERIFICATION_CODE>
                                                    }
                                                </ns1:MORE_INFO>
                                        }
                                    </ns1:PAY_ITEM_ITEM>
                            }
                        </ns1:PAY_ITEM>
                    </ns1:PR_PAYMENT>
            }
            {
                let $NSO_INFO := $cashRequest/ns2:NSO_INFO
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

declare variable $cashRequest as element(ns2:cashRequest) external;

xf:mcSolicitudEfectivoGTInGTIn($cashRequest)
