xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $numeroTransaccion as xs:string external;
declare variable $moneda as xs:string external;
declare variable $monto as xs:string external;
declare variable $usuarioPago as xs:string external;
declare variable $fechaPago as xs:string external;
declare variable $numeroReferencia as xs:string external;
declare variable $codigoAgencia as xs:string external;
declare variable $nombreAgencia as xs:string external;

declare function local:func($numeroTransaccion as xs:string, 
                            $moneda as xs:string, 
                            $monto as xs:string, 
                            $usuarioPago as xs:string, 
                            $fechaPago as xs:string, 
                            $numeroReferencia as xs:string, 
                            $codigoAgencia as xs:string, 
                            $nombreAgencia as xs:string) 
                            as element() (:: schema-element(ns1:retirosPost) ::) {
    <ns1:retirosPost>
        <ns1:numeroTransaccion>{fn:data($numeroTransaccion)}</ns1:numeroTransaccion>
        <ns1:moneda>{fn:data($moneda)}</ns1:moneda>
        <ns1:monto>{fn:data($monto)}</ns1:monto>
        <ns1:usuarioPago>{fn:data($usuarioPago)}</ns1:usuarioPago>
        <ns1:fechaPago>{fn:data($fechaPago)}</ns1:fechaPago>
        <ns1:numeroReferencia>{fn:data($numeroReferencia)}</ns1:numeroReferencia>
        <ns1:codigoAgencia>{fn:data($codigoAgencia)}</ns1:codigoAgencia>
        <ns1:nombreAgencia>{fn:data($nombreAgencia)}</ns1:nombreAgencia>
    </ns1:retirosPost>
};

local:func($numeroTransaccion, $moneda, $monto, $usuarioPago, $fechaPago, $numeroReferencia, $codigoAgencia, $nombreAgencia)