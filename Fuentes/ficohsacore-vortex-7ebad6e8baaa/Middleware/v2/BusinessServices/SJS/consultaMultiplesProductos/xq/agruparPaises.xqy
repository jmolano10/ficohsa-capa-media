xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductos" element="ns0:sjConsultaMultipleProductos" location="../xsd/sjConsultaMultipleProductos.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultiplesProductos/xq/agruparPaises/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductos";

declare function xf:agruparPaises($sjConsultaMultipleProductos as element(ns0:sjConsultaMultipleProductos))
    as element(*) {
		let $paises := distinct-values($sjConsultaMultipleProductos/ns0:PRODUCTS/ns0:PRODUCT/ns0:REGION)
		return
			<PAISES>
				{
					for $i in 1 to count($paises)
					return
						<PAIS>
							<CODIGO>{$paises[$i]}</CODIGO>		
							<PRODUCTOS>
								{
									for $producto in  $sjConsultaMultipleProductos/ns0:PRODUCTS/ns0:PRODUCT
									where $producto/ns0:REGION = $paises[$i]
									return
										<PRODUCTO>
											<ID>{fn:string($producto/ns0:ID/text())}</ID>
											<TYPE>{fn:string($producto/ns0:TYPE/text())}</TYPE>
								    	</PRODUCTO>
								}
							</PRODUCTOS>
		    			</PAIS>
				}
    		</PAISES>
};

declare variable $sjConsultaMultipleProductos as element(ns0:sjConsultaMultipleProductos) external;

xf:agruparPaises($sjConsultaMultipleProductos)