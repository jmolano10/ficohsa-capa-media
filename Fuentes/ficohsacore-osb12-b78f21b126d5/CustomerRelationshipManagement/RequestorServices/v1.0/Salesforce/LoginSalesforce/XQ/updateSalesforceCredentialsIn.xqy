xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaCredencialesSalesforce";
(:: import schema at "../../../../../../ApplicationDB/Middleware/ProviderServices/v1.0/XSD/SalesforceCredentialsUpdate/salesforceCredentialsUpdate_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/updateSalesforceCredentialsIn";

declare variable $sourceBank as xs:string external;
declare variable $sessionId as xs:string external;

declare function ns1:updateSalesforceCredentialsIn($sourceBank as xs:string, 
                                                   $sessionId as xs:string) 
                                                   as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_SESION>{fn:data($sessionId)}</ns2:PV_SESION>
        <ns2:PV_CODIGOPAIS>{fn:data($sourceBank)}</ns2:PV_CODIGOPAIS>
    </ns2:InputParameters>
};

ns1:updateSalesforceCredentialsIn($sourceBank, $sessionId)
