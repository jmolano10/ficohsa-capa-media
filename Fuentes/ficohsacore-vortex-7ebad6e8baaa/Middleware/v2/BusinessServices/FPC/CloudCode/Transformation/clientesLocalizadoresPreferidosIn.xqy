xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $codigoTipoIdentificacion as xs:string external;
declare variable $numeroIdentificacion as xs:string external;

declare function local:func($codigoTipoIdentificacion as xs:string, 
                            $numeroIdentificacion as xs:string) 
                            as element() (:: schema-element(ns1:clientesLocalizadoresPreferidos) ::) {
    <ns1:clientesLocalizadoresPreferidos>
        <ns1:codigoTipoIdentificacion>{fn:data($codigoTipoIdentificacion)}</ns1:codigoTipoIdentificacion>
        <ns1:numeroIdentificacion>{fn:data($numeroIdentificacion)}</ns1:numeroIdentificacion>
    </ns1:clientesLocalizadoresPreferidos>
};

local:func($codigoTipoIdentificacion, $numeroIdentificacion)