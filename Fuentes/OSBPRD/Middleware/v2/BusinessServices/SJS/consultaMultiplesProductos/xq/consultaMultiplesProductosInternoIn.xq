xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$productosxPais" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns0:consultaMultipleProductosInterno" location="../../../../Resources/ConsultaMultipleProductosInterno/xsd/consultaMultipleProductosInternoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultiplesProductos/xq/consultaMultiplesProductosInternoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMultipleProductosInternoTypes";

declare function xf:consultaMultiplesProductosInternoIn($productosxPais as element(*),$posicionPais as xs:int)
    as element(ns0:consultaMultipleProductosInterno) {
    <ns0:consultaMultipleProductosInterno>
    	{
			let $productos := $productosxPais/PAIS[$posicionPais]/PRODUCTOS
			return
		    	<PRODUCTS>
		    		{
			    		for $i in 1 to count($productos/PRODUCTO)
			    		return
				    		<PRODUCT>
				    			<ID>{fn:string($productos/PRODUCTO[$i]/ID/text())}</ID>
								<TYPE>{fn:string($productos/PRODUCTO[$i]/TYPE/text())}</TYPE>
				    		</PRODUCT>
		    		}
		    	</PRODUCTS>
   		}
    </ns0:consultaMultipleProductosInterno>
};

declare variable $productosxPais as element(*) external;
declare variable $posicionPais as xs:int external;

xf:consultaMultiplesProductosInternoIn($productosxPais,$posicionPais)