(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDepartamentos" element="ns1:consultaDepartamentos" location="consultaDepartamentosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedepartamentos" location="../Resources/XMLSchema_1123420404.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDepartamentosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/direcciones/ConsultaDepartamentos/consultaDepartamentosIn/";

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

declare function xf:consultaDepartamentosIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaDepartamentos as element(ns1:consultaDepartamentos))
    as element(ns0:Consultadedepartamentos) {
        <ns0:Consultadedepartamentos>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSSTATELISTType>
                <enquiryInputCollection>
                    <columnName>COUNTRY</columnName>
                    <criteriaValue>{ data($consultaDepartamentos/COUNTRY_CODE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	if (exists( $consultaDepartamentos/DEPT_CODE/text() )) then (
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ concat( $consultaDepartamentos/COUNTRY_CODE, ".",  $consultaDepartamentos/DEPT_CODE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
                	) else ()                	
                }                
            </WSSTATELISTType>
        </ns0:Consultadedepartamentos>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaDepartamentos as element(ns1:consultaDepartamentos) external;

xf:consultaDepartamentosIn($autenticacionRequestHeader,
    $consultaDepartamentos)