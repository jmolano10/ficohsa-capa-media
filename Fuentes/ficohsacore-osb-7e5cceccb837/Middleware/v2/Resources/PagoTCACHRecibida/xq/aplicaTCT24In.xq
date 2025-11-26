(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTCACHRecibida" element="ns2:pagoTCACHRecibida" location="../xsd/pagoTCACHRecibida.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoTCporACHRecibidaenLineaResponse" element="ns1:PagoTCporACHRecibidaenLineaResponse" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)
(:: pragma bea:global-element-return element="ns3:InputParameters" location="../../../../Business_Resources/tarjetaCredito/Resources/AplicaTCT24/ORA_BANK_T24_P_APLICA_TC.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTCACHRecibida";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTCACHRecibida/xq/aplicaTCT24In/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/T24_P_APLICA_TC/";

(: Función encargada de realizar el mapeo de usuario:)
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de generar un numero de referencia:)
declare function local:generateReference() as xs:string
{    
	let $mytimestamp := fn:current-dateTime() cast as xs:string
	let $result := fn:concat(fn:substring($mytimestamp,9,2),
	                         fn:substring($mytimestamp,12,2),
	                         fn:substring($mytimestamp,15,2),
	                         fn:substring($mytimestamp,18,2),
	                         fn:substring($mytimestamp,21,2))  
	return $result
};

(: Función encargada convertir los codigos de moneda según VASA:)
declare function local:getVASACurrencyCode($currency as xs:string) as xs:string
{
	let $result := if ($currency ="HNL") then ("340") else if ($currency ="USD") then ("840") else ("")
	return $result 	 
};

declare function xf:aplicaTCT24In($requestHeader as element(ns0:RequestHeader),
    $pagoTCACHRecibida as element(ns2:pagoTCACHRecibida),
    $pagoTCporACHRecibidaenLineaResponse as element(ns1:PagoTCporACHRecibidaenLineaResponse))
    as element(ns3:InputParameters) {
        <ns3:InputParameters>
        	<ns3:PN_OPERACION>1</ns3:PN_OPERACION>
            <ns3:PN_MONTO>{ data($pagoTCporACHRecibidaenLineaResponse/TELLERFINANCIALSERVICESType/LROTHAMT) }</ns3:PN_MONTO>
            <ns3:PN_NUM_TARJETA>{ data($pagoTCACHRecibida/CREDIT_CARD_NUMBER) }</ns3:PN_NUM_TARJETA>
            <ns3:PN_MONEDA>{ local:getVASACurrencyCode(data($pagoTCACHRecibida/BALANCE_CURRENCY)) }</ns3:PN_MONEDA>
            <ns3:PN_FORMAPAGO>1</ns3:PN_FORMAPAGO>
            <ns3:PV_CANAL>
            	{ 
	            	fn-bea:fail-over( local:getUsername(data($requestHeader/Authentication/UserName)),
	                    data($requestHeader/Authentication/UserName)) 
            	}
            </ns3:PV_CANAL>
            <ns3:PV_FECHA>
            	{ 
            		fn:substring(fn:concat("20", $pagoTCporACHRecibidaenLineaResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME[1]),1,8) 
        		}
            </ns3:PV_FECHA>
            <ns3:PN_NUMREFERENCIA>{ local:generateReference() }</ns3:PN_NUMREFERENCIA>
        </ns3:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoTCACHRecibida as element(ns2:pagoTCACHRecibida) external;
declare variable $pagoTCporACHRecibidaenLineaResponse as element(ns1:PagoTCporACHRecibidaenLineaResponse) external;

xf:aplicaTCT24In($requestHeader,
    $pagoTCACHRecibida,
    $pagoTCporACHRecibidaenLineaResponse)