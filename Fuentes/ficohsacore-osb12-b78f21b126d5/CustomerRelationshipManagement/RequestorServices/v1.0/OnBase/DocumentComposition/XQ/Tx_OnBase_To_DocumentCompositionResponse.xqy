xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/Tx_OnBase_To_DocumentCompositionResponse";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $documentCompositionResponseOnBase as element() (:: schema-element(ns2:documentCompositionResponseOnBase) ::) external;

declare function ns1:Tx_OnBase_To_DocumentCompositionResponse($uuid as xs:string, 
                                                       $documentCompositionResponseOnBase as element() (:: schema-element(ns2:documentCompositionResponseOnBase) ::)) as element() (:: schema-element(ns3:DocumentCompositionRsp) ::) {
    <ns3:DocumentCompositionRsp>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:DocumentCompositionResult>
            {
                for $Documents in $documentCompositionResponseOnBase/ns2:Documents
                return 
                <ns3:Documents>
                    <ns3:DocumentHandler>{fn:data($Documents/ns2:DocumentHandle)}</ns3:DocumentHandler>
                    {
                        for $Revisions in $Documents/ns2:Revisions
                        return 
                        <ns3:Revisions>
                            <ns3:Page>{fn:data($Revisions/ns2:Page)}</ns3:Page></ns3:Revisions>
                    }</ns3:Documents>
            }
            <ns3:Code>{fn:data($documentCompositionResponseOnBase/ns2:Code)}</ns3:Code>
            <ns3:Description>{fn:data($documentCompositionResponseOnBase/ns2:Description)}</ns3:Description>
            {
                if ($documentCompositionResponseOnBase/ns2:Result)
                then <ns3:Result>{fn:data($documentCompositionResponseOnBase/ns2:Result)}</ns3:Result>
                else ()
            }
        </ns3:DocumentCompositionResult>
    </ns3:DocumentCompositionRsp>
};

ns1:Tx_OnBase_To_DocumentCompositionResponse($uuid, $documentCompositionResponseOnBase)