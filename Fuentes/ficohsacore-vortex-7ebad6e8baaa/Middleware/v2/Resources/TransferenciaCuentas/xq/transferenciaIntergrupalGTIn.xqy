xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns2:transferenciaCuentasRequest" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/transferenciaIntergrupal/xsd/transferenciaIntergrupal_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciaIntergrupal";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaIntergrupalGTIn/";

declare function xf:transferenciaIntergrupalGTIn($transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest),
    $user as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        <ns1:PV_SOURCECOUNTRY>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'BANK']/VALUE) }</ns1:PV_SOURCECOUNTRY>
	            <ns1:PV_SOURCEDEBITACCOUNT>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'DEBIT_ACCOUNT']/VALUE) }</ns1:PV_SOURCEDEBITACCOUNT>
	            <ns1:PN_DEBITAMOUNT>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'DEBIT_AMOUNT']/VALUE) }</ns1:PN_DEBITAMOUNT>
	            <ns1:PV_DEBITCURRENCY>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'DEBIT_ACCOUNT_CURRENCY']/VALUE) }</ns1:PV_DEBITCURRENCY>
	            <ns1:PV_SENDINGNAME>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY = 'ACCOUNT_OWNER']/VALUE) }</ns1:PV_SENDINGNAME>
	            <ns1:PV_DESTINATIONCOUNTRY>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'BANK']/VALUE) }</ns1:PV_DESTINATIONCOUNTRY>
	            <ns1:PV_DESTINATIONCREDITACCOUNT>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'CREDIT_ACCOUNT']/VALUE) }</ns1:PV_DESTINATIONCREDITACCOUNT>
	            <ns1:PN_CREDITAMOUNT>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'CREDIT_AMOUNT']/VALUE) }</ns1:PN_CREDITAMOUNT>
	            <ns1:PV_CREDITCURRENCY>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'CREDIT_CURRENCY']/VALUE) }</ns1:PV_CREDITCURRENCY>
	            <ns1:PV_BENEFICIARYNAME>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/DESTINATION/KV_PAIR[KEY = 'ACCOUNT_OWNER']/VALUE) }</ns1:PV_BENEFICIARYNAME>
	            <ns1:PV_UID>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="UID"]/VALUE) }</ns1:PV_UID>
	            <ns1:PV_TYPETRANS>{ data($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="MODE"]/VALUE) }</ns1:PV_TYPETRANS>	                      		
                <ns1:PV_TYPEOPERATION>{ data($transferenciaCuentasRequest/DEBIT_CREDIT) }</ns1:PV_TYPEOPERATION>
                {               		        	
    				let $commission := data($transferenciaCuentasRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[KEY="COMMISSION"]/VALUE)        	      	
    				return	                   	            	 		            		          
            			if($commission != "")then(
            				<ns1:PV_COMISION>{ $commission }</ns1:PV_COMISION>
            		)else()
	            		            		         
		  		}            
	            <ns1:PV_DEBITACCOUNT>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</ns1:PV_DEBITACCOUNT>		            		           
	            <ns1:PV_CREDITACCOUNT>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</ns1:PV_CREDITACCOUNT>	            
	            <ns1:PN_TRANSFERAMOUNT>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</ns1:PN_TRANSFERAMOUNT>
	            
	            {
	                for $CURRENCY in $transferenciaCuentasRequest/CURRENCY
	                return
	                    <ns1:PV_TRANSFERCURRENCY>{ data($CURRENCY) }</ns1:PV_TRANSFERCURRENCY>
            	}
            	{
	                for $DESCRIPTION in $transferenciaCuentasRequest/DESCRIPTION
	                return
	                    <ns1:PV_DESCRIPTION>{ data($DESCRIPTION) }</ns1:PV_DESCRIPTION>
            
            	}
            	{
	                for $TRANSFER_DETAILS in $transferenciaCuentasRequest/TRANSFER_DETAILS
	                return
	                    <ns1:PV_TRANSFERDETAIL>{ data($TRANSFER_DETAILS) }</ns1:PV_TRANSFERDETAIL>
            	}
            	{
	                for $INTERFACE_REFERENCE_NO in $transferenciaCuentasRequest/INTERFACE_REFERENCE_NO
	                return
	                    <ns1:PV_INTERFACEREFERENCE>{ data($INTERFACE_REFERENCE_NO) }</ns1:PV_INTERFACEREFERENCE>
            	}
	        
	        
	            {
	                for $ITEM_LEVEL_1 in $transferenciaCuentasRequest/ITEM_LEVEL_1
	                return
	                    <ns1:PV_FINANCIALSECTORCATEGORY>{ data($ITEM_LEVEL_1) }</ns1:PV_FINANCIALSECTORCATEGORY>
            
            	}
            	{
		            for $ITEM_LEVEL_2 in $transferenciaCuentasRequest/ITEM_LEVEL_2
		            return
		                <ns1:PV_FINANCIALSECTORSUBCATEGORY>{ data($ITEM_LEVEL_2) }</ns1:PV_FINANCIALSECTORSUBCATEGORY>
                }    
                	        	
        		<ns1:PV_USER>{ $user }</ns1:PV_USER>
	        	
	        	{
	        		for $AUTHORIZATION_TICKET in $transferenciaCuentasRequest/AUTHORIZATION_TICKET
	            	return
	                <ns1:PV_TICKETAUTORIZACION>{ data($AUTHORIZATION_TICKET) }</ns1:PV_TICKETAUTORIZACION>
	        	}	     
        </ns1:InputParameters>
};

declare variable $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest) external;
declare variable $user as xs:string external;

xf:transferenciaIntergrupalGTIn($transferenciaCuentasRequest,
    $user)