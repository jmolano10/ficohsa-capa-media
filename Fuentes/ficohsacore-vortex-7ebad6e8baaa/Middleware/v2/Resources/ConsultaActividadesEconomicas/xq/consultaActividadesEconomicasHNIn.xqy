xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaActividadesEconomicas" element="ns1:consultaActividadesEconomicas" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaActividadesEconomicas/xsd/consultaActividadesEconomicas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActividadesEconomicas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActividadesEconomicas/xq/consultaActividadesEconomicasHNIn/";

declare function xf:consultaActividadesEconomicasHNIn($consultaActividadesEconomicas as element(ns1:consultaActividadesEconomicas))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_TYPE>{ data($consultaActividadesEconomicas/QUERY_INFO/TYPE) }</ns0:P_TYPE>
            <ns0:P_INITIAL_RANGE>{ data($consultaActividadesEconomicas/QUERY_INFO/INITIAL_RECORD) }</ns0:P_INITIAL_RANGE>
            <ns0:P_FINAL_RANGE>{ data($consultaActividadesEconomicas/QUERY_INFO/FINAL_RECORD) }</ns0:P_FINAL_RANGE>
        </ns0:InputParameters>
};

declare variable $consultaActividadesEconomicas as element(ns1:consultaActividadesEconomicas) external;

xf:consultaActividadesEconomicasHNIn($consultaActividadesEconomicas)