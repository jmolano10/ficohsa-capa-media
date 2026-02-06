xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaContratoGOP" element="ns1:consultaContratoGOP" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/consultaContratoGOP/xsd/ConsultaContratoGOP_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaContratoGOP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaContratoGOP/xq/ConsultaContratoGOPIn/";

declare function xf:ConsultaContratoGOPIn($consultaContratoGOP as element(ns1:consultaContratoGOP))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_RTN>{ data($consultaContratoGOP/RTN) }</ns0:PV_RTN>
        </ns0:InputParameters>
};

declare variable $consultaContratoGOP as element(ns1:consultaContratoGOP) external;

xf:ConsultaContratoGOPIn($consultaContratoGOP)