(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../BusinessServices/AbanksGT/ConsFactura/xsd/MCConsFactura_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:billQueryResponse" location="../../xsd/BillOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/billOperationsTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsFactura";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillQuery/xq/billQueryGTOut/";

declare function xf:billQueryGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:billQueryResponse) {
        <ns0:billQueryResponse>
            {
                for $PV_CONTRACT_ID in $outputParameters/ns1:PV_CONTRACT_ID
                return
                    <ns0:CONTRACT_ID>{ data($PV_CONTRACT_ID) }</ns0:CONTRACT_ID>
            }
            {
                for $PV_CONTRACT_NAME in $outputParameters/ns1:PV_CONTRACT_NAME
                return
                    <ns0:CONTRACT_NAME>{ data($PV_CONTRACT_NAME) }</ns0:CONTRACT_NAME>
            }
            {
                for $PV_DEBTOR_CODE in $outputParameters/ns1:PV_DEBTOR_CODE
                return
                    <ns0:DEBTOR_CODE>{ data($PV_DEBTOR_CODE) }</ns0:DEBTOR_CODE>
            }
            {
                for $PV_DEBTOR_NAME in $outputParameters/ns1:PV_DEBTOR_NAME
                return
                    <ns0:DEBTOR_NAME>{ data($PV_DEBTOR_NAME) }</ns0:DEBTOR_NAME>
            }
            {
                for $PR_BILLS in $outputParameters/ns1:PR_BILLS
                return                
                    <ns0:BILLS>
                        {
                            for $BILL_ITEM in $PR_BILLS/ns1:BILL/ns1:BILL_ITEM
                            return
                            	if( empty($BILL_ITEM/*) )then(
                            	
            					)else(
                            		<ns0:BILL>
	                                    <ns0:ID>{ data($BILL_ITEM/ns1:ID) }</ns0:ID>
	                                    <ns0:DESCRIPTION>{ data($BILL_ITEM/ns1:DESCRIPTION) }</ns0:DESCRIPTION>
	                                    <ns0:CURRENCY>{ data($BILL_ITEM/ns1:CURRENCY) }</ns0:CURRENCY>
	                                    <ns0:ISSUE_DATE>{ data($BILL_ITEM/ns1:ISSUE_DATE) }</ns0:ISSUE_DATE>
	                                    <ns0:DUE_DATE>{ data($BILL_ITEM/ns1:DUE_DATE) }</ns0:DUE_DATE>
	                                    {
	                                        for $BILL_AMOUNT in $BILL_ITEM/ns1:BILL_AMOUNT
	                                        return
	                                            <ns0:BILL_AMOUNT>{ data($BILL_AMOUNT) }</ns0:BILL_AMOUNT>
	                                    }
	                                    <ns0:LATE_FEE>{ data($BILL_ITEM/ns1:LATE_FEE) }</ns0:LATE_FEE>
	                                    <ns0:TOTAL_AMOUNT>{ data($BILL_ITEM/ns1:TOTAL_AMOUNT) }</ns0:TOTAL_AMOUNT>
                               		 </ns0:BILL>
                                )
                        }
                    </ns0:BILLS>
              
            }
        </ns0:billQueryResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:billQueryGTOut($outputParameters)
