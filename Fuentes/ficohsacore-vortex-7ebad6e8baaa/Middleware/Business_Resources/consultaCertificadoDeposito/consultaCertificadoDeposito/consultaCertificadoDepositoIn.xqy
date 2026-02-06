xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCertificadoDeposito1" element="ns2:consultaCertificadoDeposito" location="consultaCertificadoDepositoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadecertifdeposito" location="../Resources/XMLSchema_1178015080.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaCertificadoDepositoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoIn/";

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

declare function xf:consultaCertificadoDepositoIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $consultaCertificadoDeposito1 as element(ns2:consultaCertificadoDeposito))
    as element(ns0:Consultadecertifdeposito) {
        <ns0:Consultadecertifdeposito>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSAZACCOUNTDEPType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaCertificadoDeposito1/DEPOSIT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSAZACCOUNTDEPType>
        </ns0:Consultadecertifdeposito>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $consultaCertificadoDeposito1 as element(ns2:consultaCertificadoDeposito) external;

xf:consultaCertificadoDepositoIn($autenticacionRequestHeader1,
    $consultaCertificadoDeposito1)