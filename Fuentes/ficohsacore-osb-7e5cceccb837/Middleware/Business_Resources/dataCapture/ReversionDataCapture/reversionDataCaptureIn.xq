(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversionDataCapture" element="ns1:reversionDataCapture" location="reversionDataCaptureTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Reversiondedatacapture" location="../Resources/XMLSchema_-987790958.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionDataCaptureTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureIn/";

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

declare function xf:reversionDataCaptureIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversionDataCapture as element(ns1:reversionDataCapture))
    as element(ns0:Reversiondedatacapture) {
        <ns0:Reversiondedatacapture>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <DATACAPTUREINPUTWSType>
                <transactionId>{ data($reversionDataCapture/DATA_CAPTURE_ID) }</transactionId>
            </DATACAPTUREINPUTWSType>
        </ns0:Reversiondedatacapture>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversionDataCapture as element(ns1:reversionDataCapture) external;

xf:reversionDataCaptureIn($autenticacionRequestHeader,
    $reversionDataCapture)