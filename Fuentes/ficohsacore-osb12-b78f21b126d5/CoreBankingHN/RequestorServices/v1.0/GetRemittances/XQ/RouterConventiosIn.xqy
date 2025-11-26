xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://service.webserviceprovider.transporters.service.frametexx.com/";
(:: import schema at "../../../../ProviderServices/XSD/RouterConventions/XMLSchema_654181198.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AssembleMessageCollection";
(:: import schema at "../../../../ProviderServices/XSD/AssembleMessageCollection/AssembleMessageCollection_sp.xsd" ::)

declare variable $AssembleInfoParametersRemittancesRSP as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($AssembleInfoParametersRemittancesRSP as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: element(*, ns2:serviceRequest) ::) {
    <ns2:serviceRequest>
        {
            for $message in $AssembleInfoParametersRemittancesRSP/ns1:MENSAJE
            return 
              <requestData>{fn:data($message)}</requestData>
        }
    </ns2:serviceRequest>
};

local:func($AssembleInfoParametersRemittancesRSP)
