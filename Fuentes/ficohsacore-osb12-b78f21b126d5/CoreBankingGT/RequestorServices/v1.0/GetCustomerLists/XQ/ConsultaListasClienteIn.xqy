xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListasCliente";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerLists/GetCustomerLists_BS.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/consultaListasClienteIn";

declare variable $legalId as xs:string external;

declare function ns1:consultaListasClienteIn($legalId as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_IDENTIFICACION>{fn:data($legalId)}</ns2:PV_IDENTIFICACION>
    </ns2:InputParameters>
};

ns1:consultaListasClienteIn($legalId)