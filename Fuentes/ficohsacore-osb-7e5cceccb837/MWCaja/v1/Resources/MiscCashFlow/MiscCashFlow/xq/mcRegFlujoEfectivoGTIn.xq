(:: pragma bea:global-element-parameter parameter="$miscCashFlow" element="ns0:miscCashFlow" location="../../xsd/MiscCashFlowTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../BusinessServices/AbanksGT/RegFlujoEfectivo/xsd/MCRegFlujoEfectivo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/miscCashFlowTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCRegFlujoEfectivo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/MiscCashFlow/MiscCashFlow/xq/mcRegFlujoEfectivoGTIn/";

declare function xf:mcRegFlujoEfectivoGTIn($miscCashFlow as element(ns0:miscCashFlow))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_DIRECTION>{ data($miscCashFlow/ns0:DIRECTION) }</ns2:PV_DIRECTION>
            <ns2:PN_TXN_ID>{ data($miscCashFlow/ns0:TXN_ID) }</ns2:PN_TXN_ID>
            {
                for $REFERENCES in $miscCashFlow/ns0:REFERENCES
                return
                    <ns2:PR_REFERENCES>
                        <ns2:REF_PAIR>
                            {
                                for $PAIR in $REFERENCES/ns1:PAIR
                                return
                                    <ns2:REF_PAIR_ITEM>
                                        <ns2:KEY>{ data($PAIR/ns1:KEY) }</ns2:KEY>
                                        <ns2:VALUE>{ data($PAIR/ns1:VALUE) }</ns2:VALUE>
                                    </ns2:REF_PAIR_ITEM>
                            }
                        </ns2:REF_PAIR>
                    </ns2:PR_REFERENCES>
            }
            {
                let $PAYMENT := $miscCashFlow/ns0:PAYMENT
                return
                    <ns2:PR_PAYMENT>
                        <ns2:PAY_ITEM>
                            {
                                for $PAY_ITEM in $PAYMENT/ns1:PAY_ITEM
                                return
                                    <ns2:PAY_ITEM_ITEM>
                                        <ns2:TYPE>{ data($PAY_ITEM/ns1:TYPE) }</ns2:TYPE>
                                        <ns2:CURRENCY>{ data($PAY_ITEM/ns1:CURRENCY) }</ns2:CURRENCY>
                                        {
                                            for $AMOUNT in $PAY_ITEM/ns1:AMOUNT
                                            return
                                                <ns2:AMOUNT>{ data($AMOUNT) }</ns2:AMOUNT>
                                        }
                                        {
                                            for $MORE_INFO in $PAY_ITEM/ns1:MORE_INFO
                                            return
                                                <ns2:MORE_INFO>
                                                    {
                                                        for $ACCOUNT in $MORE_INFO/ns1:ACCOUNT
                                                        return
                                                            <ns2:ACCOUNT_VNUMBER>{ xs:decimal(data($ACCOUNT/ns1:NUMBER)) }</ns2:ACCOUNT_VNUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK
                                                        return
                                                            <ns2:CHECK_CHECK_NUMBER>{ data($CHECK/ns1:CHECK_NUMBER) }</ns2:CHECK_CHECK_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $ACCOUNT_NUMBER in $CHECK/ns1:ACCOUNT_NUMBER
                                                        return
                                                            <ns2:CHECK_ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns2:CHECK_ACCOUNT_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $BANK_CODE in $CHECK/ns1:BANK_CODE
                                                        return
                                                            <ns2:CHECK_BANK_CODE>{ data($BANK_CODE) }</ns2:CHECK_BANK_CODE>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $BANK_DESCRIPTION in $CHECK/ns1:BANK_DESCRIPTION
                                                        return
                                                            <ns2:CHECK_BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns2:CHECK_BANK_DESCRIPTION>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD,
                                                            $CARD_NUMBER in $CREDIT_CARD/ns1:CARD_NUMBER
                                                        return
                                                            <ns2:CREDIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns2:CREDIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD
                                                        return
                                                            <ns2:CREDIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($CREDIT_CARD/ns1:EXPIRATION_DATE)) }</ns2:CREDIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD
                                                        return
                                                            <ns2:CREDIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($CREDIT_CARD/ns1:VERIFICATION_CODE)) }</ns2:CREDIT_CARD_VERIFICATION_CODE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD,
                                                            $CARD_NUMBER in $DEBIT_CARD/ns1:CARD_NUMBER
                                                        return
                                                            <ns2:DEBIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns2:DEBIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD
                                                        return
                                                            <ns2:DEBIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($DEBIT_CARD/ns1:EXPIRATION_DATE)) }</ns2:DEBIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD
                                                        return
                                                            <ns2:DEBIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($DEBIT_CARD/ns1:VERIFICATION_CODE)) }</ns2:DEBIT_CARD_VERIFICATION_CODE>
                                                    }
                                                </ns2:MORE_INFO>
                                        }
                                    </ns2:PAY_ITEM_ITEM>
                            }
                        </ns2:PAY_ITEM>
                    </ns2:PR_PAYMENT>
            }
            {
                let $NSO_INFO := $miscCashFlow/ns0:NSO_INFO
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
                                                            <ns2:KEY>{ data($PAIR/ns1:KEY) }</ns2:KEY>
                                                            <ns2:VALUE>{ data($PAIR/ns1:VALUE) }</ns2:VALUE>
                                                        </ns2:PAIR_ITEM>
                                                }
                                            </ns2:KV_PAIRS>
                                    }
                                </ns2:ADDITIONAL_INFO>
                        }
                        <ns2:CTR_REFERENCE>{ data($NSO_INFO/ns1:CTR_REFERENCE) }</ns2:CTR_REFERENCE>
                    </ns2:PR_NSO_INFO>
            }
        </ns2:InputParameters>
};

declare variable $miscCashFlow as element(ns0:miscCashFlow) external;

xf:mcRegFlujoEfectivoGTIn($miscCashFlow)
