xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$compraPaquete" element="ns0:compraPaquete" location="../xsd/compraPaqueteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:buyPack" location="../../../BusinessServices/Claro/Paquetes/xsd/PackageWebServiceTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/compraPaqueteTypes";
declare namespace ns1 = "http://www.claro.com.hn/esb/ws/packages/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraPaquete/xq/compraPaquetesMovilClaroIn/";

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

declare function xf:compraPaquetesMovilClaroIn($compraPaquete as element(ns0:compraPaquete),
    $trasnId as xs:string,
    $serviceAccount as xs:string,
    $distCategory as xs:string)
    as element(ns1:buyPack) {
        <ns1:buyPack>
            <distId>
            	 {
                        fn-bea:fail-over( getUsername($serviceAccount),
                        data("0"))
                 }
			</distId>
            <distPass>
            	{
                        fn-bea:fail-over( getPassword($serviceAccount),
                        data("0"))
                }
			</distPass>        
            <msisdn>{ fn:concat('504',data($compraPaquete/PHONE_NUMBER)) }</msisdn>
            <idPack>{ data($compraPaquete/PACK_CODE) }</idPack>
            <transId>{ $trasnId }</transId>
            <distCategory>{ $distCategory }</distCategory>
        </ns1:buyPack>
};

declare variable $compraPaquete as element(ns0:compraPaquete) external;
declare variable $trasnId as xs:string external;
declare variable $serviceAccount as xs:string external;
declare variable $distCategory as xs:string external;

xf:compraPaquetesMovilClaroIn($compraPaquete,
    $trasnId,
    $serviceAccount,
    $distCategory)