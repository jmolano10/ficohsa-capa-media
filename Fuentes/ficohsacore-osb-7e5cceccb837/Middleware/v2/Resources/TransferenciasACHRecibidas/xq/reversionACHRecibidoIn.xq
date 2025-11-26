(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReversionACHRecibido" location="../../../BusinessServices/ACH/Recibido/SvcACHRecibido/xsd/XMLSchema_478367602.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/reversionACHRecibidoIn/";

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

declare function xf:reversionACHRecibidoIn($requestHeader1 as element(ns1:RequestHeader),
    $pxpResult as xs:string,
    $pxpErrorCode as xs:string,
    $transactionId as xs:string)
    as element(ns0:ReversionACHRecibido) {
        <ns0:ReversionACHRecibido>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                        data($requestHeader1/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOHNACHONLINEACHINCONFIRMWSType id = "{ $transactionId }">
                <PXPRESULT>{ $pxpResult }</PXPRESULT>
                <PXPERRORCODE>
	                {
	                	let $errorCode := fn:tokenize($pxpErrorCode, '\n')
	                	for $messageSeparated in $errorCode
	                	return
	                		  fn:substring(fn:concat($messageSeparated,''), 1, 150)
	                }
                </PXPERRORCODE>
            </FICOHNACHONLINEACHINCONFIRMWSType>
        </ns0:ReversionACHRecibido>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $pxpResult as xs:string external;
declare variable $pxpErrorCode as xs:string external;
declare variable $transactionId as xs:string external;

xf:reversionACHRecibidoIn($requestHeader1,
    $pxpResult,
    $pxpErrorCode,
    $transactionId)