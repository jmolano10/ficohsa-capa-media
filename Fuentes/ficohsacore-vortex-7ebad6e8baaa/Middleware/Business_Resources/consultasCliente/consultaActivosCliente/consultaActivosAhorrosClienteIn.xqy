xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteRequest1" element="ns2:consultaActivosClienteRequest" location="../Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadectasahorroporcliente" location="../Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/consultaActivosAhorrosClienteIn/";

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

declare function xf:consultaActivosAhorrosClienteIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $consultaActivosClienteRequest1 as element(ns2:consultaActivosClienteRequest))
    as element(ns0:Consultadectasahorroporcliente) {
        <ns0:Consultadectasahorroporcliente>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSFICOLINKSAVINGSACCTType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($consultaActivosClienteRequest1/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOLINKSAVINGSACCTType>
        </ns0:Consultadectasahorroporcliente>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $consultaActivosClienteRequest1 as element(ns2:consultaActivosClienteRequest) external;

xf:consultaActivosAhorrosClienteIn($autenticacionRequestHeader1,
    $consultaActivosClienteRequest1)