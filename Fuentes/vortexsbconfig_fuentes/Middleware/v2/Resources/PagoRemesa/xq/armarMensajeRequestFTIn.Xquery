<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoderemesaFTResponse1" element="ns0:PagoderemesaFTResponse" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRemesas1" element="ns1:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/armarMensajeRecaudo/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_ARMAR_MENSAJE.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_ARMAR_MENSAJE/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf  = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/armarMensajeRequestFTIn/";

(: Función recursiva que retorna todos los nodos de $root :)
declare function get-nodes($root as element()?) as element()* {
  for $child in $root/*
  return
    if (not($child/text()[normalize-space(.) != '']) and $child/*)
    then get-nodes($child)
    else $child
};

(: Devuelve el nodo de entrada sin el elemento a borrar :)
declare function remove-node($elements as element()*,
                            $name as xs:string*) as element()* {
  for $element in $elements
  return
    element { node-name($element) } {
      $element/@*,
      $element/node()[not(name() = $name)]
    }
};

(: Devuelve la fecha de vencimiento del ID del beneficiario :)
declare function expiration-date($date as xs:string?) as xs:string? {
  let $d := normalize-space(string($date))
  return
    if ($d = '') then ()
    else
      concat(
        xs:int(substring($d, 1, 4)) + 100,
        substring($d, 5, 2),
        substring($d, 7, 2)
      )
};

(: Devuelve la conversion de la letra Ñ a \u00d1 para WU y Vigo :)
declare function convert-text($value as xs:string?, $tipoRem as xs:string?) as xs:string? {
  let $v := string($value)
  let $t := string($tipoRem)
  return
    if (normalize-space($v) = '') then ()
    else
      let $hasEnye := matches($v, 'Ñ')
      return
        if ( ($t = '5242535.001' or $t = '5242535.002') and $hasEnye = true() )
        then concat(substring-before($v, 'Ñ'), '\u00D1', substring-after($v, 'Ñ'))
        else $v
};

declare function xf:armarMensajeRequestFTIn($requestHeader1 as element(ns3:RequestHeader),
                                           $pagoderemesaFTResponse1 as element(ns0:PagoderemesaFTResponse),
                                           $pagoRemesas1 as element(ns1:pagoRemesas))
  as element(ns2:InputParameters) {

  let $remitterId := normalize-space(string(($pagoRemesas1/*:REMITTER_ID)[1]))

  return
    <ns2:InputParameters>
      <ns2:CODIGO_CONTRATO>{ $remitterId }</ns2:CODIGO_CONTRATO>
      <ns2:TIPO_OPERACION>2</ns2:TIPO_OPERACION>
      <ns2:TIPO_PARAM>REQ</ns2:TIPO_PARAM>
      <ns2:APLICACION>FT</ns2:APLICACION>

      <ns2:INFO>
        {
          (: Header sin Password + pagoRemesas sin ADDITIONAL_INFO :)
          for $nodo in (
            get-nodes(remove-node($requestHeader1/*:Authentication, "Password")),
            get-nodes(remove-node($pagoRemesas1, "ADDITIONAL_INFO"))
          )
          return
            <ns2:DATA>
              <ns2:NAME>{ fn:local-name($nodo) }</ns2:NAME>
              <ns2:VALUE>{ fn:string($nodo/text()) }</ns2:VALUE>
            </ns2:DATA>
        }
        {
          (: ADDITIONAL_INFO/INFO :)
          for $INFO in $pagoRemesas1/*:ADDITIONAL_INFO/*:INFO
          let $name := normalize-space(string(($INFO/*:NAME)[1]))
          let $val  := string(($INFO/*:VALUE)[1])
          return
            <ns2:DATA>
              <ns2:NAME>{ $name }</ns2:NAME>
              <ns2:VALUE>{ (convert-text($val, $remitterId), '')[1] }</ns2:VALUE>
            </ns2:DATA>
        }
        {
          (: ID_EXPIRATION_DATE solo si existe DOB :)
          let $dob := normalize-space(string(($pagoRemesas1/*:BENEFICIARY_INFO/*:DATE_OF_BIRTH)[1]))
          return
            if ($dob != '') then
              <ns2:DATA>
                <ns2:NAME>ID_EXPIRATION_DATE</ns2:NAME>
                <ns2:VALUE>{ (expiration-date($dob), '')[1] }</ns2:VALUE>
              </ns2:DATA>
            else ()
        }
      </ns2:INFO>

      (: Se extrae la informacion del response del FT hecho a t24 :)
      <ns2:INFO_T24>
        {
          for $nodo in get-nodes($pagoderemesaFTResponse1)
          return
            <ns2:DATA>
              <ns2:NAME>{ fn:local-name($nodo) }</ns2:NAME>
              <ns2:VALUE>{ fn:string($nodo/text()) }</ns2:VALUE>
            </ns2:DATA>
        }
      </ns2:INFO_T24>

    </ns2:InputParameters>
};

declare variable $requestHeader1 as element(ns3:RequestHeader) external;
declare variable $pagoderemesaFTResponse1 as element(ns0:PagoderemesaFTResponse) external;
declare variable $pagoRemesas1 as element(ns1:pagoRemesas) external;

xf:armarMensajeRequestFTIn($requestHeader1,
                           $pagoderemesaFTResponse1,
                           $pagoRemesas1)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd"/>
    <con:dependency location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd"/>
    <con:dependency location="../xsd/pagoRemesas.xsd"/>
    <con:dependency location="../../../BusinessServices/armarMensajeRecaudo/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_ARMAR_MENSAJE.xsd"/>
</con:xqueryEntry>