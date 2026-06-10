<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns4="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
(:: import schema at "../xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaSolicitante";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaSolicitante/xsd/integracionConsultaSolicitante_sp.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTarjetas";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTarjetas/xsd/integracionConsultaTarjetas_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaTrxTarjetas";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxTarjetas/xsd/integracionConsultaTrxTarjetas_sp.xsd" ::)

declare variable $ResponseConsultaSolicitante as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $ResponseConsultaTarjeta as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $ResponseConsultaTrxTarjesta as element() (:: schema-element(ns3:OutputParameters) ::) external;

declare function local:func($ResponseConsultaSolicitante as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $ResponseConsultaTarjeta as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $ResponseConsultaTrxTarjesta as element() (:: schema-element(ns3:OutputParameters) ::)) 
                            as element() (:: schema-element(ns4:consultaConsolidadaRiesgoClienteResponse) ::) {
    <ns4:consultaConsolidadaRiesgoClienteResponse>
      <LOAN_MAINTENANCE>
        <CUSTOMER_INFO>
         
        {
          for $row in $ResponseConsultaSolicitante/ns1:RowSet/ns1:Row
          let $IDENTIDAD := $row/ns1:Column[@name="IDENTIDAD"]
          let $SEGMENTO := $row/ns1:Column[@name="SEGMENTOCLIENTE"]
          let $FECHANAC := $row/ns1:Column[@name="FECHANACIMIENTO"]
          let $EDAD := $row/ns1:Column[@name="EDAD"]
          let $TIPO := $row/ns1:Column[@name="TIPOCLIENTE"]
          let $SALARIO := $row/ns1:Column[@name="SALARIOCLIENTE"]
          let $FLAG := $row/ns1:Column[@name="FLAGBLAZE"]
          let $MES := $row/ns1:Column[@name="MESPLANILLA"]
          let $MONTO := $row/ns1:Column[@name="MONTOLPSPLANILLA"]
          let $FECHACARGA := $row/ns1:Column[@name="FECHACARGA"]
          return                 
          (
            <ID>{ data($IDENTIDAD) }</ID>,
            <SEGMENTO>{ data($SEGMENTO) }</SEGMENTO>,
            <FECHA_NACIMIENTO>{ data($FECHANAC) }</FECHA_NACIMIENTO>,
            <EDAD>{ data($EDAD) }</EDAD>,
            <TIPO_CLIENTE>{ data($TIPO) }</TIPO_CLIENTE>,
            <SALARIO>{ data($SALARIO) }</SALARIO>,
            if (exists($FLAG) and not($FLAG/@xsi:nil = "true")) then
              <FLAG_BLAZE>{ data($FLAG) }</FLAG_BLAZE>
            else
              <FLAG_BLAZE/>,
            <MES_PLANILLA>{ data($MES) }</MES_PLANILLA>,
            <MONTO_PLANILLA>{ data($MONTO) }</MONTO_PLANILLA>,
            <FECHA_CARGA>{ data($FECHACARGA) }</FECHA_CARGA>
         )
        }
        {
          for $row in $ResponseConsultaTarjeta/ns2:RowSet/ns2:Row
          let $NUMEROCUENTA := $row/ns2:Column[@name="NUMEROCUENTA"]
          let $BEHAVIORSCORE := $row/ns2:Column[@name="BEHAVIORSCORE"]
          let $CALIFICACIONSCORE := $row/ns2:Column[@name="CALIFICACIONSCORE"]
          let $CALIFICACIONSCORECLIENTE := $row/ns2:Column[@name="CALIFICACIONSCORECLIENTE"]
          let $ESTADO := $row/ns2:Column[@name="ESTADO"]
          let $GRUPOAFINIDAD := $row/ns2:Column[@name="GRUPOAFINIDAD"]
          let $PRODUCTO := $row/ns2:Column[@name="PRODUCTO"]
          let $FECHAAPERTURA := $row/ns2:Column[@name="FECHAAPERTURA"]
          let $FECHACANCELACION := $row/ns2:Column[@name="FECHACANCELACION"]
          let $FECHAULTIMOEXTRA := $row/ns2:Column[@name="FECHAULTIMOEXTRA"]
          let $MORAACTUAL := $row/ns2:Column[@name="MORAACTUAL"]
          let $LIMITEACTUAL := $row/ns2:Column[@name="LIMITEACTUAL"]
          let $SALDOACTUAL := $row/ns2:Column[@name="SALDOACTUAL"]
          let $SALDOCORTE := $row/ns2:Column[@name="SALDOCORTE"]
          let $SALDOEXTRA := $row/ns2:Column[@name="SALDOEXTRA"]
          let $SALDOINTRA := $row/ns2:Column[@name="SALDOINTRA"]
          let $CUOTASEXTRAVIGENTES := $row/ns2:Column[@name="CUOTASEXTRAVIGENTES"]
          let $FECBLOQUE1 := $row/ns2:Column[@name="FECBLOQUE1"]
          let $FECBLOQUE2 := $row/ns2:Column[@name="FECBLOQUE2"]
          let $CODBLOQUE1 := $row/ns2:Column[@name="CODBLOQUE1"]
          let $CODBLOQUE2 := $row/ns2:Column[@name="CODBLOQUE2"]
          let $FECHA_APROBACION_EXTRA := $row/ns2:Column[@name="FECHA_APROBACION_EXTRA"]
          let $FECHA_APROBACION_INTRA := $row/ns2:Column[@name="FECHA_APROBACION_INTRA"]
          let $LIMITE_PREVIO := $row/ns2:Column[@name="LIMITE_PREVIO"]
          let $SALDO_AUTORIZACION := $row/ns2:Column[@name="SALDO_AUTORIZACION"]
          return
            (
              <ACCOUNT>{ data($NUMEROCUENTA) }</ACCOUNT>,
              <BEHAVIOR_SCORE>{ data($BEHAVIORSCORE) }</BEHAVIOR_SCORE>,
              <QUALIFICATION_SCORE>{ data($CALIFICACIONSCORE) }</QUALIFICATION_SCORE>,
              <QUALIFICATION_CUSTOMER_SCORE>{ data($CALIFICACIONSCORECLIENTE) }</QUALIFICATION_CUSTOMER_SCORE>,
              <STATUS>{ data($ESTADO) }</STATUS>,
              <AFFINITY_GROUP>{ data($GRUPOAFINIDAD) }</AFFINITY_GROUP>,
              <PRODUCT>{ data($PRODUCTO) }</PRODUCT>,
              <OPENING_DATE>{ data($FECHAAPERTURA) }</OPENING_DATE>,
              <CANCELATION_DATE>{ data($FECHACANCELACION) }</CANCELATION_DATE>,
              <LAST_EXTRA_DATE>{ data($FECHAULTIMOEXTRA) }</LAST_EXTRA_DATE>,
              <CURRENT_DUE>{ data($MORAACTUAL) }</CURRENT_DUE>,
              <CURRENT_LIMIT>{ data($LIMITEACTUAL) }</CURRENT_LIMIT>,
              <CURRENT_BALANCE>{ data($SALDOACTUAL) }</CURRENT_BALANCE>,
              <CLOSING_BALANCE>{ data($SALDOCORTE) }</CLOSING_BALANCE>,
              <EXTRA_BALANCE>{ data($SALDOEXTRA) }</EXTRA_BALANCE>,
              <INTRA_BALANCE>{ data($SALDOINTRA) }</INTRA_BALANCE>,
              <ACTIVE_EXTRA_INSTALLMENTS>{ data($CUOTASEXTRAVIGENTES) }</ACTIVE_EXTRA_INSTALLMENTS>,
              <LOCK_DATE1>{ data($FECBLOQUE1) }</LOCK_DATE1>,
              <LOCK_DATE2>{ data($FECBLOQUE2) }</LOCK_DATE2>,
              <LOCKCODE1>{ data($CODBLOQUE1) }</LOCKCODE1>,
              <LOCKCODE2>{ data($CODBLOQUE2) }</LOCKCODE2>,
              <EXTRA_APPROVAL_DATE>{ data($FECHA_APROBACION_EXTRA) }</EXTRA_APPROVAL_DATE>,
              <INTRA_APPROVAL_DATE>{ data($FECHA_APROBACION_INTRA) }</INTRA_APPROVAL_DATE>,
              <PRIOR_LIMIT>{ data($LIMITE_PREVIO) }</PRIOR_LIMIT>,
              <AUTH_BALANCE>{ data($SALDO_AUTORIZACION) }</AUTH_BALANCE>
            )
        }
        </CUSTOMER_INFO>
       </LOAN_MAINTENANCE>
    </ns4:consultaConsolidadaRiesgoClienteResponse>
};

local:func($ResponseConsultaSolicitante, $ResponseConsultaTarjeta, $ResponseConsultaTrxTarjesta)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/consultaConsolidadaRiesgoClienteTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaSolicitante/xsd/integracionConsultaSolicitante_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaSolicitante/xsd/integracionConsultaSolicitante_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTarjetas/xsd/integracionConsultaTarjetas_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaTarjetas/xsd/integracionConsultaTarjetas_sp"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaTrxTarjetas/xsd/integracionConsultaTrxTarjetas_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaTrxTarjetas/xsd/integracionConsultaTrxTarjetas_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>