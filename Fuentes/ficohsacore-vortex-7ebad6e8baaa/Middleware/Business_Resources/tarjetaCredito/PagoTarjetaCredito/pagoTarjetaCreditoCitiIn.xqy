xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito1" element="ns1:pagoTarjetaCredito" location="pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudolocalylineadbcta" location="../../pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoCitiIn/";

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

declare function xf:pagoTarjetaCreditoCitiIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoTarjetaCredito1 as element(ns1:pagoTarjetaCredito),
    $contractId as xs:string,
    $uuid as xs:string,
    $paymentCurrency as xs:string)
    as element(ns0:Pagoderecaudolocalylineadbcta) {
        <ns0:Pagoderecaudolocalylineadbcta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl/>
				<messageId>{ $uuid }</messageId>
				<noOfAuth/>
				<replace/>
			</OfsFunction>            
            <FUNDSTRANSFERLATAMACCTTRFWSType>
                <DEBITACCOUNT>{ data($pagoTarjetaCredito1/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <PAYEECCY>{ $paymentCurrency }</PAYEECCY>
                <LRPAYCODE>{ data($pagoTarjetaCredito1/CREDIT_CARD_NUMBER) }</LRPAYCODE>
                <gLRINVOICENO>
                    <mLRINVOICENO>
                        <LRINVOICENO>{ data($pagoTarjetaCredito1/CREDIT_CARD_NUMBER) }</LRINVOICENO>
                        <LRDUEDATE>
                        {
                        	let $currentDate := string(fn:current-date())
                        	return
								concat(fn:substring($currentDate,1,4),fn:substring($currentDate,6,2),fn:substring($currentDate,9,2))
                        }
                        </LRDUEDATE>
                        <LRAMT>{ concat(data($pagoTarjetaCredito1/BALANCE_CURRENCY) , "1.00") }</LRAMT>
                        <LRTOTALAMT>{ concat($paymentCurrency, data($pagoTarjetaCredito1/PAYMENT_AMOUNT)) }</LRTOTALAMT>
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
                </gLRINVOICENO>
                <LRAGCLIENTID>{ $contractId }</LRAGCLIENTID>
            </FUNDSTRANSFERLATAMACCTTRFWSType>
        </ns0:Pagoderecaudolocalylineadbcta>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoTarjetaCredito1 as element(ns1:pagoTarjetaCredito) external;
declare variable $contractId as xs:string external;
declare variable $uuid as xs:string external;
declare variable $paymentCurrency as xs:string external;

xf:pagoTarjetaCreditoCitiIn($autenticacionRequestHeader1,
    $pagoTarjetaCredito1,
    $contractId,
    $uuid,
    $paymentCurrency)