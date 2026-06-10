<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$gestionCupon" element="ns1:gestionCupon" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:Aplicacionderetirosintarjeta" location="../../../BusinessServices/T24/RetiroSinTD/xsd/operacionesRetiroSinTDTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionCupon/xq/aplicacionRetiroFondosT24In/";

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

declare function xf:aplicacionRetiroFondosT24In($requestHeader as element(ns0:RequestHeader),
    $gestionCupon as element(ns1:gestionCupon),
    $refT24 as xs:string)
    as element(ns2:Aplicacionderetirosintarjeta) {
        <ns2:Aplicacionderetirosintarjeta>
             <WebRequestCommon>
                <userName>{fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName)) }</userName>
                <password>{fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))}</password>
            </WebRequestCommon>
            <OfsFunction></OfsFunction>
            <FICORETSINTARDESACLKNEWFTWSType id = "{ data($refT24) }">
                {
                    for $DESPIGNORATION_CODE in $gestionCupon/DESPIGNORATION_CODE
                    return
                        <ACLK>{ data($DESPIGNORATION_CODE) }</ACLK>
                }
                <Cuentacliente>{ data($gestionCupon/ACCOUNT_NUMBER) }</Cuentacliente>
                <Cantidad>{ string(data($gestionCupon/AMOUNT)) }</Cantidad>
                {
                    for $WITHDRAWAL_POINT_ID in $gestionCupon/WITHDRAWAL_POINT_ID
                    return
                        <CuentaATM>{ data($WITHDRAWAL_POINT_ID) }</CuentaATM>
                }
                <Idcuponretiro>{ data($gestionCupon/TICKET_NUMBER) }</Idcuponretiro>
            </FICORETSINTARDESACLKNEWFTWSType>
        </ns2:Aplicacionderetirosintarjeta>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $gestionCupon as element(ns1:gestionCupon) external;
declare variable $refT24 as xs:string external;

xf:aplicacionRetiroFondosT24In($requestHeader,
    $gestionCupon,
    $refT24)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/T24/RetiroSinTD/xsd/operacionesRetiroSinTDTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/RetiroSinTD/xsd/operacionesRetiroSinTDTypes"/>
    </con:dependency>
</con:xqueryEntry>