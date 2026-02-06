xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldoCuentasBatch" element="ns0:consultaSaldoCuentasBatch" location="../../AlertasProductos/xsd/alertasProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/Alertas/consultaSaldoCuentas/xsd/consultaSaldoCuentas_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/alertasProductosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldoCuentas_db";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoCuentasBatch/xq/consultaSaldoCuentasHNIn/";

declare function xf:consultaSaldoCuentasHNIn($consultaSaldoCuentasBatch as element(ns0:consultaSaldoCuentasBatch))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_PAIS_ORIGEN>
            	{
                    for $ACCOUNT in $consultaSaldoCuentasBatch/ACCOUNTS/ACCOUNT
                    return
                         <ns1:P_CODIGO_MONEDA_ITEM>{ fn:substring(data($ACCOUNT/PRODUCT_REGION),1,2) }</ns1:P_CODIGO_MONEDA_ITEM>
                }         
            </ns1:P_PAIS_ORIGEN>
            <ns1:P_NUMERO_PRODUCTO>
                {
                    for $ACCOUNT in $consultaSaldoCuentasBatch/ACCOUNTS/ACCOUNT
                    return
                        <ns1:P_NUMERO_PRODUCTO_ITEM>{ data($ACCOUNT/ID) }</ns1:P_NUMERO_PRODUCTO_ITEM>
                }
            </ns1:P_NUMERO_PRODUCTO>
        </ns1:InputParameters>
};

declare variable $consultaSaldoCuentasBatch as element(ns0:consultaSaldoCuentasBatch) external;

xf:consultaSaldoCuentasHNIn($consultaSaldoCuentasBatch)