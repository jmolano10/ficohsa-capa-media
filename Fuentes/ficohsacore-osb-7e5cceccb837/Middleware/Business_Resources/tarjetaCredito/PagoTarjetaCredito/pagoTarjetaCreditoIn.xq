(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagodetarjetadecredito" location="../Resources/XMLSchema_-604480245.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoIn/";

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

declare function xf:pagoTarjetaCreditoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito),
    $uuid as xs:string,
    $currentBalance as xs:string)
    as element(ns0:Pagodetarjetadecredito) {
        <ns0:Pagodetarjetadecredito>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId>{ $uuid }</messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>             
            <TELLERFINANCIALSERVICESFICOCCARDPAYWSOFFLType>
                <gTRANSACTION>
                    <mTRANSACTION>
                        <TRANSACTION>FROM</TRANSACTION>
                        <SURROGATEACCOUNT>{ data($pagoTarjetaCredito/DEBIT_ACCOUNT) }</SURROGATEACCOUNT>
                        <AMOUNT>{ data($pagoTarjetaCredito/PAYMENT_AMOUNT) }</AMOUNT>
                    </mTRANSACTION>
                </gTRANSACTION>
                <LROTHAMT>{ data($pagoTarjetaCredito/PAYMENT_AMOUNT) }</LROTHAMT>
                <CREDITCARDNUM>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</CREDITCARDNUM>
                <LRCRCCY>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</LRCRCCY>
                <LRAMTPAY>Other Amt</LRAMTPAY>
                <LRCONSUMEAMT>{ $currentBalance }</LRCONSUMEAMT>
            </TELLERFINANCIALSERVICESFICOCCARDPAYWSOFFLType>
        </ns0:Pagodetarjetadecredito>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;
declare variable $uuid as xs:string external;
declare variable $currentBalance as xs:string external;

xf:pagoTarjetaCreditoIn($autenticacionRequestHeader,
    $pagoTarjetaCredito,
    $uuid,
    $currentBalance)