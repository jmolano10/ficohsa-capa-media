xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;

declare function xq:TX_DummyResponseSAVE($uuid as xs:string) as element() (:: schema-element(ns1:documentResponse) ::) {
    <ns1:documentResponse>
        <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>2022-03-31</com:ValueDate>
            <com:DateTime>2022-03-31T16:47:00</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns1:StatusInfo>
        <ns1:DocumentResult>
            <ns1:Documents>
                <ns1:DocumentHandler>83274</ns1:DocumentHandler>
            </ns1:Documents>
            <ns1:Code>0</ns1:Code>
            <ns1:Description></ns1:Description>
            <ns1:Result></ns1:Result>
        </ns1:DocumentResult>
    </ns1:documentResponse>
};

xq:TX_DummyResponseSAVE($uuid)