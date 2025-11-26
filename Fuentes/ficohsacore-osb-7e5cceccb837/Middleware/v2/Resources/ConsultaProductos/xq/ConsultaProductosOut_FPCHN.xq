(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/listadoProductos/xsd/listadoProductosFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProductosResponse" location="../xsd/consultaProductosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoProductosFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductos/xq/ConsultaProductosOut_FPCHN/";

declare function xf:ConsultaProductosOut_FPCHN($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaProductosResponse) {
        <ns0:consultaProductosResponse>
            <ns0:PRODUCT_LIST>
                {
                for $PRODUCT_CODE in fn:distinct-values($outputParameters1/ns1:T_PRODUCTOS/ns1:T_PRODUCTOS_ITEM/ns1:COD_PRODUCTO/text())
                return
                	<PRODUCT_ITEM>
                		<COMPANY_CODE>FPCHN</COMPANY_CODE>
                		<PRODUCT_CODE>{$PRODUCT_CODE}</PRODUCT_CODE>
                		<PRODUCT_DESCRIPTION>{$outputParameters1/ns1:T_PRODUCTOS/ns1:T_PRODUCTOS_ITEM[ns1:COD_PRODUCTO=$PRODUCT_CODE][1]/ns1:DES_PRODUCTO/text()}</PRODUCT_DESCRIPTION>
						<PRODUCT_CURRENCY_CODE/>                						
                		<SUB_PRODUCT_LIST>
						{                		
                			let $SUB_PRODUCT_LIST := $outputParameters1/ns1:T_PRODUCTOS/ns1:T_PRODUCTOS_ITEM[ns1:COD_PRODUCTO=$PRODUCT_CODE]
                			for $SUB_PRODUCT_CODE in fn:distinct-values($SUB_PRODUCT_LIST/ns1:COD_SUB_PRODUCTO/text())
                			return
                				<SUB_PRODUCT_ITEM>
                					<SUB_PRODUCT_CODE>{$SUB_PRODUCT_CODE}</SUB_PRODUCT_CODE>		
                					<SUB_PRODUCT_DESCRIPTION>{$outputParameters1/ns1:T_PRODUCTOS/ns1:T_PRODUCTOS_ITEM[ns1:COD_PRODUCTO=$PRODUCT_CODE and ns1:COD_SUB_PRODUCTO=$SUB_PRODUCT_CODE][1]/ns1:DES_SUB_PRODUCTO/text()}</SUB_PRODUCT_DESCRIPTION>
                					<SUB_PRODUCT_CURRENCY_CODE/>
                				</SUB_PRODUCT_ITEM>
                		}
                		</SUB_PRODUCT_LIST>
                	</PRODUCT_ITEM>
                }
            </ns0:PRODUCT_LIST>
        </ns0:consultaProductosResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ConsultaProductosOut_FPCHN($outputParameters1)