xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$envioNotificacionPushIN" element="ns0:envioNotificacionPush" location="../xsd/envioNotificacionPushTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:SendPushNotificationCustomMessageIn" location="../../../BusinessServices/ICB/EnvioNotificacionPush/wsdl/ExternalNotificationsService_1.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioNotificacionPush/xq/envioNotificacionPushIN2/";
declare namespace ns2 = "urn:infocorp.framework.services.common";
declare namespace ns1 = "urn:tailored.icbanking.services.externalnotifications";
declare namespace ns4 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns3 = "urn:infocorp.framework.businessentities.security";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/envioNotificacionPushTypes";
declare namespace ns5 = "urn:infocorp.framework.businessentities.common";



(: Función encargada retornar el valor entero equivalente al codigo de subsidiaria que utiliza el servicio ICB :)
declare function getSubsidiaryId ($source_Bank as xs:string)  as xs:string {      
                		let $SubsidiaryId := $source_Bank
                		return
                		if ($SubsidiaryId = "HN01") then (
                			"1"
                		)
                		else if ($SubsidiaryId = "GT01")  then (
                			"2"
                		)
                		else if ($SubsidiaryId = "PA01")  then (
                			"3"
                		)else if ($SubsidiaryId = "NI01")  then (
                			"4"
                		)
                		else (
                			"NO DEFINED"
                		)  

 };
 
declare function xf:envioNotificacionPushIN2($envioNotificacionPushIN as element(ns0:envioNotificacionPush),
    $SubsidiaryId as xs:string,
    $document_Type as xs:string)
    as element(ns1:SendPushNotificationCustomMessageIn) {
       <ns1:SendPushNotificationCustomMessageIn>  
            			{
                if (fn:string($envioNotificacionPushIN/FILTER_TYPE/text()) = ("CUSTOMER_ID")) then (
					   <ns1:ClientIdentifier>{ data($envioNotificacionPushIN/FILTER_VALUE) }</ns1:ClientIdentifier>,
                                           <ns1:MessageBody>{ data($envioNotificacionPushIN/MESSAGE_BODY) }</ns1:MessageBody>,
					   <ns1:MessageTitle>{ data($envioNotificacionPushIN/MESSAGE_TITLE) }</ns1:MessageTitle>,
					   <ns1:SubsidiaryId>{getSubsidiaryId($SubsidiaryId)}</ns1:SubsidiaryId>,	
					   <ns1:PrivateMessageTitle>{ data($envioNotificacionPushIN/PRIVATE_MESSAGE_TITLE) }</ns1:PrivateMessageTitle>,
					   <ns1:PrivateMessageBody>{ data($envioNotificacionPushIN/PRIVATE_MESSAGE_BODY) }</ns1:PrivateMessageBody>
                ) else if (fn:string($envioNotificacionPushIN/FILTER_TYPE/text()) = ("USER_ID")) then (
					   <ns1:UserId>{ data($envioNotificacionPushIN/FILTER_VALUE) }</ns1:UserId>,
                                            <ns1:MessageBody>{ data($envioNotificacionPushIN/MESSAGE_BODY) }</ns1:MessageBody>,
					   <ns1:MessageTitle>{ data($envioNotificacionPushIN/MESSAGE_TITLE) }</ns1:MessageTitle>,
					   <ns1:SubsidiaryId>{getSubsidiaryId($SubsidiaryId)}</ns1:SubsidiaryId>,	
					   <ns1:PrivateMessageTitle>{ data($envioNotificacionPushIN/PRIVATE_MESSAGE_TITLE) }</ns1:PrivateMessageTitle>,
					   <ns1:PrivateMessageBody>{ data($envioNotificacionPushIN/PRIVATE_MESSAGE_BODY) }</ns1:PrivateMessageBody>
                ) else (
 					   <ns1:DocumentNumber>{ data($envioNotificacionPushIN/FILTER_VALUE) }</ns1:DocumentNumber>,
 					   <ns1:DocumentType>{ data($document_Type) }</ns1:DocumentType>,
					   <ns1:MessageBody>{ data($envioNotificacionPushIN/MESSAGE_BODY) }</ns1:MessageBody>,
					   <ns1:MessageTitle>{ data($envioNotificacionPushIN/MESSAGE_TITLE) }</ns1:MessageTitle>,
					   <ns1:SubsidiaryId>{getSubsidiaryId($SubsidiaryId)}</ns1:SubsidiaryId>,	
					   <ns1:PrivateMessageTitle>{ data($envioNotificacionPushIN/PRIVATE_MESSAGE_TITLE) }</ns1:PrivateMessageTitle>,
					   <ns1:PrivateMessageBody>{ data($envioNotificacionPushIN/PRIVATE_MESSAGE_BODY) }</ns1:PrivateMessageBody>
                )
             }          
 			 </ns1:SendPushNotificationCustomMessageIn>
};

declare variable $envioNotificacionPushIN as element(ns0:envioNotificacionPush) external;
declare variable $SubsidiaryId as xs:string external;
declare variable $document_Type as xs:string external;

xf:envioNotificacionPushIN2($envioNotificacionPushIN,
    $SubsidiaryId,
    $document_Type)