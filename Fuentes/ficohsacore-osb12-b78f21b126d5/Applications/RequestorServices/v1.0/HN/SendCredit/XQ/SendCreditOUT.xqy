xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/achServicesPS";
(:: import schema at "../../../../../../MWBanking/Ach/RequestorServices/v1.0/AchSoapRouter/XSD/achTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com/ach";
(:: import schema at "../../../../../ProviderServices/XSD/achCDM.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/sendCreditOUT";

declare variable $sendCreditResponse as element() (:: schema-element(ns2:SendCreditResponse) ::) external;

declare function ns1:sendCreditOUT($sendCreditResponse as element() (:: schema-element(ns2:SendCreditResponse) ::)) as element() (:: schema-element(ns3:SendCreditResponse) ::) {
    <ns3:SendCreditResponse>
        {
            if ($sendCreditResponse/ns2:achTicket)
            then <ns3:ticket>{fn:data($sendCreditResponse/ns2:achTicket)}</ns3:ticket>
            else ()
        }
        {
            if ($sendCreditResponse/ns2:processed)
            then <ns3:processed>{fn:data($sendCreditResponse/ns2:processed)}</ns3:processed>
            else ()
        }
        {
            if ($sendCreditResponse/ns2:messageType)
            then <ns3:messageType>{fn:data($sendCreditResponse/ns2:messageType)}</ns3:messageType>
            else ()
        }
        {
            for $fiMessageResponseDetails in $sendCreditResponse/ns2:fiMessageResponseDetails
            return 
            <ns3:messageResponseDetails>
                {
                    if ($fiMessageResponseDetails/ns2:receivingBankId)
                    then <ns3:receivingBankId>{fn:data($fiMessageResponseDetails/ns2:receivingBankId)}</ns3:receivingBankId>
                    else ()
                }
                {
                    if ($fiMessageResponseDetails/ns2:detailId)
                    then <ns3:detailId>{fn:data($fiMessageResponseDetails/ns2:detailId)}</ns3:detailId>
                    else ()
                }
                {
                    if ($fiMessageResponseDetails/ns2:amount)
                    then <ns3:amount>{fn:data($fiMessageResponseDetails/ns2:amount)}</ns3:amount>
                    else ()
                }
                {
                    if ($fiMessageResponseDetails/ns2:status)
                    then <ns3:status>{fn:data($fiMessageResponseDetails/ns2:status)}</ns3:status>
                    else ()
                }
                {
                    if ($fiMessageResponseDetails/ns2:originatingAccount)
                    then <ns3:originatingAccount>{fn:data($fiMessageResponseDetails/ns2:originatingAccount)}</ns3:originatingAccount>
                    else ()
                }
                {
                    if ($fiMessageResponseDetails/ns2:receivingAccount)
                    then <ns3:receivingAccount>{fn:data($fiMessageResponseDetails/ns2:receivingAccount)}</ns3:receivingAccount>
                    else ()
                }
                {
                    if ($fiMessageResponseDetails/ns2:receivingAccountName)
                    then <ns3:receivingAccountName>{fn:data($fiMessageResponseDetails/ns2:receivingAccountName)}</ns3:receivingAccountName>
                    else ()
                }
                {
                    if ($fiMessageResponseDetails/ns2:results)
                    then <ns3:results>{fn:data($fiMessageResponseDetails/ns2:results)}</ns3:results>
                    else ()
                }
                {
                    if ($fiMessageResponseDetails/ns2:reasonCode)
                    then <ns3:reasonCode>{fn:data($fiMessageResponseDetails/ns2:reasonCode)}</ns3:reasonCode>
                    else ()
                }
                {
                    if ($fiMessageResponseDetails/ns2:instructionIdentification)
                    then <ns3:instructionIdentification>{fn:data($fiMessageResponseDetails/ns2:instructionIdentification)}</ns3:instructionIdentification>
                    else ()
                }</ns3:messageResponseDetails>
        }
    </ns3:SendCreditResponse>
};

ns1:sendCreditOUT($sendCreditResponse)