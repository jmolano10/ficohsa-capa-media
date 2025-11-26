xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.claro.com.hn/esb/ws/packages/";
(:: import schema at "../../../../ProviderServices/XSD/ClaroMobilePackages/XMLSchema_1732612083.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/paymentCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/paymentCollectionTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $transId as xs:string external;
declare variable $distCategory as xs:string external;
declare variable $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::) external;

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case(fn:concat($LDAPUsername, "packclaro"))))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function local:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case(fn:concat($LDAPUsername, "packclaro"))))
  		return
		    $data/con:password/text()
 };


declare function local:func($username as xs:string,
                            $password as xs:string,
                            $transId as xs:string, 
                            $distCategory as xs:string, 
                            $paymentCollectionRequest as element() (:: schema-element(ns1:paymentCollectionRequest) ::)) 
                            as element() (:: schema-element(ns2:buyPack) ::) {
    <ns2:buyPack>
          <distId> { fn-bea:fail-over( local:getUsername(data($username)),data($username)) } </distId>
          <distPass> { fn-bea:fail-over( local:getPassword(data($username)),data($password)) } </distPass>
          <msisdn>{  fn:concat('504',data($paymentCollectionRequest/ns1:DebtorCode)) }</msisdn>
          <idPack>{ data($paymentCollectionRequest/ns1:BillInformation/ns1:BillNumber) }</idPack>
          <transId>{ $transId }</transId>
          <distCategory>{ $distCategory }</distCategory>
    </ns2:buyPack>
};

local:func($username, $password, $transId, $distCategory, $paymentCollectionRequest)