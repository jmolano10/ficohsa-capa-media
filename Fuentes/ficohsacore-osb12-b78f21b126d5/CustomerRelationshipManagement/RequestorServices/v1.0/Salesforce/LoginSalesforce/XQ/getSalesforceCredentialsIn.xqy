xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCredencialesSalesforce";
(:: import schema at "../../../../../../ApplicationDB/Middleware/ProviderServices/v1.0/XSD/GetSalesforceCredentials/getSalesforceCredentials_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getSalesforceCredentialsIn";

declare variable $sourceBank as xs:string external;

declare function ns1:getSalesforceCredentialsIn($sourceBank as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_CODIGOPAIS>{fn:data($sourceBank)}</ns2:PV_CODIGOPAIS>
    </ns2:InputParameters>
};

ns1:getSalesforceCredentialsIn($sourceBank)
