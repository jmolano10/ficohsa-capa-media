(:: pragma bea:global-element-parameter parameter="$requestHeaderCB" element="ns1:RequestHeader" location="../../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RetiroEfectivoTengo" location="../../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasCB/ProcesarTransaccionesGenericaCB/xq/aplicarTrxGenericaT24CBIn/";

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

declare function xf:aplicarTrxGenericaT24CBIn($requestHeaderCB as element(ns1:RequestHeader),
    $codTrxT24 as xs:string,
    $debitAccount as xs:string,
    $DebitCurrency as xs:string,
    $debitAmount as xs:string,
    $creditAccount as xs:string,
    $UUID as xs:string)
    as element(ns0:RetiroEfectivoTengo) {
        <ns0:RetiroEfectivoTengo>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeaderCB/Authentication/UserName)),'') }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeaderCB/Authentication/UserName)),'') }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TransactionType>{ $codTrxT24 }</TransactionType>
                <DebitAccount>{ $debitAccount }</DebitAccount>
                <DebitCurrency>{ $DebitCurrency }</DebitCurrency>
                <DebitAmount>{ $debitAmount }</DebitAmount>
                <CreditAccount>{ $creditAccount }</CreditAccount>
                <LRREFTENGO>{ $UUID }</LRREFTENGO>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns0:RetiroEfectivoTengo>
};

declare variable $requestHeaderCB as element(ns1:RequestHeader) external;
declare variable $codTrxT24 as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $DebitCurrency as xs:string external;
declare variable $debitAmount as xs:string external;
declare variable $creditAccount as xs:string external;
declare variable $UUID as xs:string external;

xf:aplicarTrxGenericaT24CBIn($requestHeaderCB,
    $codTrxT24,
    $debitAccount,
    $DebitCurrency,
    $debitAmount,
    $creditAccount,
    $UUID)
