xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/MobilePackages/XMLSchema_-578407725.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $uuid as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $PhoneOperatorRef as xs:string external;
declare variable $T24Ref as xs:string external;

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function local:func($uuid as xs:string,
                            $username as xs:string, 
                            $password as xs:string, 
                            $PhoneOperatorRef as xs:string, 
                            $T24Ref as xs:string) 
                            as element() (:: schema-element(ns1:RegistraReferenciaPaqueteMovil) ::) {
    <ns1:RegistraReferenciaPaqueteMovil>
          <WebRequestCommon>
                <userName>{ fn-bea:fail-over( local:getUsername(data($username)),data($username)) }</userName>
                <password>{ fn-bea:fail-over( local:getPassword(data($username)),data($password))}</password>
          </WebRequestCommon>
          <OfsFunction>
            	<gtsControl></gtsControl>
                <messageId>{ $uuid }</messageId>
                <noOfAuth></noOfAuth>
                <replace></replace>
    	     </OfsFunction>
            <FICOMOBILEPACKREPGETIDType id = "{ $T24Ref }">
                <IDTXNTERCERO>{ $PhoneOperatorRef }</IDTXNTERCERO>
            </FICOMOBILEPACKREPGETIDType>
    </ns1:RegistraReferenciaPaqueteMovil>
};

local:func($uuid, $username, $password, $PhoneOperatorRef, $T24Ref)