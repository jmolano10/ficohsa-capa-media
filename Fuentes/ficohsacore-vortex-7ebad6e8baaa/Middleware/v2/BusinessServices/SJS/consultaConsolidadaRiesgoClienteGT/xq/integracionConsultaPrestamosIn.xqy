xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaConsolidadaRiesgoClienteGT" element="ns0:sjConsultaConsolidadaRiesgoClienteGT" location="../xsd/sjConsultaConsolidadaRiesgoClienteGTTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../DataWarehouse/integracionConsultaPrestamos/xsd/integracionConsultaPrestamos_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaPrestamos";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaConsolidadaRiesgoClienteGTTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaConsolidadaRiesgoClienteGT/xq/integracionConsultaPrestamosIn/";

declare function xf:integracionConsultaPrestamosIn($sjConsultaConsolidadaRiesgoClienteGT as element(ns0:sjConsultaConsolidadaRiesgoClienteGT))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PAIS>{ data($sjConsultaConsolidadaRiesgoClienteGT/ns0:COUNTRY) }</ns1:PAIS>
            <ns1:IDENTIDAD>{ data($sjConsultaConsolidadaRiesgoClienteGT/ns0:IDENTIFICATION) }</ns1:IDENTIDAD>
        </ns1:InputParameters>
};

declare variable $sjConsultaConsolidadaRiesgoClienteGT as element(ns0:sjConsultaConsolidadaRiesgoClienteGT) external;

xf:integracionConsultaPrestamosIn($sjConsultaConsolidadaRiesgoClienteGT)