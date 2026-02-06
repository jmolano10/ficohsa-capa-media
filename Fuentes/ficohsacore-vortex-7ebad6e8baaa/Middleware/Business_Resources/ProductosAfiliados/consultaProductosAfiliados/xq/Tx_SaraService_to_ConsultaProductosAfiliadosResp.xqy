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
declare namespace ns11 = "urn:infocorp.framework.businessentities.thirdpartyproducts";
declare namespace ns12 = "urn:infocorp.framework.businessentities.common";

(: Se encarga de calcular el productType :)
declare function calcProductType($operationType as xs:string) as xs:string {
	if ($operationType = "AHO") then
		"Cuenta de ahorros"
	else if  ($operationType = "CHQ") then
		"Cuenta de cheques"
	else if  ($operationType = "TRC") then
		"Tarjeta de crédito"
	else if  ($operationType = "PRT") then
		"Prestamo"
	else 
		""
};

(: Se encarga de calcular el productTypeAbr :)
declare function calcProductTypeAbr($productType as xs:string) as xs:string {
	if ($productType = "Cuenta de ahorros") then
		"AHO"
	else if  ($productType = "Cuenta de cheques") then
		"CHQ"
	else if  ($productType = "Tarjeta de crédito") then
		"TRC"
	else if  ($productType = "Prestamo") then
		"PRT"
	else 
		""
};

declare function xf:Tx_SaraService_to_ConsultaProductosAfiliadosResp($getThirdPartyProductsForSaraResponse as element(ns8:GetThirdPartyProductsForSaraByDocumentNumberMessageOut), $operationType as xs:string)
    as element(ns2:consultaProductosAfiliadosResponse) {
        <ns2:consultaProductosAfiliadosResponse>
		{if (xs:string($operationType) = "ALL" and fn:exists(xs:string($getThirdPartyProductsForSaraResponse/ns8:ThirdPartyProducts))) then (
		<ns2:PRODUCTS>
			{
			for $Product in $getThirdPartyProductsForSaraResponse/ns8:ThirdPartyProducts/ns11:ThirdPartyProduct
			return 
				<ns2:PRODUCT>
					<ns2:DESTINATION>
						<ns2:COUNTRY>{ data($Product/ns11:Subsidiary/ns12:SubsidiaryName) }</ns2:COUNTRY>
						<ns2:PRODUCT_TYPE>{ calcProductTypeAbr(data($Product/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4/ns7:Value/ns12:ExtendedPropertyValue)) }</ns2:PRODUCT_TYPE>
					</ns2:DESTINATION>
					<ns2:PRODUCT_ID>{ data($Product/ns11:ThirdPartyProductNumber) }</ns2:PRODUCT_ID>
					<ns2:NAME>{ data($Product/ns11:OwnerName) }</ns2:NAME>
					<ns2:ALIAS>{ data($Product/ns11:Alias) }</ns2:ALIAS>
					<ns2:EMAIL>{ data($Product/ns11:OwnerEmail) }</ns2:EMAIL>
					<ns2:CURRENCY>{ data($Product/ns11:Currency/ns12:CurrencyAlpha3Code) }</ns2:CURRENCY>
				</ns2:PRODUCT>
			}
		</ns2:PRODUCTS>
		) else if (fn:exists(xs:string($getThirdPartyProductsForSaraResponse/ns8:ThirdPartyProducts)))then(
		<ns2:PRODUCTS>
			{
			for $Product in $getThirdPartyProductsForSaraResponse/ns8:ThirdPartyProducts/ns11:ThirdPartyProduct[ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4/ns7:Value/ns12:ExtendedPropertyValue = calcProductType($operationType)]
			return 
				<ns2:PRODUCT>
					<ns2:DESTINATION>
						<ns2:COUNTRY>{ data($Product/ns11:Subsidiary/ns12:SubsidiaryName) }</ns2:COUNTRY>
						<ns2:PRODUCT_TYPE>{ calcProductTypeAbr(data($Product/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4/ns7:Value/ns12:ExtendedPropertyValue)) }</ns2:PRODUCT_TYPE>
					</ns2:DESTINATION>
					<ns2:PRODUCT_ID>{ data($Product/ns11:ThirdPartyProductNumber) }</ns2:PRODUCT_ID>
					<ns2:NAME>{ data($Product/ns11:OwnerName) }</ns2:NAME>
					<ns2:ALIAS>{ data($Product/ns11:Alias) }</ns2:ALIAS>
					<ns2:EMAIL>{ data($Product/ns11:OwnerEmail) }</ns2:EMAIL>
					<ns2:CURRENCY>{ data($Product/ns11:Currency/ns12:CurrencyAlpha3Code) }</ns2:CURRENCY>
				</ns2:PRODUCT>
			}
		</ns2:PRODUCTS>
		) else()}
	</ns2:consultaProductosAfiliadosResponse>
};

declare variable $getThirdPartyProductsForSaraResponse as element(ns8:GetThirdPartyProductsForSaraByDocumentNumberMessageOut) external;
declare variable $operationType as xs:string external;
declare variable $productType as xs:string external;

xf:Tx_SaraService_to_ConsultaProductosAfiliadosResp($getThirdPartyProductsForSaraResponse, $operationType)