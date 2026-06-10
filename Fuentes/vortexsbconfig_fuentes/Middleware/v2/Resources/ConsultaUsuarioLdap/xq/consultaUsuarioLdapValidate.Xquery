<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaUsuarioLdapRequest1" element="ns0:consultaUsuarioLdapRequest" location="../xsd/consultaUsuarioLdapTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuarioLdap/xq/consultaUsuarioLdapValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuarioLdapTypes/v2";

declare function xf:consultaUsuarioLdapValidate($consultaUsuarioLdapRequest1 as element(ns0:consultaUsuarioLdapRequest))
    as xs:string {
        if (fn:string($consultaUsuarioLdapRequest1/USER_NAME/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        )
        else (
        	""
        )
};

declare variable $consultaUsuarioLdapRequest1 as element(ns0:consultaUsuarioLdapRequest) external;

xf:consultaUsuarioLdapValidate($consultaUsuarioLdapRequest1)</con:xquery>
    <con:dependency location="../xsd/consultaUsuarioLdapTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaUsuarioLdap/xsd/consultaUsuarioLdapTypes"/>
    </con:dependency>
</con:xqueryEntry>