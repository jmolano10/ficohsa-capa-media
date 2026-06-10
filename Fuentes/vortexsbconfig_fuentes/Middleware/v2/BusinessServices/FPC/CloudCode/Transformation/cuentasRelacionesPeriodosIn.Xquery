<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $codigoCuenta as xs:string external;
declare variable $fechaInicialConsulta as xs:string external;
declare variable $fechaFinalConsulta as xs:string external;

declare function local:func($codigoCuenta as xs:string, 
                            $fechaInicialConsulta as xs:string, 
                            $fechaFinalConsulta as xs:string) 
                            as element() (:: schema-element(ns1:cuentasRelacionesPeriodos) ::) {
    <ns1:cuentasRelacionesPeriodos>
        <ns1:codigoCuenta>{fn:data($codigoCuenta)}</ns1:codigoCuenta>
        <ns1:fechaInicialConsulta>{fn:data($fechaInicialConsulta)}</ns1:fechaInicialConsulta>
        <ns1:fechaFinalConsulta>{fn:data($fechaFinalConsulta)}</ns1:fechaFinalConsulta>
    </ns1:cuentasRelacionesPeriodos>
};

local:func($codigoCuenta, $fechaInicialConsulta, $fechaFinalConsulta)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>