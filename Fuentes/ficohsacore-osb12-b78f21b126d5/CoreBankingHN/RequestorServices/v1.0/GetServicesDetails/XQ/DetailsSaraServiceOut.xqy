xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getServicesDetailsTypes";
(:: import schema at "../../../../../MWBanking/Services/RequestorServices/XSD/getServicesDetailsTypes.xsd" ::)
declare namespace ns1="urn:tailored.icbanking.services.sara";
(:: import schema at "../../../../ProviderServices/WSDL/SaraService/SaraService.wsdl" ::)
declare namespace ns3 = "urn:infocorp.framework.services.common";
declare namespace ns12 = "urn:infocorp.framework.businessentities.common";
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare namespace ns11 = "urn:infocorp.servicepayments.businessentities.servicepayments";
declare namespace ns7 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace d4p1 = "urn:tailored.icbanking.businessentities.servicepayments";
declare namespace d8p1 ="urn:infocorp.framework.businessentities.scheduling";

declare variable $SaraServicesResponse as element() (:: schema-element(ns1:GetServicePaymentEntityForSaraByIdMessageOut) ::) external;
declare variable $uuid as xs:string external;

(: Se encarga de calcular el tipo de Servicio :)
declare function local:calcServiceType($value as xs:string) as xs:string {
	if ($value = "0") then
		"BILL"
	else 
		"MANUAL"
};

(: Se encarga de calcular el valor de AllowPartialPayment :)
declare function local:calcAllowPartialPayment($value as xs:string) as xs:string {
	if ($value = "false") then
		"NO"
	else 
		"YES"
};

(: Se encarga de calcular el valor de EnableCrossingCurrency :)
declare function local:calcEnableCrossingCurrency($value as xs:string) as xs:string {
	if ($value = "false") then
		"NO"
	else 
		"YES"
};

(: Se encarga de calcular el valor de EnableCrossingCurrency :)
declare function local:calcEnableCatalog($value as xs:string) as xs:string {
	if ($value = "false") then
		"NO"
	else 
		"YES"
};

(: Se encarga de calcular el valor de Dia :)
declare function local:calcDay($value as xs:string) as xs:string {
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
declare function local:calcProductName($value as xs:string) as xs:string {
	if ($value = "1") then
		"Checking"
	else if ($value = "2") then
		"Savings"
	else if ($value = "3") then
		"Credit Card"
	else 
		""
};

declare function local:func($SaraServicesResponse as element() (:: schema-element(ns1:GetServicePaymentEntityForSaraByIdMessageOut) ::), 
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns2:GetServicesDetailsRSP) ::) {
    <ns2:GetServicesDetailsRSP>
    <StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </StatusInfo>
    {
      if(fn:string($SaraServicesResponse/ns3:OperationResult/ns12:Value/text()) = "0")then(
        <ServiceInfo>
            <ID>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentEntityId) }</ID>
            <ContractID>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentEntityBackendId) }</ContractID>
            <Type>{ local:calcServiceType(xs:string($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentEntityType/ns12:Value)) }</Type>
            <IsDataConfig>
                {
                    let $respuesta := ""
                    return(
                      if($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField) 
                      then ("YES")
                      else ("NO")
                    )
                }
            </IsDataConfig>
            <Description>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:Description) }</Description>
        </ServiceInfo>
      )else()
    }
    {
      if(fn:string($SaraServicesResponse/ns3:OperationResult/ns12:Value/text()) = "0")then(
          <ServiceDetails>
            <ServiceFields>
              {
                  for $ServiceField in $SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentSubscribibleDataInputConfig/ns12:DataField
                  return
                    <ServiceField>
                    <Name>{ data($ServiceField/ns12:Name) }</Name>
                    <Description>{ data($ServiceField/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</Description>
                    <EnableCatalog>{ local:calcEnableCatalog(xs:string($ServiceField/ns12:IsCatalog)) }</EnableCatalog>
                    {
                      if(local:calcEnableCatalog(xs:string($ServiceField/ns12:IsCatalog)) = "YES")then(
                          <CatalogItems>
                            {
                              for $Item in $ServiceField/ns12:CatalogItems/ns12:CatalogItem
                              return
                                <Items>
                                  <Description>{data($Item/ns12:Text/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value)}</Description>
                                  <Value>{data($Item/ns12:Value/ns12:ExtendedPropertyValue) }</Value>
                              </Items>
                            }
                          </CatalogItems>
                      )else()
                    }
                </ServiceField>
              }
            </ServiceFields>
            {
              if($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField)then(
                  <ServiceDataInputConfig>
                    {
                      for $ServiceField at $count in $SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServicePaymentVariableDataInputConfig/ns12:DataField
                      return
                        if($count = 1)then(
                            <ServiceData>
                                <Name>{data($ServiceField/ns12:HelpText/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</Name>
                                <Value>
                                    {
                                          for $value in $SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ConceptualFieldsWithFixedValue/ns7:KeyValueOfstringdouble
                                          return
                                            data($value[ns7:Key = $ServiceField/ns12:Name/text()]/ns7:Value)
                                    }
                                </Value>
                                <EnableCatalog>{ local:calcEnableCatalog(xs:string($ServiceField/ns12:IsCatalog)) }</EnableCatalog>
                                {
                                    if(local:calcEnableCatalog(xs:string($ServiceField/ns12:IsCatalog)) = "YES")then(
                                        <CatalogItems>
                                          {
                                            for $Item in $ServiceField/ns12:CatalogItems/ns12:CatalogItem
                                            return
                                              <Items>
                                                  <Description>{data($Item/ns12:Text/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value)}</Description>
                                                  <Value>{data($Item/ns12:Value/ns12:ExtendedPropertyValue) }</Value>
                                              </Items>
                                          }
                                        </CatalogItems>
                                    )else()
                                }
                            </ServiceData>
                        )else(
                            <ServiceData>
                                <Name>{data($ServiceField/ns12:Label/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</Name>
                                <Value>
                                {
                                      for $value in $SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ConceptualFieldsWithFixedValue/ns7:KeyValueOfstringdouble
                                      return
                                        data($value[ns7:Key = $ServiceField/ns12:Name/text()]/ns7:Value)
                                }
                                </Value>
                            </ServiceData>
                        )
                    }
                  </ServiceDataInputConfig>
              )else()
            }
        </ServiceDetails>
      )else()
    }
    {
      if(fn:string($SaraServicesResponse/ns3:OperationResult/ns12:Value/text()) = "0")then(
          <InfoAditionalService>
              <AvaliableProductsPayment>
              {
              for $AvailableProduct in $SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:AvailableProductTypes/ns7:string
              return
                <AvaliableProduct>
                    <Code>{ data($AvailableProduct) }</Code>
                    <Description>{ local:calcProductName($AvailableProduct) }</Description>
                </AvaliableProduct>
              }
            </AvaliableProductsPayment>
            <AllowPartialPayment>{ local:calcAllowPartialPayment(xs:string($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:AllowPartialPayment)) }</AllowPartialPayment>
            <EnableCrossingCurrency>{ local:calcEnableCrossingCurrency($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "EnabledCrossingCurrency"]/ns7:Value/ns12:ExtendedPropertyValue) }</EnableCrossingCurrency>
            <AvaliableCurrency>
            {
              if(local:calcServiceType(xs:string($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentEntityType/ns12:Value)) = "MANUAL")then(
                  for $x in 1 to fn:count($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServiceCurrency/ns7:int)	
                  return
                      <Currency>
                        <Code>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentDataConfig/ns11:ServiceCurrency/ns7:int[$x]) }</Code>
                        <Description>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/d4p1:ServiceCurrenciesAllowedForManualPayment/ns7:string[$x]) }</Description>
                      </Currency>
              )else(
                  for $j in 1 to fn:count($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "ServicePaymentCurrency"])	
                  return
                    <Currency>
                      <Code>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "ServicePaymentCurrency"][$j]/ns7:Value/ns12:ExtendedPropertyValue) }</Code>
                      <Description>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ExtendedProperties/ns7:KeyValueOfstringExtendedPropertyValueEPwN05B4[ns7:Key = "ServicePaymentCurrencyDescription"][$j]/ns7:Value/ns12:ExtendedPropertyValue) }</Description>
                    </Currency>
              )
            }
            </AvaliableCurrency>
            {
              if($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction)then(
                  <TimeRestriction>
                      <Id>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:SelectionType/ns12:Value) }</Id>
                      <Name>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:RestrictionName) }</Name>
                      <HoursDuration>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:Duration) }</HoursDuration>
                      <Frequency>
                          <Hours>{ data($SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:Frequency/d8p1:HourlyExpression/d8p1:SpecificValues/ns7:int) }</Hours>
                          <Weekly>
                            {
                              for $Day in $SaraServicesResponse/ns1:ServicePaymentEntity/ns11:ServicePaymentValidationData/ns11:ServiceTimeRestrictions/ns11:ServicePaymentTimeRestriction/ns11:Frequency/d8p1:WeeklyExpression/d8p1:SpecificValues/d8p1:FrequencyWeekDay
                              return
                                <Days>
                                  <Day>{ local:calcDay(xs:string($Day/ns12:Value)) }</Day>
                                </Days>
                            }
                          </Weekly>
                      </Frequency>
                  </TimeRestriction>
              )else()
            }
            
        </InfoAditionalService>
      )else()
    }
    </ns2:GetServicesDetailsRSP>
};

local:func($SaraServicesResponse, $uuid)