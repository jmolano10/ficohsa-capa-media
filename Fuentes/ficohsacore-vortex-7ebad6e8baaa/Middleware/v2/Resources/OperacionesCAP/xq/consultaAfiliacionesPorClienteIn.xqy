xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAfiliacionesPorClienteRequest" element="ns0:consultaAfiliacionesPorClienteRequest" location="../xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaAfiliacionesPorCliente/xsd/consultaAfiliacionesPorCliente_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAfiliacionesPorCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/consultaAfiliacionesPorClienteIn/";

declare function xf:consultaAfiliacionesPorClienteIn($consultaAfiliacionesPorClienteRequest as element(ns0:consultaAfiliacionesPorClienteRequest),
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_PAIS>{ $codigoPais }</ns1:PV_CODIGO_PAIS>
            <ns1:PV_ID_CLIENTE>{ data($consultaAfiliacionesPorClienteRequest/ID_CLIENTE) }</ns1:PV_ID_CLIENTE>
        </ns1:InputParameters>
};

declare variable $consultaAfiliacionesPorClienteRequest as element(ns0:consultaAfiliacionesPorClienteRequest) external;
declare variable $codigoPais as xs:string external;

xf:consultaAfiliacionesPorClienteIn($consultaAfiliacionesPorClienteRequest,
    $codigoPais)