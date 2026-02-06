xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAfiliacionCAPRequest" element="ns1:consultaAfiliacionCAPRequest" location="../xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ConsultaAfiliacionCAP/xsd/consultaAfiliacionCAP_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAfiliacionCAP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/consultaAfiliacionCAPIn/";

declare function xf:consultaAfiliacionCAPIn($consultaAfiliacionCAPRequest as element(ns1:consultaAfiliacionCAPRequest),
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_PAIS>{ $codigoPais }</ns0:PV_CODIGO_PAIS>
            <ns0:PV_CUENTA_AP>{ data($consultaAfiliacionCAPRequest/CUENTA_AP) }</ns0:PV_CUENTA_AP>
        </ns0:InputParameters>
};

declare variable $consultaAfiliacionCAPRequest as element(ns1:consultaAfiliacionCAPRequest) external;
declare variable $codigoPais as xs:string external;

xf:consultaAfiliacionCAPIn($consultaAfiliacionCAPRequest,
    $codigoPais)