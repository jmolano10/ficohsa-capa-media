(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMunicipios" element="ns1:consultaMunicipios" location="consultaMunicipiosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultademunicipios" location="../Resources/XMLSchema_1123420404.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMunicipiosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/direcciones/ConsultaMunicipios/consultaMunicipiosIn/";

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

declare function xf:consultaMunicipiosIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaMunicipios as element(ns1:consultaMunicipios))
    as element(ns0:Consultademunicipios) {
        <ns0:Consultademunicipios>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSCITYLISTType>
                <enquiryInputCollection>
                    <columnName>COUNTRY</columnName>
                    <criteriaValue>{ data($consultaMunicipios/COUNTRY_CODE) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	if (exists($consultaMunicipios/DEPT_CODE/text())) then (
		                <enquiryInputCollection>
		                    <columnName>STATE</columnName>
		                    <criteriaValue>{ concat( $consultaMunicipios/COUNTRY_CODE, ".", $consultaMunicipios/DEPT_CODE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		        	) else ()
                }        
                {
                	if (exists($consultaMunicipios/CITY_CODE/text())) then (
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ concat( $consultaMunicipios/COUNTRY_CODE, ".", $consultaMunicipios/DEPT_CODE, ".", $consultaMunicipios/CITY_CODE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>                	
                	) else ()
                }                
            </WSCITYLISTType>
        </ns0:Consultademunicipios>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaMunicipios as element(ns1:consultaMunicipios) external;

xf:consultaMunicipiosIn($autenticacionRequestHeader,
    $consultaMunicipios)