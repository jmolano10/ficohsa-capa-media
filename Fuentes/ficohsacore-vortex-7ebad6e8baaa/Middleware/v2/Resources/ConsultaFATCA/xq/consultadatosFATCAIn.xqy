xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaFATCA" element="ns2:consultaFATCA" location="../../ConsultaListasRegulatorias/xsd/consultaListasRegulatoriasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadatosFATCA" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFATCA/xq/consultadatosFATCAIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaListasRegulatoriasTypes";
declare namespace ns1 = "T24WebServicesImpl";

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

declare function xf:consultadatosFATCAIn($requestHeader as element(ns0:RequestHeader),
    $consultaFATCA as element(ns2:consultaFATCA))
    as element(ns1:ConsultadatosFATCA) {
        <ns1:ConsultadatosFATCA>
            <WebRequestCommon>
                  <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentitacion/UserName)) }</userName>
                  <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            {
            	if (fn:string($consultaFATCA/CUSTOMER_ID_TYPE/text()) = ("CODE","CUSTOMER_ID")) then (
                	<WSCUSTFATCAAPType>
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ data($consultaFATCA/CUSTOMER_ID_VALUE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSCUSTFATCAAPType>
                ) else if (fn:string($consultaFATCA/CUSTOMER_ID_TYPE/text()) = ("LEGAL_ID")) then (
                	<WSCUSTFATCAAPType>
		                <enquiryInputCollection>
		                    <columnName>LR.INDX.LEGALID</columnName>
		                    <criteriaValue>{ data($consultaFATCA/CUSTOMER_ID_VALUE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSCUSTFATCAAPType>
                ) else (
                	<WSCUSTFATCAAPType/>
		             
                )
            }
        </ns1:ConsultadatosFATCA>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaFATCA as element(ns2:consultaFATCA) external;

xf:consultadatosFATCAIn($requestHeader,
    $consultaFATCA)