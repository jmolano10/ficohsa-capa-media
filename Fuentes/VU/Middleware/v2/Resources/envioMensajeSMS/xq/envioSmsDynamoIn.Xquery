<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/autType";
(:: import schema at "../../Esquemas_Generales/HeaderElements.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/envioMensajeSMSTypes";
(:: import schema at "../xsd/envioMensajeSMSTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/messagingTypes";
(:: import schema at "../../../../Business_Resources/envioMensajeSMS/messagingTypes.xsd" ::)
declare namespace ns4="http://www.ficohsa.com.hn/middleware.services/commonTypes";
(:: import schema at "../../../../Business_Resources/envioMensajeSMS/CommonResources/XSD/CommonTypes.xsd" ::)

declare variable $ResourceInput as element() (:: schema-element(ns1:envioMensajeSMS) ::) external;
declare variable $ResourceInputElement as element() (:: schema-element(ns2:RequestHeader) ::) external;

declare function local:func($ResourceInput as element() (:: schema-element(ns1:envioMensajeSMS) ::), 
                            $ResourceInputElement as element() (:: schema-element(ns2:RequestHeader) ::)) 
                            as element() (:: schema-element(ns3:sendSMSRequest) ::) {
    <ns3:sendSMSRequest>
        <ns3:GeneralInfo>
              <ns4:SourceBank>{fn:data($ResourceInputElement/Region/SourceBank)}</ns4:SourceBank>
              <ns4:DestinationBank>{fn:data(fn:string($ResourceInputElement/Region/DestinationBank))}</ns4:DestinationBank>
              <ns4:GlobalId></ns4:GlobalId>
              <ns4:ApplicationId></ns4:ApplicationId>
              <ns4:ApplicationUser></ns4:ApplicationUser>
              <ns4:BranchId></ns4:BranchId>
              <ns4:TransactionDate></ns4:TransactionDate>
              <ns4:Language>es</ns4:Language>
        </ns3:GeneralInfo> 
          <ns3:MobileNumber>{fn:data(xs:decimal($ResourceInput/MOBILE_NUMBER))}</ns3:MobileNumber>
          <ns3:Message>{fn:data($ResourceInput/MESSAGE)}</ns3:Message>
          <ns3:MessageType>ALERT</ns3:MessageType>
          <ns3:Service>ALERTA</ns3:Service>
          <ns3:MessageSource>
            <ns3:Company>FICOHSA</ns3:Company>
            <ns3:DeptCode>RSA</ns3:DeptCode>
          </ns3:MessageSource>
   </ns3:sendSMSRequest>
};

local:func($ResourceInput, $ResourceInputElement)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../Esquemas_Generales/HeaderElements.xsd">
            <con:schema ref="Middleware/v2/Resources/Esquemas_Generales/HeaderElements"/>
        </con:importSchema>
        <con:importSchema location="../xsd/envioMensajeSMSTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/envioMensajeSMS/xsd/envioMensajeSMSTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../../Business_Resources/envioMensajeSMS/messagingTypes.xsd">
            <con:schema ref="Middleware/Business_Resources/envioMensajeSMS/messagingTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../../Business_Resources/envioMensajeSMS/CommonResources/XSD/CommonTypes.xsd">
            <con:schema ref="Middleware/Business_Resources/envioMensajeSMS/CommonResources/XSD/CommonTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>