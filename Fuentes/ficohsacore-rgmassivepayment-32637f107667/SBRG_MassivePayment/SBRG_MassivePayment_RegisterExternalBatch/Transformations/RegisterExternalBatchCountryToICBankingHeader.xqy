xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/user";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/UserLoginT24.xsd" ::)

declare variable $connInfoElement as element() (:: schema-element(ns1:connInfoElement) ::) external;

declare function local:func($connInfoElement as element() (:: schema-element(ns1:connInfoElement) ::)) as element(*) {
    <soap:Header xmlns:h="urn:infocorp.framework.services.common" xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns:wsa="http://www.w3.org/2005/08/addressing" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:infocorp.framework.services.common" xmlns:urn1="urn:infocorp.framework.common" xmlns:arr="http://schemas.microsoft.com/2003/10/Serialization/Arrays" xmlns:urn2="urn:tailored.icbanking.services.administration.users" xmlns:urn3="urn:infocorp.framework.businessentities.approvalscheme" xmlns:urn4="urn:infocorp.framework.businessentities.common" xmlns:urn5="urn:infocorp.framework.businessentities.security">
        <wsse:Security soap:mustUnderstand="true" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
            <wsse:UsernameToken>
                <wsse:Username>
                    { fn:data($connInfoElement/ns1:username) }
                </wsse:Username>
                <wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">
                    { fn:data($connInfoElement/ns1:password) }
                </wsse:Password>
            </wsse:UsernameToken>
        </wsse:Security>
        <urn:Context>
            <urn:AuditLogParameters>
                <urn1:ActionId>0</urn1:ActionId>
                <urn1:BackOfficeUserName i:nil="true"/>
                <urn1:CustomData i:nil="true"/>
                <urn1:ExecutionModeId>0</urn1:ExecutionModeId>
                <urn1:PageId i:nil="true"/>
                <urn1:StepNumber i:nil="true"/>
            </urn:AuditLogParameters>
            <urn:Channel>BankingWeb</urn:Channel>
            <urn:Correlation>0cd171b0-63a0-438a-8ed6-5e39de99fec4</urn:Correlation>
            <urn:ExtendedContext i:nil="true"/>
            <urn:ExtendedParameters/>
            <urn:ExtendedProperties/>
            <urn:IpAddress>::1</urn:IpAddress>
            <urn:IsOTASession>0</urn:IsOTASession>
            <urn:LanguageId>0</urn:LanguageId>
            <urn:SessionId/>
            <urn:SessionTokenId>0</urn:SessionTokenId>
            <urn:SiteId>-1</urn:SiteId>
            <urn:SiteTypeId>0</urn:SiteTypeId>
            <urn:UserAgent>Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36</urn:UserAgent>
            <urn:UserId>-1</urn:UserId>
            <urn:UserName i:nil="true"/>
            <urn:UserTimeZoneId>882</urn:UserTimeZoneId>
            <urn:UserTimeZoneName>SA Pacific Standard Time</urn:UserTimeZoneName>
        </urn:Context>
        <wsa:MessageID>urn:uuid:855d9951-d4ba-4f2d-b964-58a88f1ae1fd</wsa:MessageID>
        <wsa:ReplyTo>
            <wsa:Address>http://www.w3.org/2005/08/addressing/anonymous</wsa:Address>
        </wsa:ReplyTo>
        <wsa:To soap:mustUnderstand="1">https://hnbnkpqawicbkar.gfficohsa.hn/wp6.7.11.11.0.ServiceHost/Bulk/CustomBulkService.svc</wsa:To>
        <wsa:Action>urn:tailored.icbanking.services.bulk.CustomBulkService.ProcesarLotes</wsa:Action>
    </soap:Header>
};

local:func($connInfoElement)
