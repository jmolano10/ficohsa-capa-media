(:: pragma bea:global-element-return element="ns0:addUserPropertyValue" location="../../../BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706.xsd" ::)

declare namespace ns1 = "http://com.latinia/lsubscribers/provisioner/data";
declare namespace ns0 = "http://com.latinia/lsubscribers/provisioner";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuscribeNotificacionPush/xq/addUserPropertyValueIn/";

declare function xf:addUserPropertyValueIn($validation as xs:string,
    $customerid as xs:string,
    $refCompany as xs:string,
    $propertyName as xs:string,
    $propertyValue as xs:string)
    as element(ns0:addUserPropertyValue) {
        <ns0:addUserPropertyValue>
            <validation>{ $validation }</validation>
            <refCompany>{ $refCompany }</refCompany>
            <refUser>{ $customerid }</refUser>
            <propName>{ $propertyName }</propName>
            <propValue>{ $propertyValue }</propValue>
        </ns0:addUserPropertyValue>
};

declare variable $validation as xs:string external;
declare variable $customerid as xs:string external;
declare variable $refCompany as xs:string external;
declare variable $propertyName as xs:string external;
declare variable $propertyValue as xs:string external;

xf:addUserPropertyValueIn($validation,
    $customerid,
    $refCompany,
    $propertyName,
    $propertyValue)