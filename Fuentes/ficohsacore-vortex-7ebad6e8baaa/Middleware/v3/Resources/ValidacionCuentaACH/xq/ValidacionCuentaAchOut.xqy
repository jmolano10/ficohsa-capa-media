xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$RSPDetallesCuenta" element="ns0:DetalleValidacionCuentaACHResponse" location="../../../../Business_Resources/ConsultasCuenta/ConsultaDetalleValidacionCuenta/xsd/services_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuentaAchResponse" location="../xsd/validacionCuentaAchType.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaAchType";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuentaACH/xq/ValidacionCuentaAchOut/";

declare function xf:ValidacionCuentaAchOut($RSPDetallesCuenta as element(ns0:DetalleValidacionCuentaACHResponse),
    $accountFound as xs:string)
    as element(ns1:validacionCuentaAchResponse) {
        <ns1:validacionCuentaAchResponse>
             <ACCOUNT_NUMBER>{ $accountFound }</ACCOUNT_NUMBER>
            {
	    		for $accountNameFound in data($RSPDetallesCuenta/WSACCOUNTLISTACHType/gWSACCOUNTLISTACHDetailType/mWSACCOUNTLISTACHDetailType/SHORTTITLE)
	    		return
	    			<ACCOUNT_NAME>{ $accountNameFound }</ACCOUNT_NAME>
	    	}
            {
	    	   for $accountCurrencyFound in data($RSPDetallesCuenta/WSACCOUNTLISTACHType/gWSACCOUNTLISTACHDetailType/mWSACCOUNTLISTACHDetailType/CURRENCY)
	    		return		            	
            	<CURRENCY>{ $accountCurrencyFound }</CURRENCY>           	
        	}
        	{
        		let $accountPostingRestrictFound := data($RSPDetallesCuenta/WSACCOUNTLISTACHType/gWSACCOUNTLISTACHDetailType/mWSACCOUNTLISTACHDetailType/POSTINGRESTRICT)
				let $accountInactiveMarkerFound  := data($RSPDetallesCuenta/WSACCOUNTLISTACHType/gWSACCOUNTLISTACHDetailType/mWSACCOUNTLISTACHDetailType/INACTIVEMARKER)
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
	    		for $accountCategoryFound in fn:number($RSPDetallesCuenta/WSACCOUNTLISTACHType/gWSACCOUNTLISTACHDetailType/mWSACCOUNTLISTACHDetailType/CATEGORY)
	    		return
	    			if ($accountCategoryFound >= 1000 and $accountCategoryFound <= 1999) then
		                (<PRODUCT_TYPE>CHQ</PRODUCT_TYPE>)
		            else if ($accountCategoryFound >= 6000 and $accountCategoryFound <= 6999) then
		                (<PRODUCT_TYPE>AHO</PRODUCT_TYPE>)
		            else
		                (<PRODUCT_TYPE></PRODUCT_TYPE>)
	    	}         	
        	{
	    		for $customerId in fn:string($RSPDetallesCuenta/WSACCOUNTLISTACHType/gWSACCOUNTLISTACHDetailType/mWSACCOUNTLISTACHDetailType/CUSTOMERNUMBER/text())
	    		return
	    			<CUSTOMER_ID>{$customerId}</CUSTOMER_ID>
	    	}
	    	<KV_PAIRS>  	
        	{
	    		for $kvPair in fn:string($RSPDetallesCuenta/WSACCOUNTLISTACHType/gWSACCOUNTLISTACHDetailType/mWSACCOUNTLISTACHDetailType/DEPREFACCOUNT/text())
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
        </ns1:validacionCuentaAchResponse>
};

declare variable $RSPDetallesCuenta as element(ns0:DetalleValidacionCuentaACHResponse) external;
declare variable $accountFound as xs:string external;

xf:ValidacionCuentaAchOut($RSPDetallesCuenta,
    $accountFound)