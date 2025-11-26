(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRecibidas" element="ns0:transferenciasACHRecibidas" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/tarjetaCredito/Resources/AplicaTCT24/ORA_BANK_T24_P_APLICA_TC.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/T24_P_APLICA_TC/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/aplicaTCT24In/";

declare function local:getVASACurrencyCode($currency as xs:string) as xs:string {
	let $result := if ($currency ="HNL") then ("340") else if ($currency ="USD") then ("840") else ("")
	return
		$result 	 
};

declare function local:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  	return
  		$data/con:username/text()
};

declare function local:generateReference() as xs:string {
	let $myTimeStamp := fn:current-dateTime() cast as xs:string
	let $result := fn:concat(fn:substring($myTimeStamp,9,2),
							 fn:substring($myTimeStamp,12,2),
							 fn:substring($myTimeStamp,15,2),
							 fn:substring($myTimeStamp,18,2),
							 fn:substring($myTimeStamp,21,2))
	return
		$result
};

declare function format-date ( $date as xs:string )  as xs:string {
    if (fn:string($date) != "") then (
	  	if (fn:upper-case(substring($date, 4, 3)) = ("JAN", "ENE")) then (
	    	concat("20", substring($date, 8, 2), "01", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = "FEB") then (
	    	concat("20", substring($date, 8, 2), "02", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = "MAR") then (
	    	concat("20", substring($date, 8, 2), "03", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = ("APR", "ABR")) then (
	    	concat("20", substring($date, 8, 2), "04", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = "MAY") then (
	    	concat("20", substring($date, 8, 2), "05", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = "JUN") then (
	    	concat("20", substring($date, 8, 2), "06", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = "JUL") then (
	    	concat("20", substring($date, 8, 2), "07", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = ("AUG", "AGO")) then (
	    	concat("20", substring($date, 8, 2), "08", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = "SEP") then (
	    	concat("20", substring($date, 8, 2), "09", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = "OCT") then (
	    	concat("20", substring($date, 8, 2), "10", substring($date, 1, 2)) 
	    ) else if (fn:upper-case(substring($date, 4, 3)) = "NOV") then (
	    	concat("20", substring($date, 8, 2), "11", substring($date, 1, 2)) 
	    ) else (
	    	concat("20", substring($date, 8, 2), "12", substring($date, 1, 2))
	    )
    ) else (
   		""
   	)
};
 
declare function xf:aplicaTCT24In($requestHeader as element(ns2:RequestHeader),
    $transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas),
    $fecha as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_OPERACION>{ xs:decimal(1) }</ns1:PN_OPERACION>
            <ns1:PN_MONTO>{ fn-bea:decimal-truncate(xs:decimal(data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT)), 2) }</ns1:PN_MONTO>
            <ns1:PN_NUM_TARJETA>{ data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/DESTINATION) }</ns1:PN_NUM_TARJETA>
            <ns1:PN_MONEDA>{ local:getVASACurrencyCode(data($transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CURRENCY)) }</ns1:PN_MONEDA>
            <ns1:PN_FORMAPAGO>{ xs:decimal(1) }</ns1:PN_FORMAPAGO>
            <ns1:PV_CANAL>
                {
                    fn-bea:fail-over( local:getUsername(data($requestHeader/Authentication/UserName)),
                    data($requestHeader/Authentication/UserName))
                }
			</ns1:PV_CANAL>
            <ns1:PV_FECHA>{ format-date($fecha) }</ns1:PV_FECHA>
            <ns1:PN_NUMREFERENCIA>{ local:generateReference() }</ns1:PN_NUMREFERENCIA>
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas) external;
declare variable $fecha as xs:string external;

xf:aplicaTCT24In($requestHeader,
    $transferenciasACHRecibidas,
    $fecha)