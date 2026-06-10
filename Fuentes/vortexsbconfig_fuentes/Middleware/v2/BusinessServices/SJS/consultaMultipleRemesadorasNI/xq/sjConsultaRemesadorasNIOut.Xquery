<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaMultipleRemesadorasNIResponse" location="../xsd/sjConsultaMultipleRemesadorasNI.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadorasNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRemesadorasNI/xq/sjConsultaRemesadorasNIOut/";

declare function xf:sjConsultaRemesadorasNIOut($resultGroup as element(*))
    as element(ns0:sjConsultaMultipleRemesadorasNIResponse) {
        <ns0:sjConsultaMultipleRemesadorasNIResponse>
            {
         let $count := count($resultGroup/REMITTANCE/ROUTER_RESPONSE)
         return(
           if($count > 0)then(
              let $succesResponse := $resultGroup/REMITTANCE/ROUTER_RESPONSE[SUCCESS_INDICATOR/text() = 'Success']
              let $errorResponse := $resultGroup/REMITTANCE/ROUTER_RESPONSE[SUCCESS_INDICATOR/text() != 'Success']
              return(
                if(count($succesResponse) > 0)then(
                      <ns0:SUCCESS_INDICATOR>{fn:data($succesResponse/SUCCESS_INDICATOR) }</ns0:SUCCESS_INDICATOR>,
                      <ns0:ERROR_MESSAGE>{fn:data($succesResponse/ERROR_MESSAGE) }</ns0:ERROR_MESSAGE>,
                      <ns0:REMITTANCE>
                        <ns0:ROUTER_RESPONSE>
                             <ns0:REMITTANCE_ID>{fn:data($succesResponse/REMITTANCE_ID)}</ns0:REMITTANCE_ID>
                             <ns0:REMITTER_NAME>{fn:data($succesResponse/REMITTER_NAME)}</ns0:REMITTER_NAME>
                             <ns0:AGREEMENT_ID>{fn:data($succesResponse/AGREEMENT_ID)}</ns0:AGREEMENT_ID>
                             <ns0:REMITTANCE_TYPE>{fn:data($succesResponse/REMITTANCE_TYPE)}</ns0:REMITTANCE_TYPE>
                             <ns0:REMITTANCE_NAME>{  fn:data($succesResponse/REMITTANCE_NAME) }</ns0:REMITTANCE_NAME>
                             <ns0:REMITTANCE_ABBREVIATION>{fn:data($succesResponse/REMITTANCE_ABBREVIATION)}</ns0:REMITTANCE_ABBREVIATION>
                             <ns0:PRIORITY>{fn:data($succesResponse/PRIORITY)}</ns0:PRIORITY>
                             <ns0:BENEFICIARY_NAME>{fn:data($succesResponse/BENEFICIARY_NAME)}</ns0:BENEFICIARY_NAME>
                             <ns0:PAYMENT_DATE>{fn:data($succesResponse/PAYMENT_DATE)}</ns0:PAYMENT_DATE>
                             <ns0:REMITTANCE_DATE>{fn:data($succesResponse/REMITTANCE_DATE)}</ns0:REMITTANCE_DATE>
                             <ns0:CURRENCY>{fn:data($succesResponse/CURRENCY)}</ns0:CURRENCY>
                             <ns0:REMITTANCE_STATUS>{fn:data($succesResponse/REMITTANCE_STATUS)}</ns0:REMITTANCE_STATUS>
                             <ns0:REMITTANCE_AMOUNT>{fn:data($succesResponse/REMITTANCE_AMOUNT)}</ns0:REMITTANCE_AMOUNT>
                             <ns0:REMITTANCE_SOURCE_AMOUNT>{fn:data($succesResponse/REMITTANCE_SOURCE_AMOUNT)}</ns0:REMITTANCE_SOURCE_AMOUNT>
                             <ns0:ORIGIN_COUNTRY>{fn:data($succesResponse/ORIGIN_COUNTRY)}</ns0:ORIGIN_COUNTRY>
                            <ns0:TRANSACTION_ID>{fn:data($succesResponse/TRANSACTION_ID)}</ns0:TRANSACTION_ID> 
                            <ns0:ORDER_ID>{fn:data($succesResponse/ORDER_ID)}</ns0:ORDER_ID>
                            <ns0:TRANSMITTERCODE>{fn:data($succesResponse/TRANSMITTERCODE)}</ns0:TRANSMITTERCODE>
                        </ns0:ROUTER_RESPONSE>
                      </ns0:REMITTANCE>
              )else(
                <ns0:SUCCESS_INDICATOR>{ fn:data($errorResponse/SUCCESS_INDICATOR) }</ns0:SUCCESS_INDICATOR>,
                <ns0:ERROR_MESSAGE>{ string($errorResponse[1]/ERROR_MESSAGE/text()) }</ns0:ERROR_MESSAGE>
              )
            )
           )else(
              <ns0:SUCCESS_INDICATOR>NO RECORDS</ns0:SUCCESS_INDICATOR>,
              <ns0:ERROR_MESSAGE>NO RECORDS FOUND</ns0:ERROR_MESSAGE>
           )
         )
        }
        </ns0:sjConsultaMultipleRemesadorasNIResponse>
};

declare variable $resultGroup as element(*) external;

xf:sjConsultaRemesadorasNIOut($resultGroup)]]></con:xquery>
    <con:dependency location="../xsd/sjConsultaMultipleRemesadorasNI.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI"/>
    </con:dependency>
</con:xqueryEntry>