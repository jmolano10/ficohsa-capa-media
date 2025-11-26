(:: pragma bea:global-element-parameter parameter="$cashTransfer" element="ns2:cashTransfer" location="../../xsd/BranchCashMgmtTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/AbanksGT/TransferenciaEfectivo/xsd/MCEnvioEfectivo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSGT/MGC_K_ADMINISTRACION_EFECTIVO/MC_ENVIO_EFECTIVO/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/branchCashMgmtTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BranchCashMgmt/CashTransfer/mcEnvioEfectivoGTIn/";

declare function xf:mcEnvioEfectivoGTIn($cashTransfer as element(ns2:cashTransfer))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                let $OTHER_PARTY := $cashTransfer/ns2:OTHER_PARTY
                return
                    <ns0:PR_OTHER_PARTY>
                        <ns0:TYPE>{ data($OTHER_PARTY/ns1:TYPE) }</ns0:TYPE>
                        {
                            for $ID in $OTHER_PARTY/ns1:ID
                            return
                                <ns0:ID>{ xs:decimal(data($ID)) }</ns0:ID>
                        }
                    </ns0:PR_OTHER_PARTY>
            }
            {
                let $PAYMENT := $cashTransfer/ns2:PAYMENT
                return
                    <ns0:PR_PAYMENT>
                        <ns0:PAY_ITEM>
                            {
                                for $PAY_ITEM in $PAYMENT/ns1:PAY_ITEM
                                return
                                    <ns0:PAY_ITEM_ITEM>
                                        <ns0:TYPE>{ xs:string(data($PAY_ITEM/ns1:TYPE)) }</ns0:TYPE>
                                        <ns0:CURRENCY>{ data($PAY_ITEM/ns1:CURRENCY) }</ns0:CURRENCY>
                                        {
                                            for $AMOUNT in $PAY_ITEM/ns1:AMOUNT
                                            return
                                                <ns0:AMOUNT>{ data($AMOUNT) }</ns0:AMOUNT>
                                        }
                                        {
                                            for $MORE_INFO in $PAY_ITEM/ns1:MORE_INFO
                                            return
                                                <ns0:MORE_INFO>
                                                    {
                                                        for $ACCOUNT in $MORE_INFO/ns1:ACCOUNT
                                                        return
                                                            <ns0:ACCOUNT_VNUMBER>{ xs:decimal(data($ACCOUNT/ns1:NUMBER)) }</ns0:ACCOUNT_VNUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK
                                                        return
                                                            <ns0:CHECK_CHECK_NUMBER>{ xs:decimal(data($CHECK/ns1:CHECK_NUMBER)) }</ns0:CHECK_CHECK_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $ACCOUNT_NUMBER in $CHECK/ns1:ACCOUNT_NUMBER
                                                        return
                                                            <ns0:CHECK_ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns0:CHECK_ACCOUNT_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $BANK_CODE in $CHECK/ns1:BANK_CODE
                                                        return
                                                            <ns0:CHECK_BANK_CODE>{ data($BANK_CODE) }</ns0:CHECK_BANK_CODE>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $BANK_DESCRIPTION in $CHECK/ns1:BANK_DESCRIPTION
                                                        return
                                                            <ns0:CHECK_BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns0:CHECK_BANK_DESCRIPTION>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD,
                                                            $CARD_NUMBER in $CREDIT_CARD/ns1:CARD_NUMBER
                                                        return
                                                            <ns0:CREDIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns0:CREDIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD
                                                        return
                                                            <ns0:CREDIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($CREDIT_CARD/ns1:EXPIRATION_DATE)) }</ns0:CREDIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD
                                                        return
                                                            <ns0:CREDIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($CREDIT_CARD/ns1:VERIFICATION_CODE)) }</ns0:CREDIT_CARD_VERIFICATION_CODE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD,
                                                            $CARD_NUMBER in $DEBIT_CARD/ns1:CARD_NUMBER
                                                        return
                                                            <ns0:DEBIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns0:DEBIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD
                                                        return
                                                            <ns0:DEBIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($DEBIT_CARD/ns1:EXPIRATION_DATE)) }</ns0:DEBIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD
                                                        return
                                                            <ns0:DEBIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($DEBIT_CARD/ns1:VERIFICATION_CODE)) }</ns0:DEBIT_CARD_VERIFICATION_CODE>
                                                    }
                                                </ns0:MORE_INFO>
                                        }
                                    </ns0:PAY_ITEM_ITEM>
                            }
                        </ns0:PAY_ITEM>
                    </ns0:PR_PAYMENT>
            }
            {
                let $NSO_INFO := $cashTransfer/ns2:NSO_INFO
                return
                    <ns0:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns1:TRACE
                            return
                                <ns0:TRACE>
                                    <ns0:TELLER_ID>{ xs:decimal(data($TRACE/ns1:TELLER_ID)) }</ns0:TELLER_ID>
                                    <ns0:BRANCH_ID>{ xs:decimal(data($TRACE/ns1:BRANCH_ID)) }</ns0:BRANCH_ID>
                                    <ns0:CHANNEL_CODE>{ xs:decimal(data($TRACE/ns1:CHANNEL_CODE)) }</ns0:CHANNEL_CODE>
                                    <ns0:DATE_TIME>{ data($TRACE/ns1:DATE_TIME) }</ns0:DATE_TIME>
                                    {
                                        for $QUEUE_TICKET_ID in $TRACE/ns1:QUEUE_TICKET_ID
                                        return
                                            <ns0:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns0:QUEUE_TICKET_ID>
                                    }
                                    {
                                        for $TXN_REF_NO in $TRACE/ns1:TXN_REF_NO
                                        return
                                            <ns0:TXN_REF_NO>{ data($TXN_REF_NO) }</ns0:TXN_REF_NO>
                                    }
                                    {
                                        for $DEALSLIP_ID in $TRACE/ns1:DEALSLIP_ID
                                        return
                                            <ns0:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns0:DEALSLIP_ID>
                                    }
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

declare variable $cashTransfer as element(ns2:cashTransfer) external;

xf:mcEnvioEfectivoGTIn($cashTransfer)
