xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosGT" element="ns0:sjConsultaMultipleProductosGT" location="../xsd/sjConsultaMultipleProductosGT.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xq/agruparTipos/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosGT";

declare function xf:agruparTipos($sjConsultaMultipleProductosGT as element(ns0:sjConsultaMultipleProductosGT))
    as element(*) {
        let $tipos := distinct-values($sjConsultaMultipleProductosGT/ns0:PRODUCTS/ns0:PRODUCT/ns0:TYPE)
		return
		<TYPES>
			{
				for $i in 1 to count($tipos)
				return
					<TYPE>
						<NAME_TYPE>{$tipos[$i]}</NAME_TYPE>		
						<PRODUCTS>
							{
								for $producto in  $sjConsultaMultipleProductosGT/ns0:PRODUCTS/ns0:PRODUCT
								where $producto/ns0:TYPE = $tipos[$i]
								return
									<ID>{fn:string($producto/ns0:ID/text())}</ID>
							}
						</PRODUCTS>
	    			</TYPE>
			}
    	</TYPES>
};

declare variable $sjConsultaMultipleProductosGT as element(ns0:sjConsultaMultipleProductosGT) external;

xf:agruparTipos($sjConsultaMultipleProductosGT)