(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../BusinessServices/AbanksGT/CambioLibreta/xsd/MCCambioLibreta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:passbookReplacementResponse" location="../../xsd/AccountPassbookOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/accountPassbookOperationsTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCCambioLibreta";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/AccountPassbookOperations/PassbookReplacement/xq/passbookReplacementGTOut/";

declare function xf:passbookReplacementGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns2:passbookReplacementResponse) {
        <ns2:passbookReplacementResponse>
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns1:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO/*) )then(
                	
                	)else(
                    <ns2:TRANSACTION_INFO>
                        {
                            for $DEALSLIP in $PR_TRANSACTION_INFO/ns1:DEALSLIP
                            return
                                <ns0:DEALSLIP>
                                    {
                                        for $DS_RECORD_ITEM in $DEALSLIP/ns1:DS_RECORD/ns1:DS_RECORD_ITEM
                                        return
                                            <ns0:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns0:DS_RECORD>
                                    }
                                </ns0:DEALSLIP>
                        }
                        <ns0:TXN_REF_ID>{ data($PR_TRANSACTION_INFO/ns1:TXN_REF_ID) }</ns0:TXN_REF_ID>
                        <ns0:TXN_TYPE_ID>{ data($PR_TRANSACTION_INFO/ns1:TXN_TYPE_ID) }</ns0:TXN_TYPE_ID>
                        <ns0:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns1:TXN_DATE) }</ns0:TXN_DATE>
                        <ns0:CURRENCY>{ data($PR_TRANSACTION_INFO/ns1:CURRENCY) }</ns0:CURRENCY>
                        <ns0:AMOUNT>{ data($PR_TRANSACTION_INFO/ns1:AMOUNT) }</ns0:AMOUNT>
                        <ns0:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns1:DATE_TIME) }</ns0:DATE_TIME>
                        <ns0:USER>{ data($PR_TRANSACTION_INFO/ns1:USER_TX) }</ns0:USER>
                        <ns0:BRANCH_ID>{ data($PR_TRANSACTION_INFO/ns1:BRANCH_ID) }</ns0:BRANCH_ID>
                        <ns0:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns1:BRANCH_NAME) }</ns0:BRANCH_NAME>
                        <ns0:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns1:REQUIRES_CTR) }</ns0:REQUIRES_CTR>
                        {
                            for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns1:DEALSLIP_URL
                            return
                                <ns0:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns0:DEALSLIP_URL>
                        }
                    </ns2:TRANSACTION_INFO>
                   )
            }
        </ns2:passbookReplacementResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:passbookReplacementGTOut($outputParameters)
