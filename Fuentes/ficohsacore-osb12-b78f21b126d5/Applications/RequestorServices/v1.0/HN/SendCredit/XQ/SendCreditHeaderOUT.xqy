xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/commonTypes";
(:: import schema at "../../../../../../CommonResources/XSD/CommonTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com/ach";
(:: import schema at "../../../../../ProviderServices/XSD/achCDM.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/sendCreditHeaderOUT";

declare variable $sendCreditResponse as element() (:: schema-element(ns2:SendCreditResponse) ::) external;

declare function ns1:sendCreditHeaderOUT($sendCreditResponse as element() (:: schema-element(ns2:SendCreditResponse) ::)) as element() (:: schema-element(ns3:ResponseHeader) ::) {
    <ns3:ResponseHeader>
        {
            if (fn:data($sendCreditResponse/ns2:StatusCode) != '')
            then <ns3:SuccessIndicator>Error</ns3:SuccessIndicator>
            else <ns3:SuccessIndicator>Success</ns3:SuccessIndicator>
        }
        {
            if ($sendCreditResponse/ns2:Message)
            then <ns3:Messages>{fn:data($sendCreditResponse/ns2:Message)}</ns3:Messages>
            else ()
        }
    </ns3:ResponseHeader>
};

ns1:sendCreditHeaderOUT($sendCreditResponse)