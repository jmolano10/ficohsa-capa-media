(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../BusinessServices/consultaMontoTSPCliente/xsd/XMLSchema_1118292658.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24FtAdapterPoll001_inbound/xq/consultarMontoTSPClientes_Header_In/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("IntegrationFramework/ServiceAccounts/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("IntegrationFramework/ServiceAccounts/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:consultarMontoTSPClientes_Header_In($serviceAccount as xs:string)
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ fn-bea:fail-over( getUsername($serviceAccount), 'Usuario TSP no encontrado') }</UserName>
                <Password>{ fn-bea:fail-over( getPassword($serviceAccount), '') }</Password>
            </Authentication>
            <Region>
                <SourceBank>HN01</SourceBank>
                <DestinationBank>HN01</DestinationBank>
            </Region>
        </ns0:RequestHeader>
};

declare variable $serviceAccount as xs:string external;

xf:consultarMontoTSPClientes_Header_In($serviceAccount)