xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/achServicesPS";
(:: import schema at "../../../../../../MWBanking/Ach/RequestorServices/v1.0/AchSoapRouter/XSD/achTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com/ach";
(:: import schema at "../../../../../ProviderServices/XSD/achCDM.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/getTransactionOUT";

declare variable $getReportTransactionResponse as element() (:: schema-element(ns1:GetReportTransactionResponse) ::) external;

declare function ns2:getTransactionOUT($getReportTransactionResponse as element() (:: schema-element(ns1:GetReportTransactionResponse) ::)) as element() (:: schema-element(ns3:GetReportTransactionResponse) ::) {
    <ns3:GetReportTransactionResponse>
        {
            if ($getReportTransactionResponse/ns1:currentPage)
            then <ns3:currentPage>{fn:data($getReportTransactionResponse/ns1:currentPage)}</ns3:currentPage>
            else ()
        }
        {
            if ($getReportTransactionResponse/ns1:totalPages)
            then <ns3:totalPages>{fn:data($getReportTransactionResponse/ns1:totalPages)}</ns3:totalPages>
            else ()
        }
        {
            if ($getReportTransactionResponse/ns1:pageSize)
            then <ns3:pageSize>{fn:data($getReportTransactionResponse/ns1:pageSize)}</ns3:pageSize>
            else ()
        }
        {
            for $details in $getReportTransactionResponse/ns1:details
            return 
            <ns3:details>
                {
                    if ($details/ns1:transactionType)
                    then <ns3:transactionType>{fn:data($details/ns1:transactionType)}</ns3:transactionType>
                    else ()
                }
                {
                    if ($details/ns1:messageType)
                    then <ns3:messageType>{fn:data($details/ns1:messageType)}</ns3:messageType>
                    else ()
                }
                {
                    if ($details/ns1:processedTime)
                    then <ns3:processedTime>{fn:data($details/ns1:processedTime)}</ns3:processedTime>
                    else ()
                }
                {
                    if ($details/ns1:bank)
                    then <ns3:bankName>{fn:data($details/ns1:bank)}</ns3:bankName>
                    else ()
                }
                {
                    if ($details/ns1:receivingBankId)
                    then <ns3:receivingBankId>{fn:data($details/ns1:receivingBankId)}</ns3:receivingBankId>
                    else ()
                }
                {
                    if ($details/ns1:accountType)
                    then <ns3:accountType>{fn:data($details/ns1:accountType)}</ns3:accountType>
                    else ()
                }
                {
                    if ($details/ns1:originatorAccount)
                    then <ns3:originatingAccount>{fn:data($details/ns1:originatorAccount)}</ns3:originatingAccount>
                    else ()
                }
                {
                    if ($details/ns1:destinationAccountType)
                    then <ns3:destinationAccountType>{fn:data($details/ns1:destinationAccountType)}</ns3:destinationAccountType>
                    else ()
                }
                {
                    if ($details/ns1:destinationAccount)
                    then <ns3:destinationAccount>{fn:data($details/ns1:destinationAccount)}</ns3:destinationAccount>
                    else ()
                }
                {
                    if ($details/ns1:currencyIso)
                    then <ns3:currencyIso>{fn:data($details/ns1:currencyIso)}</ns3:currencyIso>
                    else ()
                }
                {
                    if ($details/ns1:amount)
                    then <ns3:amount>{fn:data($details/ns1:amount)}</ns3:amount>
                    else ()
                }
                {
                    if ($details/ns1:reasonCode)
                    then <ns3:reasonCode>{fn:data($details/ns1:reasonCode)}</ns3:reasonCode>
                    else ()
                }
                {
                    if ($details/ns1:results)
                    then <ns3:results>{fn:data($details/ns1:results)}</ns3:results>
                    else ()
                }
                {
                    if ($details/ns1:status)
                    then <ns3:status>{fn:data($details/ns1:status)}</ns3:status>
                    else ()
                }
                {
                    if ($details/ns1:instructionIdentification)
                    then <ns3:instructionIdentification>{fn:data($details/ns1:instructionIdentification)}</ns3:instructionIdentification>
                    else ()
                }
            </ns3:details>
        }
    </ns3:GetReportTransactionResponse>
};

ns2:getTransactionOUT($getReportTransactionResponse)