xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/achServicesPS";
(:: import schema at "../../../../../../MWBanking/Ach/RequestorServices/v1.0/AchSoapRouter/XSD/achTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com/ach";
(:: import schema at "../../../../../ProviderServices/XSD/achCDM.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/getTicketOUT";

declare variable $getTicketResponse as element() (:: schema-element(ns1:GetTicketResponse) ::) external;

declare function ns2:getTicketOUT($getTicketResponse as element() (:: schema-element(ns1:GetTicketResponse) ::)) as element() (:: schema-element(ns3:GetTicketResponse) ::) {
    <ns3:GetTicketResponse>
        {
            if ($getTicketResponse/ns1:ticket)
            then <ns3:ticket>{fn:data($getTicketResponse/ns1:ticket)}</ns3:ticket>
            else ()
        }
    </ns3:GetTicketResponse>
};

ns2:getTicketOUT($getTicketResponse)