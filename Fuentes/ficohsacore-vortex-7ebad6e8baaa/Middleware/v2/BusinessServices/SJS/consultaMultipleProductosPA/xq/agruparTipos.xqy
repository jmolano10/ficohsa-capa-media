xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultiplesProductosPA" element="ns0:sjConsultaMultiplesProductosPA" location="../xsd/sjConsultaMultipleProductosPA.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/agruparTipos/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultiplesProductosPA";

declare function xf:agruparTipos($sjConsultaMultiplesProductosPA as element(ns0:sjConsultaMultiplesProductosPA))
    as element(*) {
        let $tipos := distinct-values($sjConsultaMultiplesProductosPA/ns0:PRODUCTS/ns0:PRODUCT/ns0:TYPE)
		return
		<TYPES>
			{
				for $i in 1 to count($tipos)
				return
					<TYPE>
						<NAME_TYPE>{$tipos[$i]}</NAME_TYPE>		
						<PRODUCTS>
							{
								for $producto in  $sjConsultaMultiplesProductosPA/ns0:PRODUCTS/ns0:PRODUCT
								where $producto/ns0:TYPE = $tipos[$i]
								return
									<ID>{fn:string($producto/ns0:ID/text())}</ID>
							}
						</PRODUCTS>
	    			</TYPE>
			}
    	</TYPES>
};

declare variable $sjConsultaMultiplesProductosPA as element(ns0:sjConsultaMultiplesProductosPA) external;

xf:agruparTipos($sjConsultaMultiplesProductosPA)