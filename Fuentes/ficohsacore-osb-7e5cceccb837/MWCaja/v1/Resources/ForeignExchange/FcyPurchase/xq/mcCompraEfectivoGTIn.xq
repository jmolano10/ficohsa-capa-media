(:: pragma bea:global-element-parameter parameter="$fcyPurchase" element="ns2:fcyPurchase" location="../../xsd/ForeignExchangeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns3:InputParameters" location="../../../../BusinessServices/AbanksGT/CompraEfectivo/xsd/MCCompraEfectivo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/customerTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/foreignExchangeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/ForeignExchange/FcyPurchase/xq/mcCompraEfectivoGTIn/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCCompraEfectivo";

declare function xf:mcCompraEfectivoGTIn($fcyPurchase as element(ns2:fcyPurchase))
    as element(ns3:InputParameters) {
        <ns3:InputParameters>
            {
                let $CUSTOMER := $fcyPurchase/ns2:CUSTOMER
                return
                    <ns3:PR_CUSTOMER>
                        {
                            for $LEGAL_ID in $CUSTOMER/ns2:LEGAL_ID
                            return
                                <ns3:LEGAL_ID>
                                    <ns3:NAME>{ data($LEGAL_ID/ns0:NAME) }</ns3:NAME>
                                    <ns3:ID>{ data($LEGAL_ID/ns0:ID) }</ns3:ID>
                                    {
                                    	for $LEGAL_ID in $CUSTOMER/ns2:LEGAL_ID,
                                    		$EXPIRATION_DATE in $LEGAL_ID/ns0:EXPIRATION_DATE
                                    		return
                                    			<ns3:EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</ns3:EXPIRATION_DATE>
                                    }
                                    
                                    {
                                        for $LEGAL_ID in $CUSTOMER/ns2:LEGAL_ID,
                                        	$ISSUER in $LEGAL_ID/ns0:ISSUER
                                        return
                                            <ns3:ISSUER>{ data($ISSUER) }</ns3:ISSUER>
                                    }
                                </ns3:LEGAL_ID>
                        }
                        {
                            for $PRODUCT in $CUSTOMER/ns2:PRODUCT
                            return
                                <ns3:PRODUCT>
                                    <ns3:TYPE>{ data($PRODUCT/ns0:TYPE) }</ns3:TYPE>
                                    <ns3:ID>{ data($PRODUCT/ns0:ID) }</ns3:ID>
                                </ns3:PRODUCT>
                        }
                    </ns3:PR_CUSTOMER>
            }
            <ns3:PV_EXCHANGE_CURRENCY>{ data($fcyPurchase/ns2:EXCHANGE_CURRENCY) }</ns3:PV_EXCHANGE_CURRENCY>
            {
                let $FCY_PAYMENT := $fcyPurchase/ns2:FCY_PAYMENT
                return
                    <ns3:PR_FCY_PAYMENT>
                        <ns3:PAY_ITEM>
                            {
                                for $PAY_ITEM in $FCY_PAYMENT/ns1:PAY_ITEM
                                return
                                    <ns3:PAY_ITEM_ITEM>
                                        <ns3:TYPE>{ data($PAY_ITEM/ns1:TYPE) }</ns3:TYPE>
                                        <ns3:CURRENCY>{ data($PAY_ITEM/ns1:CURRENCY) }</ns3:CURRENCY>
                                        {
                                            for $AMOUNT in $PAY_ITEM/ns1:AMOUNT
                                            return
                                                <ns3:AMOUNT>{ data($AMOUNT) }</ns3:AMOUNT>
                                        }
                                        {
                                            for $MORE_INFO in $PAY_ITEM/ns1:MORE_INFO
                                            return
                                                <ns3:MORE_INFO>
                                                    {
                                                        for $ACCOUNT in $MORE_INFO/ns1:ACCOUNT
                                                        return
                                                            <ns3:ACCOUNT_VNUMBER>{ xs:decimal(data($ACCOUNT/ns1:NUMBER)) }</ns3:ACCOUNT_VNUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK
                                                        return
                                                            <ns3:CHECK_CHECK_NUMBER>{ data($CHECK/ns1:CHECK_NUMBER) }</ns3:CHECK_CHECK_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $ACCOUNT_NUMBER in $CHECK/ns1:ACCOUNT_NUMBER
                                                        return
                                                            <ns3:CHECK_ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns3:CHECK_ACCOUNT_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $BANK_CODE in $CHECK/ns1:BANK_CODE
                                                        return
                                                            <ns3:CHECK_BANK_CODE>{ data($BANK_CODE) }</ns3:CHECK_BANK_CODE>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $BANK_DESCRIPTION in $CHECK/ns1:BANK_DESCRIPTION
                                                        return
                                                            <ns3:CHECK_BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns3:CHECK_BANK_DESCRIPTION>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD,
                                                            $CARD_NUMBER in $CREDIT_CARD/ns1:CARD_NUMBER
                                                        return
                                                            <ns3:CREDIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns3:CREDIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD
                                                        return
                                                            <ns3:CREDIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($CREDIT_CARD/ns1:EXPIRATION_DATE)) }</ns3:CREDIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD
                                                        return
                                                            <ns3:CREDIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($CREDIT_CARD/ns1:VERIFICATION_CODE)) }</ns3:CREDIT_CARD_VERIFICATION_CODE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD,
                                                            $CARD_NUMBER in $DEBIT_CARD/ns1:CARD_NUMBER
                                                        return
                                                            <ns3:DEBIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns3:DEBIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD
                                                        return
                                                            <ns3:DEBIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($DEBIT_CARD/ns1:EXPIRATION_DATE)) }</ns3:DEBIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD
                                                        return
                                                            <ns3:DEBIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($DEBIT_CARD/ns1:VERIFICATION_CODE)) }</ns3:DEBIT_CARD_VERIFICATION_CODE>
                                                    }
                                                </ns3:MORE_INFO>
                                        }
                                    </ns3:PAY_ITEM_ITEM>
                            }
                        </ns3:PAY_ITEM>
                    </ns3:PR_FCY_PAYMENT>
            }
            {
                let $LCY_PAYMENT := $fcyPurchase/ns2:LCY_PAYMENT
                return
                    <ns3:PR_LCY_PAYMENT>
                        <ns3:PAY_ITEM>
                            {
                                for $PAY_ITEM in $LCY_PAYMENT/ns1:PAY_ITEM
                                return
                                    <ns3:PAY_ITEM_ITEM>
                                        <ns3:TYPE>{ data($PAY_ITEM/ns1:TYPE) }</ns3:TYPE>
                                        <ns3:CURRENCY>{ data($PAY_ITEM/ns1:CURRENCY) }</ns3:CURRENCY>
                                        {
                                            for $AMOUNT in $PAY_ITEM/ns1:AMOUNT
                                            return
                                                <ns3:AMOUNT>{ data($AMOUNT) }</ns3:AMOUNT>
                                        }
                                        {
                                            for $MORE_INFO in $PAY_ITEM/ns1:MORE_INFO
                                            return
                                                <ns3:MORE_INFO>
                                                    {
                                                        for $ACCOUNT in $MORE_INFO/ns1:ACCOUNT
                                                        return
                                                            <ns3:ACCOUNT_VNUMBER>{ xs:decimal(data($ACCOUNT/ns1:NUMBER)) }</ns3:ACCOUNT_VNUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK
                                                        return
                                                            <ns3:CHECK_CHECK_NUMBER>{ data($CHECK/ns1:CHECK_NUMBER) }</ns3:CHECK_CHECK_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $ACCOUNT_NUMBER in $CHECK/ns1:ACCOUNT_NUMBER
                                                        return
                                                            <ns3:CHECK_ACCOUNT_NUMBER>{ xs:decimal(data($ACCOUNT_NUMBER)) }</ns3:CHECK_ACCOUNT_NUMBER>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $BANK_CODE in $CHECK/ns1:BANK_CODE
                                                        return
                                                            <ns3:CHECK_BANK_CODE>{ data($BANK_CODE) }</ns3:CHECK_BANK_CODE>
                                                    }
                                                    {
                                                        for $CHECK in $MORE_INFO/ns1:CHECK,
                                                            $BANK_DESCRIPTION in $CHECK/ns1:BANK_DESCRIPTION
                                                        return
                                                            <ns3:CHECK_BANK_DESCRIPTION>{ data($BANK_DESCRIPTION) }</ns3:CHECK_BANK_DESCRIPTION>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD,
                                                            $CARD_NUMBER in $CREDIT_CARD/ns1:CARD_NUMBER
                                                        return
                                                            <ns3:CREDIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns3:CREDIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD
                                                        return
                                                            <ns3:CREDIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($CREDIT_CARD/ns1:EXPIRATION_DATE)) }</ns3:CREDIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $CREDIT_CARD in $MORE_INFO/ns1:CREDIT_CARD
                                                        return
                                                            <ns3:CREDIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($CREDIT_CARD/ns1:VERIFICATION_CODE)) }</ns3:CREDIT_CARD_VERIFICATION_CODE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD,
                                                            $CARD_NUMBER in $DEBIT_CARD/ns1:CARD_NUMBER
                                                        return
                                                            <ns3:DEBIT_CARD_CARD_NUMBER>{ xs:decimal(data($CARD_NUMBER)) }</ns3:DEBIT_CARD_CARD_NUMBER>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD
                                                        return
                                                            <ns3:DEBIT_CARD_EXPIRATION_DATE>{ xs:decimal(data($DEBIT_CARD/ns1:EXPIRATION_DATE)) }</ns3:DEBIT_CARD_EXPIRATION_DATE>
                                                    }
                                                    {
                                                        for $DEBIT_CARD in $MORE_INFO/ns1:DEBIT_CARD
                                                        return
                                                            <ns3:DEBIT_CARD_VERIFICATION_CODE>{ xs:decimal(data($DEBIT_CARD/ns1:VERIFICATION_CODE)) }</ns3:DEBIT_CARD_VERIFICATION_CODE>
                                                    }
                                                </ns3:MORE_INFO>
                                        }
                                    </ns3:PAY_ITEM_ITEM>
                            }
                        </ns3:PAY_ITEM>
                    </ns3:PR_LCY_PAYMENT>
            }
            {
                let $NSO_INFO := $fcyPurchase/ns2:NSO_INFO
                return
                    <ns3:PR_NSO_INFO>
                        {
                            let $TRACE := $NSO_INFO/ns1:TRACE
                            return
                                <ns3:TRACE>
                                    <ns3:TELLER_ID>{ data($TRACE/ns1:TELLER_ID) }</ns3:TELLER_ID>
                                    <ns3:BRANCH_ID>{ data($TRACE/ns1:BRANCH_ID) }</ns3:BRANCH_ID>
                                    <ns3:CHANNEL_CODE>{ data($TRACE/ns1:CHANNEL_CODE) }</ns3:CHANNEL_CODE>
                                    <ns3:DATE_TIME>{ data($TRACE/ns1:DATE_TIME) }</ns3:DATE_TIME>
                                    {
                                        for $QUEUE_TICKET_ID in $TRACE/ns1:QUEUE_TICKET_ID
                                        return
                                            <ns3:QUEUE_TICKET_ID>{ data($QUEUE_TICKET_ID) }</ns3:QUEUE_TICKET_ID>
                                    }
                                    {
                                        for $TXN_REF_NO in $TRACE/ns1:TXN_REF_NO
                                        return
                                            <ns3:TXN_REF_NO>{ data($TXN_REF_NO) }</ns3:TXN_REF_NO>
                                    }
                                    {
                                        for $DEALSLIP_ID in $TRACE/ns1:DEALSLIP_ID
                                        return
                                            <ns3:DEALSLIP_ID>{ data($DEALSLIP_ID) }</ns3:DEALSLIP_ID>
                                    }
                                </ns3:TRACE>
                        }
                        {
                            for $AUTHORIZATION in $NSO_INFO/ns1:AUTHORIZATION
                            return
                                <ns3:AUTHORIZATION>
                                    <ns3:TYPE>{ data($AUTHORIZATION/ns1:TYPE) }</ns3:TYPE>
                                    {
                                        for $KV_PAIRS in $AUTHORIZATION/ns1:KV_PAIRS
                                        return
                                            <ns3:KV_PAIRS>
                                                <ns3:PAIR>
                                                    {
                                                        for $PAIR in $KV_PAIRS/ns1:PAIR
                                                        return
                                                            <ns3:PAIR_ITEM>
                                                                <ns3:KEY>{ data($PAIR/ns1:KEY) }</ns3:KEY>
                                                                <ns3:VALUE>{ data($PAIR/ns1:VALUE) }</ns3:VALUE>
                                                            </ns3:PAIR_ITEM>
                                                    }
                                                </ns3:PAIR>
                                            </ns3:KV_PAIRS>
                                    }
                                </ns3:AUTHORIZATION>
                        }
                        {
                            for $BANKNOTE_BREAKDOWN in $NSO_INFO/ns1:BANKNOTE_BREAKDOWN
                            return
                                <ns3:BANKNOTE_BREAKDOWN>
                                    <ns3:BANKNOTE>
                                        {
                                            for $BANKNOTE in $BANKNOTE_BREAKDOWN/ns1:BANKNOTE
                                            return
                                                <ns3:BANKNOTE_ITEM>
                                                    <ns3:CURRENCY>{ data($BANKNOTE/ns1:CURRENCY) }</ns3:CURRENCY>
                                                    <ns3:BANKNOTE_VALUE>{ data($BANKNOTE/ns1:VALUE) }</ns3:BANKNOTE_VALUE>
                                                    <ns3:QUANTITY>{ data($BANKNOTE/ns1:QUANTITY) }</ns3:QUANTITY>
                                                    <ns3:TOTAL>{ data($BANKNOTE/ns1:TOTAL) }</ns3:TOTAL>
                                                </ns3:BANKNOTE_ITEM>
                                        }
                                    </ns3:BANKNOTE>
                                </ns3:BANKNOTE_BREAKDOWN>
                        }
                        {
                            for $ADDITIONAL_INFO in $NSO_INFO/ns1:ADDITIONAL_INFO
                            return
                                <ns3:ADDITIONAL_INFO>
                                    {
                                        for $KV_PAIRS in $ADDITIONAL_INFO/ns1:KV_PAIRS
                                        return
                                            <ns3:KV_PAIRS>
                                                {
                                                    for $PAIR in $KV_PAIRS/ns1:PAIR
                                                    return
                                                        <ns3:PAIR_ITEM>
                                                            <ns3:KEY>{ data($PAIR/ns1:KEY) }</ns3:KEY>
                                                            <ns3:VALUE>{ data($PAIR/ns1:VALUE) }</ns3:VALUE>
                                                        </ns3:PAIR_ITEM>
                                                }
                                            </ns3:KV_PAIRS>
                                    }
                                </ns3:ADDITIONAL_INFO>
                        }
                        {
                        	for $CTR_REFERENCE in $NSO_INFO/ns1:CTR_REFERENCE
                        	return
                        		<ns3:CTR_REFERENCE>{ data($NSO_INFO/ns1:CTR_REFERENCE) }</ns3:CTR_REFERENCE>	
                        }
                        
                    </ns3:PR_NSO_INFO>
            }
        </ns3:InputParameters>
};

declare variable $fcyPurchase as element(ns2:fcyPurchase) external;

xf:mcCompraEfectivoGTIn($fcyPurchase)
