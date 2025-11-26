xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/achServicesPS";
(:: import schema at "../../../../../../MWBanking/Ach/RequestorServices/v1.0/AchSoapRouter/XSD/achTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com/ach";
(:: import schema at "../../../../../ProviderServices/XSD/achCDM.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getTransactionIn";

declare variable $getReportTransactionRequest as element() (:: schema-element(ns2:GetReportTransactionRequest) ::) external;
declare variable $userName as xs:string external;

declare function ns1:getTransactionIn($userName as xs:string, $getReportTransactionRequest as element() (:: schema-element(ns2:GetReportTransactionRequest) ::)) as element() (:: schema-element(ns3:GetReportTransactionRequest) ::) {
    <ns3:GetReportTransactionRequest>
    
        <ns3:countryId>0</ns3:countryId>
        {
            if ($getReportTransactionRequest/ns2:bank)
            then <ns3:bank>{fn:data($getReportTransactionRequest/ns2:bank)}</ns3:bank>
            else ()
        }
        {
            if ($getReportTransactionRequest/ns2:transactionType)
            then <ns3:transactionType>{fn:data($getReportTransactionRequest/ns2:transactionType)}</ns3:transactionType>
            else ()
        }
        {
            if ($getReportTransactionRequest/ns2:originatorAccount)
            then <ns3:originatorAccount>{fn:data($getReportTransactionRequest/ns2:originatorAccount)}</ns3:originatorAccount>
            else ()
        }
        {
            if ($getReportTransactionRequest/ns2:destinationAccount)
            then <ns3:destinationAccount>{fn:data($getReportTransactionRequest/ns2:destinationAccount)}</ns3:destinationAccount>
            else ()
        }
        {
            if ($getReportTransactionRequest/ns2:processedTime)
            then <ns3:processedTime>{fn:data($getReportTransactionRequest/ns2:processedTime)}</ns3:processedTime>
            else ()
        }
        {
            if ($getReportTransactionRequest/ns2:currency)
            then <ns3:currency>{fn:data($getReportTransactionRequest/ns2:currency)}</ns3:currency>
            else ()
        }
        {
            if ($getReportTransactionRequest/ns2:initialAmount)
            then <ns3:initialAmount>{fn:data($getReportTransactionRequest/ns2:initialAmount)}</ns3:initialAmount>
            else ()
        }
        {
            if ($getReportTransactionRequest/ns2:finalAmount)
            then <ns3:finalAmount>{fn:data($getReportTransactionRequest/ns2:finalAmount)}</ns3:finalAmount>
            else ()
        }
        {
            if ($getReportTransactionRequest/ns2:pageSize)
            then <ns3:pageSize>{fn:data($getReportTransactionRequest/ns2:pageSize)}</ns3:pageSize>
            else ()
        }
        {
            if ($getReportTransactionRequest/ns2:page)
            then <ns3:page>{fn:data($getReportTransactionRequest/ns2:page)}</ns3:page>
            else ()
        }
        <ns3:userName>{fn:data($userName)}</ns3:userName>
    </ns3:GetReportTransactionRequest>
};

ns1:getTransactionIn($userName, $getReportTransactionRequest)