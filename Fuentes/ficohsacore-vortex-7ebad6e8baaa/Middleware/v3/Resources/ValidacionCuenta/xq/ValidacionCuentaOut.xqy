xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$RSPDetallesCuenta" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuentaResponse" location="../xsd/validacionCuentaType.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuenta/xq/ValidacionCuentaOut2/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";

declare function xf:ValidacionCuentaOut2($RSPDetallesCuenta as element(ns0:ConsultadedetallesdelacuentaResponse),
    $accountFound as xs:string)
    as element(ns1:validacionCuentaResponse) {
        
	    <ns1:validacionCuentaResponse>
	    	<ACCOUNT_NUMBER>{ $accountFound }</ACCOUNT_NUMBER>
	    	{
	    		for $accountNameFound in data($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/SHORTTITLE)
	    		return
	    			<ACCOUNT_NAME>{ $accountNameFound }</ACCOUNT_NAME>
	    	}
	    	{
	    		for $accountCurrencyFound in data($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CURRENCY)
	    		return		            	
            		<CURRENCY>{ $accountCurrencyFound }</CURRENCY>           	
        	}
        	{
        		let $accountPostingRestrictFound := data($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/POSTINGRESTRICT)
				let $accountInactiveMarkerFound  := data($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/INACTIVEMARKER)
				return
	            	if($accountPostingRestrictFound = '') then 
	            		(
		            		if($accountInactiveMarkerFound = '') then
		            			(<ACCOUNT_STATUS>ACTIVE</ACCOUNT_STATUS>)
		            		else
		            			(<ACCOUNT_STATUS>INACTIVE</ACCOUNT_STATUS>)
	            		)
	            	else
	            		(<ACCOUNT_STATUS>{ fn:concat('BLOCKED ',$accountPostingRestrictFound) }</ACCOUNT_STATUS>)
        	}
	    	{
	    		for $accountCategoryFound in fn:number($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CATEGORY)
	    		return
	    			if ($accountCategoryFound >= 1000 and $accountCategoryFound <= 1999) then
		                (<PRODUCT_TYPE>CHQ</PRODUCT_TYPE>)
		            else if ($accountCategoryFound >= 6000 and $accountCategoryFound <= 6999) then
		                (<PRODUCT_TYPE>AHO</PRODUCT_TYPE>)
		            else
		                (<PRODUCT_TYPE></PRODUCT_TYPE>)
	    	}         	
        	{
	    		for $customerId in fn:string($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CUSTOMERNUMBER/text())
	    		return
	    			<CUSTOMER_ID>{$customerId}</CUSTOMER_ID>
	    	}   
	    	<KV_PAIRS>  	
        	{
	    		for $kvPair in fn:string($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/DEPREFACCOUNT/text())
	    		return
	    			if($kvPair = 'A') then 
	    				(
	    					<PAIR>
	    						<KEY>DEP_REF_ACCOUNT</KEY>
	    						<VALUE>YES</VALUE>
	    					</PAIR>
	    				)
	    			else
	    				(
	    					<PAIR>
	    						<KEY>DEP_REF_ACCOUNT</KEY>
	    						<VALUE>NO</VALUE>
	    					</PAIR>
	    				)
	    	}      
	    	</KV_PAIRS> 	
	    </ns1:validacionCuentaResponse>
};

declare variable $RSPDetallesCuenta as element(ns0:ConsultadedetallesdelacuentaResponse) external;
declare variable $accountFound as xs:string external;

xf:ValidacionCuentaOut2($RSPDetallesCuenta,
    $accountFound)