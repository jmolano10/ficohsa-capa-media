(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaDeTransaccionesTotales" location="../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionesTotales/xq/consultaDeTransaccionesTotalesIn/";

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

declare function xf:consultaDeTransaccionesTotalesIn($requestHeader as element(ns2:RequestHeader))
    as element(ns1:ConsultaDeTransaccionesTotales) {
        <ns1:ConsultaDeTransaccionesTotales>
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
            <FICOSELLBUYTOTAVAFXWSType>
                <enquiryInputCollection/>
            </FICOSELLBUYTOTAVAFXWSType>
        </ns1:ConsultaDeTransaccionesTotales>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:consultaDeTransaccionesTotalesIn($requestHeader)