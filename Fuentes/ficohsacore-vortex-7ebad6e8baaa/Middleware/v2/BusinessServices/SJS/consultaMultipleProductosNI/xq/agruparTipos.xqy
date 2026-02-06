xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosNI" element="ns0:sjConsultaMultipleProductosNI" location="../xsd/sjConsultaMultipleProductosNI.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/agruparTipos/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosNI";

declare function xf:agruparTipos($sjConsultaMultipleProductosNI as element(ns0:sjConsultaMultipleProductosNI))
    as element(*) {
    
    let $tipos := distinct-values($sjConsultaMultipleProductosNI/ns0:PRODUCTS/ns0:PRODUCT/ns0:TYPE)
		return
		<TYPES>
			{
				for $i in 1 to count($tipos)
				return
					<TYPE>
						<NAME_TYPE>{$tipos[$i]}</NAME_TYPE>		
						<PRODUCTS>
							{
								for $producto in  $sjConsultaMultipleProductosNI/ns0:PRODUCTS/ns0:PRODUCT
								where $producto/ns0:TYPE = $tipos[$i]
								return
									<ID>{fn:string($producto/ns0:ID/text())}</ID>
							}
						</PRODUCTS>
	    			</TYPE>
			}
    	</TYPES>
};

declare variable $sjConsultaMultipleProductosNI as element(ns0:sjConsultaMultipleProductosNI) external;

xf:agruparTipos($sjConsultaMultipleProductosNI)