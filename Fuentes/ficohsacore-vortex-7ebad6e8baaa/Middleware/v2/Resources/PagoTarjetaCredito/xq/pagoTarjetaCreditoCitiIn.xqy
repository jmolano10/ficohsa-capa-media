xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns2:pagoTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Pagoderecaudolocalylineadbcta" location="../../../../Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoCitiIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
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
 
declare function xf:pagoTarjetaCreditoCitiIn($requestHeader as element(ns0:RequestHeader),
    $pagoTarjetaCredito as element(ns2:pagoTarjetaCredito),
    $contractId as xs:string,
    $uuid as xs:string,
    $paymentCurrency as xs:string)
    as element(ns1:Pagoderecaudolocalylineadbcta) {
        <ns1:Pagoderecaudolocalylineadbcta>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl/>
				<messageId>{ $uuid }</messageId>
				<noOfAuth/>
				<replace/>
			</OfsFunction>            
            <FUNDSTRANSFERLATAMACCTTRFWSType>
                <DEBITACCOUNT>{ data($pagoTarjetaCredito/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <PAYEECCY>{ $paymentCurrency }</PAYEECCY>
                <LRPAYCODE>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</LRPAYCODE>
                <gLRINVOICENO>
                    <mLRINVOICENO>
                        <LRINVOICENO>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</LRINVOICENO>
                        <LRDUEDATE>
                        {
                        	let $currentDate := string(fn:current-date())
                        	return
								concat(fn:substring($currentDate,1,4),fn:substring($currentDate,6,2),fn:substring($currentDate,9,2))
                        }
                        </LRDUEDATE>
                        <LRAMT>{ concat(data($pagoTarjetaCredito/BALANCE_CURRENCY) , "1.00") }</LRAMT>
                        <LRTOTALAMT>{ concat($paymentCurrency, data($pagoTarjetaCredito/PAYMENT_AMOUNT)) }</LRTOTALAMT>
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
                </gLRINVOICENO>
                <LRAGCLIENTID>{ $contractId }</LRAGCLIENTID>
            </FUNDSTRANSFERLATAMACCTTRFWSType>
        </ns1:Pagoderecaudolocalylineadbcta>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoTarjetaCredito as element(ns2:pagoTarjetaCredito) external;
declare variable $contractId as xs:string external;
declare variable $uuid as xs:string external;
declare variable $paymentCurrency as xs:string external;

xf:pagoTarjetaCreditoCitiIn($requestHeader,
    $pagoTarjetaCredito,
    $contractId,
    $uuid,
    $paymentCurrency)