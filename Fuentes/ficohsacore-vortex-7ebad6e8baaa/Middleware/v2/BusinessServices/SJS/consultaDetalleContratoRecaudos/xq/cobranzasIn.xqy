xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../CNV/consultaContratosReferenciados/xsd/consultaContratoReferenciado_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaContratoReferenciado";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleContratoRecaudos/xq/CobranzasIn/";

declare function xf:CobranzasIn($contractId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CODIGO_CONTRATO>{ $contractId }</ns0:CODIGO_CONTRATO>
        </ns0:InputParameters>
};

declare variable $contractId as xs:string external;

xf:CobranzasIn($contractId)