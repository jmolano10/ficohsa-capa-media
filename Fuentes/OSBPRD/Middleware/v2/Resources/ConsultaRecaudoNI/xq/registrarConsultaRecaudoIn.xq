(:: pragma  parameter="$responseXml" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TercerosPA/registrarConsultaRecaudo/xsd/registrarConsultaRecaudo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarConsultaRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoPA/xq/registrarConsultaRecaudoIn/";

declare function xf:registrarConsultaRecaudoIn($responseXml as element(*),
    $contractId as xs:string,
    $debtorCode as xs:string,
    $secuenciaConsulta as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SECUENCIACONSULTA>{ $secuenciaConsulta }</ns0:PV_SECUENCIACONSULTA>
            <ns0:PC_RESPONSEXML>{ $responseXml }</ns0:PC_RESPONSEXML>
            <ns0:PV_IDCONVENIO>{ $contractId }</ns0:PV_IDCONVENIO>
            <ns0:PV_CODIGODEUDOR>{ $debtorCode }</ns0:PV_CODIGODEUDOR>
        </ns0:InputParameters>
};

declare variable $responseXml as element(*) external;
declare variable $contractId as xs:string external;
declare variable $debtorCode as xs:string external;
declare variable $secuenciaConsulta as xs:string external;

xf:registrarConsultaRecaudoIn($responseXml,
    $contractId,
    $debtorCode,
    $secuenciaConsulta)