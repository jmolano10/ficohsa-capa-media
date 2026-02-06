xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$desbloqueoCAPRequest" element="ns1:desbloqueoCAPRequest" location="../xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:DesbloqueodecuentasAOP" location="../../../BusinessServices/T24/svcAhorroProgramado/xsd/svcAhorroProgramado.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCAP/xq/desbloqueoCAPIn/";

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

declare function xf:desbloqueoCAPIn($requestHeader1 as element(ns2:RequestHeader),
    $desbloqueoCAPRequest as element(ns1:desbloqueoCAPRequest))
    as element(ns0:DesbloqueodecuentasAOP) {
        <ns0:DesbloqueodecuentasAOP>
            <WebRequestCommon>
                <userName>
						{
                			fn-bea:fail-over(getUsername(data($requestHeader1/Authentication/UserName)),
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
            <ACCOUNTDESBLOQAHOPWSType id = "{ data($desbloqueoCAPRequest/CUENTA_AP) }">
                <PostingRestrict>0</PostingRestrict>
            </ACCOUNTDESBLOQAHOPWSType>
        </ns0:DesbloqueodecuentasAOP>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $desbloqueoCAPRequest as element(ns1:desbloqueoCAPRequest) external;

xf:desbloqueoCAPIn($requestHeader1,
    $desbloqueoCAPRequest)