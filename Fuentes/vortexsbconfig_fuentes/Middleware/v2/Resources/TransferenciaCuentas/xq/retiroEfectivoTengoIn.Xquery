<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns2:transferenciaCuentasRequest" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RetiroEfectivoTengo" location="../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/retiroEfectivoTengoIn/";

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

declare function xf:retiroEfectivoTengoIn($requestHeader as element(ns3:RequestHeader),
    $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest),
    $transactionType as xs:string,
    $auth as xs:string,
    $uuid as xs:string)
    as element(ns1:RetiroEfectivoTengo) {
        <ns1:RetiroEfectivoTengo>
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
                <messageId>
                    {
                        if (fn:string($transferenciaCuentasRequest/INTERFACE_REFERENCE_NO/text()) = "") then
                            ($uuid)
                        else 
                            fn:string($transferenciaCuentasRequest/INTERFACE_REFERENCE_NO/text())
                    }
</messageId>
                <noOfAuth>{ $auth }</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TransactionType>{ $transactionType }</TransactionType>
                <DebitAccount>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</DebitAccount>
                {
                    for $CURRENCY in $transferenciaCuentasRequest/CURRENCY
                    return
                        <DebitCurrency>{ data($CURRENCY) }</DebitCurrency>
                }
                <DebitAmount>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</DebitAmount>
                <CreditAccount>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</CreditAccount>
                <gPAYMENTDETAILS>
                    {
                        for $TRANSFER_DETAILS in $transferenciaCuentasRequest/TRANSFER_DETAILS
                        return
                            <PaymentDetails>{ data($TRANSFER_DETAILS) }</PaymentDetails>
                    }
                </gPAYMENTDETAILS>
                <LRREFTENGO>
                    {
                        let $extractedUuid  := ($transferenciaCuentasRequest/ADDITIONAL_INFO/KV_PAIR[KEY = 'UUID']/VALUE/text())  
                        return
                            if (fn:exists($extractedUuid) and fn:string($extractedUuid != '')) then
                                (fn:string($extractedUuid))
                            else 
                                ()
                    }
				</LRREFTENGO>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:RetiroEfectivoTengo>
};

declare variable $requestHeader as element(ns3:RequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest) external;
declare variable $transactionType as xs:string external;
declare variable $auth as xs:string external;
declare variable $uuid as xs:string external;

xf:retiroEfectivoTengoIn($requestHeader,
    $transferenciaCuentasRequest,
    $transactionType,
    $auth,
    $uuid)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../xsd/transferenciaCuentasType.xsd">
        <con:schema ref="Middleware/v2/Resources/TransferenciaCuentas/xsd/transferenciaCuentasType"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes"/>
    </con:dependency>
</con:xqueryEntry>