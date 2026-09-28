(:: pragma bea:global-element-parameter parameter="$consultaProductosFinancieros" element="ns1:consultaProductosFinancieros" location="../xsd/consultaProductosFinancierosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/productosFinancieros/xsd/consultaProductosFinancieros_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaProductosFinancieros";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaProductosFinancierosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductosFinancieros/xq/consultaProductosFinancierosHNIn/";

declare function xf:consultaProductosFinancierosHNIn($consultaProductosFinancieros as element(ns1:consultaProductosFinancieros))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_APLICATION>{ data($consultaProductosFinancieros/APPLICATION) }</ns0:P_APLICATION>
            {
                for $PRODUCT_CODE in $consultaProductosFinancieros/PRODUCT_CODE
                return
                    <ns0:P_PRODUCT_CODE>{ data($PRODUCT_CODE) }</ns0:P_PRODUCT_CODE>
            }
        </ns0:InputParameters>
};

declare variable $consultaProductosFinancieros as element(ns1:consultaProductosFinancieros) external;

xf:consultaProductosFinancierosHNIn($consultaProductosFinancieros)