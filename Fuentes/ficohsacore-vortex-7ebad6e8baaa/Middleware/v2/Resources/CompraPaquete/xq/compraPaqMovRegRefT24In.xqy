xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RegistraReferenciaPaqueteMovil" location="../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaquete/xq/compraPaqMovRegRefT24In/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };


declare function xf:compraPaqMovRegRefT24In($requestHeader as element(ns1:RequestHeader),
$PhoneOperatorRef as xs:string,
    $T24Ref as xs:string)
    as element(ns0:RegistraReferenciaPaqueteMovil) {
        <ns0:RegistraReferenciaPaqueteMovil>
        	<WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentitacion/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
			</password>
            </WebRequestCommon>
             <OfsFunction>
            	<gtsControl></gtsControl>
	            <messageId></messageId>
                <noOfAuth></noOfAuth>
                <replace></replace>
    	     </OfsFunction>
            <FICOMOBILEPACKREPGETIDType id = "{ $T24Ref }">
                <IDTXNTERCERO>{ $PhoneOperatorRef }</IDTXNTERCERO>
            </FICOMOBILEPACKREPGETIDType>
        </ns0:RegistraReferenciaPaqueteMovil>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $PhoneOperatorRef as xs:string external;
declare variable $T24Ref as xs:string external;

xf:compraPaqMovRegRefT24In($requestHeader,
$PhoneOperatorRef,
    $T24Ref)