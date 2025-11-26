(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CustomerOperations/XMLSchema_210494809.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/getCustomerDetailsTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerDetailsTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/customerOperationsOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $uuid as xs:string external;
declare variable $consultadeclienteResponse as element() (:: schema-element(ns2:ConsultaClientesparaDYNAMOResponse) ::) external;

declare function xq:type-of-person 
  ( $sector as xs:string )  as xs:string {
  if (fn:string($sector) = "1000" or fn:string($sector) = "1001") then (
  	"N"
  ) else (
  	"J"
  )
};

declare function xq:type-of-address 
  ( $type as xs:string )  as xs:string {
  if (fn:string($type) = "1") then (
  	"HOME"
  ) else if (fn:string($type) = "2") then (
  	"WORK"
  ) else (
  	"OTHER"
  )
};

declare function ns1:customerOperationsOut($uuid as xs:string, 
                                           $consultadeclienteResponse as element() (:: schema-element(ns2:ConsultaClientesparaDYNAMOResponse) ::)) 
                                           as element() (:: schema-element(ns3:getCustomerDetailsResponse) ::) {
    <ns3:getCustomerDetailsResponse>
        <ns3:StatusInfo>
            {
                if ($consultadeclienteResponse/Status/successIndicator)
                then <com:Status>{fn:data($consultadeclienteResponse/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($consultadeclienteResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($consultadeclienteResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:BasicInfo>
            <ns3:CustomerId>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/CUSTOMER)}</ns3:CustomerId>
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/MNEMONIC)
                then <ns3:Mnemonic>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/MNEMONIC)}</ns3:Mnemonic>
                else ()
            }
            <ns3:IdentificationInfo>
                <ns3:LegalDocumentType>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALDOCNAME)}</ns3:LegalDocumentType>
                <ns3:LegalId>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALID)}</ns3:LegalId>
                {
                    if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALISSDATE)
                    then <ns3:IssuedDate>{concat(fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALISSDATE),0,5),'-',fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALISSDATE),5,2),'-',fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALISSDATE),7,2))}</ns3:IssuedDate>
                    else ()
                }
            </ns3:IdentificationInfo>
            {
              if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRRTN and (string($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRRTN/text()) != '')) then
                  <ns3:IdentificationInfo>
                      <ns3:LegalDocumentType>RTN</ns3:LegalDocumentType>
                      <ns3:LegalId>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRRTN)}</ns3:LegalId>
                  </ns3:IdentificationInfo>
              else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/GIVENNAMES)
                then <ns3:GivenNames>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/GIVENNAMES)}</ns3:GivenNames>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/FAMILYNAMES)
                then <ns3:FamilyName>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/FAMILYNAMES)}</ns3:FamilyName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/GIVENNAMES)
                then <ns3:FullName>{concat(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/GIVENNAMES), ' ', fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/FAMILYNAMES))}</ns3:FullName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/NAMEOFBUSINESS)
                then <ns3:NameBusiness>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/NAMEOFBUSINESS)}</ns3:NameBusiness>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/COMMERCIALNAME)
                then <ns3:CommercialName>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/COMMERCIALNAME)}</ns3:CommercialName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALHOLDERNAME)
                then <ns3:LegalHolderName>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALHOLDERNAME)}</ns3:LegalHolderName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SHORTNAME)
                then <ns3:ShortName>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SHORTNAME)}</ns3:ShortName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATEOFBIRTH)
                then <ns3:DateBirth>{concat(fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATEOFBIRTH),0,5), '-',fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATEOFBIRTH),5,2), '-',fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATEOFBIRTH),7,2))}</ns3:DateBirth>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/GENDER)
                then <ns3:Gender>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/GENDER)}</ns3:Gender>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/NATIONALITY)
                then <ns3:Nationality>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/NATIONALITY)}</ns3:Nationality>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/RESIDENCE)
                then <ns3:Residence>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/RESIDENCE)}</ns3:Residence>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/MARITALSTATUS)
                then <ns3:MaritalStatus>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/MARITALSTATUS)}</ns3:MaritalStatus>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/MARRIEDLASTNAME)
                then <ns3:MarriedLastName>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/MARRIEDLASTNAME)}</ns3:MarriedLastName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SPOUSENAME)
                then <ns3:SpouseName>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SPOUSENAME)}</ns3:SpouseName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALREPID)
                then <ns3:LegalRepresentativeId>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALREPID)}</ns3:LegalRepresentativeId>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALREPNAME)
                then <ns3:LegalRepresentativeName>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LEGALREPNAME)}</ns3:LegalRepresentativeName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/PLACEOFBIRTH)
                then <ns3:PlaceBirth>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/PLACEOFBIRTH)}</ns3:PlaceBirth>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DESPLACEOFBIRTH)
                then <ns3:PlaceBirthDescription>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DESPLACEOFBIRTH)}</ns3:PlaceBirthDescription>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TOWNCOUNTRY)
                then <ns3:CountryBirth>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TOWNCOUNTRY)}</ns3:CountryBirth>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DESTOWNCOUNTRY)
                then <ns3:CountryBirthDescription>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DESTOWNCOUNTRY)}</ns3:CountryBirthDescription>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SECTOR)
                then <ns3:Sector>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SECTOR)}</ns3:Sector>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SECTORNAME)
                then <ns3:SectorDescription>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SECTORNAME)}</ns3:SectorDescription>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INDUSTRY)
                then <ns3:Industry>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INDUSTRY)}</ns3:Industry>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INDUSTRYNAME)
                then <ns3:IndustryDescription>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INDUSTRYNAME)}</ns3:IndustryDescription>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TARGET)
                then <ns3:Target>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TARGET)}</ns3:Target>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TARGETNAME)
                then <ns3:TargetDescription>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TARGETNAME)}</ns3:TargetDescription>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/GENERATORTYPE)
                then <ns3:ForeignExchangeGenerator>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/GENERATORTYPE)}</ns3:ForeignExchangeGenerator>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/ACCOUNTOFFICER)
                then <ns3:AccountOfficer>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/ACCOUNTOFFICER)}</ns3:AccountOfficer>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/BRANCHCODE)
                then <ns3:BranchCode>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/BRANCHCODE)}</ns3:BranchCode>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SECTOR)
                then <ns3:TypePerson>{xq:type-of-person(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SECTOR))}</ns3:TypePerson>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/CUSTOMERTYPE)
                then <ns3:CustomerType>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/CUSTOMERTYPE)}</ns3:CustomerType>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/CUSTOMERSTATUS)
                then <ns3:CustomerStatus>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/CUSTOMERSTATUS)}</ns3:CustomerStatus>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRPROFILETYPE)
                then <ns3:CustomerProfileType>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRPROFILETYPE)}</ns3:CustomerProfileType>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/CUSTOMERSINCE)
                then <ns3:CustomerSince>{concat(fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/CUSTOMERSINCE),0,5),'-',fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/CUSTOMERSINCE),5,2),'-',fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/CUSTOMERSINCE),7,2))}</ns3:CustomerSince>
                else ()
            }
        </ns3:BasicInfo>
        <ns3:FinancialInfo>
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EDUCATIONLEVEL)
                then <ns3:LevelEducation>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EDUCATIONLEVEL)}</ns3:LevelEducation>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EMPLOYMENTSTATUS)
                then <ns3:EmploymentSatus>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EMPLOYMENTSTATUS)}</ns3:EmploymentSatus>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/OCCUPATION)
                then <ns3:Occupation>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/OCCUPATION)}</ns3:Occupation>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TYPEOFMERCHNT)
                then <ns3:MerchantType>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TYPEOFMERCHNT)}</ns3:MerchantType>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SMENAME)
                then <ns3:MerchantName>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/SMENAME)}</ns3:MerchantName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRGIRONEGOCIO)
                then <ns3:LineBusiness>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRGIRONEGOCIO)}</ns3:LineBusiness>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/PROFESIONTRADE)
                then <ns3:Profession>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/PROFESIONTRADE)}</ns3:Profession>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DESPROFESIONTRADE)
                then <ns3:ProfessionDescription>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DESPROFESIONTRADE)}</ns3:ProfessionDescription>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TYPEOFCOMPANY)
                then <ns3:CompanyType>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/TYPEOFCOMPANY)}</ns3:CompanyType>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EMPLOYERSNAME)
                then <ns3:EmployerName>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EMPLOYERSNAME)}</ns3:EmployerName>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/JOBTITLE)
                then <ns3:JobTitle>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/JOBTITLE)}</ns3:JobTitle>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/JOBDESCRIPTION)
                then <ns3:JobTitleDescription>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/JOBDESCRIPTION)}</ns3:JobTitleDescription>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EMPLOYMENTSTART)
                then <ns3:EmploymentStartDate>{concat(fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EMPLOYMENTSTART),0,5),'-',fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EMPLOYMENTSTART),5,2),'-',fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/EMPLOYMENTSTART),7,2))}</ns3:EmploymentStartDate>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/RESOURCEORIGIN)
                then <ns3:SourceIncome>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/RESOURCEORIGIN)}</ns3:SourceIncome>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/NOOFDEPENDENTS)
                then <ns3:NumberDependents>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/NOOFDEPENDENTS)}</ns3:NumberDependents>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INCOMERANGE)
                then <ns3:RangeIncome>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INCOMERANGE)}</ns3:RangeIncome>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INCOMECCY)
                then <ns3:IncomeCurrency>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INCOMECCY)}</ns3:IncomeCurrency>
                else ()
            }
        </ns3:FinancialInfo>
        {
            let $ADDRESS_TYPES := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/ADDRESSTYPE, "!!")
            let $MAIN_ADDRESS_YES_NO := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/MAINADDRESSYN, "!!")
            let $ADDRESS_LINE_1 := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/ADDRESSLINE1, "!!")
            let $ADDRESS_LINE_2 := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/ADDRESSLINE2, "!!")
            let $COUNTRY_CODE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/COUNTRYCODE, "!!")
            let $STATE_CODE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/STATECODE, "!!")
            let $STATECODEDES := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/STATECODEDES, "!!")
            let $CITY_CODE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/CITYCODE, "!!")
            let $CITYCODEDES := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/CITYCODEDES, "!!")
            let $COLONY_CODE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/COLONYCODE, "!!")
            let $COLONY_CODE_DESC := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/DESCOLONYCODEDES, "!!")
            let $NEIGBORHOOD := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/NEIGHBPENDING, "!!")
            let $AVENUE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/AVENUE, "!!")
            let $ADDRESS_STREET := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/ADDSTREET, "!!")
            let $BLOCK := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/BLOCK, "!!")
            let $HOUSE_NUMBER := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/HOUSENUMBER, "!!")
            let $ADDRESS_REFERENCES:= fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/REFERENCES, "!!")
            
            for $ADDRESS_TYPE at $i in $ADDRESS_TYPES
            return
                if ($ADDRESS_TYPE != "") then (
                    <ns3:AddressesInfo>
                        <ns3:AddressCode>{ $ADDRESS_TYPE }</ns3:AddressCode>
                        <ns3:AddressType>{ xq:type-of-address($ADDRESS_TYPE)}</ns3:AddressType>
                        {
                          if (string($MAIN_ADDRESS_YES_NO[$i]) != '')
                          then <ns3:IsMainAddress>{$MAIN_ADDRESS_YES_NO[$i]}</ns3:IsMainAddress>
                          else <ns3:IsMainAddress>NO</ns3:IsMainAddress>
                        }
                        <ns3:CountryCode>{ $COUNTRY_CODE[$i] }</ns3:CountryCode>
                        <ns3:DepartmentCode>{ $STATE_CODE[$i] }</ns3:DepartmentCode>
                        <ns3:DepartmentDesciption>{ $STATECODEDES[$i] }</ns3:DepartmentDesciption>
                        <ns3:MunicipalityCode>{ $CITY_CODE[$i] }</ns3:MunicipalityCode>
                        <ns3:MunicipalityDescripcion>{ $CITYCODEDES[$i] }</ns3:MunicipalityDescripcion>
                        <ns3:ColonyCode>{ $COLONY_CODE[$i] }</ns3:ColonyCode>
                        <ns3:ColonyDescripcion>{ $COLONY_CODE_DESC[$i] }</ns3:ColonyDescripcion>
                        <ns3:References>{ $ADDRESS_REFERENCES[$i] }</ns3:References>
                        <ns3:AddressLine1>{ $ADDRESS_LINE_1[$i] }</ns3:AddressLine1>
                        <ns3:AddressLine2>{ $ADDRESS_LINE_2[$i] }</ns3:AddressLine2>
                        <ns3:NeighborhoodPending>{ $NEIGBORHOOD[$i] }</ns3:NeighborhoodPending>
                        <ns3:Avenue>{ $AVENUE[$i] }</ns3:Avenue>
                        <ns3:Street>{ $ADDRESS_STREET[$i] }</ns3:Street>
                        <ns3:Block>{ $BLOCK[$i] }</ns3:Block>
                        <ns3:HouseNumber>{ $HOUSE_NUMBER[$i] }</ns3:HouseNumber>
                    </ns3:AddressesInfo>
                ) else ()    
        }
        {
            let $PHONE_NUMBER := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/PHONE/text(), "\|\|")
            let $PHONE_EXTENSION := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/EXTENSION, "!!")
            let $PHONE_REFERRENCE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/TELEPHONEREFER, "!!")
            for $PHONE_NUMBERR at $i in $PHONE_NUMBER
            return
                if ($PHONE_NUMBER != "") then (
                    <ns3:PhoneInfo>
                        <ns3:Id>{ $i }</ns3:Id>
                        <ns3:Type>LANDLINE</ns3:Type>
                        <ns3:PhoneNumber>{ $PHONE_NUMBER[$i] }</ns3:PhoneNumber>
                        <ns3:Extension>{ $PHONE_EXTENSION[$i] }</ns3:Extension>
                        <ns3:PhoneReference>{ $PHONE_REFERRENCE[$i] }</ns3:PhoneReference>
                    </ns3:PhoneInfo>
                ) else ()
        }
        {
            let $PHONE_NUMBER := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/SMS/text(), "\|\|")
            let $PHONE_REFERRENCE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/TELEPHONEREFER, "!!")
            for $PHONE_NUMBERR at $i in $PHONE_NUMBER
            return
                if ($PHONE_NUMBER != "") then (
                    <ns3:PhoneInfo>
                        <ns3:Id>{ $i }</ns3:Id>
                        <ns3:Type>MOBILE</ns3:Type>
                        <ns3:PhoneNumber>{ $PHONE_NUMBER[$i] }</ns3:PhoneNumber>
                        <ns3:PhoneReference>{ $PHONE_REFERRENCE[$i] }</ns3:PhoneReference>
                    </ns3:PhoneInfo>
                ) else ()
        }
        {
            let $EMAIL_ADDRES := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/EMAIL/text(),"\|\|")
            let $IS_MAIN_EMAIL := fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/LRMAINADELEC, "!!")
            for $EMAIL_ADDRESS at $i in $EMAIL_ADDRES
            return
                <ns3:EmailInfo>
                    <ns3:Id>{ $i }</ns3:Id>
                    <ns3:Email>{ $EMAIL_ADDRESS }</ns3:Email>
                    <ns3:IsMainEmail>{ $IS_MAIN_EMAIL[$i] }</ns3:IsMainEmail>
                </ns3:EmailInfo>
        }
        <ns3:ReferenceInfo>
            {
                let $NAMES  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/NAMEPERSREF, "!!"))  
                let $LAST_NAMES  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/SELSTNMPRRF, "!!"))
                let $RELATIONSHIP  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/RELWTHPERREF, "!!"))
                let $RELATIONSHIP_DESC  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/DESRELWTHPERREFDES, "!!"))
                let $PHONE  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/TELNOPERREF, "!!"))
                for $i  in (1 to max((count($NAMES))))
                return
                    <ns3:Personals>
                        <ns3:Id>{ $i }</ns3:Id>
                        <ns3:Names>{ $NAMES[$i] }</ns3:Names>
                        <ns3:LastNames>{ $LAST_NAMES[$i] }</ns3:LastNames>
                        <ns3:PhoneNumber>{ $PHONE[$i] }</ns3:PhoneNumber>
                        <ns3:RelationshipCode>{ $RELATIONSHIP[$i] }</ns3:RelationshipCode>
                        <ns3:RelationshipDescripcion>{ $RELATIONSHIP_DESC[$i] }</ns3:RelationshipDescripcion>
                    </ns3:Personals>
            }
        </ns3:ReferenceInfo>
        {
            let $TYPE  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/SECTORIZATIONTYPE, "!!"))  
            let $CODE  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/SECTORIZATIONCODE, "!!"))
            let $DESC  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERDYNType[1]/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType[1]/DESSECTORIZCODEDES, "!!"))   
            for $i  in (1 to max((count($TYPE), count($CODE))))  
            return
                if (($TYPE != "" or $CODE != "" or $DESC != "")) then
                    <ns3:SectorizationInfo>
                        <ns3:Type>{ $TYPE[$i] }</ns3:Type>
                        <ns3:Code>{ $CODE[$i] }</ns3:Code>
                        <ns3:Description>{ $DESC[$i] }</ns3:Description>
                    </ns3:SectorizationInfo>
                else ()
        }
        <ns3:RegulationsInfo>
            {
                if (fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRCUSAPNFDS) = "Y") then
                    <ns3:IsDnfbp>YES</ns3:IsDnfbp>
                else if (fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRCUSAPNFDS) = "N") then
                    <ns3:IsDnfbp>NO</ns3:IsDnfbp>
                else
                    <ns3:IsDnfbp></ns3:IsDnfbp>
            }
            <ns3:AppliedMeasure>NORMAL</ns3:AppliedMeasure>
            <ns3:CustomerRisk>Medio</ns3:CustomerRisk>
        </ns3:RegulationsInfo>
        <ns3:AuditInfo>
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INPUTTER)
                then <ns3:CreatedBy>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/INPUTTER)}</ns3:CreatedBy>
                else ()
            }
            {
                if ($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATETIME)
                then <ns3:DateTime>{concat('20', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATETIME),0,3),'-', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATETIME),3,2),'-', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATETIME),5,2),'T', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATETIME),7,2),':', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/DATETIME),9,2),':', '00')}</ns3:DateTime>
                else ()
            }
            <ns3:UpdateFrequency>{fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/REVIEWFREQUENCY)}</ns3:UpdateFrequency>
            <ns3:LastUpdatedDate>{ concat('20', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRFECOFI),0,3),'-', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRFECOFI),3,2),'-', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRFECOFI),5,2),'T', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRFECOFI),7,2),':', fn:substring(fn:data($consultadeclienteResponse/WSCUSTOMERDYNType/gWSCUSTOMERDYNDetailType/mWSCUSTOMERDYNDetailType/LRFECOFI),9,2),':', '00') }</ns3:LastUpdatedDate>
        </ns3:AuditInfo>
    </ns3:getCustomerDetailsResponse>
};

ns1:customerOperationsOut($uuid, $consultadeclienteResponse)