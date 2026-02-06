xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../FPC/consultaSituacionFinanciera12c/xsd/HeaderElements.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/getFinancialSituationHeaderIn/";

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

declare function xf:getFinancialSituationHeaderIn($requestHeader as element(ns0:RequestHeader), 
$serviceAccountName as xs:string)
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ fn-bea:fail-over(getUsername($serviceAccountName), $serviceAccountName) }</UserName>
                <Password>{ fn-bea:fail-over(getPassword($serviceAccountName), $serviceAccountName) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ data($requestHeader/Region/SourceBank) }</SourceBank>
                {
                    for $DestinationBank in $requestHeader/Region/DestinationBank
                    return
                        <DestinationBank>{ data($DestinationBank) }</DestinationBank>
                }
            </Region>
        </ns0:RequestHeader>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $serviceAccountName as xs:string external;

xf:getFinancialSituationHeaderIn($requestHeader, $serviceAccountName)