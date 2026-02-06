xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCertificadoDeposito" element="ns1:consultaCertificadoDeposito" location="../../../../Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecertifdeposito" location="../../../../Business_Resources/consultaCertificadoDeposito/Resources/XMLSchema_1178015080.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCertificadoDeposito/xq/consultaCertificadoDepositoIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCertificadoDepositoTypes";
declare namespace ns0 = "T24WebServicesImpl";

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
 
declare function xf:consultaCertificadoDepositoIn($requestHeader as element(ns2:RequestHeader),
    $consultaCertificadoDeposito as element(ns1:consultaCertificadoDeposito))
    as element(ns0:Consultadecertifdeposito) {
        <ns0:Consultadecertifdeposito>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSAZACCOUNTDEPType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaCertificadoDeposito/DEPOSIT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSAZACCOUNTDEPType>
        </ns0:Consultadecertifdeposito>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaCertificadoDeposito as element(ns1:consultaCertificadoDeposito) external;

xf:consultaCertificadoDepositoIn($requestHeader,
    $consultaCertificadoDeposito)