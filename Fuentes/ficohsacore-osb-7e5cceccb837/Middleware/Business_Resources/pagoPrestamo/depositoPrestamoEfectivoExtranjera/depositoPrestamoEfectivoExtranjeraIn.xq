(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Depositoenefectivofase12" location="../Resources/DebitoPrestamo/XMLSchema_1612001361.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/depositoPrestamoEfectivoExtranjera/depositoPrestamoEfectivoExtranjeraIn/";

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

declare function xf:depositoPrestamoEfectivoExtranjeraIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $uuid as xs:string)
    as element(ns1:Depositoenefectivofase12) {
        <ns1:Depositoenefectivofase12>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
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

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $uuid as xs:string external;

xf:depositoPrestamoEfectivoExtranjeraIn($autenticacionRequestHeader,
    $pagoPrestamo,
    $uuid)