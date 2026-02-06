xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/productosFinancieros/xsd/consultaProductosFinancieros_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaProductosFinancierosResponse" location="../xsd/consultaProductosFinancierosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaProductosFinancieros";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaProductosFinancierosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductosFinancieros/xq/consultaProductosFinancierosHNOut/";

declare function xf:consultaProductosFinancierosHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaProductosFinancierosResponse) {
        <ns1:consultaProductosFinancierosResponse>
            <PRODUCTS>                
				{
            	let $PRODUCT_ID_ITEM  :=  $outputParameters/ns0:P_PRODUCT_ID/ns0:P_PRODUCT_ID_ITEM
            	let $DESCRIPTION_ITEM  :=  $outputParameters/ns0:P_DESCRIPTION/ns0:P_DESCRIPTION_ITEM
            	let $CURRENCY_ITEM :=  $outputParameters/ns0:P_CURRENCY/ns0:P_CURRENCY_ITEM
            	let $STATUS :=  $outputParameters/ns0:P_STATUS/ns0:P_PRODUCT_ID_ITEM
            	for $i in 1 to count($PRODUCT_ID_ITEM)
            	return(            	            	
            	<PRODUCT>
                    	<ID>{ data($PRODUCT_ID_ITEM[$i]) }</ID>
   						<DESCRIPTION>{ data($DESCRIPTION_ITEM[$i]) }</DESCRIPTION>  				
                    	<CURRENCY>{ data($CURRENCY_ITEM[$i]) }</CURRENCY>
   						<STATUS>{ data($STATUS[$i]) }</STATUS> 
			 				                    
            	 </PRODUCT>            	
                ) 
                }                                
            </PRODUCTS>
        </ns1:consultaProductosFinancierosResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaProductosFinancierosHNOut($outputParameters)