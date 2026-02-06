xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $codigoCuenta as xs:string external;

declare function local:func($codigoCuenta as xs:string) as element() (:: schema-element(ns1:cuentasMonedas) ::) {
    <ns1:cuentasMonedas>
        <ns1:codigoCuenta>{fn:data($codigoCuenta)}</ns1:codigoCuenta>
    </ns1:cuentasMonedas>
};

local:func($codigoCuenta)