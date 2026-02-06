xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/consultaContratoGOP/xsd/ConsultaContratoGOP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaContratoGOPResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaContratoGOP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaContratoGOP/xq/ConsultaContratoGOPOut/";

declare function xf:ConsultaContratoGOPOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaContratoGOPResponse) {
        <ns1:consultaContratoGOPResponse>
            <RTN>{ data($outputParameters/ns0:PV_RTN) }</RTN>
            <CONTRACT_NUMBER>{ data($outputParameters/ns0:PV_NUMEROCONTRATO) }</CONTRACT_NUMBER>
            <CONTRACT_STATUS>{ data($outputParameters/ns0:PN_ESTADOCONTRATO) }</CONTRACT_STATUS>
            <CONTRACT_STATUS_DESC>{ data($outputParameters/ns0:PV_DESCRIPCIONCONTRATO) }</CONTRACT_STATUS_DESC>
        </ns1:consultaContratoGOPResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:ConsultaContratoGOPOut($outputParameters)