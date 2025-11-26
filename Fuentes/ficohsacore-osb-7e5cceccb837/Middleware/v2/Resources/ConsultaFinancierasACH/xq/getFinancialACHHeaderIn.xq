xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../BusinessServices/FPC/getFinancialACH12c/xsd/HeaderElements.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinancierasACH/xq/getFinancialACHHeaderIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

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

declare function xf:getFinancialACHHeaderIn($serviceAccountName as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string)
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ fn-bea:fail-over(getUsername($serviceAccountName), $serviceAccountName) }</UserName>
                <Password>{ fn-bea:fail-over(getPassword($serviceAccountName), $serviceAccountName) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ $sourceBank }</SourceBank>
                <DestinationBank>{ $destinationBank }</DestinationBank>
            </Region>
        </ns0:RequestHeader>
};

declare variable $serviceAccountName as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;

xf:getFinancialACHHeaderIn($serviceAccountName,
    $sourceBank,
    $destinationBank)
