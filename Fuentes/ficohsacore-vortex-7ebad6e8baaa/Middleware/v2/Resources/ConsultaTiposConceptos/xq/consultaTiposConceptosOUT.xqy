xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/consultaConceptos/xsd/consultaConceptos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTiposConceptosResponse" location="../xsd/ConsultaTiposConceptosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConceptos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposConceptos/xq/consultaTiposConceptosOUT/";

declare function xf:onsultaTiposConceptosOUT($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaTiposConceptosResponse) {
        <ns0:consultaTiposConceptosResponse>
            <CONCEPTS>
            {
              for $codigo at $index in $outputParameters1/ns1:PN_CODIGOCONCEPTO/ns1:PN_CODIGOCONCEPTO_ITEM
              return
                <CONCEPT>
                	<ID>{ data($codigo) }</ID>
                    <DESCRIPTION>{ data($outputParameters1/ns1:PV_DESCRIPCION/ns1:PV_DESCRIPCION_ITEM[$index]) }</DESCRIPTION>
                </CONCEPT>
             }
            </CONCEPTS>
        </ns0:consultaTiposConceptosResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:onsultaTiposConceptosOUT($outputParameters1)