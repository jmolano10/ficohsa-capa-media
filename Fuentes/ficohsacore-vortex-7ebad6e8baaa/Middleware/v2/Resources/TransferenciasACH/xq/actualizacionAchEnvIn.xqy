xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ActualizacionestadodetransACH" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/actualizacionAchEnvIn/";

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

declare function xf:actualizacionAchEnvIn($requestHeader1 as element(ns1:RequestHeader),
    $mensaje as xs:string,
    $successIndACH as xs:string,
    $idRegACHT24 as xs:string)
    as element(ns0:ActualizacionestadodetransACH) {
        <ns0:ActualizacionestadodetransACH>
        	 <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth></noOfAuth>
                <replace/>
            </OfsFunction>
            <FICOHNACHONLINEMODIFICATIONType id = "{ $idRegACHT24 }">
            		{
                	let $indicator := fn:upper-case(data($successIndACH))
                	return
	                		<IDREJECTION>
	                		{
	                			if ($indicator = "SUCCESS") then
	                			(
	                				''
	                			)
	                			elseif ($indicator = "PENDING") then
	                			(
	                				''
	                			)
	                			elseif ($indicator = "FAILED") then
	                			(
	                				$mensaje
	                			)
	                			else
	                			(
	                				$mensaje
	                			)
	                		}
	                		</IDREJECTION>
               		 }
                	  {
                		let $indicator := fn:upper-case(data($successIndACH))
                		return
	                		<STATUS>
	                		{
	                			if ($indicator = "FAILED") then
	                			(
	                				'REJECTED'
	                			)
	                			else 
	                			(
	                				$indicator
	                			)
	                		}
	                		</STATUS>
                	
                		}                            
            </FICOHNACHONLINEMODIFICATIONType>
        </ns0:ActualizacionestadodetransACH>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $mensaje as xs:string external;
declare variable $successIndACH as xs:string external;
declare variable $idRegACHT24 as xs:string external;

xf:actualizacionAchEnvIn($requestHeader1,
    $mensaje,
    $successIndACH,
    $idRegACHT24)