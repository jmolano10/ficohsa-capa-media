<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:unregisterUserAppDevice" location="../../../BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706.xsd" ::)

declare namespace ns1 = "http://com.latinia/lsubscribers/provisioner/data";
declare namespace ns0 = "http://com.latinia/lsubscribers/provisioner";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuscribeNotificacionPush/xq/unregisterUserAppDeviceIn/";

declare function xf:unregisterUserAppDeviceIn($validation as xs:string,
    $application as xs:string,
    $customerid as xs:string,
    $refCompany as xs:string,
    $deviceuuid as xs:string)
    as element(ns0:unregisterUserAppDevice) {
        <ns0:unregisterUserAppDevice>
            <validation>{ $validation }</validation>
            <refCompany>{ $refCompany }</refCompany>
            <refUser>{ $customerid }</refUser>
            <refApp>{ $application }</refApp>
            <uuid>{ $deviceuuid }</uuid>
        </ns0:unregisterUserAppDevice>
};

declare variable $validation as xs:string external;
declare variable $application as xs:string external;
declare variable $customerid as xs:string external;
declare variable $refCompany as xs:string external;
declare variable $deviceuuid as xs:string external;

xf:unregisterUserAppDeviceIn($validation,
    $application,
    $customerid,
    $refCompany,
    $deviceuuid)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706"/>
    </con:dependency>
</con:xqueryEntry>