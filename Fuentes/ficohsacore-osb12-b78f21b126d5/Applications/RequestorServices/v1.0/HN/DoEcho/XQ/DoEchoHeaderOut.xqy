xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/commonTypes";
(:: import schema at "../../../../../../CommonResources/XSD/CommonTypes.xsd" ::)
declare namespace ns1="http://www.ficohsa.com/ach";
(:: import schema at "../../../../../ProviderServices/XSD/achCDM.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/doEchoHeaderOut";

declare variable $doEchoResponse as element() (:: schema-element(ns1:DoEchoResponse) ::) external;

declare function ns2:doEchoHeaderOut($doEchoResponse as element() (:: schema-element(ns1:DoEchoResponse) ::)) as element() (:: schema-element(ns3:ResponseHeader) ::) {
    <ns3:ResponseHeader>
        {
            if (fn:data($doEchoResponse/ns1:StatusCode) != '')
            then <ns3:SuccessIndicator>Error</ns3:SuccessIndicator>
            else <ns3:SuccessIndicator>Success</ns3:SuccessIndicator>
        }
        {
            if ($doEchoResponse/ns1:Message)
            then <ns3:Messages>{fn:data($doEchoResponse/ns1:Message)}</ns3:Messages>
            else ()
        }
        {
            if($doEchoResponse/ns1:currentTime)
            then <ns3:ValueDate>{fn:data($doEchoResponse/ns1:currentTime)}</ns3:ValueDate>
            else ()
        }
    </ns3:ResponseHeader>
};

ns2:doEchoHeaderOut($doEchoResponse)