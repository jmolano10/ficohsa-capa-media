<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $tipoIdentificacionAfiliado as xs:string external;
declare variable $numeroIdentificacionAfiliado as xs:string external;
declare variable $fechaInicio as xs:string external;
declare variable $fechaFin as xs:string external;

declare function local:func($tipoIdentificacionAfiliado as xs:string, 
                            $numeroIdentificacionAfiliado as xs:string, 
                            $fechaInicio as xs:string, 
                            $fechaFin as xs:string) 
                            as element() (:: schema-element(ns1:clientesLaboralesPeriodos) ::) {
    <ns1:clientesLaboralesPeriodos>
        <ns1:tipoIdentificacionAfiliado>{fn:data($tipoIdentificacionAfiliado)}</ns1:tipoIdentificacionAfiliado>
        <ns1:numeroIdentificacionAfiliado>{fn:data($numeroIdentificacionAfiliado)}</ns1:numeroIdentificacionAfiliado>
        <ns1:fechaInicio>{fn:data($fechaInicio)}</ns1:fechaInicio>
        <ns1:fechaFin>{fn:data($fechaFin)}</ns1:fechaFin>
    </ns1:clientesLaboralesPeriodos>
};

local:func($tipoIdentificacionAfiliado, $numeroIdentificacionAfiliado, $fechaInicio, $fechaFin)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>