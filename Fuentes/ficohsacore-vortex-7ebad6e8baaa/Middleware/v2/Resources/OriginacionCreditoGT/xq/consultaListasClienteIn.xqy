xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaListasCliente" location="../../../BusinessServices/consultaListasCliente/xsd/consultaListasClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OriginacionCreditoGT/xq/consultaListasClienteIn/";

declare function xf:consultaListasClienteIn($legalId as xs:string)
    as element(ns0:consultaListasCliente) {
        <ns0:consultaListasCliente>
            <CUSTOMER_LEGAL_ID>{ $legalId }</CUSTOMER_LEGAL_ID>
        </ns0:consultaListasCliente>
};

declare variable $legalId as xs:string external;

xf:consultaListasClienteIn($legalId)