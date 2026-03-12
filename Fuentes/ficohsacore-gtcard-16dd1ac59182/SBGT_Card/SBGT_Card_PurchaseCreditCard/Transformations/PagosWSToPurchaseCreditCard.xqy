xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBRegBrokerAdapter";
(:: import schema at "../Schemas/DBRegBrokerAdapter_sp.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/PurchaseCreditCardTypes.xsd" ::)

declare variable $PagosWS as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $globalId as xs:string external;
declare variable $numeroAutorizacion as xs:string external;

declare function local:funcPagosWSToPurchaseCreditCard($PagosWS as element() (:: schema-element(ns1:OutputParameters) ::),
                                                        $globalId as xs:string,
                                                        $numeroAutorizacion as xs:string) as element() (:: schema-element(ns2:purchaseCreditCardResponse) ::) {
    <ns2:purchaseCreditCardResponse>
      <StatusInfo>
        {
                if ($PagosWS/PV_SUCCESSINDICATOR)
                then <Status>{fn:data($PagosWS/PV_SUCCESSINDICATOR)}</Status>
                else ()
            }
            <TransactionId>{fn:data($numeroAutorizacion)}</TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
    </ns2:purchaseCreditCardResponse>
};

local:funcPagosWSToPurchaseCreditCard($PagosWS, $globalId, $numeroAutorizacion)