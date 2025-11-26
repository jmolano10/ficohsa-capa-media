xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultadepagodeprestamoAA" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/consultaPagoPtmoT24In/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
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
 
declare function xf:consultaPagoPtmoT24In($requestHeader as element(ns0:RequestHeader),
    $numeroPrestamo as xs:string,
    $transactionId as xs:string)
    as element(ns1:ConsultadepagodeprestamoAA) {
        <ns1:ConsultadepagodeprestamoAA>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICOPAYMENTDETAILSAAType>
                <enquiryInputCollection>
                    <columnName>ARRANGEMENT.ID</columnName>
                    <criteriaValue>{ $numeroPrestamo }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>PAYMENT.ID</columnName>
                    <criteriaValue>{ $transactionId }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>                
            </WSFICOPAYMENTDETAILSAAType>
        </ns1:ConsultadepagodeprestamoAA>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $numeroPrestamo as xs:string external;
declare variable $transactionId as xs:string external;

xf:consultaPagoPtmoT24In($requestHeader,
    $numeroPrestamo,
    $transactionId)