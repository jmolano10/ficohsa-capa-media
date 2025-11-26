(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMonedas" element="ns1:consultaMonedas" location="consultaMonedasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetasadecambiolcy" location="../Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMonedasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaMonedas/consultaMonedasIn/";

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

declare function xf:consultaMonedasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaMonedas as element(ns1:consultaMonedas))
    as element(ns0:Consultadetasadecambiolcy) {
        <ns0:Consultadetasadecambiolcy>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSLCYEXCHRATEType>
            {
            	if ( exists($consultaMonedas/CURRENCY_ID/text()) ) then (
	                <enquiryInputCollection>
	                    <columnName>CURRENCY.CODE</columnName>
	                    <criteriaValue>{ data($consultaMonedas/CURRENCY_ID) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
                ) else ()
            }
            </WSLCYEXCHRATEType>
        </ns0:Consultadetasadecambiolcy>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaMonedas as element(ns1:consultaMonedas) external;

xf:consultaMonedasIn($autenticacionRequestHeader,
    $consultaMonedas)