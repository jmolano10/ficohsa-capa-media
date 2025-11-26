(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$activacionTarjetaDebito" element="ns0:activacionTarjetaDebito" location="../xsd/activacionTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMaestraTarjetaDebitoResponse" element="ns2:ConsultaMaestraTarjetaDebitoResponse" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ActivaciondeTarjetadeDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/activacionTarjetaDebitoTypes";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActivacionTarjetaDebito/xq/activacionTarjetaDebitoIn/";

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

declare function xf:activacionTarjetaDebitoIn($requestHeader as element(ns1:RequestHeader),
    $activacionTarjetaDebito as element(ns0:activacionTarjetaDebito),
    $consultaMaestraTarjetaDebitoResponse as element(ns2:ConsultaMaestraTarjetaDebitoResponse))
    as element(ns2:ActivaciondeTarjetadeDebito) {
        <ns2:ActivaciondeTarjetadeDebito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId></messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>             
            <LATAMCARDORDERACTIVETDWSType id = "{ concat($consultaMaestraTarjetaDebitoResponse/WSFICODEBITCARDCUSTOMERType[1]/gWSFICODEBITCARDCUSTOMERDetailType/mWSFICODEBITCARDCUSTOMERDetailType[1]/PRODUCTTYPE , ".", $activacionTarjetaDebito/DEBIT_CARD_NUMBER) }"/>
        </ns2:ActivaciondeTarjetadeDebito>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $activacionTarjetaDebito as element(ns0:activacionTarjetaDebito) external;
declare variable $consultaMaestraTarjetaDebitoResponse as element(ns2:ConsultaMaestraTarjetaDebitoResponse) external;

xf:activacionTarjetaDebitoIn($requestHeader,
    $activacionTarjetaDebito,
    $consultaMaestraTarjetaDebitoResponse)
