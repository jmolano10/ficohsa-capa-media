xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/obtenerDatosContrato/xsd/ObtenerDatosContrato_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:obtenerDatosContratoResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerDatosContrato";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ObtenerDatosContrato/xq/ObtenerDatosContratoOut/";

declare function xf:ObtenerDatosContratoOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:obtenerDatosContratoResponse) {
        <ns1:obtenerDatosContratoResponse>
            <CONTRACT_NUMBER>{ data($outputParameters1/ns0:PV_NUMEROCONTRATO) }</CONTRACT_NUMBER>
            <RTN>{ data($outputParameters1/ns0:PV_RTN) }</RTN>
            <BUSINESS_NAME>{ data($outputParameters1/ns0:PV_NOMBRECLIENTE) }</BUSINESS_NAME>
            <LEGAL_REP_ID>{ data($outputParameters1/ns0:PN_IDCLIENTE) }</LEGAL_REP_ID>
            <EMAIL>{ data($outputParameters1/ns0:PV_EMAIL) }</EMAIL>
            <LEGAL_REP_NAME>{ data($outputParameters1/ns0:PV_REPRESENTANTELEGAL) }</LEGAL_REP_NAME>
            <DEED_NUMBER>{ data($outputParameters1/ns0:PV_NUMEROESCRITURA) }</DEED_NUMBER>
            <DEED_DATE>{ data($outputParameters1/ns0:PV_FECHAESCRITURA) }</DEED_DATE>
        </ns1:obtenerDatosContratoResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:ObtenerDatosContratoOut($outputParameters1)