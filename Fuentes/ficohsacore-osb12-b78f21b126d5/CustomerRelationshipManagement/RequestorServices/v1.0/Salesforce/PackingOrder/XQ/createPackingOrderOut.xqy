xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://soap.sforce.com/schemas/class/WS_crearOrdenEmpaque";
(:: import schema at "../../../../../ProviderServices/v1.0/WSDL/PackingOrder/PackingOrder_BS.wsdl" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/createPackingOrderOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $crearOrdenEmpaqueResponse as element() (:: schema-element(ns2:crearOrdenEmpaqueResponse) ::) external;

declare function ns1:createPackingOrderOut($uuid as xs:string, 
                                           $crearOrdenEmpaqueResponse as element() (:: schema-element(ns2:crearOrdenEmpaqueResponse) ::)) 
                                           as element() (:: schema-element(ns3:packingOrderResponse) ::) {
    <ns3:packingOrderResponse>
        <ns3:StatusInfo>
            {
                if ($crearOrdenEmpaqueResponse/ns2:result/ns2:SuccesIndicator)
                then <com:Status>{fn:data($crearOrdenEmpaqueResponse/ns2:result/ns2:SuccesIndicator)}</com:Status>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            if ($crearOrdenEmpaqueResponse/ns2:result/ns2:OrdenEmpaque)
            then <ns3:ReferenceNumber>{fn:data($crearOrdenEmpaqueResponse/ns2:result/ns2:OrdenEmpaque)}</ns3:ReferenceNumber>
            else ()
        }
    </ns3:packingOrderResponse>
};

ns1:createPackingOrderOut($uuid, $crearOrdenEmpaqueResponse)
