xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EjecutarBatch" location="../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudAperturaCuenta/xq/ejecutarBatchIn/";

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

declare function xf:ejecutarBatchIn($requestHeader as element(ns1:RequestHeader),
    $serviceControl as xs:string,
    $batchId as xs:string,
    $user as xs:string )
    as element(ns0:EjecutarBatch) {
        <ns0:EjecutarBatch>
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
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <TSASERVICEINPUTWSType id = "{ $batchId }">
                <USER> { $user }</USER>
                <SERVICECONTROL>{ $serviceControl }</SERVICECONTROL>
            </TSASERVICEINPUTWSType>
        </ns0:EjecutarBatch>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $serviceControl as xs:string external;
declare variable $batchId as xs:string external;
declare variable $user as xs:string external;

xf:ejecutarBatchIn($requestHeader,
    $serviceControl,
    $batchId,
    $user)