(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo1" element="ns0:pagoPrestamo" location="../pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaPrestamo" location="../../detalleMovimientosT24/consultarPagoPtmoAA/xsd/sjConsultaPrestamo.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/ConsultaPagoPtmoT24In/";

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

declare function xf:ConsultaPagoPtmoT24In($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo1 as element(ns0:pagoPrestamo),
    $transactionId as xs:string)
    as element(ns1:sjConsultaPrestamo) {
        <ns1:sjConsultaPrestamo>
            <USERNAME>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</USERNAME>
            <PASSWORD>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</PASSWORD>
            <LOAN_ID>{ data($pagoPrestamo1/LOAN_NUMBER) }</LOAN_ID>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
        </ns1:sjConsultaPrestamo>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo1 as element(ns0:pagoPrestamo) external;
declare variable $transactionId as xs:string external;

xf:ConsultaPagoPtmoT24In($autenticacionRequestHeader1,
    $pagoPrestamo1,
    $transactionId)