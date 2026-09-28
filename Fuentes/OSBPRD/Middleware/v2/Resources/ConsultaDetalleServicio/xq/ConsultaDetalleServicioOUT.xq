xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$RSPConsultaServicioAfiliadosSara" element="ns8:GetSiteServicePaymentEntitiesForSaraByDocumentNumberMessageOut" location="../../../BusinessServices/ICB/SaraService/wsdl/saraSingleWSDL.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:consultaProductosAfiliadosResponse" location="../xsd/ConsultaDetalleServicioTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleServicio/xq/ConsultaDetalleServicioOUT";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ConsultaDetalleServicioTypes";
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
declare namespace d8p1 ="urn:infocorp.framework.businessentities.scheduling";


(: Se encarga de calcular el tipo de Servicio :)
declare function calcServiceType($value as xs:string) as xs:string {
	if ($value = "0") then
		"BILL"
	else 
		"MANUAL"
};

(: Se encarga de calcular el valor de AllowPartialPayment :)
declare function calcAllowPartialPayment($value as xs:string) as xs:string {
	if ($value = "false") then
		"NO"
	else 
		"YES"
};

(: Se encarga de calcular el valor de EnableCrossingCurrency :)
declare function calcEnableCrossingCurrency($value as xs:string) as xs:string {
	if ($value = "false") then
		"NO"
	else 
		"YES"
};

(: Se encarga de calcular el valor de EnableCrossingCurrency :)
declare function calcEnableCatalog($value as xs:string) as xs:string {
	if ($value = "false") then
		"NO"
	else 
		"YES"
};

(: Se encarga de calcular el valor de Dia :)
declare function calcDay($value as xs:string) as xs:string {
	if ($value = "1") then
		"Domingo"
	else if ($value = "2") then
		"Lunes"
	else if ($value = "3") then
		"Martes"
	else if ($value = "4") then
		"Miercoles"
	else if ($value = "5") then
		"Jueves"
	else if ($value = "6") then
		"Viernes"
	else 
		"Sabado"
};

(: Se encarga de calcular el valor de Dia :)
declare function calcProductName($value as xs:string) as xs:string {
	if ($value = "1") then
		"Checking"
	else if ($value = "2") then
		"Savings"
	else if ($value = "3") then
		"Credit Card"
	else 
		""
};


declare function xf:ConsultaDetalleServicioOUT($RSPServicioSara as element(ns8:GetServicePaymentEntityForSaraByIdMessageOut))
    as element(ns2:consultaDetalleServicioResponse) {
        <ns2:consultaDetalleServicioResponse>
		{ if (fn:string($RSPServicioSara/ns3:OperationResult/ns12:Value/text()) = "0" ) then (
		<SERVICE_INFO>
			<ID>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentEntityId) }</ID>
			<CONTRACT_ID>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentEntityBackendId) }</CONTRACT_ID>
			<TYPE>{ calcServiceType($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentEntityType/ns12:Value) }</TYPE>
		        <IS_DATA_CONFIG>
                           {
                              let $respuesta := ""
                               return(
                               if($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField) 
                                then ("YES")
                                else ("NO")
                              )
                           }
                        </IS_DATA_CONFIG>
                        <DESCRIPTION>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:Description) }</DESCRIPTION>
		</SERVICE_INFO>
		) else ()}
		{ if (fn:string($RSPServicioSara/ns3:OperationResult/ns12:Value/text()) = "0" ) then (
		<SERVICE_DETAILS>
			<SERVICE_FIELDS>
			{
			for $ServiceField in $RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentSubscribibleDataInputConfig/ns12:DataField
			return
				<SERVICE_FIELD>
					<NAME>{ data($ServiceField/ns12:Name) }</NAME>
					<DESCRIPTION>{ data($ServiceField/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</DESCRIPTION>
					<ENABLE_CATALOG>{ calcEnableCatalog($ServiceField/ns12:IsCatalog) }</ENABLE_CATALOG>
					{ if (calcEnableCatalog($ServiceField/ns12:IsCatalog) = "YES" ) then (
					<CATALOG_ITEMS>
						{ 
						for $Item in $ServiceField/ns12:CatalogItems/ns12:CatalogItem
						return
							<ITEMS>
								<DESCRIPTION>{data($Item/ns12:Text/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value)}</DESCRIPTION>
								    <VALUE>{data($Item/ns12:Value/ns12:ExtendedPropertyValue) }</VALUE>
							</ITEMS>
						}
					</CATALOG_ITEMS>
					) else ()}
				</SERVICE_FIELD>
			}
			</SERVICE_FIELDS>
                        {if ($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField) then (
                                <SERVICE_DATA_INPUT_CONFIG>
				        {
					        for $ServiceField at $count in $RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField
						return
							if ($count = 1) then (
								<DATA_SERVICE>
									<NAME>
										{data($ServiceField/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }
									</NAME>
									<VALUE>
										{
											for $value in $RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ConceptualFieldsWithFixedValue/ns7:KeyValueOfstringdouble
											return
												data($value[ns7:Key = $ServiceField/ns12:Name/text()]/ns7:Value)
										}
									</VALUE>
									<ENABLE_CATALOG>{ calcEnableCatalog($ServiceField/ns12:IsCatalog) }</ENABLE_CATALOG>
					                   { if (calcEnableCatalog($ServiceField/ns12:IsCatalog) = "YES" ) then (
					                 <CATALOG_ITEMS>
					           	{ 
						         for $Item in $ServiceField/ns12:CatalogItems/ns12:CatalogItem
						         return
							     <ITEMS>
							      	<DESCRIPTION>{data($Item/ns12:Text/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value)}</DESCRIPTION>
								    <VALUE>{data($Item/ns12:Value/ns12:ExtendedPropertyValue) }</VALUE>
							    </ITEMS>
						}
					</CATALOG_ITEMS>
					) else ()}
								</DATA_SERVICE>
							) else (
								<DATA_SERVICE>
									<NAME>
										{data($ServiceField/ns12:Label/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }
									</NAME>
									<VALUE>
										{
											for $value in $RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ConceptualFieldsWithFixedValue/ns7:KeyValueOfstringdouble
											return
												data($value[ns7:Key = $ServiceField/ns12:Name/text()]/ns7:Value)
										}
									</VALUE>
								</DATA_SERVICE>
							)
					}
                		</SERVICE_DATA_INPUT_CONFIG>

                )else ()}
		</SERVICE_DETAILS>
		) else ()}
		{ if (fn:string($RSPServicioSara/ns3:OperationResult/ns12:Value/text()) = "0" ) then (
		<INFO_ADITIONAL_SERVICE>
			<AVALIABLE_PRODUCTS_PAYMENT>
			{
			for $AvailableProduct in $RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:AvailableProductTypes/ns7:string
			return
				<AVALIABLE_PRODUCT>
					<CODE>{ data($AvailableProduct) }</CODE>
					<DESCRIPTION>{ calcProductName($AvailableProduct) }</DESCRIPTION>
				</AVALIABLE_PRODUCT>
			}
			</AVALIABLE_PRODUCTS_PAYMENT>
			<ALLOW_PARTIAL_PAYMENT>{ calcAllowPartialPayment($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:AllowPartialPayment) }</ALLOW_PARTIAL_PAYMENT>
			<ENABLE_CROSSING_CURRENCY>{ calcEnableCrossingCurrency($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "EnabledCrossingCurrency"]/ns7:Value/ns12:ExtendedPropertyValue) }</ENABLE_CROSSING_CURRENCY>
			<AVALIABLE_CURRENCY>
			{
			if (calcServiceType($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentEntityType/ns12:Value) = "MANUAL") then (
				for $x in 1 to fn:count($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServiceCurrency/ns7:int)	
				return
				<CURRENCY>
					<CODE>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServiceCurrency/ns7:int[$x]) }</CODE>
					<DESCRIPTION>{ data($RSPServicioSara/ns8:ServicePaymentEntity/d4p1:ServiceCurrenciesAllowedForManualPayment/ns7:string[$x]) }</DESCRIPTION>
					
				</CURRENCY>
			) else (
				for $j in 1 to fn:count($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "ServicePaymentCurrency"])	
				return
				<CURRENCY>
					<CODE>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "ServicePaymentCurrency"][$j]/ns7:Value/ns12:ExtendedPropertyValue) }</CODE>
					<DESCRIPTION>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "ServicePaymentCurrencyDescription"][$j]/ns7:Value/ns12:ExtendedPropertyValue) }</DESCRIPTION>
				</CURRENCY>
			)}
			</AVALIABLE_CURRENCY>
			{ if ($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction) then (
			<TIME_RESTRICTION>
				<ID>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:SelectionType/ns12:Value) }</ID>
				<NAME>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:RestrictionName) }</NAME>
				<HOURS_DURATION>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:Duration) }</HOURS_DURATION>
				<FREQUENCY>
					<HOURS>{ data($RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:Frequency/d8p1:HourlyExpression/d8p1:SpecificValues/ns7:int) }</HOURS>
					<WEEKLY>
					{
					for $Day in $RSPServicioSara/ns8:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:Frequency/d8p1:WeeklyExpression/d8p1:SpecificValues/d8p1:FrequencyWeekDay
					return
						<DAYS>
							<DAY>{ calcDay($Day/ns12:Value) }</DAY>
						</DAYS>
					}
					</WEEKLY>
				</FREQUENCY>
			</TIME_RESTRICTION>
			) else ()}
		</INFO_ADITIONAL_SERVICE>
		) else ()}
	</ns2:consultaDetalleServicioResponse>
};

declare variable $RSPServicioSara as element(ns8:GetServicePaymentEntityForSaraByIdMessageOut) external;

xf:ConsultaDetalleServicioOUT($RSPServicioSara)