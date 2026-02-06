xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaConsolidadaRiesgoCliente" element="ns1:consultaConsolidadaRiesgoCliente" location="../../../../Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaConsolidadaRiesgoClienteGT" location="../xsd/sjConsultaConsolidadaRiesgoClienteGTTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaConsolidadaRiesgoClienteGTTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaConsolidadaRiesgoClienteGT/xq/sjConsultaConsolidadaRiesgoClienteGTIn/";

declare function xf:sjConsultaConsolidadaRiesgoClienteGTIn($consultaConsolidadaRiesgoCliente as element(ns1:consultaConsolidadaRiesgoCliente))
    as element(ns0:sjConsultaConsolidadaRiesgoClienteGT) {
        <ns0:sjConsultaConsolidadaRiesgoClienteGT>
            <ns0:COUNTRY>GT</ns0:COUNTRY>
            <ns0:IDENTIFICATION>{ data($consultaConsolidadaRiesgoCliente/CUSTOMER_LEGAL_ID) }</ns0:IDENTIFICATION>
        </ns0:sjConsultaConsolidadaRiesgoClienteGT>
};

declare variable $consultaConsolidadaRiesgoCliente as element(ns1:consultaConsolidadaRiesgoCliente) external;

xf:sjConsultaConsolidadaRiesgoClienteGTIn($consultaConsolidadaRiesgoCliente)