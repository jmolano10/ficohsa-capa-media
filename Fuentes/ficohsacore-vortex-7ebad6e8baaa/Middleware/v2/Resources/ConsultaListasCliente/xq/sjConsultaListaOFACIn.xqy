xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaListaOFAC/xsd/consultaListaOFAC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaOFAC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/consultaListaOFAC/";

declare function xf:sjConsultaListaOFACIn($customerLegalId as xs:string,
    $customerName as xs:string,
    $levenshtein as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:ENTITY_ID>{ $customerLegalId }</ns0:ENTITY_ID>
            <ns0:ENTITY_NAME>{ $customerName }</ns0:ENTITY_NAME>
            <ns0:LEVENSHTEIN_PRECISION>{ data($levenshtein) }</ns0:LEVENSHTEIN_PRECISION>
        </ns0:InputParameters>
};

declare variable $customerLegalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $levenshtein as xs:string external;

xf:sjConsultaListaOFACIn($customerLegalId,
    $customerName,
    $levenshtein)