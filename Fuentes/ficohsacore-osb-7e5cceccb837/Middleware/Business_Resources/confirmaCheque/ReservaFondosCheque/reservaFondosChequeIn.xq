(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reservaFondosCheque" element="ns0:reservaFondosCheque" location="reservaFondosChequeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Confirmaciondecheques" location="../Resources/XMLSchema_-1265051491.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reservaFondosChequeTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/reservaFondosCheque/ReservaFondosCheque/reservaFondosChequeIn/";

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

declare function xf:reservaFondosChequeIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reservaFondosCheque as element(ns0:reservaFondosCheque))
    as element(ns1:Confirmaciondecheques) {
        <ns1:Confirmaciondecheques>
              <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth>0</noOfAuth>
                <replace/>
            </OfsFunction>
            <LATAMAGCHEQUECONFIRMDATALATAMWSVERType id = "{ concat($reservaFondosCheque/CHEQUE_NUMBER , ".", $reservaFondosCheque/ACCOUNT_NUMBER) }">
                <GBENEFICIARYNAME g = "1">
                    <BENEFICIARYNAME>AL PORTADOR</BENEFICIARYNAME>
                </GBENEFICIARYNAME>
                <AMOUNT>{ data($reservaFondosCheque/AMOUNT) }</AMOUNT>
                <CONFIRMYN>Y</CONFIRMYN>
                <RESERVEFUNDSYN>Y</RESERVEFUNDSYN>
            </LATAMAGCHEQUECONFIRMDATALATAMWSVERType>
        </ns1:Confirmaciondecheques>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reservaFondosCheque as element(ns0:reservaFondosCheque) external;

xf:reservaFondosChequeIn($autenticacionRequestHeader,
    $reservaFondosCheque)