xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$RSPConsultaServicioAfiliadosSara" element="ns8:GetSiteServicePaymentEntitiesForSaraByDocumentNumberMessageOut" location="../../../BusinessServices/ICB/SaraService/wsdl/saraSingleWSDL.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:consultaProductosAfiliadosResponse" location="../xsd/ConsultaDetalleServiciosAfiliadosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ServiciosAfiliados/ConsultaServiciosAfiliados/xq/Tx_SaraServiceResponse_to_ConsultaProductosAfiliadosResponse/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/ConsultaDetalleServiciosAfiliadosTypes";
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
declare namespace d8p1 ="urn:infocorp.framework.businessentities.scheduling";
declare namespace d5p1 ="urn:tailored.icbanking.businessentities.servicepayments";


(: Se encarga de calcular el tipo de Servicio :)
declare function calcServiceType($value as xs:string) as xs:string {
	if ($value = "0") then
		"BILL"
	else 
		"MANUAL"
};

(: Se encarga de calcular si es catalogo :)
declare function calcIsCatalog($value as xs:string) as xs:string {
	if ($value = "false") then
		"NO"
	else 
		"YES"
};

(: Se encarga de calcular si se permite pago parcial :)
declare function calcAllowPartialPayment($value as xs:string) as xs:string {
	if ($value = "false") then
		"NO"
	else 
		"YES"
};

(: Se encarga de calcular si se permite pago parcial :)
declare function calcEnableCrossingCurrency($value as xs:string) as xs:string {
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


declare function xf:ConsultaServiciosAfiliadosOUT($RSPConsultaDetalleServicioAfiliadosSara as element(ns8:GetSiteServicePaymentEntitiesForSaraByIdMessageOut))
    as element(ns2:consultaDetalleServiciosAfiliadosResponse) {
        <ns2:consultaDetalleServiciosAfiliadosResponse>
		{ if (fn:string($RSPConsultaDetalleServicioAfiliadosSara/ns3:OperationResult/ns12:Value/text()) = "0" ) then (
		<SERVICE_INFO>
			<SITE_ID>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:SiteServicePaymentEntityId) }</SITE_ID>
			<ID>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentEntityId) }</ID>
			<CONTRACT_ID>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentEntityBackendId) }</CONTRACT_ID>
			<TYPE>{ calcServiceType(data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentEntityType/ns12:Value)) }</TYPE>
                         <IS_DATA_CONFIG>
                           {
                              let $respuesta := ""
                               return(
                               if($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField) 
                                then ("YES")
                                else ("NO")
                              )
                           }
                        </IS_DATA_CONFIG>
			<DESCRIPTION>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:Description) }</DESCRIPTION>
			<CUSTOMER_DESCRIPTION>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:Description) }</CUSTOMER_DESCRIPTION>
		</SERVICE_INFO>
		) else ()}
		{ if (fn:string($RSPConsultaDetalleServicioAfiliadosSara/ns3:OperationResult/ns12:Value/text()) = "0" ) then (
		<SERVICE_DETAILS>
			<SERVICE_FIELDS>
				{
				for $ServiceField  at $count in $RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentSubscribibleDataInputConfig/ns12:DataField
				return
				if ($count = 1) then (
				if (calcIsCatalog($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentSubscribibleDataInputConfig/ns12:DataField[ns12:Name = $ServiceField/ns12:Name]/ns12:IsCatalog) = "YES") then (
			     		<SERVICE_FIELD>
						<NAME>{ data($ServiceField/ns12:Name) }</NAME>
						<DESCRIPTION>{ data($ServiceField/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</DESCRIPTION>
						<ENABLE_CATALOG>{ calcIsCatalog($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentSubscribibleDataInputConfig/ns12:DataField[ns12:Name = $ServiceField/ns12:Name]/ns12:IsCatalog) }</ENABLE_CATALOG>
						<CATALOG_ITEMS>
							{for $CatalogItem in $RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentSubscribibleDataInputConfig/ns12:DataField[ns12:Name = $ServiceField/ns12:Name]/ns12:CatalogItems/ns12:CatalogItem
							return
								<ITEMS>
									<DESCRIPTION>{ data($CatalogItem/ns12:Text) }</DESCRIPTION>
									<VALUE>{ data($CatalogItem/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</VALUE>
								</ITEMS>
							}
						</CATALOG_ITEMS>
					</SERVICE_FIELD>
				) else (
				     	<SERVICE_FIELD>
						<NAME>{ data($ServiceField/ns12:Name) }</NAME>
						<DESCRIPTION>{ data($ServiceField/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</DESCRIPTION>
						<ENABLE_CATALOG>{ calcIsCatalog($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentSubscribibleDataInputConfig/ns12:DataField[ns12:Name = $ServiceField/ns12:Name]/ns12:IsCatalog) }</ENABLE_CATALOG>
					</SERVICE_FIELD>
				)
				)
				else(
				if (calcIsCatalog($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField[ns12:Name = $ServiceField/ns12:Name]/ns12:IsCatalog) = "YES") then (
			     		<SERVICE_FIELD>
						<NAME>{ data($ServiceField/ns12:Name) }</NAME>
						<DESCRIPTION>{ data($ServiceField/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</DESCRIPTION>
						<ENABLE_CATALOG>{ calcIsCatalog($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField[ns12:Name = $ServiceField/ns12:Name]/ns12:IsCatalog) }</ENABLE_CATALOG>
						<CATALOG_ITEMS>
							{for $CatalogItem in $RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField[ns12:Name = $ServiceField/ns12:Name]/ns12:CatalogItems/ns12:CatalogItem
							return
								<ITEMS>
									<DESCRIPTION>{ data($CatalogItem/ns12:Text) }</DESCRIPTION>
									<VALUE>{ data($CatalogItem/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</VALUE>
								</ITEMS>
							}
						</CATALOG_ITEMS>
					</SERVICE_FIELD>
				) else (
				     	<SERVICE_FIELD>
						<NAME>{ data($ServiceField/ns12:DataField/ns12:Name) }</NAME>
						<DESCRIPTION>{ data($ServiceField/ns12:DataField/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</DESCRIPTION>
						<ENABLE_CATALOG>{ calcIsCatalog($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentSubscribibleDataInputConfig/ns12:DataField[ns12:Name = $ServiceField/ns12:DataField/ns12:Name]/ns12:IsCatalog) }</ENABLE_CATALOG>
					</SERVICE_FIELD>
				)
				)
				
				}
			</SERVICE_FIELDS>
			<DATA_SERVICES>
				{
				for $PaymentData in $RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntitySuscriptionData/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4
				return 
					<DATA_SERVICE>
						<NAME>{ data($PaymentData/ns7:Key) }</NAME>
						<VALUE>{ data($PaymentData/ns7:Value/ns12:ExtendedPropertyValue) }</VALUE>
					</DATA_SERVICE>
				}
			</DATA_SERVICES>
                        {
                          if ($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField) then (
                                <SERVICE_DATA_INPUT_CONFIG>
					{
						for $ServiceField at $count in $RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField
						return
							if ($count = 1) then (
								<DATA_SERVICE>
									<NAME>
										{data($ServiceField/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }
									</NAME>
									<VALUE>
										{
											for $value in $RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ConceptualFieldsWithFixedValue/ns7:KeyValueOfstringdouble
											return
												data($value[ns7:Key = $ServiceField/ns12:Name/text()]/ns7:Value)
										}
									</VALUE>
									<ENABLE_CATALOG>{ calcIsCatalog($ServiceField/ns12:IsCatalog) }</ENABLE_CATALOG>
					                   { if (calcIsCatalog($ServiceField/ns12:IsCatalog) = "YES" ) then (
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
											for $value in $RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ConceptualFieldsWithFixedValue/ns7:KeyValueOfstringdouble
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
		{ if (fn:string($RSPConsultaDetalleServicioAfiliadosSara/ns3:OperationResult/ns12:Value/text()) = "0" ) then (
		<INFO_ADITIONAL_SERVICE>
			<AVALIABLES_PRODUCTS_PAYMENT>
				{
				for $AvailableProduct in $RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:AvailableProductTypes/ns7:string
				return 
					<AVALIABLE_PRODUCT>
						<CODE>{ data($AvailableProduct) }</CODE>
						<DESCRIPTION>{ calcProductName($AvailableProduct) }</DESCRIPTION>
					</AVALIABLE_PRODUCT>
				}
			</AVALIABLES_PRODUCTS_PAYMENT>
			<ALLOW_PARTIAL_PAYMENT>{ calcAllowPartialPayment($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:AllowPartialPayment) }</ALLOW_PARTIAL_PAYMENT>
			<ENABLE_CROSSING_CURRENCY>{ calcEnableCrossingCurrency($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "EnabledCrossingCurrency"]/ns7:Value/ns12:ExtendedPropertyValue) }</ENABLE_CROSSING_CURRENCY>
			<AVALIABLE_CURRENCY>
				{ if (calcServiceType(data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentEntityType/ns12:Value)) = "MANUAL") then (
					for $x in 1 to fn:count($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServiceCurrency/ns7:int)	
					return
					<CURRENCY>
						<CODE>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServiceCurrency/ns7:int[$x]) }</CODE>
						<DESCRIPTION>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/d5p1:ServiceCurrenciesAllowedForManualPayment/ns7:string[$x]) }</DESCRIPTION>
					</CURRENCY>
				) else (
					for $j in 1 to fn:count($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "ServicePaymentCurrency"])	
					return
					<CURRENCY>
						<CODE>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "ServicePaymentCurrency"][$j]/ns7:Value/ns12:ExtendedPropertyValue) }</CODE>
						<DESCRIPTION>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "ServicePaymentCurrencyDescription"][$j]/ns7:Value/ns12:ExtendedPropertyValue) }</DESCRIPTION>
					</CURRENCY>	
				)}
			</AVALIABLE_CURRENCY>
			{ if ($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction) then (
			<TIME_RESTRICTION>
				<ID>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:SelectionType/ns12:Value) }</ID>
				<NAME>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:RestrictionName) }</NAME>
				<HOURS_DURATION>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:Duration) }</HOURS_DURATION>
				<FREQUENCY>
					<HOURS>{ data($RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:Frequency/d8p1:HourlyExpression/d8p1:SpecificValues/ns7:int) }</HOURS>
					<WEEKLY>
					{
					for $Day in $RSPConsultaDetalleServicioAfiliadosSara/ns8:SiteServicePaymentEntity/ns11:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:Frequency/d8p1:WeeklyExpression/d8p1:SpecificValues/d8p1:FrequencyWeekDay
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
		) else()}
	</ns2:consultaDetalleServiciosAfiliadosResponse>
};

declare variable $RSPConsultaDetalleServicioAfiliadosSara as element(ns8:GetSiteServicePaymentEntitiesForSaraByIdMessageOut) external;

xf:ConsultaServiciosAfiliadosOUT($RSPConsultaDetalleServicioAfiliadosSara)