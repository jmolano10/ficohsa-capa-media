xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$subscribeProducto" element="ns1:subscribeProducto" location="../../AlertasProductos/xsd/alertasProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Alertas/administracionSubscripcion/xsd/administracionSubscripcion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/administracionSubscripcion_db";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/alertasProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SubscribeProducto/xq/administracionSubscripcionHNIn/";

declare function xf:administracionSubscripcionHNIn($subscribeProducto as element(ns1:subscribeProducto),
    $pais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_PAIS_ORIGEN>{ fn:substring($pais,1,2) }</ns0:P_PAIS_ORIGEN>
            <ns0:P_CODIGO_CLIENTE>{ data($subscribeProducto/CUSTOMER_ID) }</ns0:P_CODIGO_CLIENTE>
            <ns0:P_TIPO_PRODUCTO>{ data($subscribeProducto/PRODUCT_TYPE) }</ns0:P_TIPO_PRODUCTO>
            <ns0:P_NUMERO_PRODUCTO>{ data($subscribeProducto/PRODUCT_NUMBER) }</ns0:P_NUMERO_PRODUCTO>
            <ns0:P_TIPO_ALERTA>{ data($subscribeProducto/ALERT_TYPE) }</ns0:P_TIPO_ALERTA>
            <ns0:P_ACCION>{ data($subscribeProducto/ACTION) }</ns0:P_ACCION>
        </ns0:InputParameters>
};

declare variable $subscribeProducto as element(ns1:subscribeProducto) external;
declare variable $pais as xs:string external;

xf:administracionSubscripcionHNIn($subscribeProducto,
    $pais)