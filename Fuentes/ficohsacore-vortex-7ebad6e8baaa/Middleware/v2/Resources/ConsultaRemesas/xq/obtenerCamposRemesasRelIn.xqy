xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/obtenerCamposRemesasRel/xsd/obtenerCamposRemesasRel_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerCamposRemesasRel";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/obtenerCamposRemesasRelIn/";

declare function xf:obtenerCamposRemesasRelIn($contrato as xs:decimal)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_ID_CONVENIO>{ $contrato }</ns0:PN_ID_CONVENIO>
        </ns0:InputParameters>
};

declare variable $contrato as xs:decimal external;

xf:obtenerCamposRemesasRelIn($contrato)