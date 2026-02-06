xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/honduras/cloudCodeLoginTypes";
(:: import schema at "../Schemas/CloudCodeLoginTypes.xsd" ::)

declare variable $credentials as xs:string external;

declare function local:func($credentials as xs:string) as element() (:: schema-element(ns1:cloudCodeLogin) ::) {
    <ns1:cloudCodeLogin>
        <credenciales>{fn:data($credentials)}</credenciales>
    </ns1:cloudCodeLogin>
};

local:func($credentials)