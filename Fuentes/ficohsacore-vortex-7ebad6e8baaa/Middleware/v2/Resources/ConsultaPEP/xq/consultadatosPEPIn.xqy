xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaPEP" element="ns2:consultaPEP" location="../../ConsultaListasRegulatorias/xsd/consultaListasRegulatoriasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadatosPEP" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaListasRegulatoriasTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPEP/xq/ConsultadatosPEPIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:ConsultadatosPEPIn($requestHeader as element(ns0:RequestHeader),
    $consultaPEP as element(ns2:consultaPEP))
    as element(ns1:ConsultadatosPEP) {
        <ns1:ConsultadatosPEP>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentitacion/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
             {
            	if (fn:string($consultaPEP/CUSTOMER_ID_TYPE/text()) = ("CODE","CUSTOMER_ID")) then (
                	<WSCUSTPEPAPType>
		                <enquiryInputCollection>
		                    <columnName>@ID</columnName>
		                    <criteriaValue>{ data($consultaPEP/CUSTOMER_ID_VALUE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSCUSTPEPAPType>
                ) else if (fn:string($consultaPEP/CUSTOMER_ID_TYPE/text()) = ("LEGAL_ID")) then (
                	<WSCUSTPEPAPType>
		                <enquiryInputCollection>
		                    <columnName>LR.INDX.LEGALID</columnName>
		                    <criteriaValue>{ data($consultaPEP/CUSTOMER_ID_VALUE) }</criteriaValue>
		                    <operand>EQ</operand>
		                </enquiryInputCollection>
		            </WSCUSTPEPAPType>
                ) else (
                	<WSCUSTPEPAPType/>
		             
                )
            }
        </ns1:ConsultadatosPEP>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaPEP as element(ns2:consultaPEP) external;

xf:ConsultadatosPEPIn($requestHeader,
    $consultaPEP)