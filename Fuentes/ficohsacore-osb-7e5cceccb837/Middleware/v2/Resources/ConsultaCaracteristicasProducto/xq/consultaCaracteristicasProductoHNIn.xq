(:: pragma bea:global-element-parameter parameter="$consultaCaracteristicasProducto" element="ns0:consultaCaracteristicasProducto" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/consultaCaracteristicasProducto/xsd/consultaCaracteristicasProducto_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCaracteristicasProducto";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCaracteristicasProducto/xq/consultaCaracteristicasProductoHNIn/";

declare function xf:consultaCaracteristicasProductoHNIn($consultaCaracteristicasProducto as element(ns0:consultaCaracteristicasProducto))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:P_LOAN_PRODUCT>{ data($consultaCaracteristicasProducto/LOAN_PRODUCT) }</ns1:P_LOAN_PRODUCT>
            <ns1:P_OBLIGATION>{ data($consultaCaracteristicasProducto/OBLIGATION) }</ns1:P_OBLIGATION>
            <ns1:P_GUARANTEE>{ data($consultaCaracteristicasProducto/GUARANTEE) }</ns1:P_GUARANTEE>
            <ns1:P_REPAYMENT>{ data($consultaCaracteristicasProducto/REPAYMENT) }</ns1:P_REPAYMENT>
        </ns1:InputParameters>
};

declare variable $consultaCaracteristicasProducto as element(ns0:consultaCaracteristicasProducto) external;

xf:consultaCaracteristicasProductoHNIn($consultaCaracteristicasProducto)