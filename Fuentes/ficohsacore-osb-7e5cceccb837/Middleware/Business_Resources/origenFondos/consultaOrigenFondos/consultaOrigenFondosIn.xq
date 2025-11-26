(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaOrigenFondos1" element="ns2:consultaOrigenFondos" location="consultaOrigenFondosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeorigendefondos" location="../resources/XMLSchema_-253522267.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaOrigenFondosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/origenFondos/consultaOrigenFondos/consultaOrigenFondosIn/";

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

declare function xf:consultaOrigenFondosIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $consultaOrigenFondos1 as element(ns2:consultaOrigenFondos))
    as element(ns0:Consultadeorigendefondos) {
        <ns0:Consultadeorigendefondos>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSFUNDSORIGINLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaOrigenFondos1/FUNDS_ORIGIN_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFUNDSORIGINLISTType>
        </ns0:Consultadeorigendefondos>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $consultaOrigenFondos1 as element(ns2:consultaOrigenFondos) external;

xf:consultaOrigenFondosIn($autenticacionRequestHeader1,
    $consultaOrigenFondos1)