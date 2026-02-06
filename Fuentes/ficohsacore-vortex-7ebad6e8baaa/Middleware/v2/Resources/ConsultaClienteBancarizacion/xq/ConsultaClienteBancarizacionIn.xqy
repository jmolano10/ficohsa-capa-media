xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaClienteBancarizacion1" element="ns1:consultaClienteBancarizacion" location="../xsd/consultaClienteBancarizacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ClientesBancarazion" location="../../../BusinessServices/T24/consultaClienteBancarizacion/xsd/svcBancarizacionTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClienteBancarizacionTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteBancarizacion/xq/ConsultaClienteBancarizacionIn/";

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

declare function xf:ConsultaClienteBancarizacionIn($requestHeader1 as element(ns2:RequestHeader),
    $consultaClienteBancarizacion1 as element(ns1:consultaClienteBancarizacion))
    as element(ns0:ClientesBancarazion) {
        <ns0:ClientesBancarazion>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
           			<FICOHNBANCCLNTSWSType>
		                <enquiryInputCollection>
		                    <columnName>LEGAL.ID</columnName>
		                    <criteriaValue>{ data($consultaClienteBancarizacion1/LEGAL_ID) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </FICOHNBANCCLNTSWSType>
        </ns0:ClientesBancarazion>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaClienteBancarizacion1 as element(ns1:consultaClienteBancarizacion) external;

xf:ConsultaClienteBancarizacionIn($requestHeader1,
    $consultaClienteBancarizacion1)