xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/getCustomerDetailsTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerDetailsTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogsEquivalence";
(:: import schema at "../../../../../CoreBankingHN/ProviderServices/XSD/GetCatalogsEquivalence/GetCatalogsEquivalence_sp.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerDetailsNI";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerDetails/GetCustomerDetailsNI_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $Output as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $GetCatalogsEquivalenceResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;

declare function local:CatalogValueOSBToAPP($value as xs:string,
	$application as xs:string,
	$catalogId as xs:string,
	$catalogEquivalencies as element(*)
) as xs:string {
	let $return := string($catalogEquivalencies/ns2:PT_EQUIVALENCIAS_SALIDA/ns2:PT_EQUIVALENCIAS_SALIDA_ITEM[ns2:CATALOGO_ID = $catalogId and ns2:VALOR_CATALOGO = $value][1]/ns2:EQUIVALENCIAS/ns2:EQUIVALENCIAS_ITEM[ns2:APLICACION = $application]/ns2:VALOR_EQUIVALENCIA/text())
	return
		if($return != "") then (
			$return
		) else ( 
			$value
		)
};

declare function local:func($uuid as xs:string, 
                            $Output as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $GetCatalogsEquivalenceResponse as element() (:: schema-element(ns2:OutputParameters) ::)) 
                            as element() (:: schema-element(ns3:getCustomerDetailsResponse) ::) {
    <ns3:getCustomerDetailsResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:BasicInfo>
            <ns3:CustomerId>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CustomerId"])}</ns3:CustomerId>
            {
                for $IdentificationInfo in $Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "IdentificationInfo"]
                where $IdentificationInfo/@name eq $IdentificationInfo/@name
                return 
                <ns3:IdentificationInfo>
                    {
                      if(fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalDocumentType"]))then(
                        <ns3:LegalDocumentType>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalDocumentType"])}</ns3:LegalDocumentType>
                      )else()
                    }
                    {
                      if(fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalId"]))then(
                        <ns3:LegalId>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalId"])}</ns3:LegalId>
                      )else()
                    }
                    {
                      if(fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "IssuedDate"]))then(
                        <ns3:IssuedDate>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "IssuedDate"])}</ns3:IssuedDate>
                      )else()
                    }
                    {
                      if(fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "ExpirationDate"]))then(
                        <ns3:ExpirationDate>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "ExpirationDate"])}</ns3:ExpirationDate>
                      )else()
                    }
                </ns3:IdentificationInfo>
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "GivenNames"])) then (
                <ns3:GivenNames>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "GivenNames"])}</ns3:GivenNames>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "FamilyName"])) then (
                <ns3:FamilyName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "FamilyName"])}</ns3:FamilyName>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "FullName"])) then (
                <ns3:FullName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "FullName"])}</ns3:FullName>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "NameBusiness"])) then (
                <ns3:NameBusiness>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "NameBusiness"])}</ns3:NameBusiness>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CommercialName"])) then (
                <ns3:CommercialName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CommercialName"])}</ns3:CommercialName>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalHolderName"])) then (
                <ns3:LegalHolderName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalHolderName"])}</ns3:LegalHolderName>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "ShortName"])) then (
                <ns3:ShortName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "ShortName"])}</ns3:ShortName>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "DateBirth"])) then (
                <ns3:DateBirth>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "DateBirth"])}</ns3:DateBirth>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Gender"])) then (
                <ns3:Gender>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Gender"])}</ns3:Gender>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Nationality"])) then (
                <ns3:Nationality>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Nationality"])}</ns3:Nationality>
              ) else ()
            }
            {
              let $Residence := fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Residence"])
              return(
                if($Residence  != "")then(
                  <ns3:Residence>{ local:CatalogValueOSBToAPP($Residence, 'COBIS', '9', $GetCatalogsEquivalenceResponse) }</ns3:Residence>    	
                )else()
              )
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "MaritalStatus"])) then (
                <ns3:MaritalStatus>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "MaritalStatus"])}</ns3:MaritalStatus>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "MarriedLastName" and @sqltype = "varchar"])) then (
                <ns3:MarriedLastName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "MarriedLastName" and @sqltype = "varchar"])}</ns3:MarriedLastName>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "SpouseName"])) then (
                <ns3:SpouseName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "SpouseName"])}</ns3:SpouseName>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalRepresentativeId"])) then (
                <ns3:LegalRepresentativeId>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalRepresentativeId"])}</ns3:LegalRepresentativeId>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalRepresentativeName"])) then (
                <ns3:LegalRepresentativeName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LegalRepresentativeName"])}</ns3:LegalRepresentativeName>
              ) else ()
              }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "PlaceBirth"])) then (
                <ns3:PlaceBirth>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "PlaceBirth"])}</ns3:PlaceBirth>
              ) else ()
              }
            {
              let $PlaceBirthDescription := fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "PlaceBirthDescription"])
              return(
                if($PlaceBirthDescription  != "")then(
                  <ns3:PlaceBirthDescription>{ local:CatalogValueOSBToAPP($PlaceBirthDescription, 'COBIS', '7', $GetCatalogsEquivalenceResponse) }</ns3:PlaceBirthDescription>    	
                )else()
              )
            }
            {
              let $CountryBirth := fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CountryBirth"])
              return(
                if($CountryBirth  != "")then(
                  <ns3:CountryBirth>{ local:CatalogValueOSBToAPP($CountryBirth, 'COBIS', '15', $GetCatalogsEquivalenceResponse) }</ns3:CountryBirth>    	
                )else()
              )
            }
            {
              let $CountryBirthDescription := fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CountryBirthDescription"])
              return(
                if($CountryBirthDescription  != "")then(
                  <ns3:CountryBirthDescription>{ local:CatalogValueOSBToAPP($CountryBirthDescription, 'COBIS', '9', $GetCatalogsEquivalenceResponse) }</ns3:CountryBirthDescription>    	
                )else()
              )
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Sector"])) then (
              <ns3:Sector>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Sector"])}</ns3:Sector>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "SectorDescription"])) then (
              <ns3:SectorDescription>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "SectorDescription"])}</ns3:SectorDescription>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Industry"])) then (
              <ns3:Industry>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Industry"])}</ns3:Industry>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "IndustryDescription"])) then (
              <ns3:IndustryDescription>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "IndustryDescription"])}</ns3:IndustryDescription>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Target"])) then (
              <ns3:Target>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Target"])}</ns3:Target>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "TargetDescription"])) then (
              <ns3:TargetDescription>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "TargetDescription"])}</ns3:TargetDescription>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "ForeignExchangeGenerator"])) then (
              <ns3:ForeignExchangeGenerator>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "ForeignExchangeGenerator"])}</ns3:ForeignExchangeGenerator>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "AccountOfficer"])) then (
              <ns3:AccountOfficer>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "AccountOfficer"])}</ns3:AccountOfficer>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "BranchCode"])) then (
              <ns3:BranchCode>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "BranchCode"])}</ns3:BranchCode>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "TypePerson"])) then (
              <ns3:TypePerson>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "TypePerson"])}</ns3:TypePerson>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CustomerType"])) then (
              <ns3:CustomerType>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CustomerType"])}</ns3:CustomerType>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CustomerStatus"])) then (
              <ns3:CustomerStatus>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CustomerStatus"])}</ns3:CustomerStatus>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CustomerProfileType"])) then (
              <ns3:CustomerProfileType>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CustomerProfileType"])}</ns3:CustomerProfileType>
            ) else ()
            }
            {
            if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CustomerSince"])) then (
              <ns3:CustomerSince>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CustomerSince"])}</ns3:CustomerSince>
            ) else ()
            }
        </ns3:BasicInfo>
        <ns3:FinancialInfo>
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LevelEducation"])) then (
                <ns3:LevelEducation>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LevelEducation"])}</ns3:LevelEducation>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "EmploymentSatus"])) then (
                <ns3:EmploymentSatus>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "EmploymentSatus"])}</ns3:EmploymentSatus>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Occupation"])) then (
                <ns3:Occupation>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Occupation"])}</ns3:Occupation>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "MerchantType"])) then (
                <ns3:MerchantType>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "MerchantType"])}</ns3:MerchantType>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "MerchantName"])) then (
                <ns3:MerchantName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "MerchantName"])}</ns3:MerchantName>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LineBusiness"])) then (
                <ns3:LineBusiness>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "LineBusiness"])}</ns3:LineBusiness>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Profession"])) then (
                <ns3:Profession>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "Profession"])}</ns3:Profession>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "ProfessionDescription"])) then (
                <ns3:ProfessionDescription>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "ProfessionDescription"])}</ns3:ProfessionDescription>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CompanyType"])) then (
                <ns3:CompanyType>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "CompanyType"])}</ns3:CompanyType>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "EmployerName"])) then (
                <ns3:EmployerName>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "EmployerName"])}</ns3:EmployerName>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "JobTitle"])) then (
                <ns3:JobTitle>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "JobTitle"])}</ns3:JobTitle>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "JobTitleDescription"])) then (
                <ns3:JobTitleDescription>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "JobTitleDescription"])}</ns3:JobTitleDescription>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "EmploymentStartDate"])) then (
                <ns3:EmploymentStartDate>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "EmploymentStartDate"])}</ns3:EmploymentStartDate>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "SourceIncome"])) then (
                <ns3:SourceIncome>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "SourceIncome"])}</ns3:SourceIncome>
              ) else ()
            }
            {
              if (fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "NumberDependents"])) then (
                <ns3:NumberDependents>{fn:data($Output/ns1:RowSet/ns1:Row/ns1:Column[@name = "NumberDependents"])}</ns3:NumberDependents>
              ) else ()
            }
        </ns3:FinancialInfo>
        {
          for $AddressInfo in $Output/ns1:RowSet[4]/ns1:Row
          return
        <ns3:AddressesInfo>
            {
              if(fn:data($AddressInfo/ns1:Column[@name = "AddressCode"]))then(
                <ns3:AddressCode>{fn:data($AddressInfo/ns1:Column[@name = "AddressCode"])}</ns3:AddressCode>
              )else()
            }
            {
              if(fn:data($AddressInfo/ns1:Column[@name = "AddressType"]))then(
                <ns3:AddressType>{fn:data($AddressInfo/ns1:Column[@name = "AddressType"])}</ns3:AddressType>
              )else()
            }
            {
              if(fn:data($AddressInfo/ns1:Column[@name = "IsMainAddress"]))then(
                <ns3:IsMainAddress>{fn:data($AddressInfo/ns1:Column[@name = "IsMainAddress"])}</ns3:IsMainAddress>
              )else()
            }
            {
              let $CountryCode := fn:data($AddressInfo/ns1:Column[@name = "CountryCode"])
              return(
                if($CountryCode  != "")then(
                  <ns3:CountryCode>{ local:CatalogValueOSBToAPP($CountryCode, 'COBIS', '15', $GetCatalogsEquivalenceResponse) }</ns3:CountryCode>    	
                )else()
              )
            }          
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "DepartmentCode"])) then (
                <ns3:DepartmentCode>{fn:data($AddressInfo/ns1:Column[@name = "DepartmentCode"])}</ns3:DepartmentCode>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "DepartmentDesciption"])) then (
                <ns3:DepartmentDesciption>{fn:data($AddressInfo/ns1:Column[@name = "DepartmentDesciption"])}</ns3:DepartmentDesciption>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "MunicipalityCode"])) then (
                <ns3:MunicipalityCode>{fn:data($AddressInfo/ns1:Column[@name = "MunicipalityCode"])}</ns3:MunicipalityCode>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "MunicipalityDescripcion"])) then (
                <ns3:MunicipalityDescripcion>{fn:data($AddressInfo/ns1:Column[@name = "MunicipalityDescripcion"])}</ns3:MunicipalityDescripcion>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "ColonyCode"])) then (
                <ns3:ColonyCode>{fn:data($AddressInfo/ns1:Column[@name = "ColonyCode"])}</ns3:ColonyCode>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "ColonyDescripcion"])) then (
                <ns3:ColonyDescripcion>{fn:data($AddressInfo/ns1:Column[@name = "ColonyDescripcion"])}</ns3:ColonyDescripcion>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "References1"])) then (
                <ns3:References>{fn:data($AddressInfo/ns1:Column[@name = "References1"])}</ns3:References>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "AddressLine1"])) then (
                <ns3:AddressLine1>{fn:data($AddressInfo/ns1:Column[@name = "AddressLine1"])}</ns3:AddressLine1>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "AddressLine2"])) then (
                <ns3:AddressLine2>{fn:data($AddressInfo/ns1:Column[@name = "AddressLine2"])}</ns3:AddressLine2>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "Avenue"])) then (
                <ns3:Avenue>{fn:data($AddressInfo/ns1:Column[@name = "Avenue"])}</ns3:Avenue>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "Street"])) then (
                <ns3:Street>{fn:data($AddressInfo/ns1:Column[@name = "Street"])}</ns3:Street>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "Block"])) then (
                <ns3:Block>{fn:data($AddressInfo/ns1:Column[@name = "Block"])}</ns3:Block>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "HouseNumber"])) then (
                <ns3:HouseNumber>{fn:data($AddressInfo/ns1:Column[@name = "HouseNumber"])}</ns3:HouseNumber>
              )else()
            }
            {
              if (fn:data($AddressInfo/ns1:Column[@name = "NeighborhoodPending"])) then (
                <ns3:NeighborhoodPending>{fn:data($AddressInfo/ns1:Column[@name = "NeighborhoodPending"])}</ns3:NeighborhoodPending>
              )else()
            }
        </ns3:AddressesInfo>
        }
        {
          for $phoneInfo in $Output/ns1:RowSet[5]/ns1:Row
          return
        <ns3:PhoneInfo>
        {
            
              if(fn:data($phoneInfo/ns1:Column[@name = "Id" and @sqltype = "tinyint"]))then(
                <ns3:Id>{fn:data($phoneInfo/ns1:Column[@name = "Id" and @sqltype = "tinyint"])}</ns3:Id>
              )else(),
              if(fn:data($phoneInfo/ns1:Column[@name = "Type"]))then(
                <ns3:Type>{fn:data($phoneInfo/ns1:Column[@name = "Type"])}</ns3:Type>
              )else(),
              if(fn:data($phoneInfo/ns1:Column[@name = "AreaCode"]))then(
                <ns3:AreaCode>{fn:data($phoneInfo/ns1:Column[@name = "AreaCode"])}</ns3:AreaCode>
              )else(),
              if(fn:data($phoneInfo/ns1:Column[@name = "PhoneNumber"]))then(
                <ns3:PhoneNumber>{fn:data($phoneInfo/ns1:Column[@name = "PhoneNumber"])}</ns3:PhoneNumber>
              )else(),
              if(fn:data($phoneInfo/ns1:Column[@name = "Extension"]))then(
                <ns3:Extension>{fn:data($phoneInfo/ns1:Column[@name = "Extension"])}</ns3:Extension>
              )else(),
              if(fn:data($phoneInfo/ns1:Column[@name = "PhoneReference"]))then(
                <ns3:PhoneReference>{fn:data($phoneInfo/ns1:Column[@name = "PhoneReference"])}</ns3:PhoneReference>
              )else()
        }
        </ns3:PhoneInfo>
        }
        {
          for $EmailInfo in $Output/ns1:RowSet[6]/ns1:Row
          return
          <ns3:EmailInfo>
            {
              if (fn:data($EmailInfo/ns1:Column[@name = "Id" and @sqltype = "smallint"])) then
                <ns3:Id>{fn:data($EmailInfo/ns1:Column[@name = "Id" and @sqltype = "smallint"])}</ns3:Id>
              else (),
              if (fn:data(fn:data($EmailInfo/ns1:Column[@name = "Email"]))) then
                <ns3:Email>{fn:data($EmailInfo/ns1:Column[@name = "Email"])}</ns3:Email>
              else (),
              if (fn:data(fn:data($EmailInfo/ns1:Column[@name = "EmailReference"]))) then
                <ns3:EmailReference>{fn:data($EmailInfo/ns1:Column[@name = "EmailReference"])}</ns3:EmailReference>
              else (),
              if (fn:data(fn:data($EmailInfo/ns1:Column[@name = "IsMainEmail"]))) then
                <ns3:IsMainEmail>{fn:data($EmailInfo/ns1:Column[@name = "IsMainEmail"])}</ns3:IsMainEmail>
              else ()
            }
          </ns3:EmailInfo>
        }
        <ns3:SectorizationInfo>
            {
              if(fn:data($Output/ns1:RowSet[8]/ns1:Row[1]/ns1:Column[@name = "Type"]))then(
                <ns3:Type>{fn:data($Output/ns1:RowSet[8]/ns1:Row[1]/ns1:Column[@name = "Type"])}</ns3:Type>
              )else()
            }
            {
              if(fn:data($Output/ns1:RowSet[8]/ns1:Row[1]/ns1:Column[@name = "Code"]))then(
                <ns3:Code>{fn:data($Output/ns1:RowSet[8]/ns1:Row[1]/ns1:Column[@name = "Code"])}</ns3:Code>
              )else()
            }
            {
              if(fn:data($Output/ns1:RowSet[8]/ns1:Row[1]/ns1:Column[@name = "Description"]))then(
                <ns3:Description>{fn:data($Output/ns1:RowSet[8]/ns1:Row[1]/ns1:Column[@name = "Description"])}</ns3:Description>
              )else()
            }
        </ns3:SectorizationInfo>
        <ns3:RegulationsInfo>
            {
              if(fn:data($Output/ns1:RowSet[9]/ns1:Row[1]/ns1:Column[@name = "IsDnfbp"]))then(
                <ns3:IsDnfbp>{fn:data($Output/ns1:RowSet[9]/ns1:Row[1]/ns1:Column[@name = "IsDnfbp"])}</ns3:IsDnfbp>
              )else()
            }
            {
              if(fn:data($Output/ns1:RowSet[9]/ns1:Row[1]/ns1:Column[@name = "AppliedMeasure"]))then(
                <ns3:AppliedMeasure>{fn:data($Output/ns1:RowSet[9]/ns1:Row[1]/ns1:Column[@name = "AppliedMeasure"])}</ns3:AppliedMeasure>
              )else()
            }
            {
              if(fn:data($Output/ns1:RowSet[9]/ns1:Row[1]/ns1:Column[@name = "CustomerRisk"]))then(
                <ns3:CustomerRisk>{fn:data($Output/ns1:RowSet[9]/ns1:Row[1]/ns1:Column[@name = "CustomerRisk"])}</ns3:CustomerRisk>
              )else()
            }
        </ns3:RegulationsInfo>
    </ns3:getCustomerDetailsResponse>
};

local:func($uuid, $Output, $GetCatalogsEquivalenceResponse)