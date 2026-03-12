xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/utility/constants";
(:: import schema at "../../SBGT_Card_Commons/Resources/SBRG_Constants_Commons/Schemas/CustomParameter.xsd" ::)

declare variable $requestParams as xs:string external;

declare function local:func($requestParams as xs:string) as element() (:: schema-element(ns1:GetParameters) ::) {
    <ns1:GetParameters>
        <ns1:parameterName>{$requestParams}</ns1:parameterName>
    </ns1:GetParameters>
};
 
local:func($requestParams)