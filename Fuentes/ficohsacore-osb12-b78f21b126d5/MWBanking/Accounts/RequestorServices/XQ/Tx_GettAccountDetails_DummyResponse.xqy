xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getAccountDetails";
(:: import schema at "../XSD/getAccountDetails.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace dyn = "http://www.ficohsa.com.hn/middleware.services/dynamoTypes";


declare function xq:Tx_GettAccountDetails_DummyResponse() as element() (:: schema-element(ns1:getAccountDetailsResponse) ::) {
    <ns1:getAccountDetailsResponse>
        <ns1:StatusInfo>
            <dyn:Status>Dummy</dyn:Status>
            <dyn:TransactionId>Dummy</dyn:TransactionId>
            <dyn:ValueDate>Dummy</dyn:ValueDate>
            <dyn:DateTime>Dummy</dyn:DateTime>
            <dyn:GlobalId>Dummy</dyn:GlobalId>
        </ns1:StatusInfo>
        <ns1:AccountDetails>
            <ns1:AccountNumber>Dummy</ns1:AccountNumber>
            <ns1:CustomerId>Dummy</ns1:CustomerId>
            <ns1:AccountName>Dummy</ns1:AccountName>
            <ns1:Category>Dummy</ns1:Category>
            <ns1:Currency>Dummy</ns1:Currency>
            <ns1:LimitRef>Dummy</ns1:LimitRef>
            <ns1:Restrictions>Dummy</ns1:Restrictions>
            <ns1:AltAccount>Dummy</ns1:AltAccount>
            <ns1:OpeningDate>Dummy</ns1:OpeningDate>
            <ns1:OperationType>Dummy</ns1:OperationType>
            <ns1:AccountOfficer>Dummy</ns1:AccountOfficer>
            <ns1:BranchCode>Dummy</ns1:BranchCode>
            <ns1:LegalId>1234</ns1:LegalId>
            <ns1:RequiredSignatures>Dummy</ns1:RequiredSignatures>
            <ns1:SignaturesDesc>Dummy</ns1:SignaturesDesc>
            <ns1:InactiveMarker>Dummy</ns1:InactiveMarker>
        </ns1:AccountDetails>
    </ns1:getAccountDetailsResponse>
};

xq:Tx_GettAccountDetails_DummyResponse()