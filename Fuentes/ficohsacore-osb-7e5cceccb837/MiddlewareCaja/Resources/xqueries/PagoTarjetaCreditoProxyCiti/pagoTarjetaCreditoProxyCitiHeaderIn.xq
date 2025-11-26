xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../xsds/esquemas_generales/HeaderElements.xsd" ::)


declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCreditoProxyCiti/pagoTarjetaCreditoProxyCitiHeaderIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("MiddlewareCaja/ServiceAccounts/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("MiddlewareCaja/ServiceAccounts/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:pagoTarjetaCreditoProxyCitiHeaderIn($userName as xs:string)
    as element(ns0:RequestHeader) {
    	<ns0:RequestHeader>
    		<Authentication>
    			<UserName>{ getUsername($userName) } </UserName>
        	    <Password>{ getPassword($userName) }</Password>
    		</Authentication>
    		<Region>
    			<SourceBank>HN01</SourceBank>
    			<DestinationBank>HN01</DestinationBank>
    		</Region>
        </ns0:RequestHeader>
};

declare variable $userName as xs:string external;

xf:pagoTarjetaCreditoProxyCitiHeaderIn($userName)