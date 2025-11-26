(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaTargetCliente" location="../xsd/svcGetTargetFromAccount_TypeArray.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultarTargetCliente/xlst/ConsultaCuentaT24Request/";

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

declare function xf:ConsultaCuentaT24Request($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $aCCOUNT_NUMBER1 as xs:string,
    $columnName as xs:string)
    as element(ns0:ConsultaTargetCliente) {
        <ns0:ConsultaTargetCliente>
            <WebRequestCommon>
               <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSFICOTARGETCUSDETAILType>
                <enquiryInputCollection>
                    <columnName>{ $columnName }</columnName>
                    <criteriaValue>{ $aCCOUNT_NUMBER1 }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOTARGETCUSDETAILType>
        </ns0:ConsultaTargetCliente>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $aCCOUNT_NUMBER1 as xs:string external;
declare variable $columnName as xs:string external;

xf:ConsultaCuentaT24Request($autenticacionRequestHeader1,
    $aCCOUNT_NUMBER1,
    $columnName)