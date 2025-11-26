(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../BusinessServices/AbanksGT/PagoCHQOtroBCO/xsd/MCPagoCHQOtroBCO_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:otherBankCheckPymtResponse" location="../../xsd/CheckOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCPagoCHQOtroBCO";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/checkOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CheckOperations/OtherbankCheckPymt/xq/otherbankCheckPymtGtOut/";

declare function xf:otherbankCheckPymtGtOut($outputParameters as element(ns2:OutputParameters))
    as element(ns1:otherBankCheckPymtResponse) {
        <ns1:otherBankCheckPymtResponse>
            {
                for $PN_CHECK_NUMBER in $outputParameters/ns2:PN_CHECK_NUMBER
                return
                    <ns1:CHECK_NUMBER>{ xs:integer(data($PN_CHECK_NUMBER)) }</ns1:CHECK_NUMBER>
            }
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns2:PR_TRANSACTION_INFO
                return
	                if( empty($PR_TRANSACTION_INFO/*) )then(
	                
	                )else(
	                    <ns1:TRANSACTION_INFO>
	                        {
	                            for $DEALSLIP in $PR_TRANSACTION_INFO/ns2:DEALSLIP
	                            return
	                                <ns0:DEALSLIP>
	                                    {
	                                        for $DS_RECORD_ITEM in $DEALSLIP/ns2:DS_RECORD/ns2:DS_RECORD_ITEM
	                                        return
	                                            <ns0:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns0:DS_RECORD>
	                                    }
	                                </ns0:DEALSLIP>
	                        }
	                        <ns0:TXN_REF_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns2:TXN_REF_ID)) }</ns0:TXN_REF_ID>
	                        <ns0:TXN_TYPE_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns2:TXN_TYPE_ID)) }</ns0:TXN_TYPE_ID>
	                        <ns0:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns2:TXN_DATE) }</ns0:TXN_DATE>
	                        <ns0:CURRENCY>{ data($PR_TRANSACTION_INFO/ns2:CURRENCY) }</ns0:CURRENCY>
	                        <ns0:AMOUNT>{ data($PR_TRANSACTION_INFO/ns2:AMOUNT) }</ns0:AMOUNT>
	                        <ns0:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns2:DATE_TIME) }</ns0:DATE_TIME>
	                        <ns0:USER>{ data($PR_TRANSACTION_INFO/ns2:USER_TX) }</ns0:USER>
	                        <ns0:BRANCH_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns2:BRANCH_ID)) }</ns0:BRANCH_ID>
	                        <ns0:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_NAME) }</ns0:BRANCH_NAME>
	                        <ns0:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns2:REQUIRES_CTR) }</ns0:REQUIRES_CTR>
	                        {
	                            for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns2:DEALSLIP_URL
	                            return
	                                <ns0:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns0:DEALSLIP_URL>
	                        }
	                    </ns1:TRANSACTION_INFO>
	                  )
            }
        </ns1:otherBankCheckPymtResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:otherbankCheckPymtGtOut($outputParameters)
