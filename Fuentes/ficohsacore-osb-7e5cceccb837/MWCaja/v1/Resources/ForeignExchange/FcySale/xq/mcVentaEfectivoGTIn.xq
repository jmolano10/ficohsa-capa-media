(:: pragma bea:global-element-parameter parameter="$fcySale" element="ns3:fcySale" location="../../xsd/ForeignExchangeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../BusinessServices/AbanksGT/VentaEfectivo/xsd/MCVentaEfectivo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCVentaEfectivo";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/ForeignExchange/FcySale/xq/mcVentaEfectivoGTIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/foreignExchangeTypes";

declare function xf:mcVentaEfectivoGTIn($fcySale as element(ns3:fcySale))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                let $CUSTOMER := $fcySale/ns3:CUSTOMER
                return
                    <ns1:PR_CUSTOMER>
                        {
                            for $LEGAL_ID in $CUSTOMER/ns3:LEGAL_ID
                            return
                                <ns1:LEGAL_ID>
                                    <ns1:NAME>{ data($LEGAL_ID/ns0:NAME) }</ns1:NAME>
                                    <ns1:ID>{ data($LEGAL_ID/ns0:ID) }</ns1:ID>
                                    {
                                        for $EXPIRATION_DATE in $LEGAL_ID/ns0:EXPIRATION_DATE
                                        return
                                            <ns1:EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</ns1:EXPIRATION_DATE>
                                    }
                                    {
                                        for $ISSUER in $LEGAL_ID/ns0:ISSUER
                                        return
                                            <ns1:ISSUER>{ data($ISSUER) }</ns1:ISSUER>
                                    }
                                </ns1:LEGAL_ID>
                        }
                        {
                            for $PRODUCT in $CUSTOMER/ns3:PRODUCT
                            return
                                <ns1:PRODUCT>
                                    <ns1:TYPE>{ data($PRODUCT/ns0:TYPE) }</ns1:TYPE>
                                    <ns1:ID>{ data($PRODUCT/ns0:ID) }</ns1:ID>
                                </ns1:PRODUCT>
                        }
                    </ns1:PR_CUSTOMER>
            }
            <ns1:PV_EXCHANGE_CURRENCY>{ data($fcySale/ns3:EXCHANGE_CURRENCY) }</ns1:PV_EXCHANGE_CURRENCY>
            {
                let $FCY_PAYMENT := $fcySale/ns3:FCY_PAYMENT
                return
                    <ns1:PR_FCY_PAYMENT>
                        <ns1:PAY_ITEM>
                            {
                                for $PAY_ITEM in $FCY_PAYMENT/ns2:PAY_ITEM
                                return
                                    <ns1:PAY_ITEM_ITEM>
                                        <ns1:TYPE>{ xs:string(data($PAY_ITEM/ns2:TYPE)) }</ns1:TYPE>
                                        <ns1:CURRENCY>{ data($PAY_ITEM/ns2:CURRENCY) }</ns1:CURRENCY>
                                        {
                                            for $AMOUNT in $PAY_ITEM/ns2:AMOUNT
                                            return
                                                <ns1:AMOUNT>{ data($AMOUNT) }</ns1:AMOUNT>
                                        }
                                        {
                                            for $MORE_INFO in $PAY_ITEM/ns2:MORE_INFO
                                            return
                                                <ns1:MORE_INFO>
                                                    {
                                                        for $ACCOUNT in $MORE_INFO/ns2:ACCOUNT
                                                        return
                                                            <ns1:ACCOUNT_VNUMBER>{ xs:decimal(data($ACCOUNT/ns2:NUMBER)) }</ns1:ACCOUNT_VNUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns2:CHECK
                                                        return
                                                            <ns1:CHECK_CHECK_NUMBER>{ xs:decimal(data($CHECK/ns2:CHECK_NUMBER)) }</ns1:CHECK_CHECK_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns2:CHECK,
                                                            $ACCOUNT_NUMBER in $CHECK/ns2:ACCOUNT_NUMBER
                                                        return
                                                            <ns1:CHECK_ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns1:CHECK_ACCOUNT_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns2:CHECK,
                                                            $BANK_CODE in $CHECK/ns2:BANK_CODE
                                                        return
                                                            <ns1:CHECK_BANK_CODE>{ data($BANK_CODE) }</ns1:CHECK_BANK_CODE>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns2:CHECK,
                                                            $BANK_DESCRIPTION in $CHECK/ns2:BANK_DESCRIPTION
                                                        return
                                                            <ns1:CHECK_BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns1:CHECK_BANK_DESCRIPTION>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns2:CREDIT_CARD,
                                                            $CARD_NUMBER in $CREDIT_CARD/ns2:CARD_NUMBER
                                                        return
                                                            <ns1:CREDIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns1:CREDIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns2:CREDIT_CARD
                                                        return
                                                            <ns1:CREDIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($CREDIT_CARD/ns2:EXPIRATION_DATE)) }</ns1:CREDIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns2:CREDIT_CARD
                                                        return
                                                            <ns1:CREDIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($CREDIT_CARD/ns2:VERIFICATION_CODE)) }</ns1:CREDIT_CARD_VERIFICATION_CODE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns2:DEBIT_CARD,
                                                            $CARD_NUMBER in $DEBIT_CARD/ns2:CARD_NUMBER
                                                        return
                                                            <ns1:DEBIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns1:DEBIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns2:DEBIT_CARD
                                                        return
                                                            <ns1:DEBIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($DEBIT_CARD/ns2:EXPIRATION_DATE)) }</ns1:DEBIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns2:DEBIT_CARD
                                                        return
                                                            <ns1:DEBIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($DEBIT_CARD/ns2:VERIFICATION_CODE)) }</ns1:DEBIT_CARD_VERIFICATION_CODE>
                                                    }
                                                </ns1:MORE_INFO>
                                        }
                                    </ns1:PAY_ITEM_ITEM>
                            }
                        </ns1:PAY_ITEM>
                    </ns1:PR_FCY_PAYMENT>
            }
            {
                let $LCY_PAYMENT := $fcySale/ns3:LCY_PAYMENT
                return
                    <ns1:PR_LCY_PAYMENT>
                        <ns1:PAY_ITEM>
                            {
                                for $PAY_ITEM in $LCY_PAYMENT/ns2:PAY_ITEM
                                return
                                    <ns1:PAY_ITEM_ITEM>
                                        <ns1:TYPE>{ xs:string(data($PAY_ITEM/ns2:TYPE)) }</ns1:TYPE>
                                        <ns1:CURRENCY>{ data($PAY_ITEM/ns2:CURRENCY) }</ns1:CURRENCY>
                                        {
                                            for $AMOUNT in $PAY_ITEM/ns2:AMOUNT
                                            return
                                                <ns1:AMOUNT>{ data($AMOUNT) }</ns1:AMOUNT>
                                        }
                                        {
                                            for $MORE_INFO in $PAY_ITEM/ns2:MORE_INFO
                                            return
                                                <ns1:MORE_INFO>
                                                    {
                                                        for $ACCOUNT in $MORE_INFO/ns2:ACCOUNT
                                                        return
                                                            <ns1:ACCOUNT_VNUMBER>{ xs:decimal(data($ACCOUNT/ns2:NUMBER)) }</ns1:ACCOUNT_VNUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns2:CHECK
                                                        return
                                                            <ns1:CHECK_CHECK_NUMBER>{ xs:decimal(data($CHECK/ns2:CHECK_NUMBER)) }</ns1:CHECK_CHECK_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns2:CHECK,
                                                            $ACCOUNT_NUMBER in $CHECK/ns2:ACCOUNT_NUMBER
                                                        return
                                                            <ns1:CHECK_ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns1:CHECK_ACCOUNT_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns2:CHECK,
                                                            $BANK_CODE in $CHECK/ns2:BANK_CODE
                                                        return
                                                            <ns1:CHECK_BANK_CODE>{ data($BANK_CODE) }</ns1:CHECK_BANK_CODE>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns2:CHECK,
                                                            $BANK_DESCRIPTION in $CHECK/ns2:BANK_DESCRIPTION
                                                        return
                                                            <ns1:CHECK_BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns1:CHECK_BANK_DESCRIPTION>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns2:CREDIT_CARD,
                                                            $CARD_NUMBER in $CREDIT_CARD/ns2:CARD_NUMBER
                                                        return
                                                            <ns1:CREDIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns1:CREDIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns2:CREDIT_CARD
                                                        return
                                                            <ns1:CREDIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($CREDIT_CARD/ns2:EXPIRATION_DATE)) }</ns1:CREDIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns2:CREDIT_CARD
                                                        return
                                                            <ns1:CREDIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($CREDIT_CARD/ns2:VERIFICATION_CODE)) }</ns1:CREDIT_CARD_VERIFICATION_CODE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns2:DEBIT_CARD,
                                                            $CARD_NUMBER in $DEBIT_CARD/ns2:CARD_NUMBER
                                                        return
                                                            <ns1:DEBIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns1:DEBIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns2:DEBIT_CARD
                                                        return
                                                            <ns1:DEBIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($DEBIT_CARD/ns2:EXPIRATION_DATE)) }</ns1:DEBIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns2:DEBIT_CARD
                                                        return
                                                            <ns1:DEBIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($DEBIT_CARD/ns2:VERIFICATION_CODE)) }</ns1:DEBIT_CARD_VERIFICATION_CODE>
                                                    }
                                                </ns1:MORE_INFO>
                                        }
                                    </ns1:PAY_ITEM_ITEM>
                            }
                        </ns1:PAY_ITEM>
                    </ns1:PR_LCY_PAYMENT>
            }
            {
                let $NSO_INFO := $fcySale/ns3:NSO_INFO
                return
                    <ns1:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns2:TRACE
                            return
                                <ns1:TRACE>
                                    <ns1:TELLER_ID>{ xs:decimal(data($TRACE/ns2:TELLER_ID)) }</ns1:TELLER_ID>
                                    <ns1:BRANCH_ID>{ xs:decimal(data($TRACE/ns2:BRANCH_ID)) }</ns1:BRANCH_ID>
                                    <ns1:CHANNEL_CODE>{ xs:decimal(data($TRACE/ns2:CHANNEL_CODE)) }</ns1:CHANNEL_CODE>
                                    <ns1:DATE_TIME>{ data($TRACE/ns2:DATE_TIME) }</ns1:DATE_TIME>
                                    {
                                        for $QUEUE_TICKET_ID in $TRACE/ns2:QUEUE_TICKET_ID
                                        return
                                            <ns1:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns1:QUEUE_TICKET_ID>
                                    }
                                    {
                                        for $TXN_REF_NO in $TRACE/ns2:TXN_REF_NO
                                        return
                                            <ns1:TXN_REF_NO>{ data($TXN_REF_NO) }</ns1:TXN_REF_NO>
                                    }
                                    {
                                        for $DEALSLIP_ID in $TRACE/ns2:DEALSLIP_ID
                                        return
                                            <ns1:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns1:DEALSLIP_ID>
                                    }
                                </ns1:TRACE>
                        }
                        {
                            for $AUTHORIZATION in $NSO_INFO/ns2:AUTHORIZATION
                            return
                                <ns1:AUTHORIZATION>
                                    <ns1:TYPE>{ data($AUTHORIZATION/ns2:TYPE) }</ns1:TYPE>
                                    {
                                        for $KV_PAIRS in $AUTHORIZATION/ns2:KV_PAIRS
                                        return
                                            <ns1:KV_PAIRS>
                                                <ns1:PAIR>
                                                    {
                                                        for $PAIR in $KV_PAIRS/ns2:PAIR
                                                        return
                                                            <ns1:PAIR_ITEM>
                                                                <ns1:KEY>{ data($PAIR/ns2:KEY) }</ns1:KEY>
                                                                <ns1:VALUE>{ data($PAIR/ns2:VALUE) }</ns1:VALUE>
                                                            </ns1:PAIR_ITEM>
                                                    }
                                                </ns1:PAIR>
                                            </ns1:KV_PAIRS>
                                    }
                                </ns1:AUTHORIZATION>
                        }
                        {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns2:BANKNOTE_BREAKDOWN
                            return
                                <ns1:BANKNOTE_BREAKDOWN>
                                    <ns1:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns2:BANKNOTE
                                            return
                                                <ns1:BANKNOTE_ITEM>
                                                    <ns1:CURRENCY>{ data($BANKNOTE/ns2:CURRENCY) }</ns1:CURRENCY>
                                                    <ns1:BANKNOTE_VALUE>{ data($BANKNOTE/ns2:VALUE) }</ns1:BANKNOTE_VALUE>
                                                    <ns1:QUANTITY>{ xs:decimal(data($BANKNOTE/ns2:QUANTITY)) }</ns1:QUANTITY>
                                                    <ns1:TOTAL>{ data($BANKNOTE/ns2:TOTAL) }</ns1:TOTAL>
                                                </ns1:BANKNOTE_ITEM>
                                        }
                                    </ns1:BANKNOTE>
                                </ns1:BANKNOTE_BREAKDOWN>
                        }
                        {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns2:ADDITIONAL_INFO
                            return
                                <ns1:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns2:KV_PAIRS
                                        return
                                            <ns1:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns2:PAIR
                                                    return
                                                        <ns1:PAIR_ITEM>
                                                            <ns1:KEY>{ data($PAIR/ns2:KEY) }</ns1:KEY>
                                                            <ns1:VALUE>{ data($PAIR/ns2:VALUE) }</ns1:VALUE>
                                                        </ns1:PAIR_ITEM>
                                                }
                                            </ns1:KV_PAIRS>
                                    }
                                </ns1:ADDITIONAL_INFO>
                        }
                        {
                            for $CTR_REFERENCE in $NSO_INFO/ns2:CTR_REFERENCE
                            return
                                <ns1:CTR_REFERENCE>{ xs:decimal(data($CTR_REFERENCE)) }</ns1:CTR_REFERENCE>
                        }
                    </ns1:PR_NSO_INFO>
            }
        </ns1:InputParameters>
};

declare variable $fcySale as element(ns3:fcySale) external;

xf:mcVentaEfectivoGTIn($fcySale)
