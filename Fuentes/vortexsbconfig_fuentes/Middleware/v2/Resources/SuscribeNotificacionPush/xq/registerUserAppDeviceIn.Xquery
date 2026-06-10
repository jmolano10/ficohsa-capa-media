<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:registerUserAppDevice" location="../../../BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706.xsd" ::)

declare namespace ns1 = "http://com.latinia/lsubscribers/provisioner/data";
declare namespace ns0 = "http://com.latinia/lsubscribers/provisioner";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuscribeNotificacionPush/xq/registerUserAppDeviceIn/";

declare function xf:registerUserAppDeviceIn($validation as xs:string,
    $application as xs:string,
    $customerid as xs:string,
    $refCompany as xs:string,
    $deviceuuid as xs:string,
    $deviceappversion as xs:string,
    $devicemodel as xs:string,
    $deviceostype as xs:string,
    $deviceversion as xs:string,
    $devicetokenid as xs:int,
    $devicetoken as xs:string)
    as element(ns0:registerUserAppDevice) {
        <ns0:registerUserAppDevice>
            <validation>{ $validation }</validation>
            <refCompany>{ $refCompany }</refCompany>
            <refUser>{ $customerid }</refUser>
            <token>
                <appVersion>{ $deviceappversion }</appVersion>
                <application>{ $application }</application>
                <channelProvider>Infocorp</channelProvider>
                <confidential/>
                <device>
                    <devModel>{ $devicemodel }</devModel>
                    <devVendor>{ $deviceostype }</devVendor>
                    <idDevice/>
                    <osVersion>{ $deviceversion }</osVersion>
                </device>
                <idApp/>
                <idAppVersion/>
                <idCompany/>
                <idPnsToken>{ $devicetokenid }</idPnsToken>
                <idProvider/>
                <idUser/>
                <roaming/>
                <token>{ $devicetoken }</token>
                <tsCreate/>
                <tsUpdate/>
                <uuidDevice>{ $deviceuuid }</uuidDevice>
            </token>
        </ns0:registerUserAppDevice>
};

declare variable $validation as xs:string external;
declare variable $application as xs:string external;
declare variable $customerid as xs:string external;
declare variable $refCompany as xs:string external;
declare variable $deviceuuid as xs:string external;
declare variable $deviceappversion as xs:string external;
declare variable $devicemodel as xs:string external;
declare variable $deviceostype as xs:string external;
declare variable $deviceversion as xs:string external;
declare variable $devicetokenid as xs:int external;
declare variable $devicetoken as xs:string external;

xf:registerUserAppDeviceIn($validation,
    $application,
    $customerid,
    $refCompany,
    $deviceuuid,
    $deviceappversion,
    $devicemodel,
    $deviceostype,
    $deviceversion,
    $devicetokenid,
    $devicetoken)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706"/>
    </con:dependency>
</con:xqueryEntry>