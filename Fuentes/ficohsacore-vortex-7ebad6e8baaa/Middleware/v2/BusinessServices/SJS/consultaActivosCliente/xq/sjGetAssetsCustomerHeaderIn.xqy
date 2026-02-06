xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteRequest" element="ns0:sjConsultaActivosClienteRequest" location="../../../../../Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaActivosCliente.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaActivosCliente/xq/sjGetAssetsCustomerHeaderIn/";

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

declare function xf:sjGetAssetsCustomerHeaderIn($serviceAccountName as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string)
    as element(ns1:RequestHeader) {
        <ns1:RequestHeader>
            <Authentication>
                <UserName>{ fn-bea:fail-over(getUsername($serviceAccountName), $serviceAccountName) }</UserName>
                <Password>{ fn-bea:fail-over(getPassword($serviceAccountName), $serviceAccountName) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ $sourceBank }</SourceBank>
                <DestinationBank>{ $destinationBank }</DestinationBank>
            </Region>
        </ns1:RequestHeader>
};

declare variable $serviceAccountName as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;

xf:sjGetAssetsCustomerHeaderIn($serviceAccountName,
    $sourceBank,
    $destinationBank)