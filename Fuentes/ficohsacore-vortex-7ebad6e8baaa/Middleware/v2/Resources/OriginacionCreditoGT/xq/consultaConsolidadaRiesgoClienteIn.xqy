xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$originacionCreditoRequest" element="ns0:originacionCreditoRequest" location="../../OriginacionCredito/xsd/originacionCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaConsolidadaRiesgoCliente" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/originacionCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OriginacionCreditoGT/xq/consultaConsolidadaRiesgoClienteIn/";

declare function xf:consultaConsolidadaRiesgoClienteIn($originacionCreditoRequest as element(ns0:originacionCreditoRequest))
    as element(ns1:consultaConsolidadaRiesgoCliente) {
        <ns1:consultaConsolidadaRiesgoCliente>
            <CUSTOMER_LEGAL_ID>{ data($originacionCreditoRequest/CLIENT_ID) }</CUSTOMER_LEGAL_ID>
            <FISCAL_ID>{ data($originacionCreditoRequest/FISCAL_ID) }</FISCAL_ID>
            <FIRST_NAME>{ data($originacionCreditoRequest/FIRST_NAME) }</FIRST_NAME>
            <LAST_NAME>{ data($originacionCreditoRequest/LAST_NAME) }</LAST_NAME>
            <BIRTH_DATE>{ data($originacionCreditoRequest/BIRTH_DATE) }</BIRTH_DATE>
            <USER_NAME>{ data($originacionCreditoRequest/USER_NAME) }</USER_NAME>
            <PERSON_TYPE>{ data($originacionCreditoRequest/PERSON_TYPE) }</PERSON_TYPE>
            <PRODUCT_CODE>{ data($originacionCreditoRequest/PRODUCT_CODE) }</PRODUCT_CODE>
        </ns1:consultaConsolidadaRiesgoCliente>
};

declare variable $originacionCreditoRequest as element(ns0:originacionCreditoRequest) external;

xf:consultaConsolidadaRiesgoClienteIn($originacionCreditoRequest)