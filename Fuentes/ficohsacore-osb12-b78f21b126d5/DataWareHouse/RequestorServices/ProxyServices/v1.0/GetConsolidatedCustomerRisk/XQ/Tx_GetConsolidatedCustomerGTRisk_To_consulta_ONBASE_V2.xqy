xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerRisk_GT1";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerRisk/v1.0/GetCustomerRiskGT_BS_sp.xsd" ::)

declare variable $legalId as xs:string external;
declare variable $nit as xs:string external;
declare variable $firstName as xs:string external;
declare variable $lastName as xs:string external;
declare variable $birthDate as xs:string external;

declare function local:Tx_GetConsolidatedCustomerGTRisk_To_consulta_ONBASE_V2($legalId as xs:string,
    $nit as xs:string,
    $firstName as xs:string,
    $lastName as xs:string,
    $birthDate as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:Identidad>{$legalId}</ns1:Identidad>
        <ns1:NIT1>{fn:data($nit)}</ns1:NIT1>
        <ns1:PRIMER_NOMBRE1>{fn:data($firstName)}</ns1:PRIMER_NOMBRE1>
        <ns1:PRIMER_APELLIDO1>{fn:data($lastName)}</ns1:PRIMER_APELLIDO1>
        <ns1:FECHA_NACIMIENTO1>{fn:data($birthDate)}</ns1:FECHA_NACIMIENTO1>
    </ns1:InputParameters>
};

local:Tx_GetConsolidatedCustomerGTRisk_To_consulta_ONBASE_V2($legalId,
    $nit,
    $firstName, 
    $lastName, 
    $birthDate
)
