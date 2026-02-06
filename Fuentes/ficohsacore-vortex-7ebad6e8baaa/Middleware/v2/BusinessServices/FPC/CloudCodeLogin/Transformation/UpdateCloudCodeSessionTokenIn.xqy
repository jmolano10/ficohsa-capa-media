xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/UpdateCloudCodeSessionToken";
(:: import schema at "../Schemas/UpdateCloudCodeSessionToken_sp.xsd" ::)

declare variable $userName as xs:string external;
declare variable $timestamp as xs:dateTime external;
declare variable $token as xs:string external;

declare function local:func($userName as xs:string, 
                            $timestamp as xs:dateTime, 
                            $token as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_NOMBRE_USUARIO>{fn:data($userName)}</ns1:PV_NOMBRE_USUARIO>
        <ns1:PD_MARCA_TIEMPO>{fn:data($timestamp)}</ns1:PD_MARCA_TIEMPO>
        <ns1:PV_TOKEN>{fn:data($token)}</ns1:PV_TOKEN>
    </ns1:InputParameters>
};

local:func($userName, $timestamp, $token)