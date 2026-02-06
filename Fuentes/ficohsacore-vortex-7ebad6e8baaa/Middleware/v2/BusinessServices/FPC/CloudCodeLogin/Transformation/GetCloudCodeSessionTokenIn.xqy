xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCloudCodeSessionToken";
(:: import schema at "../Schemas/GetCloudCodeSessionToken_sp.xsd" ::)

declare variable $userName as xs:string external;

declare function local:func($userName as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_NOMBRE_USUARIO>{fn:data($userName)}</ns1:PV_NOMBRE_USUARIO>
    </ns1:InputParameters>
};

local:func($userName)