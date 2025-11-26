(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaFicoAlertas" element="ns1:consultaFicoAlertas" location="consultaFicoAlertasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadeFicoAlertas" location="../Resources/XMLSchema_1876963756.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFicoAlertasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/ConsultaFicoAlertas/consultaFicoAlertasIn/";

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

declare function xf:consultaFicoAlertasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaFicoAlertas as element(ns1:consultaFicoAlertas))
    as element(ns0:ConsultadeFicoAlertas) {
        <ns0:ConsultadeFicoAlertas>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSALERTLISTType>            
            {
            	let $ALERT_ID := fn:string($consultaFicoAlertas/ALERT_ID/text())
            	return 
            		if($ALERT_ID != "") then (
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ data($ALERT_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
            }
	            <enquiryInputCollection>
	                <columnName>@ID</columnName>
	                <criteriaValue>FCEL</criteriaValue>
	                <operand>BW</operand>
	            </enquiryInputCollection>             
            </WSALERTLISTType>
        </ns0:ConsultadeFicoAlertas>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaFicoAlertas as element(ns1:consultaFicoAlertas) external;

xf:consultaFicoAlertasIn($autenticacionRequestHeader,
    $consultaFicoAlertas)