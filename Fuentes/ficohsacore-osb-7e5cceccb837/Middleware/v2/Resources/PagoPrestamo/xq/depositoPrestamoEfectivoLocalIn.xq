xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns2:pagoPrestamo" location="../../../../Business_Resources/pagoPrestamo/pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Depositoenefectivofase11" location="../../../../Business_Resources/pagoPrestamo/Resources/DebitoPrestamo/XMLSchema_1612001361.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/depositoPrestamoEfectivoLocalIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
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
 
declare function xf:depositoPrestamoEfectivoLocalIn($requestHeader as element(ns0:RequestHeader),
    $pagoPrestamo as element(ns2:pagoPrestamo),
    $uuid as xs:string)
    as element(ns1:Depositoenefectivofase11) {
        <ns1:Depositoenefectivofase11>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
            	<messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <TELLERFICOLCYCASHINTMP1Type>
                <gACCOUNT1 g = "1">
                    <mACCOUNT1 m = "1">
                        <DepositAmount>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</DepositAmount>
                    </mACCOUNT1>
                </gACCOUNT1>
            </TELLERFICOLCYCASHINTMP1Type>
        </ns1:Depositoenefectivofase11>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoPrestamo as element(ns2:pagoPrestamo) external;
declare variable $uuid as xs:string external;

xf:depositoPrestamoEfectivoLocalIn($requestHeader,
    $pagoPrestamo,
    $uuid)