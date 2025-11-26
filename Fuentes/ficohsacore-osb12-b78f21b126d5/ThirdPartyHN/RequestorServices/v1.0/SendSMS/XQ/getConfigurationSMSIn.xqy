xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/messagingTypes";
(:: import schema at "../../../../../MWBanking/Messaging/RequestorServices/XSD/messagingTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_P_OBTENER_INFO_COLYBRI/";
(:: import schema at "../../../../ProviderServices/XSD/GetConfigurationSMS/GetConfigurationSMS_BS.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getConfigurationSMSIn";

declare variable $sendSMSRequest as element() (:: schema-element(ns2:sendSMSRequest) ::) external;

declare function ns1:getConfigurationSMSIn($sendSMSRequest as element() (:: schema-element(ns2:sendSMSRequest) ::)) as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        {
            if ($sendSMSRequest/ns2:MobileNumber)
            then <ns3:PV_MOBILE_NUMBER>{fn:data($sendSMSRequest/ns2:MobileNumber)}</ns3:PV_MOBILE_NUMBER>
            else ()
        }
        {
            if ($sendSMSRequest/ns2:MessageType)
            then <ns3:PV_MESSAGE_TYPE>{fn:data($sendSMSRequest/ns2:MessageType)}</ns3:PV_MESSAGE_TYPE>
            else ()
        }
        {
            if ($sendSMSRequest/ns2:Service)
            then <ns3:PV_SERVICE>{fn:data($sendSMSRequest/ns2:Service)}</ns3:PV_SERVICE>
            else ()
        }
    </ns3:InputParameters>
};

ns1:getConfigurationSMSIn($sendSMSRequest)
