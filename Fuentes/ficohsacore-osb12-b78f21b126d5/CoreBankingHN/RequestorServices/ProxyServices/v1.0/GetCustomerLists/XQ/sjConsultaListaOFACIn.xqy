xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaOFAC";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultaListaOFAC/consultaListaOFAC_sp.xsd" ::)

declare variable $customerLegalId as xs:string external;
declare variable $customerName as xs:string external;
declare variable $levenshtein as xs:string external;

declare function ns1:sjConsultaListaOFACIn($customerLegalId as xs:string, 
                                           $customerName as xs:string, 
                                           $levenshtein as xs:string) 
                                           as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:ENTITY_ID>{fn:data($customerLegalId)}</ns1:ENTITY_ID>
        <ns1:ENTITY_NAME>{fn:data($customerName)}</ns1:ENTITY_NAME>
        <ns1:LEVENSHTEIN_PRECISION>{fn:data($levenshtein)}</ns1:LEVENSHTEIN_PRECISION>
    </ns1:InputParameters>
};

ns1:sjConsultaListaOFACIn($customerLegalId, $customerName, $levenshtein)