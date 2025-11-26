xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$anyType1" type="xs:anyType" ::)
(:: pragma  type="xs:anyType" ::)


declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoTransferenciaSwift/xq/updatePaymentStatusHeaderIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/hdrType";


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


declare function xf:updatePaymentStatusHeaderIn($LAUVersion as xs:string,
    $AUTXAPIKey as xs:string,
    $LAUSigned as xs:string,
    $LAUApplicationID as xs:string,
    $LAURequestNonce as xs:string,
    $AUTSignatureRequired as xs:string,
    $serviceUser as xs:string)
    as element(*) {
    
   		<soapenv:Header xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:upd="http://www.ficohsa.com.hn/updatePaymentStatus">
	    	<wsse:Security soapenv:mustUnderstand="1" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">
	         	<wsse:UsernameToken>
	            	<wsse:Username>
	            		{ fn-bea:fail-over( getUsername($serviceUser), $serviceUser) }
	            	</wsse:Username>
	            	<wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">
	            		{ fn-bea:fail-over( getPassword($serviceUser), $serviceUser) }
	            	</wsse:Password>
	            	<wsse:Nonce EncodingType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary">6373phqZtkwq2a9We39UxQ==</wsse:Nonce>
	            	<wsu:Created>2019-06-18T20:48:18.781Z</wsu:Created>
	         	</wsse:UsernameToken>
	      	</wsse:Security>
	        <ns0:RequestHeader>
	            <LauParams>
	                <LauApplicationID>{ $LAUApplicationID }</LauApplicationID>
	                <LauVersion>{ $LAUVersion }</LauVersion>
	                <LauCallTime>{ fn:adjust-dateTime-to-timezone(current-dateTime(), xdt:dayTimeDuration('PT0H')) }</LauCallTime>
	                <LauRequestNonce>{ $LAURequestNonce }</LauRequestNonce>
	                <LauSigned>{ $LAUSigned }</LauSigned>
	            </LauParams>
	            <AutParams>
	                <SignatureRequired>{ $AUTSignatureRequired }</SignatureRequired>
	                <XApiKey>{ $AUTXAPIKey }</XApiKey>
	            </AutParams>
	            <ClientParams>
	                <ForwardedFor/>
	                <ForwardedPort/>
	                <ForwardedProto/>
	            </ClientParams>
	        </ns0:RequestHeader>
	    </soapenv:Header>
};

declare variable $LAUVersion as xs:string external;
declare variable $AUTXAPIKey as xs:string external;
declare variable $LAUSigned as xs:string external;
declare variable $LAUApplicationID as xs:string external;
declare variable $LAURequestNonce as xs:string external;
declare variable $AUTSignatureRequired as xs:string external;
declare variable $serviceUser as xs:string external;


xf:updatePaymentStatusHeaderIn($LAUVersion,
    $AUTXAPIKey,
    $LAUSigned,
    $LAUApplicationID,
    $LAURequestNonce,
    $AUTSignatureRequired,
    $serviceUser)
