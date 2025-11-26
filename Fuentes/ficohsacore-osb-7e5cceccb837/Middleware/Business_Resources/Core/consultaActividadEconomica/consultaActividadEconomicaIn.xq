(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaActividadEconomica1" element="ns0:consultaActividadEconomica" location="consultaActividadEconomicaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadeactividadeconomica" location="../Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaActividadEconomicaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaActividadEconomica/consultaActividadEconomicaIn/";

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

declare function xf:consultaActividadEconomicaIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaActividadEconomica1 as element(ns0:consultaActividadEconomica))
    as element(ns1:Consultadeactividadeconomica) {
        <ns1:Consultadeactividadeconomica>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            {
                let $consultaActividadEconomica := $consultaActividadEconomica1
                return
                    <WSECONACTIVITYLISTType>
                        <enquiryInputCollection>
                            <columnName>@ID</columnName>
                            <criteriaValue>{ data($consultaActividadEconomica/ECONACTIVITY_ID) }</criteriaValue>
                            <operand>EQ</operand>
                        </enquiryInputCollection>
                    </WSECONACTIVITYLISTType>
            }
        </ns1:Consultadeactividadeconomica>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaActividadEconomica1 as element(ns0:consultaActividadEconomica) external;

xf:consultaActividadEconomicaIn($autenticacionRequestHeader1,
    $consultaActividadEconomica1)