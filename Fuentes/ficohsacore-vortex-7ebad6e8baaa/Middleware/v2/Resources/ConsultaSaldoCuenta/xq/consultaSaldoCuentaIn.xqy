xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSaldoCuenta" element="ns0:consultaSaldoCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:Consultadesaldodecuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoCuenta/xq/consultaSaldoCuentaIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";

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

declare function xf:consultaSaldoCuentaIn($requestHeader as element(ns1:RequestHeader),
    $consultaSaldoCuenta as element(ns0:consultaSaldoCuenta))
    as element(ns2:Consultadesaldodecuenta) {
        <ns2:Consultadesaldodecuenta>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICOACCTBASICDETAILSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaSaldoCuenta/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOACCTBASICDETAILSType>
        </ns2:Consultadesaldodecuenta>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $consultaSaldoCuenta as element(ns0:consultaSaldoCuenta) external;

xf:consultaSaldoCuentaIn($requestHeader,
    $consultaSaldoCuenta)