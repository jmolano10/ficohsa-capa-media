(:: pragma bea:global-element-parameter parameter="$consultaDestinos" element="ns1:consultaDestinos" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaDestinos/xsd/consultaDestinos_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDestinos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDestinos/xq/consultaDestinosHNIn/";

declare function xf:consultaDestinosHNIn($consultaDestinos as element(ns1:consultaDestinos))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>            
            	<ns0:P_ECONOMIC_ACTIVITY_CODE>{ data($consultaDestinos/ECONOMIC_ACTIVITY_CODE) }</ns0:P_ECONOMIC_ACTIVITY_CODE>
            	<ns0:P_INVESTMENT_CODE>{ data($consultaDestinos/INVESTMENT_CODE) }</ns0:P_INVESTMENT_CODE>
            	<ns0:P_INVESTMENT_SUB>{ data($consultaDestinos/QUERY_TYPE/INVESTMENT_SUB_CODE) }</ns0:P_INVESTMENT_SUB>
           		<ns0:P_RETURN_DESTINATION>{ data($consultaDestinos/QUERY_TYPE/RETURN_DESTINATION) }</ns0:P_RETURN_DESTINATION>
        </ns0:InputParameters>
};

declare variable $consultaDestinos as element(ns1:consultaDestinos) external;

xf:consultaDestinosHNIn($consultaDestinos)