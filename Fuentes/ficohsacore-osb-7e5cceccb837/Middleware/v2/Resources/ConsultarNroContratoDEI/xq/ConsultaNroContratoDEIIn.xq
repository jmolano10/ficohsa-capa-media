(:: pragma bea:global-element-parameter parameter="$consultarNroContrato" element="ns0:consultarNroContrato" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/consultarNroContrato/xsd/ConsultaNroContrato_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaNroContrato";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultarNroContrato/xq/ConsultaNroContratoIn/";

declare function xf:ConsultaNroContratoIn($consultarNroContrato as element(ns0:consultarNroContrato))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_RTN>{ data($consultarNroContrato/RTN) }</ns1:PV_RTN>
        </ns1:InputParameters>
};

declare variable $consultarNroContrato as element(ns0:consultarNroContrato) external;

xf:ConsultaNroContratoIn($consultarNroContrato)