(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSaldoCuentaPorCancelar" element="ns1:consultaSaldoCuentaPorCancelar" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaSaldoCuentaporCancelar_Validate" location="../Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoCuentaPorCancelar/consultaSaldoCuentaPorCancelar/";

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

declare function xf:consultaSaldoCuentaPorCancelar($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaSaldoCuentaPorCancelar as element(ns1:consultaSaldoCuentaPorCancelar))
    as element(ns0:ConsultaSaldoCuentaporCancelar_Validate) {
        <ns0:ConsultaSaldoCuentaporCancelar_Validate>
            <WebRequestCommon>
                 <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
            	<gtsControl></gtsControl>
	            <messageId></messageId>
	            <noOfAuth></noOfAuth>
	            <replace></replace>
         	</OfsFunction>
            <ACCOUNTCLOSURETELLERACCLOSUREWSType id = "{ data($consultaSaldoCuentaPorCancelar/ACCOUNT) }"/>
        </ns0:ConsultaSaldoCuentaporCancelar_Validate>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaSaldoCuentaPorCancelar as element(ns1:consultaSaldoCuentaPorCancelar) external;

xf:consultaSaldoCuentaPorCancelar($autenticacionRequestHeader,
    $consultaSaldoCuentaPorCancelar)