xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/UpdateDebitCardStatus/UpdateDebitCardStatus.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/updateDebitCardStatusOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $aperturaCuentasClienteResponse as element() (:: schema-element(ns2:AperturaCuentasClienteResponse) ::) external;

declare function ns1:updateDebitCardStatusOut($uuid as xs:string, 
                                              $aperturaCuentasClienteResponse as element() (:: schema-element(ns2:AperturaCuentasClienteResponse) ::)) 
                                              as element() (:: schema-element(ns3:updateDebitCardStatusResponse) ::) {
    <ns3:updateDebitCardStatusResponse>
        <ns3:StatusInfo>
            {
                if ($aperturaCuentasClienteResponse/Status/successIndicator)
                then <com:Status>{fn:data($aperturaCuentasClienteResponse/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($aperturaCuentasClienteResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($aperturaCuentasClienteResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            if ($aperturaCuentasClienteResponse/FICOBULKAPPRCLNTType/FIELDS50)
            then <ns3:CardNumber>{fn:data($aperturaCuentasClienteResponse/FICOBULKAPPRCLNTType/FIELDS50)}</ns3:CardNumber>
            else ()
        }
    </ns3:updateDebitCardStatusResponse>
};

ns1:updateDebitCardStatusOut($uuid, $aperturaCuentasClienteResponse)
