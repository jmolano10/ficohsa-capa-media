(:: pragma bea:local-element-parameter parameter="$status1" type="ns0:PagoderemesaFTResponse/Status" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReversionPagoRemesaFT" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/eliminaRemFtIn/";

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

declare function xf:eliminaRemFtIn($status1 as element(),
    $requestHeader1 as element(ns1:RequestHeader))
    as element(ns0:ReversionPagoRemesaFT) {
        <ns0:ReversionPagoRemesaFT>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentitacion/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <FUNDSTRANSFERREVERSEREMITTANCEType>
                {
                    for $transactionId in $status1/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </FUNDSTRANSFERREVERSEREMITTANCEType>
        </ns0:ReversionPagoRemesaFT>
};

declare variable $status1 as element() external;
declare variable $requestHeader1 as element(ns1:RequestHeader) external;

xf:eliminaRemFtIn($status1,
    $requestHeader1)