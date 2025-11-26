xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/updateCustomerTypesNI";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/updateCustomerNI.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogsEquivalence";
(:: import schema at "../../../../../CoreBankingHN/ProviderServices/XSD/GetCatalogsEquivalence/GetCatalogsEquivalence_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/UpdateCustomerCobis2";
(:: import schema at "../../../../ProviderServices/XSD/UpdateCustomer/UpdateCustomerCobis_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $UpdateCustomerRequest as element() (:: schema-element(ns1:updateCustomerRequest) ::) external;
declare variable $pTEquivalences as element() (:: schema-element(ns2:OutputParameters) ::) external;

declare function local:func($UpdateCustomerRequest as element() (:: schema-element(ns1:updateCustomerRequest) ::),
                            $pTEquivalences) as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        {
            if ($UpdateCustomerRequest/ns1:GeneralInfo/com:SourceBank)
            then <ns3:i_SourceBank>{fn:data($UpdateCustomerRequest/ns1:GeneralInfo/com:SourceBank)}</ns3:i_SourceBank>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:GeneralInfo/com:DestinationBank)
            then <ns3:i_DestinationBank>{fn:data($UpdateCustomerRequest/ns1:GeneralInfo/com:DestinationBank)}</ns3:i_DestinationBank>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:GeneralInfo/com:GlobalId)
            then <ns3:i_GlobalId>{fn:data($UpdateCustomerRequest/ns1:GeneralInfo/com:GlobalId)}</ns3:i_GlobalId>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:GeneralInfo/com:ApplicationId)
            then <ns3:i_ApplicationId>{fn:data($UpdateCustomerRequest/ns1:GeneralInfo/com:ApplicationId)}</ns3:i_ApplicationId>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:GeneralInfo/com:ApplicationUser)
            then <ns3:i_ApplicationUser>{fn:data($UpdateCustomerRequest/ns1:GeneralInfo/com:ApplicationUser)}</ns3:i_ApplicationUser>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:GeneralInfo/com:BranchId)
            then <ns3:i_BranchId>{fn:data($UpdateCustomerRequest/ns1:GeneralInfo/com:BranchId)}</ns3:i_BranchId>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:GeneralInfo/com:TransactionDate)
            then <ns3:i_TransactionDate>{fn:data($UpdateCustomerRequest/ns1:GeneralInfo/com:TransactionDate)}</ns3:i_TransactionDate>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:GeneralInfo/com:Language)
            then <ns3:i_Lang>{fn:data($UpdateCustomerRequest/ns1:GeneralInfo/com:Language)}</ns3:i_Lang>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerId)
            then <ns3:i_customerid>{fn:data($UpdateCustomerRequest/ns1:CustomerId)}</ns3:i_customerid>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:FirstName)
            then <ns3:i_FirstName>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:FirstName)}</ns3:i_FirstName>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SecondName)
            then <ns3:i_SecondName>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SecondName)}</ns3:i_SecondName>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:MarriedName)
            then <ns3:i_MarriedName>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:MarriedName)}</ns3:i_MarriedName>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:ThirdName)
            then <ns3:i_ThirdName>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:ThirdName)}</ns3:i_ThirdName>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:FirstLastName)
            then <ns3:i_FirstLastName>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:FirstLastName)}</ns3:i_FirstLastName>
            else ()
        }
        {
           let $GENDER := fn:upper-case(string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Gender/text()))
           return
                if($GENDER != "") then (  
                     <ns3:i_GenderType>{ local:catalogValueOSBToAPP($GENDER, 'COBIS', 1, $pTEquivalences) }</ns3:i_GenderType>
                ) else (
                     <ns3:i_GenderType xsi:nil="true" />
                )	
        }  	           
        {
            let $MARITAL_STATUS := fn:upper-case(fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:MaritalStatus/text()))
            return
                 if($MARITAL_STATUS != "") then (  
                      <ns3:i_MaritalStatus>{ local:catalogValueOSBToAPP($MARITAL_STATUS, 'COBIS', 2, $pTEquivalences) }</ns3:i_MaritalStatus>
                 ) else (
                      <ns3:i_MaritalStatus xsi:nil="true" />
                 )	
        }
        {
            let $WORK_TITLE := string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:ProfessionCode/text())
            return
                 if($WORK_TITLE != "") then (  
                     <ns3:i_ProfessionCode>{ local:catalogValueOSBToAPP($WORK_TITLE, 'COBIS', 3, $pTEquivalences) }</ns3:i_ProfessionCode>     	
                 ) else (
                     <ns3:i_ProfessionCode xsi:nil="true" />
                 )		
        }
        {
            let $ACTIVITY_ECONOMIC := string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Activity/text())
            return
                 if($ACTIVITY_ECONOMIC != "") then (  
                     <ns3:i_ActivityEconomic>{ local:catalogValueOSBToAPP($ACTIVITY_ECONOMIC, 'COBIS', 22, $pTEquivalences) }</ns3:i_ActivityEconomic>     	
                 ) else (
                     <ns3:i_ActivityEconomic xsi:nil="true" />
                 )		
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SecondLastName)
            then <ns3:i_SecondLastName>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SecondLastName)}</ns3:i_SecondLastName>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:BirthDate)
            then <ns3:i_BirthDate>{fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:BirthDate))}</ns3:i_BirthDate>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:BirthPlace)
            then <ns3:i_BirthPlace>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:BirthPlace)}</ns3:i_BirthPlace>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Nationality)
            then <ns3:i_Nationality>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Nationality)}</ns3:i_Nationality>
            else ()
        }

        <ns3:i_IncomeRange>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:IncomeRange)}</ns3:i_IncomeRange>
        {
            if ($UpdateCustomerRequest/ns1:NumberOfDependents)
            then <ns3:i_Numberdependents>{fn:data($UpdateCustomerRequest/ns1:NumberOfDependents)}</ns3:i_Numberdependents>
            else ()
        }

        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:TotalIncome)
            then <ns3:i_TotalIncome>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:TotalIncome)}</ns3:i_TotalIncome>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:MontlhyTransactionVolume)
            then <ns3:i_MyTraVolume>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:MontlhyTransactionVolume)}</ns3:i_MyTraVolume>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:AccountOfficer)
            then <ns3:i_AccountOfficer>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:AccountOfficer)}</ns3:i_AccountOfficer>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SpouseName)
            then <ns3:i_SpouseName>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SpouseName)}</ns3:i_SpouseName>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Residence)
            then <ns3:i_Residence>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Residence)}</ns3:i_Residence>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Language)
            then <ns3:i_Language>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Language)}</ns3:i_Language>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:GivenNames)
            then <ns3:i_GivenNames>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:GivenNames)}</ns3:i_GivenNames>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:FamilyNames)
            then <ns3:i_FamilyNames>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:FamilyNames)}</ns3:i_FamilyNames>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Sector)
            then <ns3:i_Sector>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Sector)}</ns3:i_Sector>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Industry)
            then <ns3:i_Industry>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Industry)}</ns3:i_Industry>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Target)
            then <ns3:i_Target>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Target)}</ns3:i_Target>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:MultipleNationality)
            then <ns3:i_MultNationality>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:MultipleNationality)}</ns3:i_MultNationality>
            else ()
        }
        <ns3:i_AddInfo>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:AdditionalInfo/ns1:Name)}</ns3:i_AddInfo>
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:GovernmentContractor)
            then <ns3:i_GovContractor>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:GovernmentContractor)}</ns3:i_GovContractor>
            else ()
        }
        {
            let $DOCUMENT_NAME := fn:upper-case(string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:DocumentName/text()))
            return
                 if($DOCUMENT_NAME != "") then (  
                     <ns3:i_DocumentName>{ local:catalogValueOSBToAPP($DOCUMENT_NAME, 'COBIS', 4, $pTEquivalences) }</ns3:i_DocumentName>     	
                 ) else (
                     <ns3:i_DocumentName xsi:nil="true" />
                 )		
        }
        <ns3:i_LegalId>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:LegalId)}</ns3:i_LegalId>
        <ns3:i_DateOfIssuance>{fn-bea:date-to-string-with-format("yyyyMMdd", xs:date(fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:DateOfIssuance))) }</ns3:i_DateOfIssuance>
        {
            if ($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:MaturityDate)
            then <ns3:i_MaturityDate>{fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:MaturityDate)}</ns3:i_MaturityDate>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ReferenceList/ns1:GivenNames)
            then <ns3:i_NameRefer>{fn:data($UpdateCustomerRequest/ns1:ReferenceList/ns1:GivenNames)}</ns3:i_NameRefer>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ReferenceList/ns1:FamilyNames)
            then <ns3:i_SurnameRefer>{fn:data($UpdateCustomerRequest/ns1:ReferenceList/ns1:FamilyNames)}</ns3:i_SurnameRefer>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ReferenceList/ns1:Cellphone)
            then <ns3:i_CellularRefer>{fn:data($UpdateCustomerRequest/ns1:ReferenceList/ns1:Cellphone)}</ns3:i_CellularRefer>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ReferenceList/ns1:PhoneNumber)
            then <ns3:i_PhoneHomeRefer>{fn:data($UpdateCustomerRequest/ns1:ReferenceList/ns1:PhoneNumber)}</ns3:i_PhoneHomeRefer>
            else ()
        }
        {
          if(fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList/ns1:Type) = '1')then(
            <ns3:i_TypeAdress>Home</ns3:i_TypeAdress>
          )else(
            <ns3:i_TypeAdress>Work</ns3:i_TypeAdress>
          )        
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:IsMain)
            then <ns3:i_IsMainA>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:IsMain)}</ns3:i_IsMainA>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:AddressLine1)
            then <ns3:i_AddressLine1>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:AddressLine1)}</ns3:i_AddressLine1>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Domicile)
            then <ns3:i_Domicile>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Domicile)}</ns3:i_Domicile>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Building)
            then <ns3:i_Building>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Building)}</ns3:i_Building>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Apartment)
            then <ns3:i_Apartment>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Apartment)}</ns3:i_Apartment>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Details)
            then <ns3:i_Details>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Details)}</ns3:i_Details>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Avenue)
            then <ns3:i_Avenue>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Avenue)}</ns3:i_Avenue>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Street)
            then <ns3:i_Street>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Street)}</ns3:i_Street>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Block)
            then <ns3:i_Block>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Block)}</ns3:i_Block>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:HouseNumber)
            then <ns3:i_HouseNumber>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:HouseNumber)}</ns3:i_HouseNumber>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:AddressLine2)
            then <ns3:i_AddressLine2>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:AddressLine2)}</ns3:i_AddressLine2>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:References)
            then <ns3:i_References>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:References)}</ns3:i_References>
            else ()
        }
        {
            let $COUNTRY_CODE := fn:upper-case(fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:CountryCode/text()))
            return
                 if($COUNTRY_CODE != "") then (  
                     <ns3:i_CountryCode>{ local:catalogValueOSBToAPP($COUNTRY_CODE, 'COBIS', 9, $pTEquivalences) }</ns3:i_CountryCode>     	
                 ) else (
                     <ns3:i_CountryCode xsi:nil="true" />
                 )
        }
        {
            let $STATE_CODE := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:StateCode/text())
            return
                 if($STATE_CODE != "") then (  
                     <ns3:i_StateCode>{ local:catalogValueOSBToAPP($STATE_CODE, 'COBIS', 8, $pTEquivalences) }</ns3:i_StateCode>     	
                 ) else (
                     <ns3:i_StateCode xsi:nil="true" />
                 )
        }
        {
            let $CITY_CODE := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:CityCode/text())
            return
                 if($CITY_CODE != "") then (  
                     <ns3:i_CityCode>{ local:catalogValueOSBToAPP($CITY_CODE, 'COBIS', 7, $pTEquivalences) }</ns3:i_CityCode>     	
                 ) else (
                     <ns3:i_CityCode xsi:nil="true" />
                 )
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:PoBox)
            then <ns3:i_PoBox>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:PoBox)}</ns3:i_PoBox>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:ZipCode)
            then <ns3:i_ZipCode>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:ZipCode)}</ns3:i_ZipCode>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:DistrictCode)
            then <ns3:i_DistrictCode>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:DistrictCode)}</ns3:i_DistrictCode>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Neighborhood)
            then <ns3:i_Neighborhood>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Neighborhood)}</ns3:i_Neighborhood>
            else ()
        }
        <ns3:i_TypePhone>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:Type)}</ns3:i_TypePhone>
        <ns3:i_Number>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:Number)}</ns3:i_Number>
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:AreaCode)
            then <ns3:i_AreaCode>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:AreaCode)}</ns3:i_AreaCode>
            else ()
        }
        <ns3:i_IsMainT>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:Ismain)}</ns3:i_IsMainT>
        {
          if(fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:Location) = '1')then(
            <ns3:i_Location>Home</ns3:i_Location>
          )else(
            <ns3:i_Location>Work</ns3:i_Location>
          )        
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:Reference)
            then <ns3:i_Reference>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:Reference)}</ns3:i_Reference>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:ZipCode)
            then <ns3:i_ZipCodeT>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList/ns1:ZipCode)}</ns3:i_ZipCodeT>
            else ()
        }
        {
          if(fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:EmailList/ns1:Type) = '1')then(
            <ns3:i_Typemail>Home</ns3:i_Typemail>
          )else(
            <ns3:i_Typemail>Work</ns3:i_Typemail>
          )        
        }
        {
            if ($UpdateCustomerRequest/ns1:ContactInfo/ns1:EmailList[ns1:Type = "1"]/ns1:IsMain)
            then <ns3:i_IsMainE>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:EmailList[ns1:Type = "1"]/ns1:IsMain)}</ns3:i_IsMainE>
            else ()
        }
        <ns3:i_Email>{fn:data($UpdateCustomerRequest/ns1:ContactInfo/ns1:EmailList[ns1:Type = "1"]/ns1:Email)}</ns3:i_Email>
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:CompanyName)
            then <ns3:i_CompanyName>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:CompanyName)}</ns3:i_CompanyName>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:CompanyType)
            then <ns3:i_CompanyType>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:CompanyType)}</ns3:i_CompanyType>
            else ()
        }
        {
            let $COMPANY_SIZE := fn:upper-case(string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:CompanySize/text()))
            return
                 if($COMPANY_SIZE != "") then (  
                     <ns3:i_companySize>{ local:catalogValueOSBToAPP($COMPANY_SIZE, 'COBIS', 24, $pTEquivalences) }</ns3:i_companySize>     	
                 ) else (
                     <ns3:i_companySize xsi:nil="true" />
                 )		
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:ImmediateBoss)
            then <ns3:i_immediateBoss>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:ImmediateBoss)}</ns3:i_immediateBoss>
            else ()
        }
        {
            let $JOB_TITLE := fn:upper-case(string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:JobTitle/text()))
            return
                 if($JOB_TITLE != "") then (  
                     <ns3:i_JobTitle>{ local:catalogValueOSBToAPP($JOB_TITLE, 'COBIS', 11, $pTEquivalences) }</ns3:i_JobTitle>     	
                 ) else (
                     <ns3:i_JobTitle xsi:nil="true" />
                 )		
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:CurrentlyEmployed)
            then <ns3:i_CurrEmployed>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:CurrentlyEmployed)}</ns3:i_CurrEmployed>
            else ()
        }

        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:IncomeSource)
            then <ns3:i_IncomeSource>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:IncomeSource)}</ns3:i_IncomeSource>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:IncomeCurrency)
            then <ns3:i_IncomeCurrency>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:IncomeCurrency)}</ns3:i_IncomeCurrency>
            else ()
        }
        {
            let $EDUCATION_LEVEL := fn:upper-case(string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:EducationLevel/text()))
            return
                 if($EDUCATION_LEVEL != "") then (  
                     <ns3:i_EducationLevel>{ local:catalogValueOSBToAPP($EDUCATION_LEVEL, 'COBIS', 10, $pTEquivalences) }</ns3:i_EducationLevel>     	
                 ) else (
                     <ns3:i_EducationLevel xsi:nil="true" />
                 )		
        }
        {
            let $OCCUPATION := fn:upper-case(string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:Occupation/text()))
            return
                 if($OCCUPATION != "") then (  
                     <ns3:i_Occupation>{ local:catalogValueOSBToAPP($OCCUPATION, 'COBIS', 23, $pTEquivalences) }</ns3:i_Occupation>     	
                 ) else (
                     <ns3:i_Occupation xsi:nil="true" />
                 )		
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:MerchantType)
            then <ns3:i_MerchantType>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:MerchantType)}</ns3:i_MerchantType>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:StartDate)
            then <ns3:i_StartDate>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:StartDate)}</ns3:i_StartDate>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:EndDate)
            then <ns3:i_EndDate>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:EndDate)}</ns3:i_EndDate>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:Website)
            then <ns3:i_sitio_web>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:Website)}</ns3:i_sitio_web>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:Observations)
            then <ns3:i_jobobservation>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:Observations)}</ns3:i_jobobservation>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeSource)
            then <ns3:i_FinancialInstitution>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeSource)}</ns3:i_FinancialInstitution>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:SourceName)
            then <ns3:i_TypeRalationShip>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:SourceName)}</ns3:i_TypeRalationShip>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeCurrency)
            then <ns3:i_FinancialCurrency>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeCurrency)}</ns3:i_FinancialCurrency>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount)
            then <ns3:i_AverageAmount>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount)}</ns3:i_AverageAmount>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount)
            then <ns3:i_other_income>{fn:data($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount)}</ns3:i_other_income>
            else ()
        }
        {
            if ($UpdateCustomerRequest/ns1:ReferenceList/ns1:Address)
            then <ns3:i_AdressRefer>{fn:data($UpdateCustomerRequest/ns1:ReferenceList/ns1:Address)}</ns3:i_AdressRefer>
            else ()
        }
        {
            let $DOCUMENT_TYPE := fn:upper-case(string($UpdateCustomerRequest/ns1:ReferenceList[1]/ns1:DocumentType/text()))
            return
                 if($DOCUMENT_TYPE != "") then (  
                     <ns3:i_DocumentNameRefer>{ local:catalogValueOSBToAPP($DOCUMENT_TYPE, 'COBIS', 4, $pTEquivalences) }</ns3:i_DocumentNameRefer>     	
                 ) else (
                     <ns3:i_DocumentNameRefer xsi:nil="true" />
                 )		
        }
        {
            if ($UpdateCustomerRequest/ns1:ReferenceList/ns1:DocumentNumber)
            then <ns3:i_LegalIDRefer>{fn:data($UpdateCustomerRequest/ns1:ReferenceList/ns1:DocumentNumber)}</ns3:i_LegalIDRefer>
            else ()
        }
        {
            let $RELATIONSHIP_REFER := fn:upper-case(string($UpdateCustomerRequest/ns1:ReferenceList[1]/ns1:Relationship/text()))
            return
                 if($RELATIONSHIP_REFER != "") then (  
                     <ns3:i_RelationShipRef>{ local:catalogValueOSBToAPP($RELATIONSHIP_REFER, 'COBIS', 37, $pTEquivalences) }</ns3:i_RelationShipRef>     	
                 ) else (
                     <ns3:i_RelationShipRef xsi:nil="true" />
                 )		
        }
        {
            if ($UpdateCustomerRequest/ns1:ReferenceList/ns1:Comment)
            then <ns3:i_CommentRefer>{fn:data($UpdateCustomerRequest/ns1:ReferenceList/ns1:Comment)}</ns3:i_CommentRefer>
            else ()
        }
    </ns3:InputParameters>
};

declare function local:catalogValueOSBToAPP($value as xs:string,
                                            $application as xs:string,
                                            $catalogId as xs:integer,
                                            $equivalencies as element() (:: schema-element(ns2:OutputParameters) ::))
                                            as xs:string {
     let $return := fn:string($equivalencies/ns2:PT_EQUIVALENCIAS_SALIDA/ns2:PT_EQUIVALENCIAS_SALIDA_ITEM[ns2:CATALOGO_ID = $catalogId and 
                             ns2:EQUIVALENCIAS/ns2:EQUIVALENCIAS_ITEM/ns2:APLICACION = $application and 
                             ns2:VALOR_CATALOGO = fn:upper-case($value)]/ns2:EQUIVALENCIAS/ns2:EQUIVALENCIAS_ITEM/ns2:VALOR_EQUIVALENCIA/text())
     
     return
          if($return != "") then (
               $return
          ) else (
               $value
          )
};

local:func($UpdateCustomerRequest, $pTEquivalences)