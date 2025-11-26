(:: pragma bea:global-element-parameter parameter="$generaEstadoCuentaTC" element="ns0:generaEstadoCuentaTC" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/VASA/obtenerUrlEstadosCuenta/xsd/ObtenerUrl_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerUrl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTC/xq/ObtenerUrlHNIN/";

declare function xf:ObtenerUrlHNIN($generaEstadoCuentaTC as element(ns0:generaEstadoCuentaTC),
    $producttypevalue as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_PRODUCT_TYPE>{ $producttypevalue }</ns1:P_PRODUCT_TYPE>
            <ns1:P_PRODUCT_VALUE>{ data($generaEstadoCuentaTC/PRODUCT_VALUE) }</ns1:P_PRODUCT_VALUE>
            <ns1:PERIODO>{ fn:concat(data($generaEstadoCuentaTC/YEAR),data($generaEstadoCuentaTC/MONTH)) }</ns1:PERIODO>
            <ns1:P_NUMERO_TARJETA>{ data($generaEstadoCuentaTC/PRODUCT_VALUE) }</ns1:P_NUMERO_TARJETA>
            <ns1:P_MES>{ data($generaEstadoCuentaTC/MONTH) }</ns1:P_MES>
            <ns1:P_ANIO>{ data($generaEstadoCuentaTC/YEAR) }</ns1:P_ANIO>
        </ns1:InputParameters>
};

declare variable $generaEstadoCuentaTC as element(ns0:generaEstadoCuentaTC) external;
declare variable $producttypevalue as xs:string external;

xf:ObtenerUrlHNIN($generaEstadoCuentaTC,
    $producttypevalue)