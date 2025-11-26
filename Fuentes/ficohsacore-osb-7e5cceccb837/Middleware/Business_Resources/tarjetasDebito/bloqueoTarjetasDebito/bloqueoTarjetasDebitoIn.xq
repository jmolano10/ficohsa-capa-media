(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$bloqueoTarjetasDebito" element="ns1:bloqueoTarjetasDebito" location="bloqueoTarjetasDebitoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMaestraTarjetaDebitoResponse" element="ns0:ConsultaMaestraTarjetaDebitoResponse" location="../Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Bloqueodetarjetadedebito" location="../Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bloqueoTarjetasDebitoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/bloqueoTarjetasDebito/bloqueoTarjetasDebitoIn/";

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

declare function xf:bloqueoTarjetasDebitoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $bloqueoTarjetasDebito as element(ns1:bloqueoTarjetasDebito),
    $consultaMaestraTarjetaDebitoResponse as element(ns0:ConsultaMaestraTarjetaDebitoResponse))
    as element(ns0:Bloqueodetarjetadedebito) {
        <ns0:Bloqueodetarjetadedebito>
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
            <LATAMCARDORDERBLOCKWSType id = "{ concat($consultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType/mWSFICODEBITCARDCUSTOMERDetailType[1]/PRODUCTTYPE , ".", $bloqueoTarjetasDebito/DEBIT_CARD_NUMBER) }"/>
        </ns0:Bloqueodetarjetadedebito>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $bloqueoTarjetasDebito as element(ns1:bloqueoTarjetasDebito) external;
declare variable $consultaMaestraTarjetaDebitoResponse as element(ns0:ConsultaMaestraTarjetaDebitoResponse) external;

xf:bloqueoTarjetasDebitoIn($autenticacionRequestHeader,
    $bloqueoTarjetasDebito,
    $consultaMaestraTarjetaDebitoResponse)