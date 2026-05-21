<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $AccountCode as xs:string external;

declare function local:format-date-FPC($fecha as xs:string) as xs:string {
  let $year := fn:substring($fecha, 1, 4)
  let $month := fn:substring($fecha, 6, 2)
  let $day := fn:substring($fecha, 9, 2)
  return fn:concat($day, '-', $month, '-',$year )
};

declare function local:funcGetMultipleProductToCloudCode($AccountCode as xs:string) as element() (:: schema-element(ns2:getPeriodos) ::) {
    let $currentDate := xs:string(fn:current-date())
    return
    <ns2:getPeriodos>
        <codigoCuenta>{fn:data($AccountCode)}</codigoCuenta>
        <fechaInicialConsulta>{local:format-date-FPC($currentDate)}</fechaInicialConsulta>
        <fechaFinalConsulta>{local:format-date-FPC($currentDate)}</fechaFinalConsulta>
    </ns2:getPeriodos>
};

local:funcGetMultipleProductToCloudCode($AccountCode)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetMultipleProduct/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>