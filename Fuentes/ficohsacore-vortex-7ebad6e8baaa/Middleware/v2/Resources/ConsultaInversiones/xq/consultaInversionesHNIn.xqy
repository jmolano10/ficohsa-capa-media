xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaInversiones" element="ns0:consultaInversiones" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaInversiones/xsd/consultaInversiones_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInversiones";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInversiones/xq/consultaInversionesHNIn/";

declare function xf:consultaInversionesHNIn($consultaInversiones as element(ns0:consultaInversiones))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_ECONOMIC_ACTIVITY_CODE>{ data($consultaInversiones/ECONOMIC_ACTIVITY_CODE) }</ns1:P_ECONOMIC_ACTIVITY_CODE>
            <ns1:P_INVESTMENT_CODE>{ data($consultaInversiones/QUERY_TYPE/INVESTMENT_CODE) }</ns1:P_INVESTMENT_CODE>
            <ns1:P_RETURN_INVESTMENT_SUB>{ data($consultaInversiones/QUERY_TYPE/RETURN_INVESTMENT_SUB) }</ns1:P_RETURN_INVESTMENT_SUB>
        </ns1:InputParameters>
};

declare variable $consultaInversiones as element(ns0:consultaInversiones) external;

xf:consultaInversionesHNIn($consultaInversiones)