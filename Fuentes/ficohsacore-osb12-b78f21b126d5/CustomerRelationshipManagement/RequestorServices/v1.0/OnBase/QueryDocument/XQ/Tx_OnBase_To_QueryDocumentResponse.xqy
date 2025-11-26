xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $onBaseResponse as element() (:: schema-element(ns1:documentQueryResponseOnBase) ::) external;

declare function xq:Tx_OnBase_To_QueryDocumentResponse($uuid as xs:string, 
                                                       $onBaseResponse as element() (:: schema-element(ns1:documentQueryResponseOnBase) ::)) 
                                                       as element() (:: schema-element(ns2:documentQueryResponse) ::) {
    <ns2:documentQueryResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:DocumentQueryResult>
            {
                for $Documents in $onBaseResponse/ns1:Documents
                return 
                <ns2:Documents>
                    <ns2:DocumentHandle>{fn:data($Documents/ns1:DocumentHandle)}</ns2:DocumentHandle>
                    <ns2:DocumentTypeName>{fn:data($Documents/ns1:DocumentTypeName)}</ns2:DocumentTypeName>
                    <ns2:Name>{fn:data($Documents/ns1:Name)}</ns2:Name>
                    <ns2:DocumentTypeID>{fn:data($Documents/ns1:DocumentTypeID)}</ns2:DocumentTypeID>
                    <ns2:DateStored>{fn:data($Documents/ns1:DateStored)}</ns2:DateStored>
                    <ns2:Keywords>
                        <ns2:Name>{fn:data($Documents/ns1:Keywords/ns1:Name)}</ns2:Name>
                        <ns2:Value>{fn:data($Documents/ns1:Keywords/ns1:Value)}</ns2:Value>
                    </ns2:Keywords>
                    {
                        if ($Documents/ns1:Revision)
                        then <ns2:Revision>{fn:data($Documents/ns1:Revision)}</ns2:Revision>
                        else ()
                    }</ns2:Documents>
            }
            <ns2:Code>{fn:data($onBaseResponse/ns1:Code)}</ns2:Code>
            <ns2:Description>{fn:data($onBaseResponse/ns1:Description)}</ns2:Description>
            {
                if ($onBaseResponse/ns1:Result)
                then <ns2:Result>{fn:data($onBaseResponse/ns1:Result)}</ns2:Result>
                else ()
            }
        </ns2:DocumentQueryResult>
    </ns2:documentQueryResponse>
};

xq:Tx_OnBase_To_QueryDocumentResponse($uuid, $onBaseResponse)