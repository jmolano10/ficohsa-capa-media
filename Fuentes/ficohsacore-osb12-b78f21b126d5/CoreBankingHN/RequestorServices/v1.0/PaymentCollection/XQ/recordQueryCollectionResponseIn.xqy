xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/RecordCollectionResponse";
(:: import schema at "../../../../ProviderServices/XSD/RecordCollectionResponse/RecordCollectionResponse_sp.xsd" ::)

declare variable $uuid as xs:string external;
declare variable $dateTime as xs:string external;
declare variable $traceProxy as xs:string external;
declare variable $uuidBitacora as xs:string external;
declare variable $paymentoCollectionResponse as element() (:: schema-element(ns1:paymentCollectionResponse) ::) external;
declare variable $transactionId as xs:string external;
declare variable $username as xs:string external;

declare function local:func($uuid as xs:string, 
                            $dateTime as xs:string, 
                            $traceProxy as xs:string, 
                            $uuidBitacora as xs:string, 
                            $paymentoCollectionResponse as element() (:: schema-element(ns1:paymentCollectionResponse) ::), 
                            $transactionId as xs:string, 
                            $username as xs:string) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters/>
};

local:func($uuid, $dateTime, $traceProxy, $uuidBitacora, $paymentoCollectionResponse, $transactionId, $username)