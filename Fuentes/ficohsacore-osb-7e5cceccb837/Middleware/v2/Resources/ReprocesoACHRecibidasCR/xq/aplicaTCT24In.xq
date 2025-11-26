(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reprocesoACHRecibidasCR" element="ns0:reprocesoACHRecibidasCR" location="../xsd/reprocesoACHRecibidasCRTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/tarjetaCredito/Resources/AplicaTCT24/ORA_BANK_T24_P_APLICA_TC.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reprocesoACHRecibidasCRTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/T24_P_APLICA_TC/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHRecibidasCR/xq/aplicaTCT24In/";

declare function local:getVASACurrencyCode($currency as xs:string) as xs:string
{
	let $result := if ($currency ="HNL") then ("340") else if ($currency ="USD") then ("840") else ("")
	return $result 	 
};
declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
};
declare function local:generateReference() as xs:string
{
	let $myTimeStamp := fn:current-dateTime() cast as xs:string
	let $result := fn:concat(fn:substring($myTimeStamp,9,2),
							 fn:substring($myTimeStamp,12,2),
							 fn:substring($myTimeStamp,15,2),
							 fn:substring($myTimeStamp,18,2),
							 fn:substring($myTimeStamp,21,2))
	return $result
};

declare function xf:aplicaTCT24In($requestHeader as element(ns2:RequestHeader),
    $reprocesoACHRecibidasCR as element(ns0:reprocesoACHRecibidasCR),
    $fecha as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_OPERACION>{ xs:decimal(1) }</ns1:PN_OPERACION>
            <ns1:PN_MONTO>{ fn-bea:decimal-truncate(xs:decimal(data($reprocesoACHRecibidasCR/BEN_AMOUNT)), 2) }</ns1:PN_MONTO>
            {
                for $BEN_ACCOUNT in $reprocesoACHRecibidasCR/BEN_ACCOUNT
                return
                    <ns1:PN_NUM_TARJETA>{ data($BEN_ACCOUNT) }</ns1:PN_NUM_TARJETA>
            }
            {
                for $BEN_CURRENCY in $reprocesoACHRecibidasCR/BEN_CURRENCY
                return
                    <ns1:PN_MONEDA>{ local:getVASACurrencyCode(data($BEN_CURRENCY)) }</ns1:PN_MONEDA>
            }
            <ns1:PN_FORMAPAGO>{ xs:decimal(1) }</ns1:PN_FORMAPAGO>
            <ns1:PV_CANAL>
                {
                    fn-bea:fail-over( local:getUsername(data($requestHeader/Authentication/UserName)),
                    data($requestHeader/Authentication/UserName))
                }
			</ns1:PV_CANAL>
            <ns1:PV_FECHA>{ $fecha }</ns1:PV_FECHA>
            <ns1:PN_NUMREFERENCIA>{ local:generateReference() }</ns1:PN_NUMREFERENCIA>
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $reprocesoACHRecibidasCR as element(ns0:reprocesoACHRecibidasCR) external;
declare variable $fecha as xs:string external;

xf:aplicaTCT24In($requestHeader,
    $reprocesoACHRecibidasCR,
    $fecha)