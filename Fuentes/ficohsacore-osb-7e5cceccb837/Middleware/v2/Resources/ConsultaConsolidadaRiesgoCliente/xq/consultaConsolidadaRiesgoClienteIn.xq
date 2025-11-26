xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaConsolidadaRiesgoCliente" element="ns1:consultaConsolidadaRiesgoCliente" location="../xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoCliente_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConsolidadRiesgoCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";

declare function xf:consultaConsolidadaRiesgoClienteIn($consultaConsolidadaRiesgoCliente as element(ns1:consultaConsolidadaRiesgoCliente))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:IDENTIDAD>{ data($consultaConsolidadaRiesgoCliente/CUSTOMER_LEGAL_ID) }</ns0:IDENTIDAD>
        </ns0:InputParameters>
};

declare variable $consultaConsolidadaRiesgoCliente as element(ns1:consultaConsolidadaRiesgoCliente) external;

xf:consultaConsolidadaRiesgoClienteIn($consultaConsolidadaRiesgoCliente)
