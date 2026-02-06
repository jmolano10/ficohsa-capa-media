xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:jwtTengo" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)

declare namespace ns0 = "http://main/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraTokenBilletera/xq/generaTokenIn/";

declare function xf:generaTokenIn($SECURITY_KEY as xs:string)
    as element(ns0:jwtTengo) {
        <ns0:jwtTengo>
            <LlaveTengo>{ $SECURITY_KEY }</LlaveTengo>
        </ns0:jwtTengo>
};

declare variable $SECURITY_KEY as xs:string external;

xf:generaTokenIn($SECURITY_KEY)