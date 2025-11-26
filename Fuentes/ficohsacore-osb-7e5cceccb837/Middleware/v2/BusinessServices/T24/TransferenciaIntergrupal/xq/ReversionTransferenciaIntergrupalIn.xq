(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:TransferenciaIntergrupalReverse" location="../xsd/TransferenciaIntergrupalTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/T24/TransferenciaIntergrupal/xq/ReversionTransferenciaIntergrupalIn/";

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

declare function xf:ReversionTransferenciaIntergrupalIn($requestHeader as element(ns0:RequestHeader),
    $transactionId as xs:string)
    as element(ns1:TransferenciaIntergrupalReverse) {
        <ns1:TransferenciaIntergrupalReverse>
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
            <FUNDSTRANSFERINTERTRANSFWSType>
                <transactionId>{ $transactionId }</transactionId>
            </FUNDSTRANSFERINTERTRANSFWSType>
        </ns1:TransferenciaIntergrupalReverse>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transactionId as xs:string external;

xf:ReversionTransferenciaIntergrupalIn($requestHeader,
    $transactionId)
