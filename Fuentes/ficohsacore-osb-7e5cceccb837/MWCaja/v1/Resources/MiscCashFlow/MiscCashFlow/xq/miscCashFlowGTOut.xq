(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../BusinessServices/AbanksGT/RegFlujoEfectivo/xsd/MCRegFlujoEfectivo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:miscCashFlowResponse" location="../../xsd/MiscCashFlowTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/miscCashFlowTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCRegFlujoEfectivo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/MiscCashFlow/MiscCashFlow/xq/miscCashFlowGTOut/";

declare function xf:miscCashFlowGTOut($outputParameters as element(ns2:OutputParameters))
    as element(ns0:miscCashFlowResponse) {
        <ns0:miscCashFlowResponse>
            <ns0:TXN_ID>{ data($outputParameters/ns2:PN_TXN_ID) }</ns0:TXN_ID>
            {
                for $PV_TXN_NAME in $outputParameters/ns2:PV_TXN_NAME
                return
                    <ns0:TXN_NAME>{ data($PV_TXN_NAME) }</ns0:TXN_NAME>
            }
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
	                        <ns1:TXN_REF_ID>{ data($PR_TRANSACTION_INFO/ns2:TXN_REF_ID) }</ns1:TXN_REF_ID>
	                        <ns1:TXN_TYPE_ID>{ data($PR_TRANSACTION_INFO/ns2:TXN_TYPE_ID) }</ns1:TXN_TYPE_ID>
	                        <ns1:TXN_DATE>{ data($PR_TRANSACTION_INFO/ns2:TXN_DATE) }</ns1:TXN_DATE>
	                        <ns1:CURRENCY>{ data($PR_TRANSACTION_INFO/ns2:CURRENCY) }</ns1:CURRENCY>
	                        <ns1:AMOUNT>{ data($PR_TRANSACTION_INFO/ns2:AMOUNT) }</ns1:AMOUNT>
	                        <ns1:DATE_TIME>{ data($PR_TRANSACTION_INFO/ns2:DATE_TIME) }</ns1:DATE_TIME>
	                        <ns1:USER>{ data($PR_TRANSACTION_INFO/ns2:USER_TX) }</ns1:USER>
	                        <ns1:BRANCH_ID>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_ID) }</ns1:BRANCH_ID>
	                        <ns1:BRANCH_NAME>{ data($PR_TRANSACTION_INFO/ns2:BRANCH_NAME) }</ns1:BRANCH_NAME>
	                        <ns1:REQUIRES_CTR>{ data($PR_TRANSACTION_INFO/ns2:REQUIRES_CTR) }</ns1:REQUIRES_CTR>
	                        <ns1:DEALSLIP_URL>{ data($PR_TRANSACTION_INFO/ns2:DEALSLIP_URL) }</ns1:DEALSLIP_URL>
	                    </ns0:TRANSACTION_INFO>
                  )
            }
        </ns0:miscCashFlowResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:miscCashFlowGTOut($outputParameters)
