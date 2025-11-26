(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../BusinessServices/AbanksGT/CONSTransaccionVNT/xsd/MCCONSTransaccionVNT_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:tillOperationsQueryResponse" location="../../xsd/TillOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/TillOperationsTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSGT/MGC_K_OPERACIONES_VENTANILLA/MC_CONS_TRANSACCION_VNT/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/TillOperations/TillOperationsQuery/xq/tillOperationsQueryGTOut/";

declare function xf:tillOperationsQueryGTOut($outputParameters as element(ns2:OutputParameters))
    as element(ns0:tillOperationsQueryResponse) {
        <ns0:tillOperationsQueryResponse>
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns2:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO/*) )then(
                	
                	)else(
		                <ns0:TRANSACTION_INFO>
		                    {
		                        for $DEALSLIP in $PR_TRANSACTION_INFO/ns2:DEALSLIP
		                        return
		                            <ns1:DEALSLIP>
		                                {
		                                    for $DS_RECORD_ITEM in $DEALSLIP/ns2:DS_RECORD/ns2:DS_RECORD_ITEM
		                                    return
		                                        <ns1:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns1:DS_RECORD>
		                                }
		                            </ns1:DEALSLIP>
		                    }
		                    <ns1:TXN_REF_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns2:TXN_REF_ID)) }</ns1:TXN_REF_ID>
		                    <ns1:TXN_TYPE_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns2:TXN_TYPE_ID)) }</ns1:TXN_TYPE_ID>
		                    <ns1:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns2:TXN_DATE) }</ns1:TXN_DATE>
		                    <ns1:CURRENCY>{ data($PR_TRANSACTION_INFO/ns2:CURRENCY) }</ns1:CURRENCY>
		                    <ns1:AMOUNT>{ data($PR_TRANSACTION_INFO/ns2:AMOUNT) }</ns1:AMOUNT>
		                    <ns1:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns2:DATE_TIME) }</ns1:DATE_TIME>
		                    <ns1:USER>{ data($PR_TRANSACTION_INFO/ns2:USER_TX) }</ns1:USER>
		                    <ns1:BRANCH_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns2:BRANCH_ID)) }</ns1:BRANCH_ID>
		                    <ns1:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_NAME) }</ns1:BRANCH_NAME>
		                    <ns1:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns2:REQUIRES_CTR) }</ns1:REQUIRES_CTR>
		                    {
		                        for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns2:DEALSLIP_URL
		                        return
		                            <ns1:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns1:DEALSLIP_URL>
		                    }
		                </ns0:TRANSACTION_INFO>
	                )
            }
        </ns0:tillOperationsQueryResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:tillOperationsQueryGTOut($outputParameters)
