<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaProductosCliente" element="ns0:consultaProductosCliente" location="../OperacionesBilletera/xsd/operacionesBilleteraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:procesar" location="../../BusinessServices/enlace/xsd/Enlace.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductosCliente/procesarIn/";

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

declare function xf:procesarIn($consultaProductosCliente as element(ns0:consultaProductosCliente), 
	$accountServiceName as xs:string,
	$userName as xs:string,
	$password as xs:string)
    as element(ns1:procesar) {
        <ns1:procesar>           
               <authorization>{ fn-bea:fail-over( getPassword($accountServiceName), $password) }</authorization>   												                                    
               <Usuario>{ fn-bea:fail-over( getUsername($accountServiceName), $userName) }</Usuario>   											          
            <Identificador>{ data($consultaProductosCliente/CUSTOMER_ID_VALUE) }</Identificador>
        </ns1:procesar>
};

declare variable $consultaProductosCliente as element(ns0:consultaProductosCliente) external;
declare variable $accountServiceName as xs:string external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

xf:procesarIn($consultaProductosCliente, $accountServiceName, $userName, $password)]]></con:xquery>
    <con:dependency location="../OperacionesBilletera/xsd/operacionesBilleteraTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesBilletera/xsd/operacionesBilleteraTypes"/>
    </con:dependency>
    <con:dependency location="../../BusinessServices/enlace/xsd/Enlace.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/enlace/xsd/Enlace"/>
    </con:dependency>
</con:xqueryEntry>