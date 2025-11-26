(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaFinancierasACH" element="ns1:consultaFinancierasACH" location="consultaFinancierasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadedestinosACH" location="../Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHIn/";

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

declare function xf:consultaFinancierasACHIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaFinancierasACH as element(ns1:consultaFinancierasACH))
    as element(ns0:ConsultadedestinosACH) {
        <ns0:ConsultadedestinosACH>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <WSACHBANKLISTType>
            {
            	if($consultaFinancierasACH/DESTINATION_CODE/text()) then (
	                <enquiryInputCollection>
	                    <columnName>@ID</columnName>
	                    <criteriaValue>{ data($consultaFinancierasACH/DESTINATION_CODE) }</criteriaValue>
	                    <operand>EQ</operand>
	                </enquiryInputCollection>
                )
                else ()
            }
            </WSACHBANKLISTType>
        </ns0:ConsultadedestinosACH>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaFinancierasACH as element(ns1:consultaFinancierasACH) external;

xf:consultaFinancierasACHIn($autenticacionRequestHeader,
    $consultaFinancierasACH)