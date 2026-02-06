xquery version "2004-draft";
(:: pragma  parameter="$ingresaVentaSeguros" type="anyType" ::)
(:: pragma bea:global-element-return element="ns1:altaDeSeguro" location="../../../BusinessServices/INXU/xsd/WSInxuBancaseguroService.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://wsInxuBancaseguroService.bancaseguros.ingesis.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguro/xq/ingresaAltaSegurosHNIn/";

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

declare function xf:ingresaAltaSegurosHNIn($ingresaVentaSeguros as element(*),
    $userService as xs:string)
    as element(ns1:altaDeSeguro) {
        <ns1:altaDeSeguro>
            <xmlAltaDeSeguro>{ fn-bea:serialize($ingresaVentaSeguros) }</xmlAltaDeSeguro>
            <credenciales>
                <usuario>{ getUsername($userService) }</usuario>
                <password>{ getPassword($userService) }</password>
            </credenciales>
        </ns1:altaDeSeguro>
};

declare variable $ingresaVentaSeguros as element(*) external;
declare variable $userService as xs:string external;

xf:ingresaAltaSegurosHNIn($ingresaVentaSeguros,
    $userService)