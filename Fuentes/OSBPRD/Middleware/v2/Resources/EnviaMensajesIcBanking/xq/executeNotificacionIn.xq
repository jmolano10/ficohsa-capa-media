(:: pragma bea:global-element-parameter parameter="$enviaMensajesIcBanking" element="ns3:enviaMensajesIcBanking" location="../xsd/enviaMensajesIcBankingTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ExecuteNotificationMessageIn" location="../../../BusinessServices/ICB/notificationService/wsdl/ficohsaNotificationsService.svc.wsdl" ::)

declare namespace ns0 = "urn:tailored.icbanking.services.notifications";
declare namespace ns2 = "urn:infocorp.framework.services.common";
declare namespace ns1 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnviaMensajesIcBanking/xq/executeNotificacionIn/";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/enviaMensajesIcBankingTypes";

declare function xf:executeNotificacionIn($enviaMensajesIcBanking as element(ns3:enviaMensajesIcBanking))
    as element(ns0:ExecuteNotificationMessageIn) {
        <ns0:ExecuteNotificationMessageIn>
            <ns0:Body>{ data($enviaMensajesIcBanking/BODY) }</ns0:Body>
            <ns0:Channel>{ data($enviaMensajesIcBanking/CHANNEL) }</ns0:Channel>
            <ns0:IsImportant>{ 'true' }</ns0:IsImportant>
            <ns0:Title>{ data($enviaMensajesIcBanking/TITLE) }</ns0:Title>
            <ns0:User>{ data($enviaMensajesIcBanking/IB_USER) }</ns0:User>
        </ns0:ExecuteNotificationMessageIn>
};

declare variable $enviaMensajesIcBanking as element(ns3:enviaMensajesIcBanking) external;

xf:executeNotificacionIn($enviaMensajesIcBanking)