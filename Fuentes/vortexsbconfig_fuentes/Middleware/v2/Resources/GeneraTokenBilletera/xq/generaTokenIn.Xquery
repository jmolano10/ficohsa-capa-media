<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:jwtTengo" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)

declare namespace ns0 = "http://main/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraTokenBilletera/xq/generaTokenIn/";

declare function xf:generaTokenIn($SECURITY_KEY as xs:string)
    as element(ns0:jwtTengo) {
        &lt;ns0:jwtTengo>
            &lt;LlaveTengo>{ $SECURITY_KEY }&lt;/LlaveTengo>
        &lt;/ns0:jwtTengo>
};

declare variable $SECURITY_KEY as xs:string external;

xf:generaTokenIn($SECURITY_KEY)</con:xquery>
    <con:dependency location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services"/>
    </con:dependency>
</con:xqueryEntry>