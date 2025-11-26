(:: pragma bea:global-element-return element="ns0:ReversionDepositoTengo" location="../../../BusinessServices/TransaccionesAsincronas/T24/svcReversarTransaccionCB/xsd/services_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTRXDepositoCB/";


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

declare function xf:reversarTRXDepositoCB($FT as xs:string, $user as xs:string)
    as element(ns0:ReversionDepositoTengo) {
        <ns0:ReversionDepositoTengo>
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
            <FUNDSTRANSFERFICOREVTXNUUIDFTType>
                <transactionId>{ $FT }</transactionId>
            </FUNDSTRANSFERFICOREVTXNUUIDFTType>
        </ns0:ReversionDepositoTengo>
};

declare variable $FT as xs:string external;
declare variable $user as xs:string external;

xf:reversarTRXDepositoCB($FT, $user)
