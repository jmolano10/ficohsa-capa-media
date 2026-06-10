<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/honduras/cloudCodeLoginTypes";
(:: import schema at "../Schemas/CloudCodeLoginTypes.xsd" ::)

declare variable $credentials as xs:string external;

declare function local:func($credentials as xs:string) as element() (:: schema-element(ns1:cloudCodeLogin) ::) {
    &lt;ns1:cloudCodeLogin>
        &lt;credenciales>{fn:data($credentials)}&lt;/credenciales>
    &lt;/ns1:cloudCodeLogin>
};

local:func($credentials)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeLoginTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/FPC/CloudCodeLogin/Schemas/CloudCodeLoginTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>