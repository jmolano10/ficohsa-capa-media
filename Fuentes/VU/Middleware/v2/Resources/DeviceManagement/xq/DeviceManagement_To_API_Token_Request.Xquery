<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetAPIAuth_BS";
(:: import schema at "../xsd/GetAPIAuth_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $appName as xs:string external;

declare function xq:DeviceManagement_To_API_Token_Request($appName as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    &lt;ns1:InputParameters>
        &lt;ns1:PV_NOMBRE_APP>{fn:data($appName)}&lt;/ns1:PV_NOMBRE_APP>
    &lt;/ns1:InputParameters>
};

xq:DeviceManagement_To_API_Token_Request($appName)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/GetAPIAuth_BS_sp.xsd">
            <con:schema ref="Middleware/v2/Resources/DeviceManagement/xsd/GetAPIAuth_BS_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>