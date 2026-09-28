xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaPrestamo" location="../../../../Business_Resources/detalleMovimientosT24/consultarPagoPtmoAA/xsd/sjConsultaPrestamo.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleCompletoTransaccion/xq/ConsultaReciboPtmoT24In/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";

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
 
declare function xf:ConsultaReciboPtmoT24In($requestHeader as element(ns0:RequestHeader),
    $loanNumber as xs:string,
    $transactionId as xs:string)
    as element(ns1:sjConsultaPrestamo) {
        <ns1:sjConsultaPrestamo>
            <USERNAME>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/requestHeaderUserName)) }</USERNAME>
            <PASSWORD>{ fn-bea:fail-over( getPassword(data($requestHeader/requestHeaderUserName)),
                								data($requestHeader/requestHeaderPassword)) }</PASSWORD>
            <LOAN_ID>{ $loanNumber }</LOAN_ID>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
        </ns1:sjConsultaPrestamo>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $loanNumber as xs:string external;
declare variable $transactionId as xs:string external;

xf:ConsultaReciboPtmoT24In($requestHeader,
    $loanNumber,
    $transactionId)