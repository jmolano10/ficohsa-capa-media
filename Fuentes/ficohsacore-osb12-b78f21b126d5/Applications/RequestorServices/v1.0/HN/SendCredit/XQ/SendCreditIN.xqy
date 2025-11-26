xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/achServicesPS";
(:: import schema at "../../../../../../MWBanking/Ach/RequestorServices/v1.0/AchSoapRouter/XSD/achTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com/ach";
(:: import schema at "../../../../../ProviderServices/XSD/achCDM.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/sendCreditIN";

declare variable $sendCreditRequest as element() (:: schema-element(ns2:SendCreditRequest) ::) external;
declare variable $userName as xs:string external;

declare function ns1:sendCreditIN($userName as xs:string, $sendCreditRequest as element() (:: schema-element(ns2:SendCreditRequest) ::)) as element() (:: schema-element(ns3:SendCredit) ::) {
    <ns3:SendCredit>
        {
            if ($sendCreditRequest/ns2:ticket)
            then <ns3:achTicket>{fn:data($sendCreditRequest/ns2:ticket)}</ns3:achTicket>
            else ()
        }
        {
            if ($sendCreditRequest/ns2:messagetype)
            then <ns3:messagetype>{fn:data($sendCreditRequest/ns2:messagetype)}</ns3:messagetype>
            else ()
        }
        <ns3:userName>{fn:data($userName)}</ns3:userName>
        {
            for $MessageRequestDetails in $sendCreditRequest/ns2:MessageRequestDetails
            return 
            <ns3:fiMessageRequestDetails>
                {
                    if ($MessageRequestDetails/ns2:receivingBankId)
                    then <ns3:receivingBankId>{fn:data($MessageRequestDetails/ns2:receivingBankId)}</ns3:receivingBankId>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:originatorId)
                    then <ns3:originatorId>{fn:data($MessageRequestDetails/ns2:originatorId)}</ns3:originatorId>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:originatorAccount)
                    then <ns3:originatorAccount>{fn:data($MessageRequestDetails/ns2:originatorAccount)}</ns3:originatorAccount>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:accountType)
                    then <ns3:accountType>{fn:data($MessageRequestDetails/ns2:accountType)}</ns3:accountType>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:originatorName)
                    then <ns3:originatorName>{fn:data($MessageRequestDetails/ns2:originatorName)}</ns3:originatorName>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:receivingId)
                    then <ns3:receivingId>{fn:data($MessageRequestDetails/ns2:receivingId)}</ns3:receivingId>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:destinationAccount)
                    then <ns3:destinationAccount>{fn:data($MessageRequestDetails/ns2:destinationAccount)}</ns3:destinationAccount>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:destinationAccountType)
                    then <ns3:destinationAccountType>{fn:data($MessageRequestDetails/ns2:destinationAccountType)}</ns3:destinationAccountType>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:recipientName)
                    then <ns3:recipientName>{fn:data($MessageRequestDetails/ns2:recipientName)}</ns3:recipientName>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:description)
                    then <ns3:description>{fn:data($MessageRequestDetails/ns2:description)}</ns3:description>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:instructionIdentification)
                    then <ns3:instructionIdentification>{fn:data($MessageRequestDetails/ns2:instructionIdentification)}</ns3:instructionIdentification>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:currencyISO)
                    then <ns3:currencyISO>{fn:data($MessageRequestDetails/ns2:currencyISO)}</ns3:currencyISO>
                    else ()
                }
                {
                    if ($MessageRequestDetails/ns2:amount)
                    then <ns3:amount>{fn:data($MessageRequestDetails/ns2:amount)}</ns3:amount>
                    else ()
                }
                 {
                    if ($MessageRequestDetails/ns2:IdQR)
                    then <ns3:IdQr>{fn:data($MessageRequestDetails/ns2:IdQR)}</ns3:IdQr>
                    else ()
                }</ns3:fiMessageRequestDetails>
        }
    </ns3:SendCredit>
};

ns1:sendCreditIN($userName, $sendCreditRequest)