(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$enrolaClienteFicoAlertas" element="ns1:enrolaClienteFicoAlertas" location="enrolaClienteFicoAlertasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Registrarclienteenbusinessevent" location="../Resources/XMLSchema_1876963756.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/enrolaClienteFicoAlertasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/EnrolaClienteFicoAlertas/enrolaClienteFicoAlertasIn/";

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

declare function xf:enrolaClienteFicoAlertasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $enrolaClienteFicoAlertas as element(ns1:enrolaClienteFicoAlertas),
    $messageGroup as xs:string)
    as element(ns0:Registrarclienteenbusinessevent) {
        <ns0:Registrarclienteenbusinessevent>
             <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
			    <gtsControl></gtsControl>
			    <messageId></messageId>
			    <noOfAuth></noOfAuth>
			    <replace></replace>
			</OfsFunction>             
            <DECUSTOMERPREFERENCESINPUTWSType id = "{ data($enrolaClienteFicoAlertas/CUSTOMER_ID) }">
                <gMESSAGEGROUP g = "1">
                    <mMESSAGEGROUP m = "1">
                        <MESSAGEGROUP>{ $messageGroup }</MESSAGEGROUP>
                        <sgCARRIER sg = "1">
                            <CARRIER s = "1">
                                <CARRIER>{ data($enrolaClienteFicoAlertas/CARRIER) }</CARRIER>
                                <REQUIRED>Y</REQUIRED>
                                <ADDRESS>{ data($enrolaClienteFicoAlertas/PHONE_ID) }</ADDRESS>
                                {
                                    let $FORMAT := fn:string($enrolaClienteFicoAlertas/FORMAT/text())
                                    return
                                    	if ($FORMAT != "") then (
                                    		<FORMAT>{ data($FORMAT) }</FORMAT>
                                    	) else (
                                    		<FORMAT>3</FORMAT>
                                    	)
                                        
                                }
                                {
                                    let $LANGUAGE := fn:string($enrolaClienteFicoAlertas/LANGUAGE/text())
                                    return
                                    	if ($LANGUAGE != "") then (
                                    		<LANGUAGE>{ data($LANGUAGE) }</LANGUAGE>
                                    	) else (
                                    		<LANGUAGE>GB</LANGUAGE>
                                    	)
                                        
                                }
                            </CARRIER>
                        </sgCARRIER>
                    </mMESSAGEGROUP>
                </gMESSAGEGROUP>
            </DECUSTOMERPREFERENCESINPUTWSType>
        </ns0:Registrarclienteenbusinessevent>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $enrolaClienteFicoAlertas as element(ns1:enrolaClienteFicoAlertas) external;
declare variable $messageGroup as xs:string external;

xf:enrolaClienteFicoAlertasIn($autenticacionRequestHeader,
    $enrolaClienteFicoAlertas,
    $messageGroup)