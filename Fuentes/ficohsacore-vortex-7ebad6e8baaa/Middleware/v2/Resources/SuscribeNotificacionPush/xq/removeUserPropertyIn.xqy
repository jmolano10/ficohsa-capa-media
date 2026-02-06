xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:removeUserProperty" location="../../../BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706.xsd" ::)

declare namespace ns1 = "http://com.latinia/lsubscribers/provisioner/data";
declare namespace ns0 = "http://com.latinia/lsubscribers/provisioner";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuscribeNotificacionPush/xq/removeUserPropertyIn/";

declare function xf:removeUserPropertyIn($validation as xs:string,
    $customerid as xs:string,
    $refCompany as xs:string)
    as element(ns0:removeUserProperty) {
        <ns0:removeUserProperty>
            <validation>{ $validation }</validation>
            <refCompany>{ $refCompany }</refCompany>
            <refUser>{ $customerid }</refUser>
            <propName>poseePush</propName>
        </ns0:removeUserProperty>
};

declare variable $validation as xs:string external;
declare variable $customerid as xs:string external;
declare variable $refCompany as xs:string external;

xf:removeUserPropertyIn($validation,
    $customerid,
    $refCompany)