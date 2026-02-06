xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ext:eCartera" location="../xq/webservicesirc.wsdl" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/HistorialCrediticio/xq/SolicitaHistorialCrediticioISBIn/";
declare namespace soap-env = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace urn = "urn:infocorp.framework.services.common";
declare namespace urn1 = "urn:infocorp.framework.common";
declare namespace h = "urn:infocorp.framework.services.common"; 
declare namespace i = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace wsa = "http://www.w3.org/2005/08/addressing";
declare namespace wsse = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
declare namespace wsu = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";
declare namespace ext = "http://ext.sirc.info.ws.sib.gob.gt/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getParam ($legDoc as xs:string, $par as xs:string)  as xs:string {      
	if ($legDoc = "PASAPORTE") then
		$par
	else 
		""
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getDPIParam ($legDoc as xs:string, $par as xs:string)  as xs:string {      
	if ($legDoc = "DPI") then
		$par
	else 
		""
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getFixedNIT ($par as xs:string)  as xs:string {      
	if (fn:starts-with(fn:substring($par, fn:string-length($par) - 1, 2), "-")) then
		$par
	else 
		fn:concat(fn:substring($par, 1, fn:string-length($par) - 1), "-", fn:substring($par, fn:string-length($par), 1))
 };

(: Función encargada de separacion de nombre y apellido:)
declare function getNamesAndLastName ($line as xs:string, $tipo as xs:integer)  as xs:string {      
		 if ($tipo=1) then
		 let $Text:= fn:substring-before($line," ")
                   return fn:normalize-space(SinEspacios($Text,$line))
		else 
		   let $Text:=fn:substring-after($line," ")
	           return fn:normalize-space(($Text))
 };
 (: Función que verifica que el nombre no regrese vacio:)
declare function SinEspacios ($line, $lineoriginal as xs:string)  as xs:string {      
	if (fn:string-length($line) = 0) then
		let $Text:= $lineoriginal
		return $Text
	else 
	    let $Text:= $line
	    return $Text
 };
(: Función encargada de realizar el mapeo de contraseña:)
declare function getSecondname ($Firstname, $par as xs:string)  as xs:string {      
	if (fn:string-length($par) <= 25) then
		'.'
	else 
		fn:substring($par, fn:string-length($Firstname) + 2, fn:string-length($par) - fn:string-length($Firstname) + 1)
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPhoneNumber ($par as xs:string)  as xs:string {      
	if (fn:string-length($par) > 0) then
		fn:concat('502', $par)
	else 
		$par
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getLastname ($par as xs:string)  as xs:string {      
	if (fn:string-length($par) > 25) then
		fn:substring($par, 26, fn:string-length($par) - 25)
	else 
		"."
 };

declare function xf:SolicitaHistorialCrediticioIn($serviceAccount as xs:string,
    $parametrizacionValue as xs:string,
    $p1 as xs:string,
    $p2 as xs:string,
    $p3 as xs:string,
    $p4 as xs:string,
    $p5 as xs:string,
    $p6 as xs:string,
    $p7 as xs:string,
    $p8 as xs:string,
    $p9 as xs:string,
    $p10 as xs:string,
    $p11 as xs:string,
    $p12 as xs:string,
    $p13 as xs:string,
    $legalDoc)
    as xs:string {
		fn:concat("25|", data($parametrizacionValue), "|", fn-bea:fail-over( getUsername($serviceAccount), $serviceAccount), "|", fn-bea:fail-over( getPassword($serviceAccount), $serviceAccount), "|", getNamesAndLastName($p1,1), "|",  getNamesAndLastName($p2,2), "|", data($p3), "|", getNamesAndLastName($p4,1), "|", getNamesAndLastName($p5,2), "|", data($p6), "|", data($p7), "|", getFixedNIT($p8), "|", getDPIParam( $legalDoc, $p9), "|", getParam( $legalDoc, $p10), "|", getParam( $legalDoc, $p11), "|", data($p12), "|", getPhoneNumber($p13)) 
};

declare variable $serviceAccount as xs:string external;
declare variable $parametrizacionValue as xs:string external;
declare variable $p1 as xs:string external;
declare variable $p2 as xs:string external;
declare variable $p3 as xs:string external;
declare variable $p4 as xs:string external;
declare variable $p5 as xs:string external;
declare variable $p6 as xs:string external;
declare variable $p7 as xs:string external;
declare variable $p8 as xs:string external;
declare variable $p9 as xs:string external;
declare variable $p10 as xs:string external;
declare variable $p11 as xs:string external;
declare variable $p12 as xs:string external;
declare variable $p13 as xs:string external;
declare variable $legalDoc as xs:string external;
declare variable $stringTemp as xs:string external;

xf:SolicitaHistorialCrediticioIn($serviceAccount,
    $parametrizacionValue,
    $p1,
    $p2,
    $p3,
    $p4,
    $p5,
    $p6,
    $p7,
    $p8,
    $p9,
    $p10,
    $p11,
    $p12,
    $p13,
    $legalDoc)