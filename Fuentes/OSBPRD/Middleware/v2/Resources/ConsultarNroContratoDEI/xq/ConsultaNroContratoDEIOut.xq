(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/consultarNroContrato/xsd/ConsultaNroContrato_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultarNroContratoResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaNroContrato";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultarNroContrato/xq/ConsultaNroContratoOut/";

declare function xf:ConsultaNroContratoOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultarNroContratoResponse) {
        <ns0:consultarNroContratoResponse>
            <RTN>{ data($outputParameters/ns1:PV_RTN) }</RTN>
            <CONTRACT_NUMBER>{ data($outputParameters/ns1:PV_NUMEROCONTRATO) }</CONTRACT_NUMBER>
            <CONTRACT_STATUS>{ data($outputParameters/ns1:PN_ESTADOCONTRATO) }</CONTRACT_STATUS>
            <CONTRACT_STATUS_DESC>{ data($outputParameters/ns1:PV_DESCRIPCIONCONTRATO) }</CONTRACT_STATUS_DESC>
            <CLIENT_TYPE>{ data($outputParameters/ns1:PV_TIPOCLIENTE) }</CLIENT_TYPE>
            <TITLE_NAME>{ data($outputParameters/ns1:PV_NOMBRECLIENTE) }</TITLE_NAME>
            <TITLE_ID>{ data($outputParameters/ns1:PV_IDCLIENTE) }</TITLE_ID>
        </ns0:consultarNroContratoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultaNroContratoOut($outputParameters)