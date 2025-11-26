(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../../v1/BusinessServices/AbanksGT/REPPagoTC/xsd/MCREPPagoTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:creditCardPaymentResponse" location="../../../../../v1/Resources/CreditCardOperations/xsd/CreditCardOperationsTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSGT/MGC_K_GESTION_TC/MC_REP_PAGO_TC/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/creditCardOperationsTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardPayment/xq/creditCardPaymentGTOut/";

declare function xf:creditCardPaymentGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns2:creditCardPaymentResponse) {
        <ns2:creditCardPaymentResponse>
            {
                for $PN_CREDIT_CARD_NUMBER in $outputParameters/ns0:PN_CREDIT_CARD_NUMBER
                return
                    <ns2:CREDIT_CARD_NUMBER>{ xs:string(data($PN_CREDIT_CARD_NUMBER)) }</ns2:CREDIT_CARD_NUMBER>
            }
            {
                for $PV_NAME in $outputParameters/ns0:PV_NAME
                return
                    <ns2:NAME>{ data($PV_NAME) }</ns2:NAME>
            }
            {
                for $PV_BALANCE_CURRENCY in $outputParameters/ns0:PV_BALANCE_CURRENCY
                return
                    <ns2:BALANCE_CURRENCY>{ data($PV_BALANCE_CURRENCY) }</ns2:BALANCE_CURRENCY>
            }
            {
                for $PN_BALANCE_AMOUNT in $outputParameters/ns0:PN_BALANCE_AMOUNT
                return
                    <ns2:BALANCE_AMOUNT>{ data($PN_BALANCE_AMOUNT) }</ns2:BALANCE_AMOUNT>
            }
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns0:PR_TRANSACTION_INFO
                return
	                if( empty($PR_TRANSACTION_INFO/*) )then(
	                
	                )else(
	                    <ns2:TRANSACTION_INFO>
	                        {
	                            for $DEALSLIP in $PR_TRANSACTION_INFO/ns0:DEALSLIP
	                            return
	                                <ns1:DEALSLIP>
	                                    {
	                                        for $DS_RECORD_ITEM in $DEALSLIP/ns0:DS_RECORD/ns0:DS_RECORD_ITEM
	                                        return
	                                            <ns1:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns1:DS_RECORD>
	                                    }
	                                </ns1:DEALSLIP>
	                        }
	                        <ns1:TXN_REF_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns0:TXN_REF_ID)) }</ns1:TXN_REF_ID>
	                        <ns1:TXN_TYPE_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns0:TXN_TYPE_ID)) }</ns1:TXN_TYPE_ID>
	                        <ns1:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns0:TXN_DATE) }</ns1:TXN_DATE>
	                        <ns1:CURRENCY>{ data($PR_TRANSACTION_INFO/ns0:CURRENCY) }</ns1:CURRENCY>
	                        <ns1:AMOUNT>{ data($PR_TRANSACTION_INFO/ns0:AMOUNT) }</ns1:AMOUNT>
	                        <ns1:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns0:DATE_TIME) }</ns1:DATE_TIME>
	                        <ns1:USER>{ data($PR_TRANSACTION_INFO/ns0:USER_TX) }</ns1:USER>
	                        <ns1:BRANCH_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns0:BRANCH_ID)) }</ns1:BRANCH_ID>
	                        <ns1:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns0:BRANCH_NAME) }</ns1:BRANCH_NAME>
	                        <ns1:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns0:REQUIRES_CTR) }</ns1:REQUIRES_CTR>
	                        {
	                            for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns0:DEALSLIP_URL
	                            return
	                                <ns1:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns1:DEALSLIP_URL>
	                        }
	                    </ns2:TRANSACTION_INFO>
                    )
            }
        </ns2:creditCardPaymentResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:creditCardPaymentGTOut($outputParameters)
