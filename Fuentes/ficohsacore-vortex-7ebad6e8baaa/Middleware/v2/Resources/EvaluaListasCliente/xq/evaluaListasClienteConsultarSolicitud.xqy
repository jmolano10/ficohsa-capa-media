xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$evaluaListasClienteRequest" element="ns2:evaluaListasClienteRequest" location="../xsd/evaluaListasClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaListasClientesOFACONU" location="../../../BusinessServices/EvaluaListasCliente/xsd/XMLSchema_-105785688.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/evaluaListasClienteTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaListasCliente/xq/evaluaListasClienteConsultarSolicitud/";

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

declare function xf:evaluaListasClienteConsultarSolicitud($requestHeader as element(ns0:RequestHeader),
    $evaluaListasClienteRequest as element(ns2:evaluaListasClienteRequest))
    as element(ns1:ENQListasOFACONU) {
        <ns1:ENQListasOFACONU>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
			<FICOREVISIONTXNOFACONUWSType>
                {
                    for $TRANSACTION_ID in fn:string($evaluaListasClienteRequest/TRANSACTION_ID/text())
                    return
                    	<enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ $TRANSACTION_ID }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
                }
            </FICOREVISIONTXNOFACONUWSType>            
        </ns1:ENQListasOFACONU>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $evaluaListasClienteRequest as element(ns2:evaluaListasClienteRequest) external;

xf:evaluaListasClienteConsultarSolicitud($requestHeader,
    $evaluaListasClienteRequest)