(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaPrestamo" location="../xsd/sjConsultaPrestamo.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientosT24/consultarPagoPtmoAA/xq/ConsultaReciboPtmoT24In/";

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

declare function xf:ConsultaReciboPtmoT24In($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $loanNumber as xs:string,
    $transactionId as xs:string)
    as element(ns0:sjConsultaPrestamo) {
        <ns0:sjConsultaPrestamo>
            <USERNAME>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</USERNAME>
            <PASSWORD>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</PASSWORD>
            <LOAN_ID>{ $loanNumber }</LOAN_ID>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
        </ns0:sjConsultaPrestamo>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $loanNumber as xs:string external;
declare variable $transactionId as xs:string external;

xf:ConsultaReciboPtmoT24In($autenticacionRequestHeader1,
    $loanNumber,
    $transactionId)