(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$evaluaCuentaAbanksTypeResponse1" element="ns0:EvaluaCuentaAbanksTypeResponse" location="../../../BusinessServices/EvaluaCuentaAbanks/xsd/EvaluaCuentaAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadecuentascanceladas" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "EvaluaCuentaAbanks";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/ConsultaCuentaCanceladaForEachIn/";

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
 
declare function xf:ConsultaCuentaCanceladaForEachIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $evaluaCuentaAbanksTypeResponse1 as element(ns0:EvaluaCuentaAbanksTypeResponse),
    $index as xs:integer)
    as element(ns1:Consultadecuentascanceladas) {
        <ns1:Consultadecuentascanceladas>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSACCOUNTCLOSEDType>
                <enquiryInputCollection>
                	<columnName>@ID</columnName>
                    {
                       		let $ACCOUNT_ID := $evaluaCuentaAbanksTypeResponse1/ns0:EvaluaCuentaAbanksTypeResponse[$index]/ns0:ACCOUNT_ID
                            return
                                <criteriaValue>{ data($ACCOUNT_ID) }</criteriaValue>
                       
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTCLOSEDType>
        </ns1:Consultadecuentascanceladas>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $evaluaCuentaAbanksTypeResponse1 as element(ns0:EvaluaCuentaAbanksTypeResponse) external;
declare variable $index as xs:integer external;

xf:ConsultaCuentaCanceladaForEachIn($autenticacionRequestHeader1,
    $evaluaCuentaAbanksTypeResponse1,
    $index)