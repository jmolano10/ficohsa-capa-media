xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:sjConsultaListasClienteRequest" location="../../../BusinessServices/SJS/consultaListasClienteGT/xsd/sjConsultaListasClienteGT.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasClienteGT/xq/consultaListasClienteIn/";

declare function xf:consultaListasClienteIn($legalId as xs:string)
    as element(ns0:sjConsultaListasClienteRequest) {
        <ns0:sjConsultaListasClienteRequest>
            <ns0:CUSTOMER_LEGAL_ID>{ $legalId }</ns0:CUSTOMER_LEGAL_ID>
        </ns0:sjConsultaListasClienteRequest>
};

declare variable $legalId as xs:string external;

xf:consultaListasClienteIn($legalId)