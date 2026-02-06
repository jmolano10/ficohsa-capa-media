xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaConsolidadaRiesgoClienteGT" element="ns1:sjConsultaConsolidadaRiesgoClienteGT" location="../xsd/sjConsultaConsolidadaRiesgoClienteGTTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../DataWarehouse/integracionConsultaTarjetas/xsd/integracionConsultaTarjetas_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaConsolidadaRiesgoClienteGTTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTarjetas";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaConsolidadaRiesgoClienteGT/xq/integracionConsultaTarjetasIn/";

declare function xf:integracionConsultaTarjetasIn($sjConsultaConsolidadaRiesgoClienteGT as element(ns1:sjConsultaConsolidadaRiesgoClienteGT))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PAIS>{ data($sjConsultaConsolidadaRiesgoClienteGT/ns1:COUNTRY) }</ns0:PAIS>
            <ns0:IDENTIDAD>{ data($sjConsultaConsolidadaRiesgoClienteGT/ns1:IDENTIFICATION) }</ns0:IDENTIDAD>
        </ns0:InputParameters>
};

declare variable $sjConsultaConsolidadaRiesgoClienteGT as element(ns1:sjConsultaConsolidadaRiesgoClienteGT) external;

xf:integracionConsultaTarjetasIn($sjConsultaConsolidadaRiesgoClienteGT)