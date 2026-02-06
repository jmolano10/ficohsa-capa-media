xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $tipoIdentificacion as xs:string external;
declare variable $numeroIdentificacion as xs:string external;
declare variable $codigoCliente as xs:string external;

declare function local:func($tipoIdentificacion as xs:string, 
                            $numeroIdentificacion as xs:string, 
                            $codigoCliente as xs:string) 
                            as element() (:: schema-element(ns1:cuentas) ::) {
    <ns1:cuentas>
        <ns1:tipoIdentificacion>{fn:data($tipoIdentificacion)}</ns1:tipoIdentificacion>
        <ns1:numeroIdentificacion>{fn:data($numeroIdentificacion)}</ns1:numeroIdentificacion>
        <ns1:codigoCliente>{fn:data($codigoCliente)}</ns1:codigoCliente>
    </ns1:cuentas>
};

local:func($tipoIdentificacion, $numeroIdentificacion, $codigoCliente)