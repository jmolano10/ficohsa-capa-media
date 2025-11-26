(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../BusinessServices/AbanksGT/CONFSaldoLibreta/xsd/MCCONFSaldoLibreta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:passbookBalanceConfirmationResponse" location="../../xsd/AccountPassbookOperationsTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/accountPassbookOperationsTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCCONFSaldoLibreta";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/AccountPassbookOperations/PassbookBalanceConfirmation/xq/passbookBalanceConfirmationGTOut/";

declare function xf:passbookBalanceConfirmationGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:passbookBalanceConfirmationResponse) {
        <ns0:passbookBalanceConfirmationResponse>
            {
                for $PV_ACCOUNT_NUMBER in $outputParameters/ns1:PV_ACCOUNT_NUMBER
                return
                    <ns0:ACCOUNT_NUMBER>{ data($PV_ACCOUNT_NUMBER) }</ns0:ACCOUNT_NUMBER>
            }
            {
                for $PV_CONFIRMATION_RESULT in $outputParameters/ns1:PV_CONFIRMATION_RESULT
                return
                    <ns0:CONFIRMATION_RESULT>{ data($PV_CONFIRMATION_RESULT) }</ns0:CONFIRMATION_RESULT>
            }
            {
                for $PR_LAST_PASSBOOK_ENTRY in $outputParameters/ns1:PR_LAST_PASSBOOK_ENTRY
                return
                	if( empty($PR_LAST_PASSBOOK_ENTRY/*) )then(
                	)else(
                		<ns0:LAST_PASSBOOK_ENTRY>
	                        <ns0:DATE>{ data($PR_LAST_PASSBOOK_ENTRY/ns1:LAST_DATE) }</ns0:DATE>
	                        <ns0:AMOUNT>{ data($PR_LAST_PASSBOOK_ENTRY/ns1:AMOUNT) }</ns0:AMOUNT>
	                        <ns0:NATURE>{ data($PR_LAST_PASSBOOK_ENTRY/ns1:NATURE) }</ns0:NATURE>
                    	</ns0:LAST_PASSBOOK_ENTRY>
                	)
                    
            }
        </ns0:passbookBalanceConfirmationResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:passbookBalanceConfirmationGTOut($outputParameters)
