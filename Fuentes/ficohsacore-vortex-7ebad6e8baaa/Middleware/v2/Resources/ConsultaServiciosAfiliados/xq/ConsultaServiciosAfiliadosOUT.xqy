xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$RSPConsultaServicioAfiliadosSara" element="ns8:GetSiteServicePaymentEntitiesForSaraByDocumentNumberMessageOut" location="../../../../v2/BusinessServices/ICB/SaraService/wsdl/saraSingleWSDL.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:consultaProductosAfiliadosResponse" location="../xsd/ConsultaServiciosAfiliadosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ServiciosAfiliados/ConsultaServiciosAfiliados/xq/Tx_SaraServiceResponse_to_ConsultaProductosAfiliadosResponse/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ConsultaServiciosAfiliadosTypes";
declare namespace ns1 = "urn:infocorp.framework.services.common";
declare namespace ns4 = "urn:infocorp.framework.businessentities.security";
declare namespace ns3 = "urn:infocorp.framework.services.common";
declare namespace ns0 = "urn:infocorp.framework.businessentities.authorization";
declare namespace ns9 = "urn:infocorp.framework.businessentities.logging";
declare namespace ns5 = "urn:infocorp.framework.businessentities.transactions";
declare namespace ns6 = "urn:infocorp.framework.businessentities.thirdpartyproducts";
declare namespace ns10 = "urn:infocorp.framework.businessentities.common";
declare namespace ns7 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns8 = "urn:tailored.icbanking.services.sara";
declare namespace ns11 = "urn:infocorp.servicepayments.businessentities.servicepayments";
declare namespace ns12 = "urn:infocorp.framework.businessentities.common";

declare function xf:ConsultaServiciosAfiliadosOUT($RSPConsultaServicioAfiliadosSara as element(ns8:GetSiteServicePaymentEntitiesForSaraByDocumentNumberMessageOut))
    as element(ns2:consultaServiciosAfiliadosResponse) {
        <ns2:consultaServiciosAfiliadosResponse>
		{if (fn:string($RSPConsultaServicioAfiliadosSara/ns3:OperationResult/ns12:Value/text()) = "0" ) then (
		<SERVICES>
			{
			for $ServicePayment in $RSPConsultaServicioAfiliadosSara/ns8:SiteServicePaymentEntities/ns11:SiteServicePaymentEntity
			return 
				<SERVICE>
					<SITE_ID>{ data($ServicePayment/ns11:SiteServicePaymentEntityId) }</SITE_ID>
					<ID>{ data($ServicePayment/ns11:ServicePaymentEntity/ns11:ServicePaymentEntityId) }</ID>
					<CONTRACT_ID>{ data($ServicePayment/ns11:ServicePaymentEntity/ns11:ServicePaymentEntityBackendId) }</CONTRACT_ID>
					<DESCRIPTION>{ data($ServicePayment/ns11:ServicePaymentEntity/ns11:Description) }</DESCRIPTION>
					<CUSTOMER_DESCRIPTION>{ data($ServicePayment/ns11:Description) }</CUSTOMER_DESCRIPTION>
				</SERVICE>
			}
		</SERVICES>
		) else()}
	</ns2:consultaServiciosAfiliadosResponse>
};

declare variable $RSPConsultaServicioAfiliadosSara as element(ns8:GetSiteServicePaymentEntitiesForSaraByDocumentNumberMessageOut) external;

xf:ConsultaServiciosAfiliadosOUT($RSPConsultaServicioAfiliadosSara)