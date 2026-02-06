xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAprobadoras" element="ns1:consultaAprobadoras" location="../../CatalogosInfoCliente/xsd/catalogosInfoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CatalogosInfoCliente/consultaAprobadoras/xsd/consultaAprobadoras_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAprobadoras";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAprobadoras/xq/consultaAprobadorasHNIn/";

declare function xf:consultaAprobadorasHNIn($consultaAprobadoras as element(ns1:consultaAprobadoras))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_TYPE>{ data($consultaAprobadoras/QUERY_TYPE/TYPE) }</ns0:P_TYPE>
            {
                for $APPROVAL_CODE in $consultaAprobadoras/QUERY_TYPE/APPROVAL_CODE
                return
                    <ns0:P_APPROVAL_CODE>{ data($APPROVAL_CODE) }</ns0:P_APPROVAL_CODE>
            }
        </ns0:InputParameters>
};

declare variable $consultaAprobadoras as element(ns1:consultaAprobadoras) external;

xf:consultaAprobadorasHNIn($consultaAprobadoras)