xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/consultaCaracteristicasProducto/xsd/consultaCaracteristicasProducto_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCaracteristicasProductoResponse" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCaracteristicasProducto";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCaracteristicasProducto/xq/consultaCaracteristicasProductoHNOut/";

declare function xf:consultaCaracteristicasProductoHNOut($LOAN_PRODUCT as xs:int,$outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaCaracteristicasProductoResponse) {
        <ns0:consultaCaracteristicasProductoResponse>
			<LOAN_PRODUCT>{ $LOAN_PRODUCT }</LOAN_PRODUCT>
			{
                for $P_LOAN_PRODUCT_DESC in $outputParameters/ns1:P_LOAN_PRODUCT_DESC
                return
                    <LOAN_PRODUCT_DESC>{ data($P_LOAN_PRODUCT_DESC) }</LOAN_PRODUCT_DESC>
            }
            <LOAN_PRODUCT_DETAILS>
                <OBLIGATION_TYPES>
            	{
            	let $OBLIGATION_CODE :=  $outputParameters/ns1:P_OBLIGATION_CODE/ns1:P_OBLIGATION_CODE_ITEM
            	let $OBLIGATION_DESCRIPTION :=  $outputParameters/ns1:P_OBLIGATION_DESCRIPTION/ns1:P_OBLIGATION_DESCRIPTION_ITEM
            	for $i in 1 to count($OBLIGATION_CODE)
            	return(                 
                <OBLIGATION_TYPE>
                    	<CODE>{ data($OBLIGATION_CODE[$i]) }</CODE>
   						<DESCRIPTION>{ data($OBLIGATION_DESCRIPTION[$i]) }</DESCRIPTION>  
                </OBLIGATION_TYPE>
                )
				}
                </OBLIGATION_TYPES>
                <GUARANTEE_TYPES>
            	{
            	let $GUARANTEE_CODE :=  $outputParameters/ns1:P_GUARANTEE_CODE/ns1:P_GUARANTEE_CODE_ITEM
            	let $GUARANTEE_DESCRIPTION :=  $outputParameters/ns1:P_GUARANTEE_DESCRIPTION/ns1:P_OBLIGATION_DESCRIPTION_ITEM
            	return
	            	 if (count($GUARANTEE_CODE) < 1) then (
	    				<GUARANTEE_TYPE/>
					 )else(
		            	for $i in 1 to count($GUARANTEE_CODE)            	
		            	return(           
		                	<GUARANTEE_TYPE>
		                    	<CODE>{ data($GUARANTEE_CODE[$i]) }</CODE>
		   						<DESCRIPTION>{ data($GUARANTEE_DESCRIPTION[$i]) }</DESCRIPTION>  
		               		</GUARANTEE_TYPE>
		               	)
		             )
				}
                </GUARANTEE_TYPES>
                <REPAYMENT_TYPES>
            	{
            	let $REPAYMENT_CODE :=  $outputParameters/ns1:P_REPAYMENT_CODE/ns1:P_GUARANTEE_CODE_ITEM
            	let $REPAYMENT_DESCRIPTION :=  $outputParameters/ns1:P_REPAYMENT_TYPE_DESCRIPTION/ns1:P_OBLIGATION_DESCRIPTION_ITEM
            	return
	            	 if (count($REPAYMENT_CODE) < 1) then (
	    				<REPAYMENT_TYPE/>
					 )else(
            	for $i in 1 to count($REPAYMENT_CODE)
	            	return(   
	                	<REPAYMENT_TYPE>
	                    	<CODE>{ data($REPAYMENT_CODE[$i]) }</CODE>
	   						<DESCRIPTION>{ data($REPAYMENT_DESCRIPTION[$i]) }</DESCRIPTION>  
	                	</REPAYMENT_TYPE>
	                )
	               )
				}
                </REPAYMENT_TYPES>                                  
            </LOAN_PRODUCT_DETAILS>
        </ns0:consultaCaracteristicasProductoResponse>
};

declare variable $LOAN_PRODUCT as xs:int external;
declare variable $outputParameters as element(ns1:OutputParameters) external;


xf:consultaCaracteristicasProductoHNOut($LOAN_PRODUCT,$outputParameters)