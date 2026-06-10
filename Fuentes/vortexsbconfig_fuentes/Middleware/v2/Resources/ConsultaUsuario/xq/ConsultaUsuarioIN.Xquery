<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaUsuarioIN" element="ns0:consultaUsuario" location="../xsd/consultaUsuarioTypes.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuario/xq/ConsultaUsuarioIN/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuarioTypes";
declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.administration.users";
declare namespace ns5 = "urn:infocorp.framework.services.common";
declare namespace ns6 = "urn:infocorp.framework.common";

declare function xf:ConsultaUsuarioIN($consultaUsuarioIN as element(ns0:consultaUsuario))
    as element(*) {
        &lt;ns3:GetUserByDocumentNumberMessageIn>
			&lt;ns3:LegalId>{ data($consultaUsuarioIN/CUSTOMER_ID_VALUE) }&lt;/ns3:LegalId>
      	&lt;/ns3:GetUserByDocumentNumberMessageIn>
};

declare variable $consultaUsuarioIN as element(ns0:consultaUsuario) external;

xf:ConsultaUsuarioIN($consultaUsuarioIN)</con:xquery>
    <con:dependency location="../xsd/consultaUsuarioTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaUsuario/xsd/consultaUsuarioTypes"/>
    </con:dependency>
</con:xqueryEntry>