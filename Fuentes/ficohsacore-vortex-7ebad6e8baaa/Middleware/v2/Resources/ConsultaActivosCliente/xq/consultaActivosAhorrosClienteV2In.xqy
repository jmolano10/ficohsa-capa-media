xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteRequest1" element="ns1:consultaActivosClienteRequest" location="../xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaCuentaAhorroxCliente" location="../../../BusinessServices/T24/ConsultaCuentaAhorro/xsd/services_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosAhorrosClienteV2In/";

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
 

declare function xf:consultaActivosAhorrosClienteV2In($requestHeader1 as element(ns2:RequestHeader),
    $consultaActivosClienteRequest1 as element(ns1:consultaActivosClienteRequest))
    as element(ns0:ConsultaCuentaAhorroxCliente) {
        <ns0:ConsultaCuentaAhorroxCliente>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICOLINKSAVINGSACCOUNTType>
                <enquiryInputCollection>
                    <columnName>CUSTOMER</columnName>
                    <criteriaValue>{ data($consultaActivosClienteRequest1/CUSTOMER_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOLINKSAVINGSACCOUNTType>
        </ns0:ConsultaCuentaAhorroxCliente>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaActivosClienteRequest1 as element(ns1:consultaActivosClienteRequest) external;

xf:consultaActivosAhorrosClienteV2In($requestHeader1,
    $consultaActivosClienteRequest1)