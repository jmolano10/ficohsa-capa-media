(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaVentanilla" element="ns1:consultaVentanilla" location="consultaVentanillaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeventanilla" location="../Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaVentanillaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaVentanilla/consultaVentanillaIn/";

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

declare function xf:consultaVentanillaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaVentanilla as element(ns1:consultaVentanilla))
    as element(ns0:Consultadeventanilla) {
        <ns0:Consultadeventanilla>
			<WebRequestCommon>
				<userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSTELLERIDENQType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ concat("""",fn-bea:pad-left($consultaVentanilla/TILL_ID, 4, "0"), """") }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSTELLERIDENQType>
        </ns0:Consultadeventanilla>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaVentanilla as element(ns1:consultaVentanilla) external;

xf:consultaVentanillaIn($autenticacionRequestHeader,
    $consultaVentanilla)