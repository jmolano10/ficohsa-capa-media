<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/DeviceInfoTypes";
(:: import schema at "../xsd/DeviceInfoTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $deviceInfo as element() (:: schema-element(ns1:DeviceInfoRequest) ::) external;
declare variable $apiKey as xs:string external;

declare function xq:DeviceInfo_To_VU($apiKey as xs:string, $deviceInfo as element() (:: schema-element(ns1:DeviceInfoRequest) ::)) as element() (:: schema-element(ns1:DeviceInfoRequestVU) ::) {
    <ns1:DeviceInfoRequestVU>
        <ns1:apikey>{$apiKey}</ns1:apikey>
        <ns1:userId>{fn:data($deviceInfo/ns1:user)}</ns1:userId>
    </ns1:DeviceInfoRequestVU>
};

xq:DeviceInfo_To_VU($apiKey, $deviceInfo)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/DeviceInfoTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/DeviceInfo/xsd/DeviceInfoTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>