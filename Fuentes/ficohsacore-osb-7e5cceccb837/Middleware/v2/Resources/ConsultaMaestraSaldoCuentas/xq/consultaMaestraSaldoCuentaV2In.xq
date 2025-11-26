(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMaestraSaldoCuenta" element="ns1:consultaMaestraSaldoCuenta" location="../xsd/consultaMaestraSaldoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaMaestroSaldoCuenta" location="../../../BusinessServices/T24/ConsultaMaestroSaldoCuenta/xsd/services_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaV2In/";

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

declare function xf:consultaMaestraSaldoCuentaV2In($requestHeader as element(ns2:RequestHeader),
    $consultaMaestraSaldoCuenta as element(ns1:consultaMaestraSaldoCuenta))
    as element(ns0:ConsultaMaestroSaldoCuenta) {
        <ns0:ConsultaMaestroSaldoCuenta>
         <WebRequestCommon>
                 <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICOACCTDETAILSMASTERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaMaestraSaldoCuenta/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOACCTDETAILSMASTERType>
        </ns0:ConsultaMaestroSaldoCuenta>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaMaestraSaldoCuenta as element(ns1:consultaMaestraSaldoCuenta) external;

xf:consultaMaestraSaldoCuentaV2In($requestHeader,
    $consultaMaestraSaldoCuenta)