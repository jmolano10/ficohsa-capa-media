xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$notificaEstadoRemesaCreditoCuenta1" element="ns0:NotificaEstadoRemesaCreditoCuenta" location="../xsd/notificaEstadoRemesaCreditoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadecliente" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoRemesaCreditoCuentaTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoRemesaCreditoCuenta/xq/notificaEstadoRemesaCreditoCuentaIn/";



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

declare function xf:notificaEstadoRemesaCreditoCuentaIn($username as xs:string,
    $password as xs:string,
    $notificaEstadoRemesaCreditoCuenta1 as element(ns0:NotificaEstadoRemesaCreditoCuenta))
    as element(ns1:Consultadecliente) {
        <ns1:Consultadecliente>
        <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($username),$username) }</userName>
                <password>{ fn-bea:fail-over( getPassword($username),$password) }</password>
            </WebRequestCommon>
            <WSCUSTOMERType>
                <enquiryInputCollection>
					<columnName>LR.INDX.LEGALID</columnName>
                    <criteriaValue>{ data($notificaEstadoRemesaCreditoCuenta1/LEGALID) }</criteriaValue>
					<operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERType>
        </ns1:Consultadecliente>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $notificaEstadoRemesaCreditoCuenta1 as element(ns0:NotificaEstadoRemesaCreditoCuenta) external;

xf:notificaEstadoRemesaCreditoCuentaIn($username,
    $password,
    $notificaEstadoRemesaCreditoCuenta1)