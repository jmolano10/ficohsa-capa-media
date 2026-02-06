xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaOficialesNegocio" element="ns2:consultaOficialesNegocio" location="../../../../Business_Resources/Core/consultaOficialesNegocio/consultaOficialesNegocioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaDAO" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOficialesNegocio/xq/consultaOficialesNegocioIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaOficialesNegocioTypes";
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
 
declare function xf:consultaOficialesNegocioIn($requestHeader as element(ns0:RequestHeader),
    $consultaOficialesNegocio as element(ns2:consultaOficialesNegocio))
    as element(ns1:ConsultaDAO) {
        <ns1:ConsultaDAO>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSADMINDEPTACCTOFFICERType>
            {
           		let $OFFICER_CODE := fn:string($consultaOficialesNegocio/OFFICER_CODE/text())
           		return 
           			if ($OFFICER_CODE != "") then (
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ $OFFICER_CODE }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }            
            {
           		let $BRANCH_CODE := fn:string($consultaOficialesNegocio/BRANCH_CODE/text())
           		return 
           			if ($BRANCH_CODE != "") then (
		                <enquiryInputCollection>
		                    <columnName>DEPT.PARENT</columnName>
		                    <criteriaValue>{ $BRANCH_CODE }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		    		) else ()
	        }
	            <enquiryInputCollection>
	                <columnName>DEPT.LEVEL</columnName>
	                <criteriaValue>30</criteriaValue>
	                <operand>EQ</operand>
	            </enquiryInputCollection>
            </WSADMINDEPTACCTOFFICERType>
        </ns1:ConsultaDAO>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaOficialesNegocio as element(ns2:consultaOficialesNegocio) external;

xf:consultaOficialesNegocioIn($requestHeader,
    $consultaOficialesNegocio)