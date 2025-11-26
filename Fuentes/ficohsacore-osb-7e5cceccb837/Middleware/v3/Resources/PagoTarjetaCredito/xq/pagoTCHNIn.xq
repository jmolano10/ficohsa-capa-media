(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$RequestBody" element="ns2:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PagodeTCenFT" location="../../../../v2/BusinessServices/T24/svcPagoTarjetaCredito_DebitoCuenta/xsd/PagoTarjetaCredito_DebitoCuentaTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTCHNIn/";

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

declare function xf:pagoTCHNIn($requestHeader as element(ns0:RequestHeader),
    $RequestBody as element(ns2:pagoTarjetaCredito),
    $uuid as xs:string,
    $currentBalance as xs:string,
    $clientId as xs:string)
    as element(ns1:PagodeTCenFT) {
        <ns1:PagodeTCenFT>
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
            <FUNDSTRANSFERFICOCCARDPAYMENTWSType>
                <SurrogateAccount>{ data($RequestBody/DEBIT_ACCOUNT) }</SurrogateAccount>
                <Amount>{ data($RequestBody/PAYMENT_AMOUNT) }</Amount>
                <LRCCARDNO>{ data($RequestBody/CREDIT_CARD_NUMBER) }</LRCCARDNO>
                <CLIENTID>{ $clientId }</CLIENTID>
                <LRCONSUMEAMT>{ $currentBalance }</LRCONSUMEAMT>
                <LRCCARDCCY>{ data($RequestBody/BALANCE_CURRENCY) }</LRCCARDCCY>
            </FUNDSTRANSFERFICOCCARDPAYMENTWSType>
        </ns1:PagodeTCenFT>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $RequestBody as element(ns2:pagoTarjetaCredito) external;
declare variable $uuid as xs:string external;
declare variable $currentBalance as xs:string external;
declare variable $clientId as xs:string external;

xf:pagoTCHNIn($requestHeader,
    $RequestBody,
    $uuid,
    $currentBalance,
    $clientId)
