xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizaEstadoTDIN" element="ns0:actualizaEstadoTD" location="../xsd/actualizaEstadoTDTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ActualizacionEstadoTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoTDTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoTD/xq/actualizaEstadoTDIN/";

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

declare function xf:actualizaEstadoTDIN($requestHeaderIN as element(ns2:RequestHeader),
    $actualizaEstadoTDIN as element(ns0:actualizaEstadoTD))
    as element(ns1:ActualizacionEstadoTarjetaDebito) {
        <ns1:ActualizacionEstadoTarjetaDebito>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeaderIN/Authentication/UserName)),
                        data($requestHeaderIN/Authentitacion/UserName))
                    }
                </userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeaderIN/Authentication/UserName)),
                        data($requestHeaderIN/Authentication/Password))
                    }
                </password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <LATAMCARDORDERACTIVATEWSType id = "{  concat(data($actualizaEstadoTDIN/CARD_TYPE) , '.' , data($actualizaEstadoTDIN/CARD_NUMBER/text()))}"/>
        </ns1:ActualizacionEstadoTarjetaDebito>
};

declare variable $requestHeaderIN as element(ns2:RequestHeader) external;
declare variable $actualizaEstadoTDIN as element(ns0:actualizaEstadoTD) external;

xf:actualizaEstadoTDIN($requestHeaderIN,
    $actualizaEstadoTDIN)