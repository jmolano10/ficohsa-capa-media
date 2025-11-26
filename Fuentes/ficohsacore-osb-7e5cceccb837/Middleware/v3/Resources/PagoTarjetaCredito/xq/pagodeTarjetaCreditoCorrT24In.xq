(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCreditoRequest" element="ns2:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PagoTarjetaCreditoTengo" location="../../../../v2/BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagodeTarjetaCreditoCorrT24In/";

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

declare function xf:pagodeTarjetaCreditoCorrT24In($requestHeader as element(ns0:RequestHeader),
    $pagoTarjetaCreditoRequest as element(ns2:pagoTarjetaCredito),
    $clientId as xs:string,
    $currentBalance as xs:string,
    $uuid as xs:string)
    as element(ns1:PagoTarjetaCreditoTengo) {
        <ns1:PagoTarjetaCreditoTengo>
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
            <TELLERFINANCIALSERVICESFICOCCARDPAYWSOFFLType>
                <gTRANSACTION>
                    <mTRANSACTION>
                        <Transaction>FROM</Transaction>
                        <SurrogateAccount>{ data($pagoTarjetaCreditoRequest/DEBIT_ACCOUNT) }</SurrogateAccount>
                        <Amount>{ data($pagoTarjetaCreditoRequest/PAYMENT_AMOUNT) }</Amount>
                    </mTRANSACTION>
                </gTRANSACTION>
                <LROTHAMT>{ data($pagoTarjetaCreditoRequest/PAYMENT_AMOUNT) }</LROTHAMT>
                <CREDITCARDNUM>{ data($pagoTarjetaCreditoRequest/CREDIT_CARD_NUMBER) }</CREDITCARDNUM>
                <LRCRCCY>{ data($pagoTarjetaCreditoRequest/BALANCE_CURRENCY) }</LRCRCCY>
                <LRAMTPAY>Other Amt</LRAMTPAY>
                <LRCONSUMEAMT>{ $currentBalance }</LRCONSUMEAMT>
                <gLR.ECONOMIC.ACT>
                    <mLR.ECONOMIC.ACT>
                        <CLIENTID>{ $clientId }</CLIENTID>
                    </mLR.ECONOMIC.ACT>
                </gLR.ECONOMIC.ACT>
                <LRREFTENGO>{ data($pagoTarjetaCreditoRequest/REGIONAL_DETAILS/SOURCE/KV_PAIR[1]/VALUE) }</LRREFTENGO>
            </TELLERFINANCIALSERVICESFICOCCARDPAYWSOFFLType>
        </ns1:PagoTarjetaCreditoTengo>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoTarjetaCreditoRequest as element(ns2:pagoTarjetaCredito) external;
declare variable $clientId as xs:string external;
declare variable $currentBalance as xs:string external;
declare variable $uuid as xs:string external;

xf:pagodeTarjetaCreditoCorrT24In($requestHeader,
    $pagoTarjetaCreditoRequest,
    $clientId,
    $currentBalance,
    $uuid)
