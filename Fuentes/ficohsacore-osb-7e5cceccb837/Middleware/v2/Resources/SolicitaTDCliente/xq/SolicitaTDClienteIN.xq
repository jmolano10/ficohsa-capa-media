(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitaTDClienteIN" element="ns1:solicitaTDCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AsignacionTarjetaDebitoconReliv" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaTDCliente/xq/SolicitaTDClienteIN/";

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

declare function xf:SolicitaTDClienteIN($requestHeaderIN as element(ns2:RequestHeader),
    $solicitaTDClienteIN as element(ns1:solicitaTDCliente))
    as element(ns0:AsignacionTarjetaDebitoconReliv) {
        <ns0:AsignacionTarjetaDebitoconReliv>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeaderIN/Authentication/UserName)), 
												data($requestHeaderIN/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeaderIN/Authentication/UserName)),
                								data($requestHeaderIN/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICODEBITCARDISSUANCEFICOPRINCIPALAWSType id = "{ concat(data($solicitaTDClienteIN/COSTUMER_CODE/text()) , '.' , data($solicitaTDClienteIN/CARD_TYPE/text()) ) }" >
                <gACCTCCY>
                    <mACCTCCY>
                        <AccountCurrency>{ data($solicitaTDClienteIN/ACCOUNT_CURRENCY) }</AccountCurrency>
                        <PrimaryAccount>{ data($solicitaTDClienteIN/ACCOUNT_NUMBER) }</PrimaryAccount>
                    </mACCTCCY>
                </gACCTCCY>
            </FICODEBITCARDISSUANCEFICOPRINCIPALAWSType>
        </ns0:AsignacionTarjetaDebitoconReliv>
};

declare variable $requestHeaderIN as element(ns2:RequestHeader) external;
declare variable $solicitaTDClienteIN as element(ns1:solicitaTDCliente) external;

xf:SolicitaTDClienteIN($requestHeaderIN,
    $solicitaTDClienteIN)
