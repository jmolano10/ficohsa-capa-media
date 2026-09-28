xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$getThirdPartyProductsForSaraResponse" element="ns8:GetThirdPartyProductsForSaraByDocumentNumberMessageOut" location="../../../BusinessServices/ICB/SaraService/wsdl/saraSingleWSDL.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListaServicios/xq/ConsultaListaServiciosHeaderOUT";
declare namespace auth="http://www.ficohsa.com.hn/middleware.services/autType";
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
declare namespace ns11 = "urn:infocorp.framework.services.common";
declare namespace ns12 = "urn:infocorp.framework.businessentities.common";

(: Se encarga de calcular el successIndicator :)
declare function calcSuccessIndicator($OperationResult as xs:string) as xs:string {
	if ($OperationResult = "0") then
		"Success"
	else 
		"Error"
};

declare function xf:ConsultaListaServiciosHeaderOUT($RSPConsultaListaServiciosSara as element(ns8:GetServicePaymentEntitiesWithTagsForSaraMessageOut))
    as element(auth:ResponseHeader) {
        <auth:ResponseHeader>
        	<successIndicator>{ calcSuccessIndicator(data($RSPConsultaListaServiciosSara/ns3:OperationResult/ns12:Value)) }</successIndicator>
        </auth:ResponseHeader>
};

declare variable $RSPConsultaListaServiciosSara as element(ns8:GetServicePaymentEntitiesWithTagsForSaraMessageOut) external;

xf:ConsultaListaServiciosHeaderOUT($RSPConsultaListaServiciosSara)