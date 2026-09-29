xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://service.srvaplcobisgenerales.ecobis.cobiscorp";
(:: import schema at "../Schemas/services.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/referencedata";
(:: import schema at "../../SBNI_ReferenceData_Commons/Schemas/ReferenceDataInquiryTypes.xsd" ::)

declare namespace dto="http://dto.srvaplcobisentidades.ecobis.cobiscorp";
(:: import schema at "../Schemas/cobiscorp.ecobis.srvaplcobisentidades.dto.xsd" ::)


declare variable $coreResponse as element() (:: schema-element(ns1:opBuscarFechaSistemaRespuesta) ::) external;
declare variable $globalId as xs:string external;

declare function local:format-date($inputDate as xs:string) as xs:string {
  let $year := substring($inputDate, 1, 4)
  let $month := substring($inputDate, 5, 2)
  let $day := substring($inputDate, 7, 2)
  return concat($year, '-', $month, '-', $day)
};

declare function local:func($globalId as xs:string,$coreResponse as element() (:: schema-element(ns1:opBuscarFechaSistemaRespuesta) ::)) 
    as element() (:: schema-element(ns2:getSystemDateResponse) ::) {
    let $fecha := data($coreResponse/dto:fechaProceso)
    let $fechaString := fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", $fecha)
    let $fechaDate := xs:date($fechaString)
    let $nextDate := $fechaDate + xs:dayTimeDuration("PT24H")
    let $anio := fn:string(year-from-date($fechaDate))
    let $primerDia := xs:date(concat($anio, "-01-01"))
    let $daysBetween := fn-bea:pad-left(fn:string(($fechaDate - $primerDia) div xs:dayTimeDuration("PT24H")), 3, "0")

    return
    (
        <ns2:getSystemDateResponse>
        
        <StatusInfo>
            <Status>{  
                if ( (data($coreResponse/dto:contextoRespuesta/dto:codTipoRespuesta))  eq "0" ) then
                  "Success"
                else
                (data($coreResponse/dto:contextoRespuesta/dto:codTipoRespuesta)) 
            } 
            </Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>            
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
           </StatusInfo>
        
            <WorkingDate>{ local:format-date( fn-bea:dateTime-to-string-with-format("yyyyMMdd", $fecha) ) }</WorkingDate>
            <JulianDate>{ concat($anio, $daysBetween) }</JulianDate>
            <NextWorkingDate>{ local:format-date( fn-bea:date-to-string-with-format("yyyyMMdd", $nextDate) )}</NextWorkingDate>
        </ns2:getSystemDateResponse>
    )
};


local:func($globalId,$coreResponse)