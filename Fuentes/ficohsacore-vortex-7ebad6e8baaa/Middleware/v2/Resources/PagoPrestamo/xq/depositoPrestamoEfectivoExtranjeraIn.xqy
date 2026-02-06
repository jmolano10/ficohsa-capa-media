xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns2:pagoPrestamo" location="../../../../Business_Resources/pagoPrestamo/pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Depositoenefectivofase12" location="../../../../Business_Resources/pagoPrestamo/Resources/DebitoPrestamo/XMLSchema_1612001361.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/depositoPrestamoEfectivoExtranjeraIn/";
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
 
declare function xf:depositoPrestamoEfectivoExtranjeraIn($requestHeader as element(ns0:RequestHeader),
    $pagoPrestamo as element(ns2:pagoPrestamo),
    $uuid as xs:string)
    as element(ns1:Depositoenefectivofase12) {
        <ns1:Depositoenefectivofase12>
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
            <TELLERFICOFCYCASHINTMP1Type>
                <CurrencyDeposited>USD</CurrencyDeposited>
                <gACCOUNT1 g = "1">
                    <mACCOUNT1 m = "1">
                        <AmountDeposited>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</AmountDeposited>
                    </mACCOUNT1>
                </gACCOUNT1>
            </TELLERFICOFCYCASHINTMP1Type>
        </ns1:Depositoenefectivofase12>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoPrestamo as element(ns2:pagoPrestamo) external;
declare variable $uuid as xs:string external;

xf:depositoPrestamoEfectivoExtranjeraIn($requestHeader,
    $pagoPrestamo,
    $uuid)