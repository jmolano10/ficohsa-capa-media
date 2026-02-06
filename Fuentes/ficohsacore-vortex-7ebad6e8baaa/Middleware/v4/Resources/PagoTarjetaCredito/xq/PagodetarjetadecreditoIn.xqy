xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoRequestBody" element="ns2:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PagoTarjetaCreditoV4" location="../../../BusinessServices/T24/svcPayCreditCardFT/XMLSchema_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v4/Resources/PagoTarjetaCredito/xq/Pagodetarjetacredito/";

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

declare function xf:Pagodetarjetacredito($requestHeader as element(ns0:RequestHeader),
    $pagoTarjetaCreditoRequestBody as element(ns2:pagoTarjetaCredito),
    $clientId as xs:string,
    $currentBalance as xs:string,
    $uuid as xs:string)
    as element(ns1:PagoTarjetaCreditoV4) {
        <ns1:PagoTarjetaCreditoV4>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
                </userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
               </password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <FUNDSTRANSFERRETAILCCARDPAYMENTWSType>
                <DebitAccount>{ data($pagoTarjetaCreditoRequestBody/DEBIT_ACCOUNT) }</DebitAccount>
                <DebitAmount>{ data($pagoTarjetaCreditoRequestBody/PAYMENT_AMOUNT) }</DebitAmount>
                <LRCRCCY>{ data($pagoTarjetaCreditoRequestBody/BALANCE_CURRENCY) }</LRCRCCY>
                <CLIENTID>{ $clientId }</CLIENTID>
                <LRCONSUMEAMT>{ $currentBalance }</LRCONSUMEAMT>
                <LRCARDNUMBER>{ data($pagoTarjetaCreditoRequestBody/CREDIT_CARD_NUMBER) }</LRCARDNUMBER>
                <LROTHAMT>{ data($pagoTarjetaCreditoRequestBody/PAYMENT_AMOUNT) }</LROTHAMT>
                <LRAMTPAY>Other Amt</LRAMTPAY>
            </FUNDSTRANSFERRETAILCCARDPAYMENTWSType>
        </ns1:PagoTarjetaCreditoV4>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoTarjetaCreditoRequestBody as element(ns2:pagoTarjetaCredito) external;
declare variable $clientId as xs:string external;
declare variable $currentBalance as xs:string external;
declare variable $uuid as xs:string external;

xf:Pagodetarjetacredito($requestHeader,
    $pagoTarjetaCreditoRequestBody,
    $clientId,
    $currentBalance,
    $uuid)