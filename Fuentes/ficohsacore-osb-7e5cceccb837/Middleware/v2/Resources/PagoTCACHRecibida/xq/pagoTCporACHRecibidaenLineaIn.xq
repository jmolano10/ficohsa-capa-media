(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTCACHRecibida" element="ns1:pagoTCACHRecibida" location="../xsd/pagoTCACHRecibida.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PagoTCporACHRecibidaenLinea" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTCACHRecibida";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTCACHRecibida/xq/pagoTCporACHRecibidaenLineaIn/";

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

declare function xf:pagoTCporACHRecibidaenLineaIn($requestHeader as element(ns2:RequestHeader),
    $pagoTCACHRecibida as element(ns1:pagoTCACHRecibida),
    $uuid as xs:string,
    $currentBalance as xs:string,
    $clientId as xs:string)
    as element(ns0:PagoTCporACHRecibidaenLinea) {
        <ns0:PagoTCporACHRecibidaenLinea>
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
            <TELLERFINANCIALSERVICESFICOCCARDPAYWSOFFLACHType>
                <gTRANSACTION>
                    <mTRANSACTION>
                        <Transaction>FROM</Transaction>
                        <SurrogateAccount>{ data($pagoTCACHRecibida/DEBIT_ACCOUNT) }</SurrogateAccount>
                        <Amount>{ data($pagoTCACHRecibida/PAYMENT_AMOUNT) }</Amount>
                    </mTRANSACTION>
                </gTRANSACTION>
                <LROTHAMT>{ data($pagoTCACHRecibida/PAYMENT_AMOUNT) }</LROTHAMT>
                <CREDITCARDNUM>{ data($pagoTCACHRecibida/CREDIT_CARD_NUMBER) }</CREDITCARDNUM>
                <LRCRCCY>{ data($pagoTCACHRecibida/BALANCE_CURRENCY) }</LRCRCCY>
                <LRCONSUMEAMT>{ $currentBalance }</LRCONSUMEAMT>
                <gLR.ECONOMIC.ACT>
                    <mLR.ECONOMIC.ACT>
                        <CLIENTID>{ $clientId }</CLIENTID>
                    </mLR.ECONOMIC.ACT>
                </gLR.ECONOMIC.ACT>
                {
                    for $ID_LOG in $pagoTCACHRecibida/ID_LOG
                    return
                        <LRFICOACHPXD>{ data($ID_LOG) }</LRFICOACHPXD>
                }
            </TELLERFINANCIALSERVICESFICOCCARDPAYWSOFFLACHType>
        </ns0:PagoTCporACHRecibidaenLinea>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $pagoTCACHRecibida as element(ns1:pagoTCACHRecibida) external;
declare variable $uuid as xs:string external;
declare variable $currentBalance as xs:string external;
declare variable $clientId as xs:string external;

xf:pagoTCporACHRecibidaenLineaIn($requestHeader,
    $pagoTCACHRecibida,
    $uuid,
    $currentBalance,
    $clientId)