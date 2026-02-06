xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../FPC/getMultipleProduct12c/xsd/HeaderElements.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaMultiplesProductosHeaderIn/";

declare function getUsername ($serviceAccountName as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($serviceAccountName)))
  		return
		    $data/con:username/text()
};
declare function getPassword ($serviceAccountName as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($serviceAccountName)))
  		return
		    $data/con:password/text()
};

declare function xf:consultaMultiplesProductosHeaderIn($serviceAccountName as xs:string,
    $region as xs:string)
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ fn-bea:fail-over(getUsername($serviceAccountName), $serviceAccountName) }</UserName>
                <Password>{ fn-bea:fail-over(getPassword($serviceAccountName), $serviceAccountName) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ $region }</SourceBank>
                <DestinationBank>{ $region }</DestinationBank>
            </Region>
        </ns0:RequestHeader>
};

declare variable $serviceAccountName as xs:string external;
declare variable $region as xs:string external;

xf:consultaMultiplesProductosHeaderIn($serviceAccountName,
    $region)