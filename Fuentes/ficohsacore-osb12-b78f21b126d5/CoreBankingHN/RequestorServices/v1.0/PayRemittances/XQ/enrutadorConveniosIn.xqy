xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://service.webserviceprovider.transporters.service.frametexx.com/";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/XMLSchema_-1423180259.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ArmarMensajeRecaudosBS";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/ArmarMensajeRecaudosBS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $outputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function xq:enrutadorConveniosIn($outputParameters as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: element(*, ns2:serviceRequest) ::) {
    <ns2:serviceRequest>
        {
            if ($outputParameters/ns1:MENSAJE)
            then <requestData>{fn:data($outputParameters/ns1:MENSAJE)}</requestData>
            else ()
        }
    </ns2:serviceRequest>
};

xq:enrutadorConveniosIn($outputParameters)
