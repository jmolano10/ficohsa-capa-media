(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../BusinessServices/AbanksGT/REFDiferencia/xsd/MCREFDiferencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:tillDifferenceReportResponse" location="../../xsd/TillOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/TillOperationsTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCREFDiferencia";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/TillOperations/TillDifferenceReport/xq/tillDifferenceReportGTOut/";

declare function xf:tillDifferenceReportGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:tillDifferenceReportResponse) {
        <ns0:tillDifferenceReportResponse>
            {
                for $PR_TRANSACTION_INFO in $outputParameters/ns1:PR_TRANSACTION_INFO
                return
                	if( empty($PR_TRANSACTION_INFO/*) )then(
                	
                	)else(
		                <ns0:TRANSACTION_INFO>
		                    {
		                        for $DEALSLIP in $PR_TRANSACTION_INFO/ns1:DEALSLIP
		                        return
		                            <ns2:DEALSLIP>
		                                {
		                                    for $DS_RECORD_ITEM in $DEALSLIP/ns1:DS_RECORD/ns1:DS_RECORD_ITEM
		                                    return
		                                        <ns2:DS_RECORD>{ data($DS_RECORD_ITEM) }</ns2:DS_RECORD>
		                                }
		                            </ns2:DEALSLIP>
		                    }
		                    <ns2:TXN_REF_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns1:TXN_REF_ID)) }</ns2:TXN_REF_ID>
		                    <ns2:TXN_TYPE_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns1:TXN_TYPE_ID)) }</ns2:TXN_TYPE_ID>
		                    <ns2:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns1:TXN_DATE) }</ns2:TXN_DATE>
		                    <ns2:CURRENCY>{ data($PR_TRANSACTION_INFO/ns1:CURRENCY) }</ns2:CURRENCY>
		                    <ns2:AMOUNT>{ data($PR_TRANSACTION_INFO/ns1:AMOUNT) }</ns2:AMOUNT>
		                    <ns2:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns1:DATE_TIME) }</ns2:DATE_TIME>
		                    <ns2:USER>{ data($PR_TRANSACTION_INFO/ns1:USER_TX) }</ns2:USER>
		                    <ns2:BRANCH_ID>{ xs:integer(data($PR_TRANSACTION_INFO/ns1:BRANCH_ID)) }</ns2:BRANCH_ID>
		                    <ns2:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns1:BRANCH_NAME) }</ns2:BRANCH_NAME>
		                    <ns2:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns1:REQUIRES_CTR) }</ns2:REQUIRES_CTR>
		                    {
		                        for $DEALSLIP_URL in $PR_TRANSACTION_INFO/ns1:DEALSLIP_URL
		                        return
		                            <ns2:DEALSLIP_URL>{ data($DEALSLIP_URL) }</ns2:DEALSLIP_URL>
		                    }
		                </ns0:TRANSACTION_INFO>
		              )
            }
        </ns0:tillDifferenceReportResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:tillDifferenceReportGTOut($outputParameters)
