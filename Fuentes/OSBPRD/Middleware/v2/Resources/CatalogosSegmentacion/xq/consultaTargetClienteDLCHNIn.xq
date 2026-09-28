(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaTarget" element="ns2:consultaTarget" location="../xsd/catalogosSegmentacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultatargetclienteDLC" location="../../../BusinessServices/T24/catalogosSegmentacion/xsd/XMLSchema_1140175518.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/catalogosSegmentacionTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CatalogosSegmentacion/xq/catalogosSegmentacionHNIn/";

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

declare function xf:catalogosSegmentacionHNIn($requestHeader as element(ns0:RequestHeader),
    $consultaTarget as element(ns2:consultaTarget))
    as element(ns1:ConsultatargetclienteDLC) {
        <ns1:ConsultatargetclienteDLC>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over(getUsername(data($requestHeader/Authentication/UserName)),data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over(getPassword(data($requestHeader/Authentication/UserName)),data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            {
            	for $i in 1 to count($consultaTarget/TARGET_ID)
            	return
	            	if(not(empty($consultaTarget/TARGET_ID))) then (
	            		<FICOETARGETWSType>
			                <enquiryInputCollection>
			                	<columnName>@ID</columnName>
			                    <criteriaValue>{ data($consultaTarget/TARGET_ID) }</criteriaValue>
			                    <operand>EQ</operand>
			                </enquiryInputCollection>
			            </FICOETARGETWSType>
	            	) else ()
            }            
        </ns1:ConsultatargetclienteDLC>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaTarget as element(ns2:consultaTarget) external;

xf:catalogosSegmentacionHNIn($requestHeader,
    $consultaTarget)