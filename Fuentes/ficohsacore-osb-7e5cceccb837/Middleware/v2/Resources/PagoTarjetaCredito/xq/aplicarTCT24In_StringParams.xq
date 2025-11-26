(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../Business_Resources/tarjetaCredito/Resources/AplicaTCT24/ORA_BANK_T24_P_APLICA_TC.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/T24_P_APLICA_TC/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCredito/xq/aplicarTCT24In_StringParams/";

declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function local:getVASACurrencyCode($currency as xs:string) as xs:string
{
	let $result := if ($currency ="HNL") then ("340") else if ($currency ="USD") then ("840") else ("")
	return $result 	 
};

declare function xf:aplicarTCT24In_StringParams($Amount as xs:string,
    $CreditCardNumber as xs:string,
    $Currency as xs:string,
    $UserName as xs:string,
    $Date as xs:string,
    $LRCrdCardSeq as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:PN_OPERACION>1</ns0:PN_OPERACION>
            <ns0:PN_MONTO>{ $Amount }</ns0:PN_MONTO>
            <ns0:PN_NUM_TARJETA>{ $CreditCardNumber }</ns0:PN_NUM_TARJETA>
            <ns0:PN_MONEDA>{ local:getVASACurrencyCode($Currency) }</ns0:PN_MONEDA>
            <ns0:PN_FORMAPAGO>1</ns0:PN_FORMAPAGO>
            <ns0:PV_CANAL>{ fn-bea:fail-over( local:getUsername($UserName),$UserName) }</ns0:PV_CANAL>
            <ns0:PV_FECHA>{ $Date }</ns0:PV_FECHA>
            <ns0:PN_NUMREFERENCIA>{ $LRCrdCardSeq }</ns0:PN_NUMREFERENCIA>
        </ns0:InputParameters>
};

declare variable $Amount as xs:string external;
declare variable $CreditCardNumber as xs:string external;
declare variable $Currency as xs:string external;
declare variable $UserName as xs:string external;
declare variable $Date as xs:string external;
declare variable $LRCrdCardSeq as xs:string external;

xf:aplicarTCT24In_StringParams($Amount,
    $CreditCardNumber,
    $Currency,
    $UserName,
    $Date,
    $LRCrdCardSeq)
