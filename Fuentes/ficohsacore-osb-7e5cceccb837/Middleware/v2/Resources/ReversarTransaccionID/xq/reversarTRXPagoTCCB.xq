(:: pragma bea:global-element-return element="ns0:ReversionPagoTCTengo" location="../../../BusinessServices/TransaccionesAsincronas/T24/svcReversarTransaccionCB/xsd/services_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTRXPagoTCCB/";

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

declare function xf:reversarTRXPagoTCCB($TFS as xs:string,
    $user as xs:string)
    as element(ns0:ReversionPagoTCTengo) {
        <ns0:ReversionPagoTCTengo>
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
              <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFINANCIALSERVICESFICOREVTXNUUIDTFSType id = "{ $TFS }"/>
        </ns0:ReversionPagoTCTengo>
};

declare variable $TFS as xs:string external;
declare variable $user as xs:string external;

xf:reversarTRXPagoTCCB($TFS,
    $user)
