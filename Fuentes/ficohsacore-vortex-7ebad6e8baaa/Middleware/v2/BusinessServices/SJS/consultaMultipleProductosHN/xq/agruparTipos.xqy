xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosHN" element="ns0:sjConsultaMultipleProductosHN" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/agruparTipos/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";

declare function xf:agruparTipos($sjConsultaMultipleProductosHN as element(ns0:sjConsultaMultipleProductosHN))
    as element(*) {
        let $tipos := distinct-values($sjConsultaMultipleProductosHN/ns0:PRODUCTS/ns0:PRODUCT/ns0:TYPE)
		return
		<TYPES>
			{
				for $i in 1 to count($tipos)
				return
					<TYPE>
						<NAME_TYPE>{$tipos[$i]}</NAME_TYPE>		
						<PRODUCTS>
							{
								for $producto in  $sjConsultaMultipleProductosHN/ns0:PRODUCTS/ns0:PRODUCT
								where $producto/ns0:TYPE = $tipos[$i]
								return
									<ID>{fn:string($producto/ns0:ID/text())}</ID>
							}
						</PRODUCTS>
	    			</TYPE>
			}
    	</TYPES>
};

declare variable $sjConsultaMultipleProductosHN as element(ns0:sjConsultaMultipleProductosHN) external;

xf:agruparTipos($sjConsultaMultipleProductosHN)