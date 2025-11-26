xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetReferencedContract";
(:: import schema at "../../../../ProviderServices/XSD/GetReferencedContract/GetReferencedContract_sp.xsd" ::)

declare variable $ContractId as xs:string external;

declare function local:func($ContractId as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:CODIGO_CONTRATO>{fn:data($ContractId)}</ns1:CODIGO_CONTRATO>
    </ns1:InputParameters>
};

local:func($ContractId)