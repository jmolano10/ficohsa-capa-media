(:: pragma bea:global-element-parameter parameter="$negotiationEnactment" element="ns1:negotiationEnactment" location="../../xsd/ForeignExchangeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../BusinessServices/AbanksGT/ProcesamientoNegociacion/xsd/MCProcNegociacionFX_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCProcNegociacionFX";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/foreignExchangeTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/ForeignExchange/NegotiationEnactment/xq/mcProcNegociacionFXGTIn/";

declare function xf:mcProcNegociacionFXGTIn($negotiationEnactment as element(ns1:negotiationEnactment))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_FOREX_TYPE>{ data($negotiationEnactment/ns1:FOREX_TYPE) }</ns2:PV_FOREX_TYPE>
            <ns2:PV_NEGOTIATION_ID>{ data($negotiationEnactment/ns1:NEGOTIATION_ID) }</ns2:PV_NEGOTIATION_ID>
            {
                let $SOURCE_PAYMENT := $negotiationEnactment/ns1:SOURCE_PAYMENT
                return
                    <ns2:PR_SOURCE_PAYMENT>
                        <ns2:PAY_ITEM>
                            {
                                for $PAY_ITEM in $SOURCE_PAYMENT/ns0:PAY_ITEM
                                return
                                    <ns2:PAY_ITEM_ITEM>
                                        <ns2:TYPE>{ data($PAY_ITEM/ns0:TYPE) }</ns2:TYPE>
                                        <ns2:CURRENCY>{ data($PAY_ITEM/ns0:CURRENCY) }</ns2:CURRENCY>
                                        {
                                            for $AMOUNT in $PAY_ITEM/ns0:AMOUNT
                                            return
                                                <ns2:AMOUNT>{ data($AMOUNT) }</ns2:AMOUNT>
                                        }
                                        {
                                            for $MORE_INFO in $PAY_ITEM/ns0:MORE_INFO
                                            return
                                                <ns2:MORE_INFO>
                                                    {
                                                        for $ACCOUNT in $MORE_INFO/ns0:ACCOUNT
                                                        return
                                                            <ns2:ACCOUNT_VNUMBER>{ xs:decimal(data($ACCOUNT/ns0:NUMBER)) }</ns2:ACCOUNT_VNUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK
                                                        return
                                                            <ns2:CHECK_CHECK_NUMBER>{ data($CHECK/ns0:CHECK_NUMBER) }</ns2:CHECK_CHECK_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK,
                                                            $ACCOUNT_NUMBER in $CHECK/ns0:ACCOUNT_NUMBER
                                                        return
                                                            <ns2:CHECK_ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns2:CHECK_ACCOUNT_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK,
                                                            $BANK_CODE in $CHECK/ns0:BANK_CODE
                                                        return
                                                            <ns2:CHECK_BANK_CODE>{ data($BANK_CODE) }</ns2:CHECK_BANK_CODE>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK,
                                                            $BANK_DESCRIPTION in $CHECK/ns0:BANK_DESCRIPTION
                                                        return
                                                            <ns2:CHECK_BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns2:CHECK_BANK_DESCRIPTION>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD,
                                                            $CARD_NUMBER in $CREDIT_CARD/ns0:CARD_NUMBER
                                                        return
                                                            <ns2:CREDIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns2:CREDIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD
                                                        return
                                                            <ns2:CREDIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($CREDIT_CARD/ns0:EXPIRATION_DATE)) }</ns2:CREDIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD
                                                        return
                                                            <ns2:CREDIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($CREDIT_CARD/ns0:VERIFICATION_CODE)) }</ns2:CREDIT_CARD_VERIFICATION_CODE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD,
                                                            $CARD_NUMBER in $DEBIT_CARD/ns0:CARD_NUMBER
                                                        return
                                                            <ns2:DEBIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns2:DEBIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD
                                                        return
                                                            <ns2:DEBIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($DEBIT_CARD/ns0:EXPIRATION_DATE)) }</ns2:DEBIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD
                                                        return
                                                            <ns2:DEBIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($DEBIT_CARD/ns0:VERIFICATION_CODE)) }</ns2:DEBIT_CARD_VERIFICATION_CODE>
                                                    }
                                                </ns2:MORE_INFO>
                                        }
                                    </ns2:PAY_ITEM_ITEM>
                            }
                        </ns2:PAY_ITEM>
                    </ns2:PR_SOURCE_PAYMENT>
            }
            {
                let $TARGET_PAYMENT := $negotiationEnactment/ns1:TARGET_PAYMENT
                return
                    <ns2:PR_TARGET_PAYMENT>
                        <ns2:PAY_ITEM>
                            {
                                for $PAY_ITEM in $TARGET_PAYMENT/ns0:PAY_ITEM
                                return
                                    <ns2:PAY_ITEM_ITEM>
                                        <ns2:TYPE>{ data($PAY_ITEM/ns0:TYPE) }</ns2:TYPE>
                                        <ns2:CURRENCY>{ data($PAY_ITEM/ns0:CURRENCY) }</ns2:CURRENCY>
                                        {
                                            for $AMOUNT in $PAY_ITEM/ns0:AMOUNT
                                            return
                                                <ns2:AMOUNT>{ data($AMOUNT) }</ns2:AMOUNT>
                                        }
                                        {
                                            for $MORE_INFO in $PAY_ITEM/ns0:MORE_INFO
                                            return
                                                <ns2:MORE_INFO>
                                                    {
                                                        for $ACCOUNT in $MORE_INFO/ns0:ACCOUNT
                                                        return
                                                            <ns2:ACCOUNT_VNUMBER>{ xs:decimal(data($ACCOUNT/ns0:NUMBER)) }</ns2:ACCOUNT_VNUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK
                                                        return
                                                            <ns2:CHECK_CHECK_NUMBER>{ data($CHECK/ns0:CHECK_NUMBER) }</ns2:CHECK_CHECK_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK,
                                                            $ACCOUNT_NUMBER in $CHECK/ns0:ACCOUNT_NUMBER
                                                        return
                                                            <ns2:CHECK_ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns2:CHECK_ACCOUNT_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK,
                                                            $BANK_CODE in $CHECK/ns0:BANK_CODE
                                                        return
                                                            <ns2:CHECK_BANK_CODE>{ data($BANK_CODE) }</ns2:CHECK_BANK_CODE>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns0:CHECK,
                                                            $BANK_DESCRIPTION in $CHECK/ns0:BANK_DESCRIPTION
                                                        return
                                                            <ns2:CHECK_BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns2:CHECK_BANK_DESCRIPTION>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD,
                                                            $CARD_NUMBER in $CREDIT_CARD/ns0:CARD_NUMBER
                                                        return
                                                            <ns2:CREDIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns2:CREDIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD
                                                        return
                                                            <ns2:CREDIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($CREDIT_CARD/ns0:EXPIRATION_DATE)) }</ns2:CREDIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns0:CREDIT_CARD
                                                        return
                                                            <ns2:CREDIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($CREDIT_CARD/ns0:VERIFICATION_CODE)) }</ns2:CREDIT_CARD_VERIFICATION_CODE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD,
                                                            $CARD_NUMBER in $DEBIT_CARD/ns0:CARD_NUMBER
                                                        return
                                                            <ns2:DEBIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns2:DEBIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD
                                                        return
                                                            <ns2:DEBIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($DEBIT_CARD/ns0:EXPIRATION_DATE)) }</ns2:DEBIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns0:DEBIT_CARD
                                                        return
                                                            <ns2:DEBIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($DEBIT_CARD/ns0:VERIFICATION_CODE)) }</ns2:DEBIT_CARD_VERIFICATION_CODE>
                                                    }
                                                </ns2:MORE_INFO>
                                        }
                                    </ns2:PAY_ITEM_ITEM>
                            }
                        </ns2:PAY_ITEM>
                    </ns2:PR_TARGET_PAYMENT>
            }
            {
                let $NSO_INFO := $negotiationEnactment/ns1:NSO_INFO
                return
                    <ns2:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns0:TRACE
                            return
                                <ns2:TRACE>
                                    <ns2:TELLER_ID>{ data($TRACE/ns0:TELLER_ID) }</ns2:TELLER_ID>
                                    <ns2:BRANCH_ID>{ data($TRACE/ns0:BRANCH_ID) }</ns2:BRANCH_ID>
                                    <ns2:CHANNEL_CODE>{ data($TRACE/ns0:CHANNEL_CODE) }</ns2:CHANNEL_CODE>
                                    <ns2:DATE_TIME>{ data($TRACE/ns0:DATE_TIME) }</ns2:DATE_TIME>
                                    {
                                        for $QUEUE_TICKET_ID in $TRACE/ns0:QUEUE_TICKET_ID
                                        return
                                            <ns2:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns2:QUEUE_TICKET_ID>
                                    }
                                    {
                                        for $TXN_REF_NO in $TRACE/ns0:TXN_REF_NO
                                        return
                                            <ns2:TXN_REF_NO>{ data($TXN_REF_NO) }</ns2:TXN_REF_NO>
                                    }
                                    {
                                        for $DEALSLIP_ID in $TRACE/ns0:DEALSLIP_ID
                                        return
                                            <ns2:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns2:DEALSLIP_ID>
                                    }
                                </ns2:TRACE>
                        }
                        {
                            for $AUTHORIZATION in $NSO_INFO/ns0:AUTHORIZATION
                            return
                                <ns2:AUTHORIZATION>
                                    <ns2:TYPE>{ data($AUTHORIZATION/ns0:TYPE) }</ns2:TYPE>
                                    {
                                        for $KV_PAIRS in $AUTHORIZATION/ns0:KV_PAIRS
                                        return
                                            <ns2:KV_PAIRS>
                                                <ns2:PAIR>
                                                    {
                                                        for $PAIR in $KV_PAIRS/ns0:PAIR
                                                        return
                                                            <ns2:PAIR_ITEM>
                                                                <ns2:KEY>{ data($PAIR/ns0:KEY) }</ns2:KEY>
                                                                <ns2:VALUE>{ data($PAIR/ns0:VALUE) }</ns2:VALUE>
                                                            </ns2:PAIR_ITEM>
                                                    }
                                                </ns2:PAIR>
                                            </ns2:KV_PAIRS>
                                    }
                                </ns2:AUTHORIZATION>
                        }
                        {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns0:BANKNOTE_BREAKDOWN
                            return
                                <ns2:BANKNOTE_BREAKDOWN>
                                    <ns2:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns0:BANKNOTE
                                            return
                                                <ns2:BANKNOTE_ITEM>
                                                    <ns2:CURRENCY>{ data($BANKNOTE/ns0:CURRENCY) }</ns2:CURRENCY>
                                                    <ns2:BANKNOTE_VALUE>{ data($BANKNOTE/ns0:VALUE) }</ns2:BANKNOTE_VALUE>
                                                    <ns2:QUANTITY>{ data($BANKNOTE/ns0:QUANTITY) }</ns2:QUANTITY>
                                                    <ns2:TOTAL>{ data($BANKNOTE/ns0:TOTAL) }</ns2:TOTAL>
                                                </ns2:BANKNOTE_ITEM>
                                        }
                                    </ns2:BANKNOTE>
                                </ns2:BANKNOTE_BREAKDOWN>
                        }
                        {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns0:ADDITIONAL_INFO
                            return
                                <ns2:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns0:KV_PAIRS
                                        return
                                            <ns2:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns0:PAIR
                                                    return
                                                        <ns2:PAIR_ITEM>
                                                            <ns2:KEY>{ data($PAIR/ns0:KEY) }</ns2:KEY>
                                                            <ns2:VALUE>{ data($PAIR/ns0:VALUE) }</ns2:VALUE>
                                                        </ns2:PAIR_ITEM>
                                                }
                                            </ns2:KV_PAIRS>
                                    }
                                </ns2:ADDITIONAL_INFO>
                        }
                        {
                        	for $CTR_REFERENCE in $NSO_INFO/ns0:CTR_REFERENCE
                        	return
                        		<ns2:CTR_REFERENCE>{ data($CTR_REFERENCE) }</ns2:CTR_REFERENCE>	
                        }
                        
                    </ns2:PR_NSO_INFO>
            }
        </ns2:InputParameters>
};

declare variable $negotiationEnactment as element(ns1:negotiationEnactment) external;

xf:mcProcNegociacionFXGTIn($negotiationEnactment)
