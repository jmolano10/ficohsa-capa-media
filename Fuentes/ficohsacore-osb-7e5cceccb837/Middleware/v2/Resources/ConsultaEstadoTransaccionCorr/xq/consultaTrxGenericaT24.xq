(:: pragma bea:global-element-return element="ns0:ConsultaTransaccionesTENGOEEH" location="../../../BusinessServices/T24/svcGestionesTrxSEEHTENGO/xsd/svcGestionesTrxSEEHTENGOTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccionCorr/xq/consultaTrxGenericaT24/";

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

declare function xf:consultaTrxGenericaT24($IdTransaccion as xs:string,
    $user as xs:string,
    $pass as xs:string)
    as element(ns0:ConsultaTransaccionesTENGOEEH) {
        <ns0:ConsultaTransaccionesTENGOEEH>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername($user),$user)
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword($user),$pass)
                    }
				</password>
            </WebRequestCommon>
            <FICOATMREVCONCATType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $IdTransaccion }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </FICOATMREVCONCATType>
        </ns0:ConsultaTransaccionesTENGOEEH>
};

declare variable $IdTransaccion as xs:string external;
declare variable $user as xs:string external;
declare variable $pass as xs:string external;

xf:consultaTrxGenericaT24($IdTransaccion,
    $user,
    $pass)