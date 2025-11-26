xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CustomerOpi_BS";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerOpi/v1.0/CustomerOpi_BS_sp.xsd" ::)

declare namespace gco="http://www.w3.org/2005/xquery-local-functions";

declare variable $LegalID as xs:string external;

declare function gco:CustomerOpiHNIn($LegalID as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PARAMCLIENTE>{fn:data($LegalID)}</ns1:PARAMCLIENTE>
    </ns1:InputParameters>
};

gco:CustomerOpiHNIn($LegalID)
