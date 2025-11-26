(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaProfesiones" element="ns0:consultaProfesiones" location="consultaProfesionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadeprofesiones" location="../Resources/XMLSchema_123738754.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProfesionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaProfesion/ConsultaProfesiones/consultaProfesionesIn/";

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

declare function xf:consultaProfesionesIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaProfesiones as element(ns0:consultaProfesiones))
    as element(ns1:Consultadeprofesiones) {
        <ns1:Consultadeprofesiones>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>        
            <WSPROFESSIONLISTType>
                {
                    let $PROFESSION_ID := $consultaProfesiones/PROFESSION_ID/text()
                    return
                        if (exists($PROFESSION_ID)) then (
                        	<enquiryInputCollection>
                            	<columnName>@ID</columnName>
                            	<criteriaValue>{ data($PROFESSION_ID) }</criteriaValue>
                            	<operand>EQ</operand>
                        	</enquiryInputCollection>
                        ) else ()
                }
            </WSPROFESSIONLISTType>
        </ns1:Consultadeprofesiones>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaProfesiones as element(ns0:consultaProfesiones) external;

xf:consultaProfesionesIn($autenticacionRequestHeader,
    $consultaProfesiones)