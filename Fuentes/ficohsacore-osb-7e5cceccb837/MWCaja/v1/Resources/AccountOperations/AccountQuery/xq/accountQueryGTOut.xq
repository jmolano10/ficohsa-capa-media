(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../BusinessServices/AbanksGT/ConsultaCuenta/xsd/MCConsultaCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:accountQueryResponse" location="../../xsd/AccountOperationsTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/accountTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsultaCuenta";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/AccountOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/AccountOperations/AccountQuery/xq/accountQueryGTOut/";

declare function xf:accountQueryGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:accountQueryResponse) {
        <ns0:accountQueryResponse>
            {
                for $PR_ACCOUNT_INFO in $outputParameters/ns1:PR_ACCOUNT_INFO
                return
                	if( empty($PR_ACCOUNT_INFO/*) )then(
                		
                	)else(
                		<ns0:ACCOUNT_INFO>
	                        <ns2:NUMBER>{ data($PR_ACCOUNT_INFO/ns1:NUMBERS) }</ns2:NUMBER>
	                        <ns2:NAME>{ data($PR_ACCOUNT_INFO/ns1:NAME) }</ns2:NAME>
	                        <ns2:CURRENCY>{ data($PR_ACCOUNT_INFO/ns1:CURRENCY) }</ns2:CURRENCY>
	                        <ns2:TYPE>{ data($PR_ACCOUNT_INFO/ns1:TYPE) }</ns2:TYPE>
	                        <ns2:STATUS>{ data($PR_ACCOUNT_INFO/ns1:STATUS) }</ns2:STATUS>
                    	</ns0:ACCOUNT_INFO>
                	)                   
            }
            {
                for $PR_SIGNATURES in $outputParameters/ns1:PR_SIGNATURES
                return
                	if( empty($PR_SIGNATURES/*) )then(
                	
                	)else(
                		<ns0:SIGNATURES>
	                        <ns2:REGISTERED>{ data($PR_SIGNATURES/ns1:REGISTERED) }</ns2:REGISTERED>
	                        <ns2:REQUIRED>{ data($PR_SIGNATURES/ns1:REQUIRED) }</ns2:REQUIRED>
	                        <ns2:DESCRIPTION>{ data($PR_SIGNATURES/ns1:DESCRIPTION) }</ns2:DESCRIPTION>
	                        {
	                            for $SIGNATURE_ITEM in $PR_SIGNATURES/ns1:SIGNATURE/ns1:SIGNATURE_ITEM
	                            return
	                            	
	                            		<ns2:SIGNATURE>
		                                    <ns2:TYPE>{ data($SIGNATURE_ITEM/ns1:TYPE) }</ns2:TYPE>
		                                    <ns2:NAME>{ data($SIGNATURE_ITEM/ns1:NAME) }</ns2:NAME>
		                                    <ns2:IMAGE>{ data($SIGNATURE_ITEM/ns1:IMAGE) }</ns2:IMAGE>
		                                    <ns2:FILE_EXTENSION>{ data($SIGNATURE_ITEM/ns1:FILE_EXTENSION) }</ns2:FILE_EXTENSION>
	                                	</ns2:SIGNATURE>
	                            	                    
	                        }
                    	</ns0:SIGNATURES>
                	)
                    
            }
            {
                for $PR_PASSBOOK_INFO in $outputParameters/ns1:PR_PASSBOOK_INFO
                return
                		if( empty($PR_PASSBOOK_INFO/*) )then(
                		
                		)else(
                			<ns0:PASSBOOK_INFO>
		                        <ns2:TYPE>{ data($PR_PASSBOOK_INFO/ns1:TYPE) }</ns2:TYPE>
		                        <ns2:ID>{ data($PR_PASSBOOK_INFO/ns1:ID) }</ns2:ID>
                   		 	</ns0:PASSBOOK_INFO>
                		)
                		
                	
                    
            }
        </ns0:accountQueryResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:accountQueryGTOut($outputParameters)
