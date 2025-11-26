(:: pragma bea:global-element-parameter parameter="$procesarTransaccionCore" element="ns0:procesarTransaccionCore" location="../xsd/procesarTransaccionCoreTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PagoTarjetaCreditoTengo" location="../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesarTransaccionCoreTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesarTransaccionCore/xq/procesarPagoTCCBIn/";

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

declare function xf:procesarPagoTCCBIn($procesarTransaccionCore as element(ns0:procesarTransaccionCore))
    as element(ns1:PagoTarjetaCreditoTengo) {
        <ns1:PagoTarjetaCreditoTengo>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($procesarTransaccionCore/USER_CB)),'') }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($procesarTransaccionCore/USER_CB)),'') }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ data($procesarTransaccionCore/MESSAGGE_ID) }</messageId>
            </OfsFunction>
            <TELLERFINANCIALSERVICESFICOCCARDPAYWSOFFLType>
                <gTRANSACTION>
                    <mTRANSACTION>
                        <Transaction>FROM</Transaction>
                        <SurrogateAccount>{ data($procesarTransaccionCore/CREDIT_ACCOUNT) }</SurrogateAccount>
                        <Amount>{ data($procesarTransaccionCore/DEBIT_AMOUNT) }</Amount>
                    </mTRANSACTION>
                </gTRANSACTION>
                <LROTHAMT>{ data($procesarTransaccionCore/DEBIT_AMOUNT) }</LROTHAMT>
                <CREDITCARDNUM>{ data($procesarTransaccionCore/CREDIT_CARD_NUMBER) }</CREDITCARDNUM>
                <LRCRCCY>{ data($procesarTransaccionCore/LR_CRCCY) }</LRCRCCY>
                <LRAMTPAY>Other Amt</LRAMTPAY>
                <LRCONSUMEAMT>{ data($procesarTransaccionCore/LR_CONSUMEAMT) }</LRCONSUMEAMT>
                <gLR.ECONOMIC.ACT>
                    <mLR.ECONOMIC.ACT>
                        <CLIENTID>{ data($procesarTransaccionCore/CLIENT_ID) }</CLIENTID>
                    </mLR.ECONOMIC.ACT>
                </gLR.ECONOMIC.ACT>
                <LRREFTENGO>{ data($procesarTransaccionCore/TRANSACTION_ID) }</LRREFTENGO>
            </TELLERFINANCIALSERVICESFICOCCARDPAYWSOFFLType>
        </ns1:PagoTarjetaCreditoTengo>
};

declare variable $procesarTransaccionCore as element(ns0:procesarTransaccionCore) external;

xf:procesarPagoTCCBIn($procesarTransaccionCore)
