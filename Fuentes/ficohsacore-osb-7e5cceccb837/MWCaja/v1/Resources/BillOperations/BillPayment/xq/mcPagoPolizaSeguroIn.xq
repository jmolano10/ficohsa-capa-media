(:: pragma bea:global-element-parameter parameter="$billPayment" element="ns0:billPayment" location="../../xsd/BillOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../BusinessServices/AbanksGT/PagoPolizaSeguro/xsd/MCPagoPolizaSeguro_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/billOperationsTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCPagoPolizaSeguro";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillPayment/xq/mcPagoPolizaSeguroIn/";

declare function xf:mcPagoPolizaSeguroIn($billPayment as element(ns0:billPayment))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_NUMERO_POLIZA>{ data($billPayment/ns0:DEBTOR_CODE) }</ns2:PV_NUMERO_POLIZA>            
            <ns2:PV_NOMBRE_CLIENTE>{ $billPayment/ns0:EXTRA_INFO/ns1:PAIR[ns1:KEY='DEBTOR_NAME']/ns1:VALUE/text() }</ns2:PV_NOMBRE_CLIENTE>            
            <ns2:PR_PAYMENT>
                <ns2:PAY_ITEM>
                    {
                        for $payment in $billPayment/ns0:PAYMENT/ns1:PAY_ITEM
                        return
                            <ns2:PAY_ITEM_ITEM>
                                <ns2:TYPE>{ data($payment/ns1:TYPE) }</ns2:TYPE>
                                <ns2:CURRENCY>{ data($payment/ns1:CURRENCY) }</ns2:CURRENCY>
                                <ns2:AMOUNT>{ data($payment/ns1:AMOUNT) }</ns2:AMOUNT>
                                <ns2:MORE_INFO>
                                    <ns2:ACCOUNT_VNUMBER>{ data($payment/ns1:MORE_INFO/ns1:ACCOUNT/ns1:NUMBER) }</ns2:ACCOUNT_VNUMBER>
                                    <ns2:CHECK_CHECK_NUMBER>{ data($payment/ns1:MORE_INFO/ns1:CHECK/ns1:CHECK_NUMBER) }</ns2:CHECK_CHECK_NUMBER>
                                    <ns2:CHECK_ACCOUNT_NUMBER>{ data($payment/ns1:MORE_INFO/ns1:CHECK/ns1:ACCOUNT_NUMBER) }</ns2:CHECK_ACCOUNT_NUMBER>
                                    <ns2:CHECK_BANK_CODE>{ data($payment/ns1:MORE_INFO/ns1:CHECK/ns1:BANK_CODE) }</ns2:CHECK_BANK_CODE>
                                    <ns2:CHECK_BANK_DESCRIPTION>{ data($payment/ns1:MORE_INFO/ns1:CHECK/ns1:BANK_DESCRIPTION) }</ns2:CHECK_BANK_DESCRIPTION>
                                    <ns2:CREDIT_CARD_CARD_NUMBER>{ data($payment/ns1:MORE_INFO/ns1:CREDIT_CARD/ns1:CARD_NUMBER) }</ns2:CREDIT_CARD_CARD_NUMBER>
                                    <ns2:CREDIT_CARD_EXPIRATION_DATE>{ data($payment/ns1:MORE_INFO/ns1:CREDIT_CARD/ns1:EXPIRATION_DATE) }</ns2:CREDIT_CARD_EXPIRATION_DATE>
                                    <ns2:CREDIT_CARD_VERIFICATION_CODE>{ data($payment/ns1:MORE_INFO/ns1:CREDIT_CARD/ns1:VERIFICATION_CODE) }</ns2:CREDIT_CARD_VERIFICATION_CODE>
                                    <ns2:DEBIT_CARD_CARD_NUMBER>{ data($payment/ns1:MORE_INFO/ns1:DEBIT_CARD/ns1:CARD_NUMBER) }</ns2:DEBIT_CARD_CARD_NUMBER>
                                    <ns2:DEBIT_CARD_EXPIRATION_DATE>{ data($payment/ns1:MORE_INFO/ns1:DEBIT_CARD/ns1:EXPIRATION_DATE) }</ns2:DEBIT_CARD_EXPIRATION_DATE>
                                    <ns2:DEBIT_CARD_VERIFICATION_CODE>{ data($payment/ns1:MORE_INFO/ns1:DEBIT_CARD/ns1:VERIFICATION_CODE) }</ns2:DEBIT_CARD_VERIFICATION_CODE>
                                </ns2:MORE_INFO>
                            </ns2:PAY_ITEM_ITEM>
                    }
                </ns2:PAY_ITEM>
            </ns2:PR_PAYMENT>
            <ns2:PR_NSO_INFO>
                <ns2:TRACE>
                    <ns2:TELLER_ID>{ data($billPayment/ns0:NSO_INFO/ns1:TRACE/ns1:TELLER_ID) }</ns2:TELLER_ID>
                    <ns2:BRANCH_ID>{ data($billPayment/ns0:NSO_INFO/ns1:TRACE/ns1:BRANCH_ID) }</ns2:BRANCH_ID>
                    <ns2:CHANNEL_CODE>{ data($billPayment/ns0:NSO_INFO/ns1:TRACE/ns1:CHANNEL_CODE) }</ns2:CHANNEL_CODE>
                    <ns2:DATE_TIME>{ data($billPayment/ns0:NSO_INFO/ns1:TRACE/ns1:DATE_TIME) }</ns2:DATE_TIME>
                    <ns2:QUEUE_TICKET_ID>{ data($billPayment/ns0:NSO_INFO/ns1:TRACE/ns1:QUEUE_TICKET_ID) }</ns2:QUEUE_TICKET_ID>
                    <ns2:TXN_REF_NO>{ data($billPayment/ns0:NSO_INFO/ns1:TRACE/ns1:TXN_REF_NO) }</ns2:TXN_REF_NO>
                    <ns2:DEALSLIP_ID>{ data($billPayment/ns0:NSO_INFO/ns1:TRACE/ns1:DEALSLIP_ID) }</ns2:DEALSLIP_ID>
                </ns2:TRACE>
                <ns2:AUTHORIZATION>
                    <ns2:TYPE>{ data($billPayment/ns0:NSO_INFO/ns1:AUTHORIZATION/ns1:TYPE) }</ns2:TYPE>
                    <ns2:KV_PAIRS>
                        <ns2:PAIR>
                            {
                                for $pair in $billPayment/ns0:NSO_INFO/ns1:AUTHORIZATION/ns1:KV_PAIRS/ns1:PAIR
                                return
                                    <ns2:PAIR_ITEM>
                                        <ns2:KEY>{ data($pair/ns1:KEY) }</ns2:KEY>
                                        <ns2:VALUE>{ data($pair/ns1:VALUE) }</ns2:VALUE>
                                    </ns2:PAIR_ITEM>
                            }
                        </ns2:PAIR>
                    </ns2:KV_PAIRS>
                </ns2:AUTHORIZATION>
                <ns2:BANKNOTE_BREAKDOWN>
                    <ns2:BANKNOTE>
                        {
                            for $bankNote in $billPayment/ns0:NSO_INFO/ns1:BANKNOTE_BREAKDOWN/ns1:BANKNOTE
                            return
                                <ns2:BANKNOTE_ITEM>
                                    <ns2:CURRENCY>{ data($bankNote/ns1:CURRENCY) }</ns2:CURRENCY>
                                    <ns2:BANKNOTE_VALUE>{ data($bankNote/ns1:VALUE) }</ns2:BANKNOTE_VALUE>
                                    <ns2:QUANTITY>{ data($bankNote/ns1:QUANTITY) }</ns2:QUANTITY>
                                    <ns2:TOTAL>{ data($bankNote/ns1:TOTAL) }</ns2:TOTAL>
                                </ns2:BANKNOTE_ITEM>
                        }
                    </ns2:BANKNOTE>
                </ns2:BANKNOTE_BREAKDOWN>
                <ns2:ADDITIONAL_INFO>
                    <ns2:KV_PAIRS>
                        {
                            for $additionalInfo in $billPayment/ns0:NSO_INFO/ns1:ADDITIONAL_INFO/ns1:KV_PAIRS/ns1:PAIR
                            return
                                <ns2:PAIR_ITEM>
                                    <ns2:KEY>{ data($additionalInfo/ns1:KEY) }</ns2:KEY>
                                    <ns2:VALUE>{ data($additionalInfo/ns1:VALUE) }</ns2:VALUE>
                                </ns2:PAIR_ITEM>
                        }
                    </ns2:KV_PAIRS>
                </ns2:ADDITIONAL_INFO>
                <ns2:CTR_REFERENCE>{ data($billPayment/ns0:NSO_INFO/ns1:CTR_REFERENCE) }</ns2:CTR_REFERENCE>
            </ns2:PR_NSO_INFO>
        </ns2:InputParameters>
};

declare variable $billPayment as element(ns0:billPayment) external;

xf:mcPagoPolizaSeguroIn($billPayment)