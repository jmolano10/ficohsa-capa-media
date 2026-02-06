xquery version "2004-draft";
(:: pragma  parameter="$productosXPais" type="anyType" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultipleProductosResponse/ns0:ASSETS" location="../xsd/sjConsultaMultipleProductos.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductos";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultiplesProductos/xq/consultaMultipleProductosErrorAssetsOut/";

declare function xf:consultaMultipleProductosErrorAssetsOut($productosXPais as element(*))
    as element() {
        <ns0:ASSETS>
            {
            	for $PRODUCT in $productosXPais/PRODUCTOS/PRODUCTO
		        return
		        if (fn:string($PRODUCT/TYPE/text()) = ('AHO', 'CHQ', 'DEP', 'FPC')) then (
			        <ns0:ASSET>
						<ns0:ID>{$PRODUCT/ID/text()}</ns0:ID>
						<ns0:TYPE>{$PRODUCT/TYPE/text()}</ns0:TYPE>
						<ns0:SOURCE_BANK>{$productosXPais/CODIGO/text()}</ns0:SOURCE_BANK>
						<ns0:SUCCESS_INDICATOR>ERROR</ns0:SUCCESS_INDICATOR>
						<ns0:ERROR_MESSAGE>PAIS NO IMPLEMENTADO</ns0:ERROR_MESSAGE>
					</ns0:ASSET>
				) else ("")
            }
        </ns0:ASSETS>
};

declare variable $productosXPais as element(*) external;

xf:consultaMultipleProductosErrorAssetsOut($productosXPais)