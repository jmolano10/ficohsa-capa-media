(:: pragma bea:global-element-return element="ns0:ReversarTransaccionTENGOEEH" location="../../../BusinessServices/T24/svcGestionesTrxSEEHTENGO/xsd/svcGestionesTrxSEEHTENGOTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTrxGenericaT24/";

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

declare function xf:reversarTrxGenericaT24($FT as xs:string,
    $user as xs:string)
    as element(ns0:ReversarTransaccionTENGOEEH) {
        <ns0:ReversarTransaccionTENGOEEH>
         <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername($user),'')
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword($user),'')
                    }
				</password>
            </WebRequestCommon>
            <FUNDSTRANSFERTENGOEEHREVERSIONType>
                <transactionId>{ $FT }</transactionId>
            </FUNDSTRANSFERTENGOEEHREVERSIONType>
        </ns0:ReversarTransaccionTENGOEEH>
};

declare variable $FT as xs:string external;
declare variable $user as xs:string external;

xf:reversarTrxGenericaT24($FT,
    $user)