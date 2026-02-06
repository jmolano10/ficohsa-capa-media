xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$modificacionTarjetaDebito" element="ns2:modificacionTarjetaDebito" location="../xsd/modificacionTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ModificacionTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/modificacionTarjetaDebitoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificacionTarjetaDebito/xq/modificacionTarjetaDebitoIn/";

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

declare function xf:modificacionTarjetaDebitoIn($requestHeader as element(ns0:RequestHeader),
    $modificacionTarjetaDebito as element(ns2:modificacionTarjetaDebito),
    $SecondaryAccount as xs:string,
    $ProductType as xs:string)
    as element(ns1:ModificacionTarjetaDebito) {
        <ns1:ModificacionTarjetaDebito>
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
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <LATAMCARDORDERMODIFICATIONWSType id = "{ concat($ProductType,".",data($modificacionTarjetaDebito/CARD_NUMBER)) }">
                <gACCTCCY>
                    <mACCTCCY>
                        <sgSCNDRYACCT>
                            {
                            	(:Este segmento permite identificar si existen cuentas secundarias, evitando que la sobre escriba en T24:)
                                if (fn:string($SecondaryAccount) != "") 
                                then (
                                	let $ORG_SECOND_ACCT := fn:tokenize(fn:string($SecondaryAccount),"!!")
	                                for $i in 1 to fn:count($ORG_SECOND_ACCT)
	                                return
	                                    <SecondaryAccount>{ xs:string($ORG_SECOND_ACCT[$i]) } </SecondaryAccount>
                                ) else ()
                            }                            
                            {
                            	(:Este segmento incorpora o adiciona las nuevas cuentas secundarias:)
                                let $NEW_SECOND_ACCT := $modificacionTarjetaDebito/SECONDARY_ACCOUNTS/SECONDARY_ACCOUNT
                                for $n in 1 to fn:count($NEW_SECOND_ACCT)
                                return
                                    <SecondaryAccount>{ xs:string($NEW_SECOND_ACCT[$n]) } </SecondaryAccount>
                            }                           
                        </sgSCNDRYACCT>
                    </mACCTCCY>
                </gACCTCCY>
            </LATAMCARDORDERMODIFICATIONWSType>
        </ns1:ModificacionTarjetaDebito>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $modificacionTarjetaDebito as element(ns2:modificacionTarjetaDebito) external;
declare variable $SecondaryAccount as xs:string external;
declare variable $ProductType as xs:string external;

xf:modificacionTarjetaDebitoIn($requestHeader,
    $modificacionTarjetaDebito,
    $SecondaryAccount,
    $ProductType)