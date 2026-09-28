(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaSaldoCuenta1" element="ns1:consultaSaldoCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaSaldoCuenta" location="../../../../Business_Resources/ConsultasCuenta/Resources/ConsultaSaldoCuenta/xsd/services_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoCuenta/xq/consultaSaldoCuentaV2In/";

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


declare function xf:consultaSaldoCuentaV2In($requestHeader as element(ns2:RequestHeader),
    $consultaSaldoCuenta1 as element(ns1:consultaSaldoCuenta))
    as element(ns0:ConsultaSaldoCuenta) {
        <ns0:ConsultaSaldoCuenta>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <FICOCONSULSALDOACCTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaSaldoCuenta1/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOCONSULSALDOACCTType>
        </ns0:ConsultaSaldoCuenta>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaSaldoCuenta1 as element(ns1:consultaSaldoCuenta) external;

xf:consultaSaldoCuentaV2In($requestHeader,
    $consultaSaldoCuenta1)