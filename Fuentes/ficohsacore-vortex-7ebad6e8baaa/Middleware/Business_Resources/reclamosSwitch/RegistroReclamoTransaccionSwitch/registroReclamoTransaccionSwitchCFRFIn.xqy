xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registroReclamoTransaccionSwitch" element="ns1:registroReclamoTransaccionSwitch" location="registroReclamoTransaccionSwitchTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Reclamoswitchficohsaenficohsa" location="../Resources/XMLSchema_-1759531368.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroReclamoTransaccionSwitchTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/reclamosSwitch/RegistroReclamoTransaccionSwitch/registroReclamoTransaccionSwitchCFRFIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

(: Se encarga de partir un string en una secuencia de string de determinado tamaño :)
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:registroReclamoTransaccionSwitchCFRFIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $registroReclamoTransaccionSwitch as element(ns1:registroReclamoTransaccionSwitch))
    as element(ns0:Reclamoswitchficohsaenficohsa) {
        <ns0:Reclamoswitchficohsaenficohsa>
			<WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId></messageId>
				<noOfAuth>0</noOfAuth>
				<replace></replace>
			</OfsFunction>
            <FUNDSTRANSFERFICOCLAIMType>
                <CLAIMCURRENCY>{ data($registroReclamoTransaccionSwitch/CLAIM_CURRENCY) }</CLAIMCURRENCY>
                <CLAIMAMOUNT>{ data($registroReclamoTransaccionSwitch/CLAIM_AMOUNT) }</CLAIMAMOUNT>
             
                <gPAYMENTDETAILS>
 				{
                	for $DESCRIPTION in splitString(data($registroReclamoTransaccionSwitch/DESCRIPTION),34)
                		return
                			if(fn:string($DESCRIPTION) != "") then (
                				<PAYMENTDETAILS>{concat($DESCRIPTION, ".")}</PAYMENTDETAILS>
                			) else ()
                }   
                </gPAYMENTDETAILS>
                {
                    for $ATM_ID in $registroReclamoTransaccionSwitch/ATM_ID
                    return
                        <TERMINALID>{ data($ATM_ID) }</TERMINALID>
                }
                {
                    for $TRACE_NUMBER in $registroReclamoTransaccionSwitch/TRACE_NUMBER
                    return
                        <TRACENO>{ data($TRACE_NUMBER) }</TRACENO>
                }
                {
                    for $CLAIM_NUMBER in $registroReclamoTransaccionSwitch/CLAIM_NUMBER
                    return
                        <CLAIMNUMBER>{ data($CLAIM_NUMBER) }</CLAIMNUMBER>
                }
                {
                    for $CARD_NUMBER in $registroReclamoTransaccionSwitch/CARD_NUMBER
                    return
                        <LRCARDNUMBER>{ data($CARD_NUMBER) }</LRCARDNUMBER>
                }
            </FUNDSTRANSFERFICOCLAIMType>
        </ns0:Reclamoswitchficohsaenficohsa>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $registroReclamoTransaccionSwitch as element(ns1:registroReclamoTransaccionSwitch) external;

xf:registroReclamoTransaccionSwitchCFRFIn($autenticacionRequestHeader,
    $registroReclamoTransaccionSwitch)