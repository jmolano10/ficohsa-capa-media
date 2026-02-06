xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)


declare function local:func() as element() (:: schema-element(ns1:entesBancos) ::) {
    <ns1:entesBancos/>
};

local:func()