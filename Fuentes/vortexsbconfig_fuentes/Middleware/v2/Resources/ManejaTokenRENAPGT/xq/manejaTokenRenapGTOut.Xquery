<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="man:manejaTokenRENAPResponse" location="../xsd/manejaTokenRENAPGTTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ManejaTokenRENAPGT/xq/manejaTokenRenapGTOut/";
declare namespace man = "http://www.ficohsa.com.hn/middleware.services/manejaTokenRENAPGTTypes";

declare function xf:manejaTokenRenapGTOut($TokenRenap as xs:string)
    as element(man:manejaTokenRENAPResponse) {
        &lt;man:manejaTokenRENAPResponse>
            &lt;TOKEN>{ $TokenRenap }&lt;/TOKEN>
        &lt;/man:manejaTokenRENAPResponse>
};

declare variable $TokenRenap as xs:string external;

xf:manejaTokenRenapGTOut($TokenRenap)</con:xquery>
    <con:dependency location="../xsd/manejaTokenRENAPGTTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ManejaTokenRENAPGT/xsd/manejaTokenRENAPGTTypes"/>
    </con:dependency>
</con:xqueryEntry>