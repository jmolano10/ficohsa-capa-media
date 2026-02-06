xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$getThirdPartyProductsForSaraResponse" element="ns8:GetThirdPartyProductsForSaraByDocumentNumberMessageOut" location="../../../../v2/BusinessServices/ICB/SaraService/wsdl/saraSingleWSDL.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:consultaProductosAfiliadosResponse" location="../xsd/ConsultaProductosAfiliadosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ProductosAfiliados/consultaProductosAfiliados/xq/Tx_SaraServiceResponse_to_ConsultaProductosAfiliadosResponse/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ConsultaProductosAfiliadosTypes";
declare namespace ns1 = "urn:infocorp.framework.services.common";
declare namespace ns4 = "urn:infocorp.framework.businessentities.security";
declare namespace ns3 = "urn:Infocorp.framework.services.common";
declare namespace ns0 = "urn:infocorp.framework.businessentities.authorization";
declare namespace ns9 = "urn:infocorp.framework.businessentities.logging";
declare namespace ns5 = "urn:infocorp.framework.businessentities.transactions";
declare namespace ns6 = "urn:infocorp.framework.businessentities.thirdpartyproducts";
declare namespace ns10 = "urn:infocorp.framework.businessentities.common";
declare namespace ns7 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns8 = "urn:tailored.icbanking.services.sara";

declare function xf:Tx_SaraServiceResponse_to_ConsultaProductosAfiliadosResponse($getThirdPartyProductsForSaraResponse as element(ns8:GetThirdPartyProductsForSaraByDocumentNumberMessageOut))
    as element(ns2:consultaProductosAfiliadosResponse) {
        <ns2:consultaProductosAfiliadosResponse>
		<ns2:PRODUCTS>
			<ns2:PRODUCT>
				<ns2:DESTINATION>
					<ns2:COUNTRY>Honduras</ns2:COUNTRY>
					<ns2:PRODUCT_TYPE>AHO</ns2:PRODUCT_TYPE>
					<ns2:BANK_NAME>Ficohsa</ns2:BANK_NAME>
				</ns2:DESTINATION>
				<ns2:PRODUCT_ID>123456789</ns2:PRODUCT_ID>
				<ns2:NAME>name</ns2:NAME>
				<ns2:ALIAS>alias</ns2:ALIAS>
				<ns2:EMAIL>email@ficohsa.com</ns2:EMAIL>
				<ns2:CURRENCY>HNL</ns2:CURRENCY>
			</ns2:PRODUCT>
		</ns2:PRODUCTS>
	</ns2:consultaProductosAfiliadosResponse>
};

declare variable $getThirdPartyProductsForSaraResponse as element(ns8:GetThirdPartyProductsForSaraByDocumentNumberMessageOut) external;

xf:Tx_SaraServiceResponse_to_ConsultaProductosAfiliadosResponse($getThirdPartyProductsForSaraResponse)