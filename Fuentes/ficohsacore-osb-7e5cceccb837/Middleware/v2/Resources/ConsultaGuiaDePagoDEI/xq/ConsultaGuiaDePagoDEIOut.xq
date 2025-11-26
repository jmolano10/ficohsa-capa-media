(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/consultaGuiaDePago/xsd/ConsultaGuiaDePago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaGuiaDePagoResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGuiaDePago";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGuiaDePago/xq/ConsultaGuiaDePagoOut/";

declare function xf:ConsultaGuiaDePagoOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaGuiaDePagoResponse) {
        <ns0:consultaGuiaDePagoResponse>
            <CONTRACT_NUMBER>{ data($outputParameters/ns1:PV_NUMEROCONTRATO) }</CONTRACT_NUMBER>
            <RTN>{ data($outputParameters/ns1:PV_RTN) }</RTN>
            <BUSINESS_NAME>{ data($outputParameters/ns1:PV_RAZONSOCIAL) }</BUSINESS_NAME>
            <LEGAL_ID>{ data($outputParameters/ns1:PV_IDPERSONA) }</LEGAL_ID>
            <EMAIL>{ data($outputParameters/ns1:PV_EMAIL) }</EMAIL>
            <LEGAL_REP_NAME>{ data($outputParameters/ns1:PV_NOMBREREPRESENTANTE) }</LEGAL_REP_NAME>
            <PUBLIC_DEED_NUMBER>{ data($outputParameters/ns1:PV_NUMEROESCRITURA) }</PUBLIC_DEED_NUMBER>
            <PUBLIC_DEED_DATE>{ data($outputParameters/ns1:PV_FECHAESCRITURA) }</PUBLIC_DEED_DATE>
        </ns0:consultaGuiaDePagoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultaGuiaDePagoOut($outputParameters)