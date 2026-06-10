<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$searchCashPickUpOrderResponse" element="ns0:searchCashPickUpOrderResponse" location="../../../Remesas/RIANI/searchCashPickUpOrder/wsdl/searchCashPickUpOrder.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaRemesadorasNI" element="ns1:sjConsultaMultipleRemesadorasNI" location="../xsd/sjConsultaMultipleRemesadorasNI.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/riaMoneyTransferTypes";
declare namespace ns1= "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadorasNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRemesadorasNI/xq/searchCashPickUpOrderOut/";

declare function xf:searchCashPickUpOrderOut($searchCashPickUpOrderResponse as element(ns0:searchCashPickUpOrderResponse), $sjConsultaRemesadorasNI as element(ns1:sjConsultaMultipleRemesadorasNI))
    as element(*) {
        <ROUTER_RESPONSE>
       {
          let $successIndicator := string($searchCashPickUpOrderResponse/ns0:Response/ns0:ResponseCode/text())
          return(
            if($successIndicator = ("1000", "2002"))then(
                  <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
            )else(
               <SUCCESS_INDICATOR>{ fn:concat("RIA-INQ-", $successIndicator)}</SUCCESS_INDICATOR>,
               <ERROR_MESSAGE>{ fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:ResponseText) }</ERROR_MESSAGE>
            )
          )
      }
        <REMITTANCE_ID>{fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:PIN)}</REMITTANCE_ID>
        <REMITTER_NAME>
          { 
            string-join(
                  for $part in (
                    fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:CustNameFirst),
                    fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:CustNameMiddle),
                    fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:CustNameLast1),
                    fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:CustNameLast2)
                  )
                  where normalize-space($part) != ''
                  return $part,
                  ' '
                )
          }
          </REMITTER_NAME>
          {
             for $item in $sjConsultaRemesadorasNI/ns1:REMITTANCE_TYPES/ns1:REMITTANCE_TYPES_ITEM
             where $item/ns1:REMITTANCE_NAME = 'RIA'
             return(
                <AGREEMENT_ID>{ fn:data($item/ns1:AGREEMENT_ID) }</AGREEMENT_ID>,
                <REMITTANCE_TYPE>{ fn:data($item/ns1:REMITTANCE_TYPE) }</REMITTANCE_TYPE>,
                <REMITTANCE_NAME>{  fn:data($item/ns1:REMITTANCE_NAME) }</REMITTANCE_NAME>,
                <REMITTANCE_ABBREVIATION>{  fn:data($item/ns1:REMITTANCE_ABBREVIATION) }</REMITTANCE_ABBREVIATION>,
                <PRIORITY>{  fn:data($item/ns1:PRIORITY) }</PRIORITY>
            )
          }
          <BENEFICIARY_NAME>
          {
              string-join(
                for $part in (
                  fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:BeneNameFirst),
                  fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:BeneNameMiddle),
                  fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:BeneNameLast1),
                  fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:BeneNameLast2)
                )
                where normalize-space($part) != ''
                return $part,
                ' '
              )
          }
          </BENEFICIARY_NAME>
          {
            let $orderDate := fn:string($searchCashPickUpOrderResponse/ns0:Response/ns0:OrderDate/text())
            return(
             if (fn:exists($orderDate) and fn:string-length($orderDate) > 0) then(
              <REMITTANCE_DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd", $orderDate) }</REMITTANCE_DATE>
            )else()
            )
          }
          <CURRENCY>{fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:BeneCurrency)}</CURRENCY>
          <EXCHANGE_RATE>{fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:Rate)}</EXCHANGE_RATE>
          {
            let $responseCode := string($searchCashPickUpOrderResponse/ns0:Response/ns0:ResponseCode/text())
            return(
              if($responseCode="1000")then(
                <REMITTANCE_STATUS>DISPONIBLE</REMITTANCE_STATUS>
              )else if($responseCode="2002")then(
                 <REMITTANCE_STATUS>PAGADA</REMITTANCE_STATUS>
              )else()
            )
          }
          <REMITTANCE_AMOUNT>{fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:BeneAmount)}</REMITTANCE_AMOUNT>
          <REMITTANCE_SOURCE_AMOUNT>{fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:BeneAmount)}</REMITTANCE_SOURCE_AMOUNT>
          <ORIGIN_COUNTRY>{fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:CountryFrom)}</ORIGIN_COUNTRY> 
          <TRANSACTION_ID>{fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:TransRefID)}</TRANSACTION_ID> 
          <ORDER_ID>{fn:data($searchCashPickUpOrderResponse/ns0:Response/ns0:OrderNo)}</ORDER_ID>
      </ROUTER_RESPONSE>
};

declare variable $searchCashPickUpOrderResponse as element(ns0:searchCashPickUpOrderResponse) external;
declare variable $sjConsultaRemesadorasNI as element(ns1:sjConsultaMultipleRemesadorasNI) external;

xf:searchCashPickUpOrderOut($searchCashPickUpOrderResponse, $sjConsultaRemesadorasNI)]]></con:xquery>
    <con:dependency location="../../../Remesas/RIANI/searchCashPickUpOrder/wsdl/searchCashPickUpOrder.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/Remesas/RIANI/searchCashPickUpOrder/wsdl/searchCashPickUpOrder"/>
    </con:dependency>
    <con:dependency location="../xsd/sjConsultaMultipleRemesadorasNI.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI"/>
    </con:dependency>
</con:xqueryEntry>