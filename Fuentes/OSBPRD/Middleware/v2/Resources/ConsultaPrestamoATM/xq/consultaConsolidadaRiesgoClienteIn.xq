(:: pragma bea:global-element-return element="ns0:consultaConsolidadaRiesgoCliente" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPrestamoATM/xq/consultaConsolidadaRiesgoClienteIn/";

declare function xf:consultaConsolidadaRiesgoClienteIn($legalId as xs:string)
    as element(ns0:consultaConsolidadaRiesgoCliente) {
        <ns0:consultaConsolidadaRiesgoCliente>
            <CUSTOMER_LEGAL_ID>{ $legalId }</CUSTOMER_LEGAL_ID>
        </ns0:consultaConsolidadaRiesgoCliente>
};

declare variable $legalId as xs:string external;

xf:consultaConsolidadaRiesgoClienteIn($legalId)