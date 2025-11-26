xquery version "1.0" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/ICB/SaraService/xq/SaraServiceHeaderIN/";
declare namespace soap-env = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace urn = "urn:infocorp.framework.services.common";
declare namespace urn1 = "urn:infocorp.framework.common";
declare namespace h = "urn:infocorp.framework.services.common"; 
declare namespace i = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace wsa = "http://www.w3.org/2005/08/addressing";
declare namespace wsse = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
declare namespace wsu = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

(: Se encarga de retornar el wsa:Action correspondiente a la operación que se desea invocar :)
declare function getAction($operation as xs:string) as xs:string {
	if ($operation = "GetServicePaymentEntitiesWithTagsForSara") then
		"urn:tailored.icbanking.services.sara.SaraService.GetServicePaymentEntitiesWithTagsForSara"
	else if ($operation = "GetServicePaymentEntityForSaraById") then
		"urn:tailored.icbanking.services.sara.SaraService.GetServicePaymentEntityForSaraByIdMessageOut"
	else 
		"Invalid Operation"
};

declare function xf:SaraServiceHeaderIN($serviceAccount as xs:string, $operation as xs:string)
    as element(*) {
        <soap-env:Header>
			<wsse:Security soap-env:mustUnderstand="true">
				<wsse:UsernameToken>
					<wsse:Username>{ 
						fn-bea:fail-over( getUsername($serviceAccount), $serviceAccount) }
					</wsse:Username>
					<wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">
						{ fn-bea:fail-over( getPassword($serviceAccount), $serviceAccount) }
					</wsse:Password>
				</wsse:UsernameToken>
			</wsse:Security>
			<urn:Context>
				<urn:AuditLogParameters>
					<urn1:ActionId>0</urn1:ActionId>
					<urn1:BackOfficeUserName i:nil="true" />
					<urn1:CustomData i:nil="true" />
					<urn1:ExecutionModeId>0</urn1:ExecutionModeId>
					<urn1:PageId i:nil="true" />
					<urn1:StepNumber i:nil="true" />
				</urn:AuditLogParameters>
				<urn:Channel>BankingWeb</urn:Channel>
				<urn:Correlation>0cd171b0-63a0-438a-8ed6-5e39de99fec4</urn:Correlation>
				<urn:ExtendedContext i:nil="true" />
				<urn:ExtendedParameters i:nil="true" />
				<urn:ExtendedProperties i:nil="true" />
				<urn:IpAddress>::1</urn:IpAddress>
				<urn:IsOTASession>0</urn:IsOTASession>
				<urn:LanguageId>0</urn:LanguageId>
				<urn:SessionId></urn:SessionId>
				<urn:SessionTokenId>0</urn:SessionTokenId>
				<urn:SiteId>-1</urn:SiteId>
				<urn:SiteTypeId>0</urn:SiteTypeId>
				<urn:UserAgent>Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36
					(KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36</urn:UserAgent>
				<urn:UserId>-1</urn:UserId>
				<urn:UserName i:nil="true" />
				<urn:UserTimeZoneId>882</urn:UserTimeZoneId>
				<urn:UserTimeZoneName>SA Pacific Standard Time</urn:UserTimeZoneName>
			</urn:Context>
			<wsa:MessageID>urn:uuid:855d9951-d4ba-4f2d-b964-58a88f1ae1fd</wsa:MessageID>
			<wsa:ReplyTo>
				<wsa:Address>http://www.w3.org/2005/08/addressing/anonymous</wsa:Address>
			</wsa:ReplyTo>
			<wsa:To soap-env:mustUnderstand="1">https://hnbnkpqawicbkar.gfficohsa.hn/UPD_01.Tailored.ICBanking.ServiceHost/Sara/SaraService.svc</wsa:To>
			<wsa:Action>{ getAction($operation) }</wsa:Action>
		</soap-env:Header>
};

declare variable $serviceAccount as xs:string external;
declare variable $operation as xs:string external;

xf:SaraServiceHeaderIN($serviceAccount, $operation)