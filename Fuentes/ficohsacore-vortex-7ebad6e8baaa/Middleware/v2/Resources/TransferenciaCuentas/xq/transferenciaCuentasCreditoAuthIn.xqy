xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns2:transferenciaCuentasRequest" location="../../../../Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfentrecuentasinstrcredito" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaCuentasCreditIn/";

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
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:transferenciaCuentasCreditIn($requestHeader as element(ns0:RequestHeader),
    $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest),
    $transactionType as xs:string,
    $uuid as xs:string,
    $auth as xs:string)
    as element(ns1:Transfentrecuentasinstrcredito) {
        <ns1:Transfentrecuentasinstrcredito>
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
            <FUNDSTRANSFERRETAILCRSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCOUNT>{ data($transferenciaCuentasRequest/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <CREDITACCOUNT>{ data($transferenciaCuentasRequest/CREDIT_ACCOUNT) }</CREDITACCOUNT>
                <CREDITAMOUNT>{ data($transferenciaCuentasRequest/TRANSFER_AMOUNT) }</CREDITAMOUNT>
                {
                    for $ITEM_LEVEL_1 in $transferenciaCuentasRequest/ITEM_LEVEL_1
                    return
                        <LRCATEGORY>{ data($ITEM_LEVEL_1) }</LRCATEGORY>
                }
                {
                    for $ITEM_LEVEL_2 in $transferenciaCuentasRequest/ITEM_LEVEL_2
                    return
                        <LRSUBCATEG>{ data($ITEM_LEVEL_2) }</LRSUBCATEG>
                }
                {
                    for $ITEM_LEVEL_3 in $transferenciaCuentasRequest/ITEM_LEVEL_3
                    return
                        <LRITEM>{ data($ITEM_LEVEL_3) }</LRITEM>
                }
                {
                    for $ITEM_LEVEL_4 in $transferenciaCuentasRequest/ITEM_LEVEL_4
                    return
                        <LRSUBITEM>{ data($ITEM_LEVEL_4) }</LRSUBITEM>
                }
                {
                    for $ITEM_LEVEL_5 in $transferenciaCuentasRequest/ITEM_LEVEL_5
                    return
                        <LRGROUP>{ data($ITEM_LEVEL_5) }</LRGROUP>
                }
            </FUNDSTRANSFERRETAILCRSALEWSType>
        </ns1:Transfentrecuentasinstrcredito>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns2:transferenciaCuentasRequest) external;
declare variable $transactionType as xs:string external;
declare variable $uuid as xs:string external;
declare variable $auth as xs:string external;

xf:transferenciaCuentasCreditIn($requestHeader,
    $transferenciaCuentasRequest,
    $transactionType,
    $uuid,
    $auth)