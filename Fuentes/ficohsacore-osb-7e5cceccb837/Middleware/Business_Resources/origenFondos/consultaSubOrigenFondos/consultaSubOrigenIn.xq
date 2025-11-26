(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSubOrigenFondos1" element="ns0:consultaSubOrigenFondos" location="consultaSubOrigenFondosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultasuborigendefondos" location="../resources/XMLSchema_-253522267.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSubOrigenFondosTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/origenFondos/consultaSubOrigenFondos/consultaSubOrigenIn/";

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

declare function xf:consultaSubOrigenIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaSubOrigenFondos1 as element(ns0:consultaSubOrigenFondos))
    as element(ns1:Consultasuborigendefondos) {
        <ns1:Consultasuborigendefondos>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSFUNDSSUBORIGINLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaSubOrigenFondos1/FUNDS_ORIGIN_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFUNDSSUBORIGINLISTType>
        </ns1:Consultasuborigendefondos>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaSubOrigenFondos1 as element(ns0:consultaSubOrigenFondos) external;

xf:consultaSubOrigenIn($autenticacionRequestHeader1,
    $consultaSubOrigenFondos1)