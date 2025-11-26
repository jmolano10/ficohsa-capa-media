xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/LocalTransfer/XMLSchema_1836213454.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare variable $transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::) external;
declare variable $uuid as xs:string external;
declare variable $user as xs:string external;
declare variable $password as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $auth as xs:string external;

declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
declare function local:splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), local:splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function local:func($transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::), 
                            $uuid as xs:string, 
                            $user as xs:string, 
                            $password as xs:string, 
                            $transactionType as xs:string, 
                            $auth as xs:string) 
                            as element() (:: schema-element(ns2:Transfentrecuentasinstrcredito) ::) {
    <ns2:Transfentrecuentasinstrcredito>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( local:getUsername(data($user)),
                        data($user))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( local:getPassword(data($user)),
                        data($password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>
                    {
                        if (fn:string($transfersLocalAccountRequest/ns1:InterfaceReferenceNo/text()) = "") then
                            ($uuid)
                        else 
                            fn:string($transfersLocalAccountRequest/ns1:InterfaceReferenceNo/text())
                    }
</messageId>
                <noOfAuth>{ $auth }</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILCRSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCOUNT>{ data($transfersLocalAccountRequest/ns1:DebitAccount) }</DEBITACCOUNT>
                <CREDITACCOUNT>{ data($transfersLocalAccountRequest/ns1:CreditAccount) }</CREDITACCOUNT>
                <CREDITAMOUNT>{ data($transfersLocalAccountRequest/ns1:TransferAmmount) }</CREDITAMOUNT>
                {
                    for $ITEM_LEVEL_1 in $transfersLocalAccountRequest/ns1:ItemLevel1
                    return
                        <LRCATEGORY>{ data($ITEM_LEVEL_1) }</LRCATEGORY>
                }
                {
                    for $ITEM_LEVEL_2 in $transfersLocalAccountRequest/ns1:ItemLevel2
                    return
                        <LRSUBCATEG>{ data($ITEM_LEVEL_2) }</LRSUBCATEG>
                }
                {
                    for $ITEM_LEVEL_3 in $transfersLocalAccountRequest/ns1:ItemLevel3
                    return
                        <LRITEM>{ data($ITEM_LEVEL_3) }</LRITEM>
                }
                {
                    for $ITEM_LEVEL_4 in $transfersLocalAccountRequest/ns1:ItemLevel4
                    return
                        <LRSUBITEM>{ data($ITEM_LEVEL_4) }</LRSUBITEM>
                }
                {
                    for $ITEM_LEVEL_5 in $transfersLocalAccountRequest/ns1:ItemLevel5
                    return
                        <LRGROUP>{ data($ITEM_LEVEL_5) }</LRGROUP>
                }
            </FUNDSTRANSFERRETAILCRSALEWSType>
        </ns2:Transfentrecuentasinstrcredito>
};


local:func($transfersLocalAccountRequest, $uuid, $user, $password, $transactionType, $auth)