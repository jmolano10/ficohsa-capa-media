<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaTucaHNTypes";

(: Esta variable YA VIENE PARSEADA desde el flow :)
declare variable $ReporteXML as element() external;


declare function local:consultaTucaHNOut() {

  (: Punto de entrada real del XML :)
  let $rep := $ReporteXML
  
   (: --- STATUS pre-calculado para evitar nodo actual --- :)
    let $status :=
        if (
            fn:normalize-space(
                fn:string(
                    $rep/datosGenerales/identificacionesSujeto/identificacionSujeto/estado
                )
            ) != ''
        )
        then
            fn:normalize-space(
                fn:string(
                    $rep/datosGenerales/identificacionesSujeto/identificacionSujeto/estado
                )
            )
        else
            'NO DATA'

  return

  <ns1:consultaTucaHNResponse>
   <STATUS>{ $status }</STATUS>
    <BUREAU_TUCA>¨
    { 
          if (exists($rep/datosGenerales)) then
            <GENERAL_DATA>
              <IDESTUDIOTUCA>{ data($rep/encabezado/identificadorEstudio) }</IDESTUDIOTUCA>
              <IDENTIDAD>{ data($rep/datosGenerales/identificacionesSujeto/identificacionSujeto/numero) }</IDENTIDAD>
              <FIRST_LAST_NAME>{ data($rep/datosGenerales/primerApellido) }</FIRST_LAST_NAME>
              <SECOND_LAST_NAME>{ data($rep/datosGenerales/segundoApellido) }</SECOND_LAST_NAME>
              <LAST_NAME_CASADA>{ data($rep/datosGenerales/apellidoCasada) }</LAST_NAME_CASADA>
              <FIRST_NAME>{ data($rep/datosGenerales/primerNombre) }</FIRST_NAME>
              <SECOND_NAME>{ data($rep/datosGenerales/segundoNombre) }</SECOND_NAME>
              <NAME_COMPLETO>{ data($rep/datosGenerales/nombreCompleto) }</NAME_COMPLETO>
              <ID_TYPE>{ data($rep/datosGenerales/identificacionesSujeto/identificacionSujeto/tipo) }</ID_TYPE>
              <ID_NUMBER>{ data($rep/datosGenerales/identificacionesSujeto/identificacionSujeto/numero) }</ID_NUMBER>
              <STATUS_ID_CODE>{ data($rep/datosGenerales/identificacionesSujeto/identificacionSujeto/estado/@codigo) }</STATUS_ID_CODE>
              <STATUS_ID>{ data($rep/datosGenerales/identificacionesSujeto/identificacionSujeto/estado) }</STATUS_ID>
              <DATE_BIRTH>{ data($rep/datosGenerales/fechaNacimiento) }</DATE_BIRTH>
              <AGE>{ data($rep/datosGenerales/edad) }</AGE>
              <ORIGIN>{ data($rep/datosGenerales/origen) }</ORIGIN>
              <STATUS_CIVIL_CODE>{ data($rep/datosGenerales/estadoCivil/@codigo) }</STATUS_CIVIL_CODE>
              <STATUS_CIVIL>{ data($rep/datosGenerales/estadoCivil) }</STATUS_CIVIL>
              <GENDER_CODE>{ data($rep/datosGenerales/genero/@codigo) }</GENDER_CODE>
              <GENDER>{ data($rep/datosGenerales/genero) }</GENDER>
              <SOCIAL_REASON>{ data($rep/datosGenerales/razonSocial) }</SOCIAL_REASON>
              <NAME_COMERCIAL>{ data($rep/datosGenerales/nombreComercial) }</NAME_COMERCIAL>
              <DATE_CREACION>{ data($rep/encabezado/fechaReporte) }</DATE_CREACION>
              <DEPENDIENTES/>
              <STATUS_ID>{ data($rep/datosGenerales/estadoVida) }</STATUS_ID>
            </GENERAL_DATA>
          else ()
        }
  
   <MODEL>
        {
          for $m in $rep/modelosAnalisis/modelo
          return
           
              <MODEL_ITEM>
                <PRODUCT>{ data($m/producto) }</PRODUCT>
                <CODE_PRODUCT>{ data($m/producto/@codigo) }</CODE_PRODUCT>
                <RESULT>{ data($m/resultado) }</RESULT>
                <REASONS>{ data($m/razones) }</REASONS>
              </MODEL_ITEM>
            
        }
  </MODEL>
    <LOCATION>
        {
          for $l in $rep/localizacion/direccionYTelefono
          return
          
              <LOCATION_ITEM>
                <TIPO>{ data($l/tipo) }</TIPO>
                <CODE>{ data($l/tipo/@codigo) }</CODE>
                <PHONE>{ data($l/telefono) }</PHONE>
                <EXTENSION>{ data($l/extension) }</EXTENSION>
                <DESC>{ data($l/direccion/desc) }</DESC>
                <DIVISIONGEOGRAFICA1>{ data($l/direccion/divisionGeografica1) }</DIVISIONGEOGRAFICA1>
                <DIVISIONGEOGRAFICA2>{ data($l/direccion/divisionGeografica2) }</DIVISIONGEOGRAFICA2>
              </LOCATION_ITEM>
           
        }
   </LOCATION>
   <OBLIGATIONS_BEHAVIOR>
        {
          for $o in $rep/comportamientoObligaciones/obligacion
          return
              <OBLIGATIONS_ITEM>
                <IDESTUDIOTUCA>{ data($rep/encabezado/identificadorEstudio) }</IDESTUDIOTUCA>
                <IDENTIDAD>{ data($rep/datosGenerales/identificacionesSujeto/identificacionSujeto/numero) }</IDENTIDAD>
                <TYPE_OBS>{ data($o/@tipoObs) }</TYPE_OBS>
                <SECTOR>{ data($o/@sector) }</SECTOR>
                <CREDIT>{ data($o/creditoConsecutivo) }</CREDIT>
                <MENSAGGE/>
                <ENTITY_CODE>{ data($o/entidadInformante/@codigo) }</ENTITY_CODE>
                <ENTITY>{ data($o/entidadInformante) }</ENTITY>
                <TYPE_CODE>{ data($o/tipo/@codigo) }</TYPE_CODE>
                <TYPE>{ data($o/tipo) }</TYPE>
                <GUARANTEE_CODE>{ data($o/garantia/@codigo) }</GUARANTEE_CODE>
                <GUARANTEE>{ data($o/garantia) }</GUARANTEE>
                <NUMBER>{ data($o/numero) }</NUMBER>
                <OPENING_DATE>{ data($o/fechaApertura) }</OPENING_DATE>
                <LAST_DATE>{ data($o/fecVencimiento) }</LAST_DATE>
                <ACTUALIZATION_DATE>{ data($o/fechaActualizacion) }</ACTUALIZATION_DATE>
                <PERIOD_CODE>{ data($o/periodoPago/@codigo) }</PERIOD_CODE>
                <PERIOD>{ data($o/periodoPago) }</PERIOD>
                <CALIFICATION_CODE>{ data($o/comportamientoPago/calificacion/@codigo) }</CALIFICATION_CODE>
                <CALIFICATION>{ data($o/comportamientoPago/calificacion) }</CALIFICATION>
                <DUE>{ data($o/comportamientoPago/diasMora) }</DUE>
                <CURRENCY>{ data($o/comportamientoPago/moneda) }</CURRENCY>
                <CURRENCY_CODE>{ data($o/comportamientoPago/moneda/@codigo) }</CURRENCY_CODE>
                <CURRENCY_TYPE>{ data($o/comportamientoPago/moneda/@tipo) }</CURRENCY_TYPE>
                <STATUS_CODE>{ data($o/comportamientoPago/estado/@codigo) }</STATUS_CODE>
                <STATUS_OPEN>{ data($o/comportamientoPago/estado/@vigente)}</STATUS_OPEN>
                <STATUS_INDEX>{ data($o/comportamientoPago/estado/@indice) }</STATUS_INDEX>
                <STATUS>{ data($o/comportamientoPago/estado) }</STATUS>
                <LIMIT>{ data($o/comportamientoPago/limite) }</LIMIT>
                <CURRENT_BALANCE>{ data($o/comportamientoPago/saldoActual) }</CURRENT_BALANCE>
                <DELINQUENCY_BALANCE>{ data($o/comportamientoPago/saldoMora) }</DELINQUENCY_BALANCE>
                <INSTALLMENT>{ data($o/comportamientoPago/cuota) }</INSTALLMENT>
                <BEHAVIOR>{ data($o/comportamientoPago/vectorHistorico) }</BEHAVIOR>
                <HISTORICAL_LOC_USD/>
                <HISTORICAL_LOC_HNL/>
              </OBLIGATIONS_ITEM>
        }
  </OBLIGATIONS_BEHAVIOR>
  <INQUIRIES>
        {
          for $i in $rep/listaConsultas/consulta
          return
            
              <INQUIRIES_ITEM>
                <TYPE>{ data($i/tipoConsulta) }</TYPE>
                <ENTITY_CODE>{ data($i/entidadConsultante/@codigo) }</ENTITY_CODE>
                <ENTITY>{ data($i/entidadConsultante) }</ENTITY>
                <DATE>{ data($i/fecha) }</DATE>
                <MOTIVE_CODE>{ data($i/motivo/@codigo) }</MOTIVE_CODE>
                <MOTIVE>{ data($i/motivo) }</MOTIVE>
              </INQUIRIES_ITEM>      
        }
   </INQUIRIES>
    </BUREAU_TUCA>

  </ns1:consultaTucaHNResponse>
};

local:consultaTucaHNOut()]]></con:xquery>
</con:xqueryEntry>