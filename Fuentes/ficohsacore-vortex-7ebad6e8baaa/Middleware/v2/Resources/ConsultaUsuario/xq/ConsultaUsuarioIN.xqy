xquery version "2004-draft" encoding "Cp1252";
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
        <ns3:GetUserByDocumentNumberMessageIn>
			<ns3:LegalId>{ data($consultaUsuarioIN/CUSTOMER_ID_VALUE) }</ns3:LegalId>
      	</ns3:GetUserByDocumentNumberMessageIn>
};

declare variable $consultaUsuarioIN as element(ns0:consultaUsuario) external;

xf:ConsultaUsuarioIN($consultaUsuarioIN)