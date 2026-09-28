xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$RSPConsultaServicioAfiliadosSara" element="ns8:GetSiteServicePaymentEntitiesForSaraByDocumentNumberMessageOut" location="../../../BusinessServices/ICB/SaraService/wsdl/saraSingleWSDL.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:consultaProductosAfiliadosResponse" location="../xsd/ConsultaListaServiciosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListaServicios/xq/ConsultaListaServiciosOUT";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ConsultaListaServiciosTypes";
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
declare namespace d4p1 = "urn:tailored.icbanking.businessentities.servicepayments";
declare namespace d6p1 = "urn:tailored.icbanking.businessentities.framework.tagging";
declare namespace ns13 ="urn:infocorp.framework.businessentities.tagging";
declare namespace i ="http://www.w3.org/2001/XMLSchema-instance";


(: Se encarga de calcular el tipo de Servicio :)
declare function calcServiceType($value as xs:string) as xs:string {
	if ($value = "0") then
		"BILL"
	else 
		"MANUAL"
};


declare function xf:ConsultaListaServiciosOUT($RSPConsultaListaServiciosSara as element(ns8:GetServicePaymentEntitiesWithTagsForSaraMessageOut))
    as element(ns2:consultaListaServiciosResponse) {
        <ns2:consultaListaServiciosResponse>
		{ if (fn:string($RSPConsultaListaServiciosSara/ns3:OperationResult/ns12:Value/text()) = "0" ) then (
		<SERVICES>
			{
			for $Service in $RSPConsultaListaServiciosSara/ns8:ServicePaymentEntities/d4p1:ServicePaymentEntityExtended
			return
				<SERVICE>
					<ID>{ data($Service/ns11:ServicePaymentEntityId) }</ID>
					<CONTRACT_ID>{ data($Service/ns11:ServicePaymentEntityBackendId) }</CONTRACT_ID>
					<DESCRIPTION>{ data($Service/ns11:Description) }</DESCRIPTION>
					<COUNTRY>{ data($Service/d4p1:Tags/d6p1:TagExtended[d6p1:parentTagId/@i:nil="true"]/ns13:Name/ns12:Languages/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</COUNTRY>
					<CATEGORIES>
						{ 
						for $Category in $Service/d4p1:Tags/d6p1:TagExtended[d6p1:parentTagId/text()]
						return
							<CATEGORY>
								<VALUE>{ data($Category/ns13:Name/ns12:Languages/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</VALUE>
								<SUBCATEGORIES>
									{
									for $Subcategory in $Service/d4p1:Tags/d6p1:TagExtended[d6p1:parentTagId= $Category/ns13:TagId]
									return
										<SUBCATEGORY>
											<VALUE>{ data($Subcategory/ns13:Name/ns12:Languages/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</VALUE>
											<SUBTYPES>
											{
											for $Subtype in $Service/d4p1:Tags/d6p1:TagExtended[d6p1:parentTagId= $Subcategory/ns13:TagId]
											return
												<SUBTYPE>
													<VALUE>{ data($Subcategory/ns13:Name/ns12:Languages/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</VALUE>
												</SUBTYPE>
											}
											</SUBTYPES>
										</SUBCATEGORY>
									}
								</SUBCATEGORIES>
							</CATEGORY>
						}
					</CATEGORIES>
				</SERVICE>
			}

		</SERVICES>
		) else ()}
	</ns2:consultaListaServiciosResponse>
};

declare variable $RSPConsultaListaServiciosSara as element(ns8:GetServicePaymentEntitiesWithTagsForSaraMessageOut) external;

xf:ConsultaListaServiciosOUT($RSPConsultaListaServiciosSara)