xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getRemittanceFieldsTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/getRemittanceFieldsTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetRemittanceFields";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittanceFields/GetRemittanceFields_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $OutputParameters as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function local:func($OutputParameters as element() (:: schema-element(ns2:OutputParameters) ::)) as element() (:: schema-element(ns1:getRemittanceFieldsResponse) ::) {
    <ns1:getRemittanceFieldsResponse>
    <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
      
        <Fields>
        {
          for $item at $index in $OutputParameters/ns2:PV_NOMBRE/ns2:PV_NOMBRE_ITEM
          return (
          <Field>
                
                <Name>{fn:data($item)}</Name>
                <Type>{fn:data($OutputParameters/ns2:PV_TIPO/ns2:PV_TIPO_ITEM[$index])}</Type>
                <LabelEs>{fn:data($OutputParameters/ns2:PV_ETIQUETAES/ns2:PV_ETIQUETAES_ITEM[$index])}</LabelEs>
                <LabelEn>{fn:data($OutputParameters/ns2:PV_ETIQUETAEN/ns2:PV_ETIQUETAES_ITEM[$index])}</LabelEn>
            </Field>
          )
        }
            
        </Fields>
    </ns1:getRemittanceFieldsResponse>
};

local:func($OutputParameters)
