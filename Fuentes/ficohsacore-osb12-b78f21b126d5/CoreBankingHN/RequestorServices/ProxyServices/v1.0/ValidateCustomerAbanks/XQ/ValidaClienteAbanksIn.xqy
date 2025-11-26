xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaClienteAbanks_BS";
(:: import schema at "../../../../../ProviderServices/XSD/ValidaClienteAbanks/ValidaClienteAbanks_BS_sp.xsd" ::)

declare variable $customerId as xs:string external;
declare variable $IdentificationNumber as xs:string external;

declare function local:func($customerId as xs:string, 
                            $IdentificationNumber as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PN_CODIGO_CLIENTE>{fn:data($customerId)}</ns1:PN_CODIGO_CLIENTE>
        <ns1:PV_NUMERO_IDENTIFICACION>{fn:data($IdentificationNumber)}</ns1:PV_NUMERO_IDENTIFICACION>
    </ns1:InputParameters>
};

local:func($customerId, $IdentificationNumber)