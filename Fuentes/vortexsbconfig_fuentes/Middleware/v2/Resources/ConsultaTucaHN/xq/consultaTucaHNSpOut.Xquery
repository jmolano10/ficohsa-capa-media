<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaTucaHNTypes";
(:: import schema at "../xsd/consultaTucaHNTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaBuroTucaHN";
(:: import schema at "../../../BusinessServices/BuroTucaHN/xsd/ConsultaBuroTucaHN_sp.xsd" ::)

declare variable $ConsultaTucaResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;


declare function local:consultaTucaHNSpOut($ConsultaTucaResponse as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:consultaTucaHNResponse) ::) {
    <ns2:consultaTucaHNResponse>
        <BUREAU_TUCA>
        <STATUS>{data($ConsultaTucaResponse/ns1:P_STATUS)}</STATUS>
{
       
      if (exists($ConsultaTucaResponse/ns1:P_GENERAL_DATA)) then
        <GENERAL_DATA>
          <IDESTUDIOTUCA>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:IDESTUDIOTUCA) }</IDESTUDIOTUCA>
          <IDENTIDAD>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:IDENTIDAD) }</IDENTIDAD>
          <FIRST_LAST_NAME>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:FIRST_LAST_NAME) }</FIRST_LAST_NAME>
          <SECOND_LAST_NAME>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:SECOND_LAST_NAME) }</SECOND_LAST_NAME>
          <LAST_NAME_CASADA>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:LAST_NAME_CASADA) }</LAST_NAME_CASADA>
          <FIRST_NAME>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:FIRST_NAME) }</FIRST_NAME>
          <SECOND_NAME>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:SECOND_NAME) }</SECOND_NAME>
          <NAME_COMPLETO>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:NAME_COMPLETO) }</NAME_COMPLETO>
          <ID_TYPE>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:ID_TYPE) }</ID_TYPE>
          <ID_NUMBER>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:ID_NUMBER) }</ID_NUMBER>
          <STATUS_ID_CODE>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:STATUS_ID_CODE) }</STATUS_ID_CODE>
          <STATUS_ID>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:STATUS_ID) }</STATUS_ID>
          <DATE_BIRTH>{data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:DATE_BIRTH) }</DATE_BIRTH>
          <AGE>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:AGE) }</AGE>
          <ORIGIN>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:ORIGIN) }</ORIGIN>
          <STATUS_CIVIL_CODE>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:STATUS_CIVIL_CODE) }</STATUS_CIVIL_CODE>
          <STATUS_CIVIL>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:STATUS_CIVIL) }</STATUS_CIVIL>
          <GENDER_CODE>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:GENDER_CODE) }</GENDER_CODE>
          <GENDER>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:GENDER) }</GENDER>
          <SOCIAL_REASON>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:SOCIAL_REASON) }</SOCIAL_REASON>
          <NAME_COMERCIAL>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:NAME_COMERCIAL) }</NAME_COMERCIAL>
          <DATE_CREACION>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:DATE_CREACION) }</DATE_CREACION>
          <DEPENDIENTES>{ data($ConsultaTucaResponse/ns1:P_GENERAL_DATA/ns1:DEPENDIENTES) }</DEPENDIENTES>
        </GENERAL_DATA>
      else ()
    }
  
      <MODEL>
        {
          for $m in $ConsultaTucaResponse/ns1:P_MODELS/ns1:P_MODELS_ITEM
          return
       
           <MODEL_ITEM>
              <PRODUCT>{ data($m/ns1:PRODUCT) }</PRODUCT>
              <CODE_PRODUCT>{ data($m/ns1:CODE_PRODUCT) }</CODE_PRODUCT>
              <RESULT>{ data($m/ns1:RESULT) }</RESULT>
              <REASONS>{ data($m/ns1:REASONS) }</REASONS>
            </MODEL_ITEM>
        }
      </MODEL>
       <LOCATION>
      {
        for $m in $ConsultaTucaResponse/ns1:P_LOCATIONS/ns1:P_LOCATIONS_ITEM
        return
         <LOCATION_ITEM>
            <TIPO>{ data($m/ns1:TIPO) }</TIPO>
            <CODE>{ data($m/ns1:CODE) }</CODE>
            <PHONE>{ data($m/ns1:PHONE) }</PHONE>
            <EXTENSION>{ data($m/ns1:EXTENSION) }</EXTENSION>
            <DIVISIONGEOGRAFICA1>{ data($m/ns1:DIVISIONGEOGRAFICA1) }</DIVISIONGEOGRAFICA1>
            <DIVISIONGEOGRAFICA2>{ data($m/ns1:DIVISIONGEOGRAFICA2) }</DIVISIONGEOGRAFICA2>
            <DESC>{ data($m/ns1:DESC_LOCATION) }</DESC>
            <PERIOD>{ data($m/ns1:PERIOD) }</PERIOD>
          </LOCATION_ITEM>
      }
       </LOCATION>
      <OBLIGATIONS_BEHAVIOR>
        {
            for $o in $ConsultaTucaResponse/ns1:P_OBLIGATIONS/ns1:P_OBLIGATIONS_ITEM
          
            let $tipo := normalize-space($o/ns1:TYPE)
          
            (: prioridad para ordenar :)
            let $orden :=
              if (contains($tipo, 'Vigente')) then 1
              else if (contains($tipo, 'Historica') or contains($tipo, 'Historico')) then 2
              else 3
          
            (: prefijo :)
            let $prefijo :=
              if ($orden = 1) then 'ACTIVE_REFERENCES'
              else if ($orden = 2) then 'HISTORICAL_REFERENCES'
              else 'UNKNOWN_REFERENCES'
          
            (: letra :)
            let $letra :=
              if (starts-with($tipo, 'Tarjeta')) then 't'
              else if (starts-with($tipo, 'Banca')) then 'b'
              else if (starts-with($tipo, 'Comercio')) then 'c'
              else if (starts-with($tipo, 'Extra')) then 'e'
              else 'x'
          
            order by $orden
          
            return
            element { concat($prefijo, '_', $letra) }
            {
              <IDESTUDIOTUCA>{ data($o/ns1:IDESTUDIOTUCA) }</IDESTUDIOTUCA>,
              <IDENTIDAD>{ data($o/ns1:IDENTIDAD) }</IDENTIDAD>,
              <TYPE_OBS>{ data($o/ns1:TYPE_OBS) }</TYPE_OBS>,
              <SECTOR>{ data($o/ns1:SECTOR) }</SECTOR>,
              <CREDIT>{ data($o/ns1:CREDIT_CONSECUTIVE) }</CREDIT>,
              <MENSAGGE>{ data($o/ns1:MENSAGGE) }</MENSAGGE>,
              <ENTITY_CODE>{ data($o/ns1:ENTITY_CODE) }</ENTITY_CODE>,
              <ENTITY>{ data($o/ns1:ENTITY) }</ENTITY>,
              <TYPE_CODE>{ data($o/ns1:TYPE_CODE) }</TYPE_CODE>,
              <TYPE>{ data($o/ns1:TYPE) }</TYPE>,
              <GUARANTEE_CODE>{ data($o/ns1:GUARANTEE_CODE) }</GUARANTEE_CODE>,
              <GUARANTEE_TYPE>{ data($o/ns1:GUARANTEE) }</GUARANTEE_TYPE>,
              <NUMBER>{ data($o/ns1:NUMBER_OBL) }</NUMBER>,
              <OPENING_DATE>{ data($o/ns1:OPENING_DATE) }</OPENING_DATE>,
              <LAST_DATE>{data($o/ns1:LAST_DATE) }</LAST_DATE>,
              <ACTUALIZATION_DATE>{ data($o/ns1:ACTUALIZATION_DATE) }</ACTUALIZATION_DATE>,
              <PERIOD_CODE>{ data($o/ns1:PERIOD_CODE) }</PERIOD_CODE>,
              <PERIOD>{ data($o/ns1:PERIOD) }</PERIOD>,
              <CALIFICATION_CODE>{ data($o/ns1:CALIFICATION_CODE) }</CALIFICATION_CODE>,
              <CALIFICATION>{ data($o/ns1:CALIFICATION) }</CALIFICATION>,
              <DUE>{ data($o/ns1:DUE) }</DUE>,
              <DUE_BALANCE>0</DUE_BALANCE>,
              <TERM>0</TERM>,
              <CURRENCY>{ data($o/ns1:CURRENCY) }</CURRENCY>,
              <EXCHANGE_FACTOR>0</EXCHANGE_FACTOR>,
              <CURRENCY_CODE>{ data($o/ns1:CURRENCY_CODE) }</CURRENCY_CODE>,
              <CURRENCY_TYPE>{ data($o/ns1:CURRENCY_TYPE) }</CURRENCY_TYPE>,
              <STATUS_CODE>{ data($o/ns1:STATUS_CODE) }</STATUS_CODE>,
              <STATUS_OPEN>{ data($o/ns1:STATUS_OPEN) }</STATUS_OPEN>,
              <STATUS_INDEX>{ data($o/ns1:STATUS_INDEX) }</STATUS_INDEX>,
              <STATUS>{ data($o/ns1:STATUS) }</STATUS>,
              <LIMIT>{ data($o/ns1:LIMIT_AMOUNT) }</LIMIT>,
              <CURRENT_BALANCE>{ data($o/ns1:CURRENT_BALANCE) }</CURRENT_BALANCE>,
              <MIN_PAYMENT>0</MIN_PAYMENT>,
              <GUARANTEE>0</GUARANTEE>,
              <PAYMENT_DUE>0</PAYMENT_DUE>,
              <AMOUNT>0</AMOUNT>,
              <DELINQUENCY_BALANCE>{ data($o/ns1:DELINQUENCY_BALANCE) }</DELINQUENCY_BALANCE>,
              <IN_EXECUTION>0</IN_EXECUTION>,
              <PUNISHED>0</PUNISHED>,
              <PUNISHED_BALANCE>0</PUNISHED_BALANCE>,
              <INSTALLMENT>{ data($o/ns1:INSTALLMENT) }</INSTALLMENT>,
               <BEHAVIOR_DATE>
               {
  let $y := normalize-space($o/ns1:BEHAVIOR_YEAR)
  let $m := normalize-space($o/ns1:BEHAVIOR_MONTH)
  let $mm :=
    if (number($m) lt 10) then concat('0', $m)
    else $m
  return
    if ($y != '' and $m != '') then concat($mm, '/', $y)
    else ()
}
                </BEHAVIOR_DATE>,
              <BEHAVIOR_DUE>{ data($o/ns1:BEHAVIOR_DUE) }</BEHAVIOR_DUE>,
              <BEHAVIOR>{ data($o/ns1:BEHAVIOR) }</BEHAVIOR>,
              <HISTORICAL_LOC_USD>{ data($o/ns1:HISTORICAL_LOC_USD) }</HISTORICAL_LOC_USD>,
              <HISTORICAL_LOC_HNL>{ data($o/ns1:HISTORICAL_LOC_HNL) }</HISTORICAL_LOC_HNL>
              }
          }
  </OBLIGATIONS_BEHAVIOR>


      
      
      <INQUIRIES>
          {
            for $i in $ConsultaTucaResponse/ns1:P_INQUIRIES/ns1:P_INQUIRIES_ITEM
            return
                <INQUIRIES_ITEM>
                  <TYPE>{ data($i/ns1:TYPE) }</TYPE>
                  <ENTITY_CODE>{ data($i/ns1:ENTITY_CODE) }</ENTITY_CODE>
                  <ENTITY>{ data($i/ns1:ENTITY) }</ENTITY>
                  <DATE>{ data($i/ns1:DATE_INQUIRY) }</DATE>
                  <MOTIVE_CODE>{ data($i/ns1:MOTIVE_CODE) }</MOTIVE_CODE>
                  <MOTIVE>{ data($i/ns1:MOTIVE) }</MOTIVE>
                </INQUIRIES_ITEM>  
          }
      </INQUIRIES>
              
      
        </BUREAU_TUCA>
    </ns2:consultaTucaHNResponse>
};

local:consultaTucaHNSpOut($ConsultaTucaResponse)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/consultaTucaHNTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/ConsultaTucaHN/xsd/consultaTucaHNTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/BuroTucaHN/xsd/ConsultaBuroTucaHN_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/BuroTucaHN/xsd/ConsultaBuroTucaHN_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>