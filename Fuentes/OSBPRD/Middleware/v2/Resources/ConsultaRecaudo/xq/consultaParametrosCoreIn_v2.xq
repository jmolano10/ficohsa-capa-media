(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo1" element="ns1:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeparametroscore" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaParametrosCoreIn_v2/";

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


declare function xf:consultaParametrosCoreIn_v2($requestHeader1 as element(ns2:RequestHeader),
    $consultaRecaudo1 as element(ns1:consultaRecaudo))
    as element(ns0:Consultadeparametroscore) {
        <ns0:Consultadeparametroscore>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSCOREPARAMETERSType>
                <enquiryInputCollection>
                	<columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaRecaudo1/CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCOREPARAMETERSType>
        </ns0:Consultadeparametroscore>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaRecaudo1 as element(ns1:consultaRecaudo) external;

xf:consultaParametrosCoreIn_v2($requestHeader1,
    $consultaRecaudo1)