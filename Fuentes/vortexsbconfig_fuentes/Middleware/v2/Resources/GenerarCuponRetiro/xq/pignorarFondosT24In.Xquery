<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$generarCuponRetiro" element="ns1:generarCuponRetiro" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:PignoraciondefondosretirosinTD" location="../../../BusinessServices/T24/RetiroSinTD/xsd/operacionesRetiroSinTDTypes.xsd" ::)

declare namespace ns2 = "T24WebServicesImpl";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GenerarCuponRetiro/xq/pignorarFondosT24In/";

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

declare function xf:pignorarFondosT24In($requestHeader as element(ns0:RequestHeader),
    $generarCuponRetiro as element(ns1:generarCuponRetiro))
    as element(ns2:PignoraciondefondosretirosinTD) {
        <ns2:PignoraciondefondosretirosinTD>
            <WebRequestCommon>
                <userName>{fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName)) }</userName>
                <password>{fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))}</password>
            </WebRequestCommon>
            <OfsFunction></OfsFunction>
            <ACLOCKEDEVENTSRETSINTARType>
                <Accountnumber>{ data($generarCuponRetiro/ACCOUNT_NUMBER) }</Accountnumber>
                <LockedAmount>{ string(data($generarCuponRetiro/AMOUNT)) }</LockedAmount>
            </ACLOCKEDEVENTSRETSINTARType>
        </ns2:PignoraciondefondosretirosinTD>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $generarCuponRetiro as element(ns1:generarCuponRetiro) external;

xf:pignorarFondosT24In($requestHeader,
    $generarCuponRetiro)]]></con:xquery>
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