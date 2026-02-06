xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoRequestBody" element="ns2:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Pagodetarjetadecredito" location="../../../../Business_Resources/tarjetaCredito/Resources/XMLSchema_-604480245.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/PagodetarjetadecreditoIn/";

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
 
declare function xf:PagodetarjetadecreditoIn($requestHeader as element(ns0:RequestHeader),
    $pagoTarjetaCreditoRequestBody as element(ns2:pagoTarjetaCredito),
    $clientId as xs:string,
    $currentBalance as xs:string,
    $uuid as xs:string)
    as element(ns1:Pagodetarjetadecredito) {
        <ns1:Pagodetarjetadecredito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
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
                        <SURROGATEACCOUNT>{ data($pagoTarjetaCreditoRequestBody/DEBIT_ACCOUNT) }</SURROGATEACCOUNT>
                        <AMOUNT>{ data($pagoTarjetaCreditoRequestBody/PAYMENT_AMOUNT) }</AMOUNT>
                    </mTRANSACTION>
                </gTRANSACTION>
                <LROTHAMT>{ data($pagoTarjetaCreditoRequestBody/PAYMENT_AMOUNT) }</LROTHAMT>
                <CREDITCARDNUM>{ data($pagoTarjetaCreditoRequestBody/CREDIT_CARD_NUMBER) }</CREDITCARDNUM>
                <LRCRCCY>{ data($pagoTarjetaCreditoRequestBody/BALANCE_CURRENCY) }</LRCRCCY>
                <LRAMTPAY>Other Amt</LRAMTPAY>
                <LRCONSUMEAMT>{ $currentBalance }</LRCONSUMEAMT>
                <gLR.ECONOMIC.ACT>
                    <mLR.ECONOMIC.ACT>
                        <CLIENTID>{ $clientId }</CLIENTID>
                    </mLR.ECONOMIC.ACT>
                </gLR.ECONOMIC.ACT>
            </TELLERFINANCIALSERVICESFICOCCARDPAYWSOFFLType>
        </ns1:Pagodetarjetadecredito>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoTarjetaCreditoRequestBody as element(ns2:pagoTarjetaCredito) external;
declare variable $clientId as xs:string external;
declare variable $currentBalance as xs:string external;
declare variable $uuid as xs:string external;

xf:PagodetarjetadecreditoIn($requestHeader,
    $pagoTarjetaCreditoRequestBody,
    $clientId,
    $currentBalance,
    $uuid)