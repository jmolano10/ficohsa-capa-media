xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypesNI";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/createCustomerNI.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateCustomer_BS";
(:: import schema at "../../../../../ProviderServices/XSD/CreateCustomer/CreateCustomer_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogsEquivalence";
(:: import schema at "../../../../../../CoreBankingHN/ProviderServices/XSD/GetCatalogsEquivalence/GetCatalogsEquivalence_sp.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";


declare variable $customerId as xs:string external;
declare variable $createCustomerRequest as element() (:: schema-element(ns1:createCustomerRequest) ::) external;
declare variable $GetCatalogsEquivalenceResponse as element() (:: schema-element(ns3:OutputParameters) ::) external;

declare function local:CatalogValueOSBToAPP($value as xs:string,
	$application as xs:string,
	$catalogId as xs:string,
	$catalogEquivalencies as element(*)
) as xs:string {
	let $responseCatalog := $catalogEquivalencies/ns3:PT_EQUIVALENCIAS_SALIDA/ns3:PT_EQUIVALENCIAS_SALIDA_ITEM[ns3:CATALOGO_ID = $catalogId and 
                                                     ns3:EQUIVALENCIAS/ns3:EQUIVALENCIAS_ITEM/ns3:APLICACION = $application and 
                                                              ns3:VALOR_CATALOGO = $value]
															  
	let $return := fn:string($responseCatalog[1]/ns3:EQUIVALENCIAS/ns3:EQUIVALENCIAS_ITEM/ns3:VALOR_EQUIVALENCIA/text())
	return
		if($return != "") then (
			$return
		) else (
			$value
		)
};

declare function local:func($createCustomerRequest as element() (:: schema-element(ns1:createCustomerRequest) ::),
                            $GetCatalogsEquivalenceResponse as element() (:: schema-element(ns3:OutputParameters) ::),
                            $customerId as xs:string) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {                          
    <ns2:InputParameters>
        {
            if ($createCustomerRequest/ns1:GeneralInfo/com:SourceBank)
            then <ns2:i_SourceBank>{fn:data($createCustomerRequest/ns1:GeneralInfo/com:SourceBank)}</ns2:i_SourceBank>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:GeneralInfo/com:DestinationBank)
            then <ns2:i_DestinationBank>{fn:data($createCustomerRequest/ns1:GeneralInfo/com:DestinationBank)}</ns2:i_DestinationBank>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:GeneralInfo/com:GlobalId)
            then <ns2:i_GlobalId>{fn:data($createCustomerRequest/ns1:GeneralInfo/com:GlobalId)}</ns2:i_GlobalId>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:GeneralInfo/com:ApplicationId)
            then <ns2:i_ApplicationId>{fn:data($createCustomerRequest/ns1:GeneralInfo/com:ApplicationId)}</ns2:i_ApplicationId>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:GeneralInfo/com:ApplicationUser)
            then <ns2:i_ApplicationUser>{fn:data($createCustomerRequest/ns1:GeneralInfo/com:ApplicationUser)}</ns2:i_ApplicationUser>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:GeneralInfo/com:BranchId)
            then <ns2:i_BranchId>{fn:data($createCustomerRequest/ns1:GeneralInfo/com:BranchId)}</ns2:i_BranchId>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:GeneralInfo/com:TransactionDate)
            then <ns2:i_TransactionDate>{fn:data($createCustomerRequest/ns1:GeneralInfo/com:TransactionDate)}</ns2:i_TransactionDate>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:GeneralInfo/com:Language)
            then <ns2:i_Lang>{fn:data($createCustomerRequest/ns1:GeneralInfo/com:Language)}</ns2:i_Lang>
            else ()
        }
        <ns2:i_Type>{fn:data($createCustomerRequest/ns1:Type)}</ns2:i_Type>
        <ns2:i_DocumentName>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:DocumentName)}</ns2:i_DocumentName>
        <ns2:i_LegalId>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:LegalId)}</ns2:i_LegalId>
        <ns2:i_DateOfIssuance>{fn-bea:date-to-string-with-format("yyyyMMdd", xs:date(fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:DateOfIssuance))) }</ns2:i_DateOfIssuance>
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:MaturityDate)
            then <ns2:i_MaturityDate>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:MaturityDate)}</ns2:i_MaturityDate>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:FirstName)
            then <ns2:i_FirstName>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:FirstName)}</ns2:i_FirstName>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:SecondName)
            then <ns2:i_SecondName>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:SecondName)}</ns2:i_SecondName>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ThirdName)
            then <ns2:i_ThirdName>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ThirdName)}</ns2:i_ThirdName>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:FirstLastName)
            then <ns2:i_FirstLastName>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:FirstLastName)}</ns2:i_FirstLastName>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:SecondLastName)
            then <ns2:i_SecondLastName>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:SecondLastName)}</ns2:i_SecondLastName>
            else ()
        }
        {
            let  $GENDER := fn:upper-case(string($createCustomerRequest/ns1:CustomerInfo/ns1:Gender/text()))
             return(
                      if ($GENDER != "")then(
                        <ns2:i_GenderType>{ local:CatalogValueOSBToAPP($GENDER, 'COBIS', '1', $GetCatalogsEquivalenceResponse) }</ns2:i_GenderType>
                      )else()
             )
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:BirthDate)
            then <ns2:i_BirthDate>{fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:BirthDate))}</ns2:i_BirthDate>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:BirthPlace)
            then <ns2:i_BirthPlace>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:BirthPlace)}</ns2:i_BirthPlace>
            else ()
        }
        {
           let  $BIRTH_COUNTRY := fn:upper-case(string($createCustomerRequest/ns1:CustomerInfo/ns1:BirthCountry/text()))
             return(
                      if ($BIRTH_COUNTRY != "")then(
                        <ns2:i_BirthCountry>{ local:CatalogValueOSBToAPP($BIRTH_COUNTRY, 'COBIS', '9', $GetCatalogsEquivalenceResponse) }</ns2:i_BirthCountry>
                      )else()
             )
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:TotalIncome)
            then <ns2:i_TotalIncome>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:TotalIncome)}</ns2:i_TotalIncome>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:MontlhyTransactionVolume)
            then <ns2:i_MyTraVolume>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:MontlhyTransactionVolume)}</ns2:i_MyTraVolume>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:AccountOfficer)
            then <ns2:i_AccountOfficer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:AccountOfficer)}</ns2:i_AccountOfficer>
            else ()
        }
        {
        
           let  $MARITAL_STATUS := fn:upper-case(string($createCustomerRequest/ns1:CustomerInfo/ns1:MaritalStatus/text()))
             return(
                      if ($MARITAL_STATUS != "")then(
                        <ns2:i_MaritalStatus>{ local:CatalogValueOSBToAPP($MARITAL_STATUS, 'COBIS', '2', $GetCatalogsEquivalenceResponse) }</ns2:i_MaritalStatus>
                      )else()
             )
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ActivityEconomic)
            then <ns2:i_ActivityEconomic>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ActivityEconomic)}</ns2:i_ActivityEconomic>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:EmployeeTurn)
            then <ns2:i_EmployeeTurn>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:EmployeeTurn)}</ns2:i_EmployeeTurn>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:SpouseName)
            then <ns2:i_SpouseName>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:SpouseName)}</ns2:i_SpouseName>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:MarriedName)
            then <ns2:i_MarriedName>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:MarriedName)}</ns2:i_MarriedName>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:Nationality)
            then <ns2:i_Nationality>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:Nationality)}</ns2:i_Nationality>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:Residence)
            then <ns2:i_Residence>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:Residence)}</ns2:i_Residence>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:Language)
            then <ns2:i_Language>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:Language)}</ns2:i_Language>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:GivenNames)
            then <ns2:i_GivenNames>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:GivenNames)}</ns2:i_GivenNames>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:FamilyNames)
            then <ns2:i_FamilyNames>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:FamilyNames)}</ns2:i_FamilyNames>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:Sector)
            then <ns2:i_Sector>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:Sector)}</ns2:i_Sector>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:Industry)
            then <ns2:i_Industry>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:Industry)}</ns2:i_Industry>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:Target)
            then <ns2:i_Target>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:Target)}</ns2:i_Target>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:MultipleNationality)
            then <ns2:i_MultNationality>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:MultipleNationality)}</ns2:i_MultNationality>
            else ()
        }
        <ns2:i_AddInfo>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:AdditionalInfo/ns1:Name)}</ns2:i_AddInfo>
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:GovernmentContractor)
            then <ns2:i_GovContractor>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:GovernmentContractor)}</ns2:i_GovContractor>
            else ()
        }
        {
          if(fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Type)= '1')then(
            <ns2:i_TypeAdress>Home</ns2:i_TypeAdress>
          )else(
            <ns2:i_TypeAdress>Work</ns2:i_TypeAdress>
          )        
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:IsMain)
            then <ns2:i_IsMainA>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:IsMain)}</ns2:i_IsMainA>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:PoBox)
            then <ns2:i_PoBox>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:PoBox)}</ns2:i_PoBox>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:ZipCode)
            then <ns2:i_ZipCode>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:ZipCode)}</ns2:i_ZipCode>
            else ()
        }
        {
           let  $COUNTRY_CODE := fn:upper-case(string($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:CountryCode/text()))
             return(
                      if ($COUNTRY_CODE != "")then(
                        <ns2:i_CountryCode>{ local:CatalogValueOSBToAPP($COUNTRY_CODE, 'COBIS', '9', $GetCatalogsEquivalenceResponse) }</ns2:i_CountryCode>
                      )else()
             )
        }
        {       
           let  $STATE_CODE := fn:upper-case(string($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:StateCode/text()))
             return(
                      if ($STATE_CODE != "")then(
                        <ns2:i_StateCode>{ local:CatalogValueOSBToAPP($STATE_CODE, 'COBIS', '8', $GetCatalogsEquivalenceResponse) }</ns2:i_StateCode>
                      )else()
             )
        }
        {
        
           let  $CITY_CODE := fn:upper-case(string($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:CityCode/text()))
             return(
                      if ($CITY_CODE != "")then(
                        <ns2:i_CityCode>{ local:CatalogValueOSBToAPP($CITY_CODE, 'COBIS', '7', $GetCatalogsEquivalenceResponse) }</ns2:i_CityCode>
                      )else()
             )
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:DistrictCode)
            then <ns2:i_DistrictCode>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:DistrictCode)}</ns2:i_DistrictCode>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Neighborhood)
            then <ns2:i_Neighborhood>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Neighborhood)}</ns2:i_Neighborhood>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:References)
            then <ns2:i_References>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:References)}</ns2:i_References>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:AddressLine1)
            then <ns2:i_AddressLine1>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:AddressLine1)}</ns2:i_AddressLine1>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:AddressLine2)
            then <ns2:i_AddressLine2>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:AddressLine2)}</ns2:i_AddressLine2>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Domicile)
            then <ns2:i_Domicile>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Domicile)}</ns2:i_Domicile>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Building)
            then <ns2:i_Building>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Building)}</ns2:i_Building>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Apartment)
            then <ns2:i_Apartment>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Apartment)}</ns2:i_Apartment>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Details)
            then <ns2:i_Details>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Details)}</ns2:i_Details>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Avenue)
            then <ns2:i_Avenue>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Avenue)}</ns2:i_Avenue>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Street)
            then <ns2:i_Street>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Street)}</ns2:i_Street>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Block)
            then <ns2:i_Block>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:Block)}</ns2:i_Block>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:HouseNumber)
            then <ns2:i_HouseNumber>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:HouseNumber)}</ns2:i_HouseNumber>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:DateResidence)
            then <ns2:i_DateResidence>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList/ns1:DateResidence)}</ns2:i_DateResidence>
            else ()
        }
        <ns2:i_TypePhone>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:Type)}</ns2:i_TypePhone>
        <ns2:i_IsMainT>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:Ismain)}</ns2:i_IsMainT>
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:AreaCode)
            then <ns2:i_AreaCode>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:AreaCode)}</ns2:i_AreaCode>
            else ()
        }
        <ns2:i_Number>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:Number)}</ns2:i_Number>
        {
          if(fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:Location)= '1')then(
            <ns2:i_Location>Home</ns2:i_Location>
          )else(
            <ns2:i_Location>Work</ns2:i_Location>
          )        
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:Reference)
            then <ns2:i_Reference>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:Reference)}</ns2:i_Reference>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:ZipCode)
            then <ns2:i_ZipCodeT>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList/ns1:ZipCode)}</ns2:i_ZipCodeT>
            else ()
        }
        {
          if(fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:EmailList/ns1:Type)= '1')then(
            <ns2:i_Typemail>Home</ns2:i_Typemail>
          )else(
            <ns2:i_Typemail>Work</ns2:i_Typemail>
          )        
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:EmailList/ns1:IsMain)
            then <ns2:i_IsMainE>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:EmailList/ns1:IsMain)}</ns2:i_IsMainE>
            else ()
        }
        <ns2:i_Email>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:EmailList/ns1:Email)}</ns2:i_Email>
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CurrentlyEmployed)
            then <ns2:i_CurrEmployed>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CurrentlyEmployed)}</ns2:i_CurrEmployed>
            else ()
        }
        
        {
        
           let  $PROFESION_CODE := fn:upper-case(string($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:ProfessionCode/text()))
             return(
                      if ($PROFESION_CODE != "")then(
                        <ns2:i_ProfessionCode>{ local:CatalogValueOSBToAPP($PROFESION_CODE, 'COBIS', '3', $GetCatalogsEquivalenceResponse) }</ns2:i_ProfessionCode>
                      )else()
             )
        }
        
        {
           let  $JOB_TITLE := fn:upper-case(string($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:JobTitle/text()))
             return(
                      if ($JOB_TITLE != "")then(
                        <ns2:i_JobTitle>{ local:CatalogValueOSBToAPP($JOB_TITLE, 'COBIS', '11', $GetCatalogsEquivalenceResponse) }</ns2:i_JobTitle>
                      )else()
             )
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeSource)
            then <ns2:i_IncomeSource>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeSource)}</ns2:i_IncomeSource>
            else ()
        }
        <ns2:i_IncomeRange>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeRange)}</ns2:i_IncomeRange>
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeCurrency)
            then <ns2:i_IncomeCurrency>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeCurrency)}</ns2:i_IncomeCurrency>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:Occupation)
            then <ns2:i_Occupation>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:Occupation)}</ns2:i_Occupation>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeSource)
            then <ns2:i_FinancialInstitution>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeSource)}</ns2:i_FinancialInstitution>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:SourceName)
            then <ns2:i_TypeRalationShip>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:SourceName)}</ns2:i_TypeRalationShip>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeCurrency)
            then <ns2:i_FinancialCurrency>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeCurrency)}</ns2:i_FinancialCurrency>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount)
            then <ns2:i_AverageAmount>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount)}</ns2:i_AverageAmount>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Observations)
            then <ns2:i_Observations>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Observations)}</ns2:i_Observations>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:YearRelationShip)
            then <ns2:i_YearRelationShip>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:YearRelationShip)}</ns2:i_YearRelationShip>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:GivenNames)
            then <ns2:i_NameRefer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:GivenNames)}</ns2:i_NameRefer>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:FamilyNames)
            then <ns2:i_SurnameRefer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:FamilyNames)}</ns2:i_SurnameRefer>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:AdressRefer)
            then <ns2:i_AdressRefer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:AdressRefer)}</ns2:i_AdressRefer>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:DocumentNameRefer)
            then <ns2:i_DocumentNameRefer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:DocumentNameRefer)}</ns2:i_DocumentNameRefer>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:LegalIDRefer)
            then <ns2:i_LegalIDRefer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:LegalIDRefer)}</ns2:i_LegalIDRefer>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:PhoneNumber)
            then <ns2:i_PhoneHomeRefer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:PhoneNumber)}</ns2:i_PhoneHomeRefer>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:PhoneWorkRefer)
            then <ns2:i_PhoneWorkRefer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:PhoneWorkRefer)}</ns2:i_PhoneWorkRefer>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:Cellphone)
            then <ns2:i_CellularRefer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:Cellphone)}</ns2:i_CellularRefer>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:Relationship)
            then <ns2:i_RelationShipRef>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:Relationship)}</ns2:i_RelationShipRef>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:CommentRefer)
            then <ns2:i_CommentRefer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:ReferenceList/ns1:CommentRefer)}</ns2:i_CommentRefer>
            else ()
        }
        {  
           let  $EDUCATION_LEVEL := fn:upper-case(string($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:EducationLevel/text()))
             return(
                      if ($EDUCATION_LEVEL != "")then(
                        <ns2:i_EducationLevel>{ local:CatalogValueOSBToAPP($EDUCATION_LEVEL, 'COBIS', '10', $GetCatalogsEquivalenceResponse) }</ns2:i_EducationLevel>
                      )else()
             )
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:MerchantType)
            then <ns2:i_MerchantType>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:MerchantType)}</ns2:i_MerchantType>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyType)
            then <ns2:i_CompanyType>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyType)}</ns2:i_CompanyType>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyName)
            then <ns2:i_CompanyName>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyName)}</ns2:i_CompanyName>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:StartDate)
            then <ns2:i_StartDate>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:StartDate)}</ns2:i_StartDate>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:FatcaResident)
            then <ns2:i_FatcaResident>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:FatcaResident)}</ns2:i_FatcaResident>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:FatcaAdress)
            then <ns2:i_FatcaAdress>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:FatcaAdress)}</ns2:i_FatcaAdress>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:FatcaPhone)
            then <ns2:i_FatcaPhone>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:FatcaPhone)}</ns2:i_FatcaPhone>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:FatcaTransfer)
            then <ns2:i_FatcaTransfer>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:FatcaTransfer)}</ns2:i_FatcaTransfer>
            else ()
        }
        {
            if ($createCustomerRequest/ns1:CustomerInfo/ns1:IsPep)
            then <ns2:i_IsPep>{fn:data($createCustomerRequest/ns1:CustomerInfo/ns1:IsPep)}</ns2:i_IsPep>
            else ()
        }
    </ns2:InputParameters>
};

local:func($createCustomerRequest, $GetCatalogsEquivalenceResponse, $customerId)