(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$aplicaDebitoCheque" element="ns0:aplicaDebitoCheque" location="aplicaDebitoChequeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AplicaDebitosdeCheques" location="../resources/XMLSchema_1569843523.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aplicaDebitoChequeTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/compensacion/aplicaDebitoCheque/aplicaDebitoChequeIn/";

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

declare function xf:aplicaDebitoChequeIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $aplicaDebitoCheque as element(ns0:aplicaDebitoCheque))
    as element(ns1:AplicaDebitosdeCheques) {
        <ns1:AplicaDebitosdeCheques>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TSASERVICESACEType>
                <SERVICECONTROL>{ data($aplicaDebitoCheque/SERVICE_INSTRUCTION) }</SERVICECONTROL>
            </TSASERVICESACEType>
        </ns1:AplicaDebitosdeCheques>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $aplicaDebitoCheque as element(ns0:aplicaDebitoCheque) external;

xf:aplicaDebitoChequeIn($autenticacionRequestHeader,
    $aplicaDebitoCheque)