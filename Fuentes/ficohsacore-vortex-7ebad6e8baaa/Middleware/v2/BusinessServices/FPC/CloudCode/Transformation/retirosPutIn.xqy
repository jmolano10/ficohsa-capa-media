xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $numeroTransaccion as xs:string external;
declare variable $cuenta as xs:string external;

declare function local:func($numeroTransaccion as xs:string, 
                            $cuenta as xs:string) 
                            as element() (:: schema-element(ns1:retirosPut) ::) {
    <ns1:retirosPut>
        <ns1:numeroTransaccion>{fn:data($numeroTransaccion)}</ns1:numeroTransaccion>
        <ns1:cuenta>{fn:data($cuenta)}</ns1:cuenta>
    </ns1:retirosPut>
};

local:func($numeroTransaccion, $cuenta)