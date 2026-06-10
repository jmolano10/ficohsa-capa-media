<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $numeroSolicitud as xs:string external;
declare variable $numeroIdentificacion as xs:string external;

declare function local:func($numeroSolicitud as xs:string, 
                            $numeroIdentificacion as xs:string) 
                            as element() (:: schema-element(ns1:retirosGet) ::) {
    <ns1:retirosGet>
        <ns1:numeroSolicitud>{fn:data($numeroSolicitud)}</ns1:numeroSolicitud>
        <ns1:numeroIdentificacion>{fn:data($numeroIdentificacion)}</ns1:numeroIdentificacion>
    </ns1:retirosGet>
};

local:func($numeroSolicitud, $numeroIdentificacion)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>