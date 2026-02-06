xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTiposConceptosRequest1" element="ns1:consultaTiposConceptosRequest" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/consultaConceptos/xsd/consultaConceptos_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposConceptos/xq/consultaTiposConceptosIN/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConceptos";

declare function xf:consultaTiposConceptosIN($consultaTiposConceptosRequest1 as element(ns1:consultaTiposConceptosRequest))
    as element(ns0:InputParameters) {
    <ns0:InputParameters>
      <ns0:PN_CODIGO_IMPUESTO>{ data($consultaTiposConceptosRequest1/TAX_ID) }</ns0:PN_CODIGO_IMPUESTO>
      <ns0:PN_CODIGO>{ data($consultaTiposConceptosRequest1/CONCEPT_ID) }</ns0:PN_CODIGO>
    </ns0:InputParameters>
};

declare variable $consultaTiposConceptosRequest1 as element(ns1:consultaTiposConceptosRequest) external;

xf:consultaTiposConceptosIN($consultaTiposConceptosRequest1)