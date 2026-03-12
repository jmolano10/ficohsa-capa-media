xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.procesa.com/fdcs/ot";
(:: import schema at "../Resources/OnlineTransactions_v4.wsdl" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/PurchaseCreditCardTypes.xsd" ::)

declare variable $dbResponse as element() (:: schema-element(ns1:OnlinePaymentV4Response) ::) external;
declare variable $globalId as xs:string external;

declare function local:funcOnlineTransactionsToPurchase($dbResponse as element() (:: schema-element(ns1:OnlinePaymentV4Response) ::),
                                                        $globalId as xs:string) as element() (:: schema-element(ns2:purchaseCreditCardResponse) ::) {
    <ns2:purchaseCreditCardResponse>
      <StatusInfo>
          {
              if ($dbResponse/ActionDescription)
              then <Status>{fn:data($dbResponse/ActionDescription)}</Status>
              else ()
          }
          <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
          <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
          <GlobalId>{fn:data($globalId)}</GlobalId>
      </StatusInfo>
    </ns2:purchaseCreditCardResponse>
};

local:funcOnlineTransactionsToPurchase($dbResponse, $globalId)