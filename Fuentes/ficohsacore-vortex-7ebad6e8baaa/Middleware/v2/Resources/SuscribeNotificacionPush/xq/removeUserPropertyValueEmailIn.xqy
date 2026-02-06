xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:removeUserPropertyValue" location="../../../BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706.xsd" ::)

declare namespace ns1 = "http://com.latinia/lsubscribers/provisioner/data";
declare namespace ns0 = "http://com.latinia/lsubscribers/provisioner";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuscribeNotificacionPush/xq/removeUserPropertyValueIn/";

declare function xf:removeUserPropertyValueIn($validation as xs:string,
    $customerid as xs:string,
    $refCompany as xs:string)
    as element(ns0:removeUserPropertyValue) {
        <ns0:removeUserPropertyValue>
            <validation>{ $validation }</validation>
            <refCompany>{ $refCompany }</refCompany>
            <refUser>{ $customerid }</refUser>
            <propName>chn_pref</propName>
            <propValue>EMAIL</propValue>
        </ns0:removeUserPropertyValue>
};

declare variable $validation as xs:string external;
declare variable $customerid as xs:string external;
declare variable $refCompany as xs:string external;

xf:removeUserPropertyValueIn($validation,
    $customerid,
    $refCompany)