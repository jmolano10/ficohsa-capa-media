(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$status1" type="ns0:RegistroACHRecibidaResponse/Status" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ActualizacionestadodetransACH" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/actTxnAchEnvIn/";

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

declare function xf:actTxnAchEnvIn($requestHeader1 as element(ns1:RequestHeader),
    $id as xs:string,
    $status1 as element(),
    $message as xs:string,
    $successIndACH as xs:string)
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
            <FICOHNACHONLINEMODIFICATIONType id = "{ $id }">
                {
                	let $indicator := data($successIndACH)
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
                			elseif ($indicator = "ERROR") then
                			(
                				$message
                			)
                			else
                			(
                				'ERROR'
                			)
                		}
                		</IDREJECTION>
                	
                }
                {
                    for $transactionId in $status1/transactionId
                    return
                        <IDTXNT24>{ data($transactionId) }</IDTXNT24>
                }
                {
                	let $indicator := data($successIndACH)
                	return
                		<STATUS>
                		{
                			if ($indicator = "SUCCESS") then
                			(
                				'SUCCESS'
                			)
                			elseif ($indicator = "PENDING") then
                			(
                				'PENDING'
                			)
                			elseif ($indicator = "ERROR") then
                			(
                				'REJECTED'
                			)
                			else
                			(
                				'ERROR'
                			)
                		}
                		</STATUS>
                	
                }
            </FICOHNACHONLINEMODIFICATIONType>
        </ns0:ActualizacionestadodetransACH>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $id as xs:string external;
declare variable $status1 as element() external;
declare variable $message as xs:string external;
declare variable $successIndACH as xs:string external;

xf:actTxnAchEnvIn($requestHeader1,
    $id,
    $status1,
    $message,
    $successIndACH)