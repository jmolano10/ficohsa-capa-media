xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoDePaquetesMovilesFTResponse" element="ns0:PagoDePaquetesMovilesFTResponse" location="../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReversionDePaquetesMovilesFT" location="../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaquete/xq/reversionPaquetesMovilIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";

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

declare function xf:reversionPaquetesMovilIn($requestHeader as element(ns1:RequestHeader), $pagoDePaquetesMovilesFTResponse as element(ns0:PagoDePaquetesMovilesFTResponse))
    as element(ns0:ReversionDePaquetesMovilesFT) {
        <ns0:ReversionDePaquetesMovilesFT>
        	<WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentitacion/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
			</password>
            </WebRequestCommon>
            <FUNDSTRANSFERFICOMOBILEPACKAGEREVWSType>
                {
                    for $transactionId in $pagoDePaquetesMovilesFTResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERFICOMOBILEPACKAGEREVWSType>
        </ns0:ReversionDePaquetesMovilesFT>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $pagoDePaquetesMovilesFTResponse as element(ns0:PagoDePaquetesMovilesFTResponse) external;

xf:reversionPaquetesMovilIn($requestHeader,$pagoDePaquetesMovilesFTResponse)