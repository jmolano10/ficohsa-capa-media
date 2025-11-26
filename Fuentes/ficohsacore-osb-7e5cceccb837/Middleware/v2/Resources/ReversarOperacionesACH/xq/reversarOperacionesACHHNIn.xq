(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarOperacionesACH" element="ns1:reversarOperacionesACH" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReversaOperacionesACH" location="../../../BusinessServices/ReversarOperacionesACH/xsd/XMLSchema_482495286.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarOperacionesACH/xq/reversarOperacionesACHHNIn/";

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

declare function xf:reversarOperacionesACHHNIn($requestHeader1 as element(ns2:RequestHeader),
    $reversarOperacionesACH as element(ns1:reversarOperacionesACH))
    as element(ns0:ReversaOperacionesACH) {
        <ns0:ReversaOperacionesACH>
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
            <FICOHNACHTICKETREVERSEType id = "{ data($reversarOperacionesACH/TICKET) }">
                <CODIGORECHAZO>{ data($reversarOperacionesACH/CODIGO_RECHAZO) }</CODIGORECHAZO>
                <MENSAJERECHAZO>{ data($reversarOperacionesACH/MENSAJE_RECHAZO) }</MENSAJERECHAZO>
            </FICOHNACHTICKETREVERSEType>
        </ns0:ReversaOperacionesACH>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $reversarOperacionesACH as element(ns1:reversarOperacionesACH) external;

xf:reversarOperacionesACHHNIn($requestHeader1,
    $reversarOperacionesACH)
