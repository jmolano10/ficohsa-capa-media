xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaConsolidadaRiesgoCliente" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaConsolidadoRiesgoClienteIn/";

declare function xf:consultaConsolidadoRiesgoClienteIn($customerLegalID as xs:string)
    as element(ns0:consultaConsolidadaRiesgoCliente) {
        <ns0:consultaConsolidadaRiesgoCliente>
            <CUSTOMER_LEGAL_ID>{ $customerLegalID }</CUSTOMER_LEGAL_ID>
        </ns0:consultaConsolidadaRiesgoCliente>
};

declare variable $customerLegalID as xs:string external;

xf:consultaConsolidadoRiesgoClienteIn($customerLegalID)