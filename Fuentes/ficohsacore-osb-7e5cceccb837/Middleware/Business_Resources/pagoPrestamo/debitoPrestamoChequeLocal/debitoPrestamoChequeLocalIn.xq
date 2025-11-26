(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Depositocombinado" location="../Resources/DepositoCombinado/XMLSchema_-420276392.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/debitoPrestamoChequeLocal/debitoPrestamoChequeLocalIn/";

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

declare function xf:debitoPrestamoChequeLocalIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $depositAccount as xs:string,
    $uuid as xs:string)
    as element(ns1:Depositocombinado) {
        <ns1:Depositocombinado>
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
            <TELLERFINANCIALSERVICESFICOINPUTWSType>
                <DepositAccount>{ $depositAccount }</DepositAccount>
                <gTRANSACTION g = "1">
                    <mTRANSACTION m = "1">
                        <TRANSACTION>CLEARING</TRANSACTION>
                        <CURRENCY>HNL</CURRENCY>
                        <AMOUNT>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</AMOUNT>
                        {
                            for $BANK_CODE in $pagoPrestamo/BANK_CODE
                            return
                                <SORTCODE>{ data($BANK_CODE) }</SORTCODE>
                        }
                        {
                            for $CHEQUE_NUMBER in $pagoPrestamo/CHEQUE_NUMBER
                            return
                                <CHEQUENUMBER>{ data($CHEQUE_NUMBER) }</CHEQUENUMBER>
                        }
                    </mTRANSACTION>
                </gTRANSACTION>
            </TELLERFINANCIALSERVICESFICOINPUTWSType>
        </ns1:Depositocombinado>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $depositAccount as xs:string external;
declare variable $uuid as xs:string external;

xf:debitoPrestamoChequeLocalIn($autenticacionRequestHeader,
    $pagoPrestamo,
    $depositAccount,
    $uuid)