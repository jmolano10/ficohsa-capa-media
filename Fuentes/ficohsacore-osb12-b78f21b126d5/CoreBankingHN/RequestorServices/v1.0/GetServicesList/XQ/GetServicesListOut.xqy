xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getServicesListTypes";
(:: import schema at "../../../../../MWBanking/Services/RequestorServices/XSD/getServicesListTypes.xsd" ::)
declare namespace ns1="urn:tailored.icbanking.services.sara";
(:: import schema at "../../../../ProviderServices/WSDL/SaraService/SaraService.wsdl" ::)
declare namespace ns11 = "urn:infocorp.servicepayments.businessentities.servicepayments";
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare namespace d4p1 = "urn:tailored.icbanking.businessentities.servicepayments";
declare namespace d6p1 = "urn:tailored.icbanking.businessentities.framework.tagging";
declare namespace i ="http://www.w3.org/2001/XMLSchema-instance";
declare namespace ns13 ="urn:infocorp.framework.businessentities.tagging";
declare namespace ns12 = "urn:infocorp.framework.businessentities.common";
declare namespace ns7 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";

declare variable $uuid as xs:string external;
declare variable $SaraServiceResponse as element() (:: schema-element(ns1:GetServicePaymentEntitiesWithTagsForSaraMessageOut) ::) external;

(: Se encarga de calcular el tipo de Servicio :)
declare function local:calcServiceType($value as xs:string) as xs:string {
	if ($value = "0") then
		"BILL"
	else 
		"MANUAL"
};

declare function local:func($uuid as xs:string, $SaraServiceResponse as element() (:: schema-element(ns1:GetServicePaymentEntitiesWithTagsForSaraMessageOut) ::)) as element() (:: schema-element(ns2:GetServicesListRSP) ::) {
    <ns2:GetServicesListRSP>
        <StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </StatusInfo>
        <Services>
          {
                for $Service in $SaraServiceResponse/ns1:ServicePaymentEntities/d4p1:ServicePaymentEntityExtended
		return
                    <Service>
                        <Id>{ data($Service/ns11:ServicePaymentEntityId) }</Id>
                        <ContractId>{ data($Service/ns11:ServicePaymentEntityBackendId) }</ContractId>
                        <Description>{ data($Service/ns11:Description) }</Description>
                        <Country>{ data($Service/d4p1:Tags/d6p1:TagExtended[d6p1:parentTagId/@i:nil="true"]/ns13:Name/ns12:Languages/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</Country>
                        <Categories>
                            { 
                                for $Category in $Service/d4p1:Tags/d6p1:TagExtended[d6p1:parentTagId/text()]
                                return
                                    <Category>
                                        <Value>{ data($Category/ns13:Name/ns12:Languages/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</Value>
                                        <SubCategories>
                                          {
                                              for $Subcategory in $Service/d4p1:Tags/d6p1:TagExtended[d6p1:parentTagId= $Category/ns13:TagId]
                                              return
                                                  <SubCategory>
                                                      <Value>{ data($Subcategory/ns13:Name/ns12:Languages/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</Value>
                                                      <SubTypes>
                                                        {
                                                            for $Subtype in $Service/d4p1:Tags/d6p1:TagExtended[d6p1:parentTagId= $Subcategory/ns13:TagId]
                                                            return
                                                                <SubType>
                                                                    <Value>{ data($Subcategory/ns13:Name/ns12:Languages/ns7:KeyValueOfLanguagestringt0xKdhz5[ns7:Key/ns12:Value = 2]/ns7:Value) }</Value>
                                                                </SubType>
                                                        }
                                                      </SubTypes>
                                                  </SubCategory>
                                          }
                                        </SubCategories>
                                    </Category>
                              }
                        </Categories>
                    </Service>
          }
        </Services>
    </ns2:GetServicesListRSP>
};

local:func($uuid, $SaraServiceResponse)