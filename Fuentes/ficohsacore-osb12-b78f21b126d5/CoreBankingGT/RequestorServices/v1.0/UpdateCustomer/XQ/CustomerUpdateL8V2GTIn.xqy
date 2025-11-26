xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns3="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../CreditCardProcessor/ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogsEquivalence";
(:: import schema at "../../../../../CoreBankingHN/ProviderServices/XSD/GetCatalogsEquivalence/GetCatalogsEquivalence_sp.xsd" ::)

declare variable $customerId as xs:string external;
declare variable $UpdateCustomerRequest as element() (:: schema-element(ns1:updateCustomerRequest) ::) external;
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

declare function local:func($UpdateCustomerRequest as element() (:: schema-element(ns1:updateCustomerRequest) ::), 
                            $GetCatalogsEquivalenceResponse as element() (:: schema-element(ns2:OutputParameters) ::),
                            $customerId as xs:string) 
                            as element() (:: schema-element(ns3:CustomerUpdateL8V2Request) ::) {
    <ns3:CustomerUpdateL8V2Request>
                <AZXGCI-ORG>{fn:data($UpdateCustomerRequest/ns1:Org)}</AZXGCI-ORG>
                <AZXGCI-CARD-NBR>{fn:data($customerId)}</AZXGCI-CARD-NBR>
                <AZXGCI-NBR-TYPE>1</AZXGCI-NBR-TYPE>
                <AZXGCI-FOREIGN-USE>0</AZXGCI-FOREIGN-USE>
                <AZXGCI-DEMOGRAPHIC-DATAIND>1</AZXGCI-DEMOGRAPHIC-DATAIND>
                <AZXGCI-USER-DATA-IND>1</AZXGCI-USER-DATA-IND>
                <AZXGCI-VIP-STATUS>1</AZXGCI-VIP-STATUS>
                <AZXGCI-STATUS>0</AZXGCI-STATUS>
                <AZXGCI-SIC-CODE xsi:nil="true"/>
                <AZXGCI-TITLE xsi:nil="true"/>
                { 
                    let $maritalStatus := fn:upper-case(fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:MaritalStatus/text()))
                    return
                        if($maritalStatus != "") then
                            <AZXGCI-MARITAL-STATUS>{ local:CatalogValueOSBToAPP($maritalStatus, 'VISION+GT', '2', $GetCatalogsEquivalenceResponse) }</AZXGCI-MARITAL-STATUS>
                        else
                            <AZXGCI-MARITAL-STATUS xsi:nil="true"/>
                }
                <AZXGCI-NAME-LINE-1 xsi:nil="true"/>
                <AZXGCI-NAME-LINE-1-TYP xsi:nil="true"/> 
                <AZXGCI-NAME-LINE-2 xsi:nil="true"/>
                <AZXGCI-NAME-LINE-2-TYP xsi:nil="true"/>
                <AZXGCI-NAME-LINE-3 xsi:nil="true"/>		
                <AZXGCI-NAME-LINE-3-TYP xsi:nil="true"/>		     
                {
                    let $houseNumber := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"][1]/ns1:HouseNumber/text())
                    return 
                        if($houseNumber != "") then
                            <AZXGCI-HOUSE-NBR>{ $houseNumber }</AZXGCI-HOUSE-NBR>
                        else
                            <AZXGCI-HOUSE-NBR xsi:nil="true"/>
                }
                {
                    let $houseName := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"][1]/ns1:Domicile/text())
                    return 
                        if($houseName != "") then
                            <AZXGCI-HOUSE-NAME>{ $houseName }</AZXGCI-HOUSE-NAME>
                        else
                            <AZXGCI-HOUSE-NAME xsi:nil="true"/>
                }
                {
                    let $homeAddressLine1 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"][1]/ns1:AddressLine1/text())
                    let $homeAddressLine2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"][1]/ns1:AddressLine2/text())
                    let $houseAddress := concat($homeAddressLine1, ' ', $homeAddressLine2)
                    return (
                        if($houseAddress != "") then (
                            <AZXGCI-ADDR-1>{ fn:substring($houseAddress, 1, 40) }</AZXGCI-ADDR-1>,
                            <AZXGCI-ADDR-2>{ fn:substring($houseAddress, 42, 40) }</AZXGCI-ADDR-2>
                        ) else (
                            <AZXGCI-ADDR-1 xsi:nil="true"/>,
                            <AZXGCI-ADDR-2 xsi:nil="true"/>
                        )
                    )
                }
                {
                    let $references := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"][1]/ns1:References/text())
                    return (
                        if($references != "") then (
                            <AZXGCI-ADDR-3>{ fn:substring($references, 1, 40) }</AZXGCI-ADDR-3>,
                            <AZXGCI-ADDR-4>{ fn:substring($references, 41, 40) }</AZXGCI-ADDR-4>
                        ) else (
                            <AZXGCI-ADDR-3 xsi:nil="true"/>,
                            <AZXGCI-ADDR-4 xsi:nil="true"/>
                        )
                    )
                }
                {
                    let $state := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"][1]/ns1:StateCode/text())
                    return 
                        if($state != "") then
                            <AZXGCI-CITY>{ local:CatalogValueOSBToAPP($state, 'VISION+GT', '8', $GetCatalogsEquivalenceResponse) }</AZXGCI-CITY>
                        else
                            <AZXGCI-CITY xsi:nil="true"/>
                }
                {
                    let $city := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"][1]/ns1:CityCode/text())
                    return (
                        if($city != "") then (
                            <AZXGCI-STATE>{ local:CatalogValueOSBToAPP($city, 'VISION+GT', '7', $GetCatalogsEquivalenceResponse) }</AZXGCI-STATE>,
                            <AZXGCI-PSTL-CD>{ local:CatalogValueOSBToAPP($city, 'VISION+GT', '7', $GetCatalogsEquivalenceResponse) }</AZXGCI-PSTL-CD>
                        ) else (
                            <AZXGCI-STATE xsi:nil="true"/>,
                            <AZXGCI-PSTL-CD xsi:nil="true"/>
                        )
                    )
                }
                {
                    let $country := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"][1]/ns1:CountryCode/text())
                    return 
                        if($country != "") then
                            <AZXGCI-CNTRY-CD>{ local:CatalogValueOSBToAPP($country, 'VISION+GT', '9', $GetCatalogsEquivalenceResponse) }</AZXGCI-CNTRY-CD>
                        else
                            <AZXGCI-CNTRY-CD xsi:nil="true"/>
                }
                <AZXGCI-OWN-RENT-RESID-FLAG>1</AZXGCI-OWN-RENT-RESID-FLAG>		
                <AZXGCI-LANGUAGE-IND>ESP</AZXGCI-LANGUAGE-IND>		
        	<AZXGCI-MAILING-LIST>N</AZXGCI-MAILING-LIST>		
                <AZXGCI-CONTACT-IND>0</AZXGCI-CONTACT-IND>
                {
                    let $gender := fn:upper-case(fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Gender/text()))
                    return 
                        if($gender != "") then
                            <AZXGCI-GENDER-CODE>{ local:CatalogValueOSBToAPP(data($gender), 'VISION+GT', '1', $GetCatalogsEquivalenceResponse) }</AZXGCI-GENDER-CODE>
                        else
                            <AZXGCI-GENDER-CODE xsi:nil="true"/>
                }
                {
                    let $homePhoneNumber := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "LANDLINE"][1]/ns1:Number/text())
                    return 
                        if($homePhoneNumber != "") then
                            <AZXGCI-HOME-PHONE>{ $homePhoneNumber }</AZXGCI-HOME-PHONE>
                        else
                            <AZXGCI-HOME-PHONE xsi:nil="true"/>
                }
                <AZXGCI-HOME-PHONE-IND xsi:nil="true"/>
                {
                    let $faxPhone := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "FAX"][1]/ns1:Number/text())
                    return 
                        if($faxPhone != "") then
                            <AZXGCI-FAX-PHONE>{ $faxPhone }</AZXGCI-FAX-PHONE>		
                        else
                            <AZXGCI-FAX-PHONE xsi:nil="true"/>
                }
                <AZXGCI-FAX-PHONE-IND xsi:nil="true"/>
                {
                    let $mobilePhone := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "MOBILE"][1]/ns1:Number/text())
                    return 
                        if($mobilePhone != "") then
                            <AZXGCI-MOBILE-PHONE>{ $mobilePhone }</AZXGCI-MOBILE-PHONE>
                        else
                            <AZXGCI-MOBILE-PHONE xsi:nil="true"/>
                }
                <AZXGCI-MOBILE-PHONE-IND xsi:nil="true"/>
                {
                    let $birthDate := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:BirthDate/text())
                    return 
                        if($birthDate != "") then
                            <AZXGCI-DOB>{ fn-bea:date-to-string-with-format("yyyyDDD", xs:date($birthDate)) }</AZXGCI-DOB>
                        else
                            <AZXGCI-DOB xsi:nil="true"/>
                }
                {
                    let $nacionality := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Nationality/text())
                    return 
                        if($nacionality != "") then
                            <AZXGCI-DL-CNTRY>{ $nacionality }</AZXGCI-DL-CNTRY>
                        else
                            <AZXGCI-DL-CNTRY xsi:nil="true"/>
                }
                <AZXGCI-DL-STATE xsi:nil="true"/>
                {
                    let $driversLicense := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "LICENCIA" or fn:upper-case(ns1:DocumentName) = "NUMERO DE ID TRIBUTA (NIT)"]/ns1:LegalId/text())
                    return 
                        if($driversLicense != "") then
                            <AZXGCI-DL-NBR>{ $driversLicense }</AZXGCI-DL-NBR>
                        else
                            <AZXGCI-DL-NBR xsi:nil="true"/>
                }
                {
                    let $documentType := fn:upper-case(fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "DOCTO PERSONAL DE ID (DPI)" or fn:upper-case(ns1:DocumentName) = "PASAPORTE"]/ns1:DocumentName/text()))
                    return 
                        if($documentType != "") then
                            <AZXGCI-TAX-ID-TYP>{ local:CatalogValueOSBToAPP(data($documentType), 'VISION+GT', '4', $GetCatalogsEquivalenceResponse) }</AZXGCI-TAX-ID-TYP>		
                        else
                            <AZXGCI-TAX-ID-TYP xsi:nil="true"/>
                }
                {
                    let $documentId := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "DOCTO PERSONAL DE ID (DPI)" or fn:upper-case(ns1:DocumentName) = "PASAPORTE"]/ns1:LegalId/text())
                    return 
                        if($documentId != "") then
                            <AZXGCI-TAX-ID>{ $documentId }</AZXGCI-TAX-ID>
                        else
                            <AZXGCI-TAX-ID xsi:nil="true"/>
                }
                <AZXGCI-1099C-W9-DATE-FILED xsi:nil="true"/>
                {
                    let $workPlace := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:CompanyName/text())
                    return 
                        if($workPlace != "") then
                            <AZXGCI-EMPLOYER>{ $workPlace }</AZXGCI-EMPLOYER>
                        else
                            <AZXGCI-EMPLOYER xsi:nil="true"/>
                }
                {
                    let $workAddressLine1 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"][1]/ns1:AddressLine1/text())
                    let $workAddressLine2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"][1]/ns1:AddressLine2/text())
                    let $workAddress := concat($workAddressLine1, ' ', $workAddressLine2)
                    return (
                        if($workAddress != "") then (
                            <AZXGCI-EMPLOYER-ADDR-1>{ fn:substring($workAddress, 1, 40) }</AZXGCI-EMPLOYER-ADDR-1>,
                            <AZXGCI-EMPLOYER-ADDR-2>{ fn:substring($workAddress, 42, 40) }</AZXGCI-EMPLOYER-ADDR-2>
                        ) else (
                            <AZXGCI-EMPLOYER-ADDR-1 xsi:nil="true"/>,
                            <AZXGCI-EMPLOYER-ADDR-2 xsi:nil="true"/>
                        )
                    )
                }
                {
                    let $workPhoneNumber := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "REFERENCE" and ns1:Location="2"][1]/ns1:Number/text())
                    return 
                        if($workPhoneNumber != "") then
                            <AZXGCI-EMP-PHONE>{ $workPhoneNumber }</AZXGCI-EMP-PHONE>
                        else
                            <AZXGCI-EMP-PHONE xsi:nil="true"/>
                }
                {
                    let $workFax := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "FAX" and ns1:Location="2"][1]/ns1:Number/text())
                    return 
                        if($workFax != "") then
                            <AZXGCI-EMP-PHONE-EXTN>{ $workFax }</AZXGCI-EMP-PHONE-EXTN>
                        else
                            <AZXGCI-EMP-PHONE-EXTN xsi:nil="true"/>
                }
                <AZXGCI-EMP-PHONE-FLAG xsi:nil="true"/>
                {
                    let $profession := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:ProfessionCode/text())
                    return 
                        if($profession != "") then
                            <AZXGCI-POSITION>{ local:CatalogValueOSBToAPP($profession, 'VISION+GT', '3', $GetCatalogsEquivalenceResponse) }</AZXGCI-POSITION>
                        else
                            <AZXGCI-POSITION xsi:nil="true"/>
                }
                {
                    let $relativeName := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SpouseName/text())
                    return 
                        if($relativeName != "") then
                            <AZXGCI-RELATIVE-NAME>{ $relativeName }</AZXGCI-RELATIVE-NAME>
                        else
                            <AZXGCI-RELATIVE-NAME xsi:nil="true"/>
                }
                {
                    let $dependents := fn:string($UpdateCustomerRequest/ns1:NumberOfDependents/text())
                    return 
                        if($dependents != "") then
                            <AZXGCI-NBR-OF-DEPENDENTS>{ $dependents }</AZXGCI-NBR-OF-DEPENDENTS>
                        else
                            <AZXGCI-NBR-OF-DEPENDENTS xsi:nil="true"/>
                }
                {
                    let $email := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:EmailList[fn:upper-case(ns1:IsMain) = "YES"][1]/ns1:Email/text())
                    return 
                        if($email != "") then
                            <AZXGCI-EMAIL>{ $email }</AZXGCI-EMAIL>
                        else
                            <AZXGCI-EMAIL xsi:nil="true"/>
                }
                <AZXGCI-EMAIL-IND xsi:nil="true"/>
                <AZXGCI-SMS-IND xsi:nil="true"/>
                {
                    let $customerInfoItem := $UpdateCustomerRequest/ns1:CustomerInfo
                    let $firstName := fn:string($customerInfoItem/ns1:FirstName/text())
                    let $secondName := fn:string($customerInfoItem/ns1:SecondName/text())
                    let $thirdName := fn:string($customerInfoItem/ns1:ThirdName/text())
                    return (
                        if($firstName != "" and $secondName != "" and $thirdName != "") then (
                            <AZXGCI-FIRST-NAME>{ fn:normalize-space(concat($firstName, ' ', $secondName, ' ', $thirdName)) }</AZXGCI-FIRST-NAME>
                        ) else if($firstName != "" and $secondName != "") then (
                            <AZXGCI-FIRST-NAME>{ fn:normalize-space(concat($firstName, ' ', $secondName)) }</AZXGCI-FIRST-NAME>
                        ) else if($firstName != "") then (
                            <AZXGCI-FIRST-NAME>{ fn:normalize-space($firstName) }</AZXGCI-FIRST-NAME>
                        ) else (
                            <AZXGCI-FIRST-NAME xsi:nil="true"/>
                        )
                    )
                }
                <AZXGCI-MIDDLE-NAME xsi:nil="true"/>
                {
                    let $customerInfoItem := $UpdateCustomerRequest/ns1:CustomerInfo
                    let $firstLastName := fn:string($customerInfoItem/ns1:FirstLastName/text())
                    let $secondLastName := fn:string($customerInfoItem/ns1:SecondLastName/text())
                    return (
                        if($firstLastName != "" and $secondLastName != "") then (
                            <AZXGCI-LAST-NAME>{ fn:normalize-space(concat($firstLastName, ' ', $secondLastName)) }</AZXGCI-LAST-NAME>
                        ) else if($firstLastName != "") then (
                            <AZXGCI-LAST-NAME>{ fn:normalize-space($firstLastName) }</AZXGCI-LAST-NAME>
                        ) else (
                            <AZXGCI-LAST-NAME xsi:nil="true"/>
                        )
                    )
                }
                <AZXGCI-SUFFIX xsi:nil="true"/>
                {
                    let $birthCountry := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:BirthCountry/text())
                    return 
                        if($birthCountry != "") then
                            <AZXGCI-COUNTY>{ $birthCountry }</AZXGCI-COUNTY>
                        else
                            <AZXGCI-COUNTY xsi:nil="true"/>
                }
                {
                    let $chanelCode := fn:string($UpdateCustomerRequest/ns1:ChanelCode/text())
                    return 
                        if($chanelCode != "") then
                            <AZXGCI-MEMO-1>{ $chanelCode }</AZXGCI-MEMO-1>
                        else
                            <AZXGCI-MEMO-1 xsi:nil="true"/>
                }
                <AZXGCI-MEMO-2 xsi:nil="true"/>
                {
                    let $employmentYears := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:EmploymentYears/text())
                    return 
                        if($employmentYears != "") then
                            <AZXGCI-USER-1>{ $employmentYears }</AZXGCI-USER-1>
                        else
                            <AZXGCI-USER-1 xsi:nil="true"/>
                }
                {
                    let $employmentMonths := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:EmploymentMonths/text())
                    return 
                        if($employmentMonths != "") then
                            <AZXGCI-USER-2>{ $employmentMonths }</AZXGCI-USER-2>
                        else
                            <AZXGCI-USER-2 xsi:nil="true"/>
                }
                {
                    let $jobTitle := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:JobTitle/text())
                    return 
                        if($jobTitle != "") then
                            <AZXGCI-USER-3>{ $jobTitle }</AZXGCI-USER-3>
                        else
                            <AZXGCI-USER-3 xsi:nil="true"/>
                }
                <AZXGCI-USER-4 xsi:nil="true"/>
                <AZXGCI-USER-5 xsi:nil="true"/>
                {
                    let $segment := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Segment/text())
                    return 
                        if($segment != "") then
                            <AZXGCI-USER-6>{ $segment }</AZXGCI-USER-6>
                        else
                            <AZXGCI-USER-6 xsi:nil="true"/>
                }
                <AZXGCI-USER-7 xsi:nil="true"/>
                {
                    let $isPep := string($UpdateCustomerRequest/ns1:IsPep/text())
                    return (
                        if($isPep != "")then(
                            if(fn:upper-case($isPep) = "YES")then(
                              <AZXGCI-USER-8>Y</AZXGCI-USER-8>
                            )else(
                              <AZXGCI-USER-8>N</AZXGCI-USER-8>
                            )
                        )else(
                            <AZXGCI-USER-8/>	            	
                        )
                    )
                }
                <AZXGCI-USER-9 xsi:nil="true"/>
                {
                    let $expirationDate := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "DOCTO PERSONAL DE ID (DPI)" or fn:upper-case(ns1:DocumentName) = "PASAPORTE"]/ns1:MaturityDate/text())
                    return 
                        if($expirationDate != "") then
                            <AZXGCI-USER-10>{ fn-bea:date-to-string-with-format("yyyyDDD", xs:date($expirationDate)) }</AZXGCI-USER-10>
                        else
                            <AZXGCI-USER-10 xsi:nil="true"/>
                }
                {
                    let $issueDate := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "DOCTO PERSONAL DE ID (DPI)" or fn:upper-case(ns1:DocumentName) = "PASAPORTE"]/ns1:DateOfIssuance/text())
                    return 
                        if($issueDate != "") then
                            <AZXGCI-USER-11>{ fn-bea:date-to-string-with-format("yyyyDDD", xs:date($issueDate)) }</AZXGCI-USER-11>
                        else
                            <AZXGCI-USER-11 xsi:nil="true"/>
                }
                {
                    let $countryIssuePassport := fn:string($UpdateCustomerRequest/ns1:CountryIssuePassport/text())
                    return 
                        if($countryIssuePassport != "") then
                            <AZXGCI-USER-12>{ $countryIssuePassport }</AZXGCI-USER-12>
                        else
                            <AZXGCI-USER-12 xsi:nil="true"/>
                }
                <AZXGCI-USER-13 xsi:nil="true"/>
                {
                    let $educationLevel := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:EducationLevel/text())
                    return 
                        if($educationLevel != "") then
                            <AZXGCI-USER-14>{ $educationLevel }</AZXGCI-USER-14>
                        else
                            <AZXGCI-USER-14 xsi:nil="true"/>
                }
                {
                    let $incomeRange := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:IncomeRange/text())
                    return 
                        if($incomeRange != "") then
                            <AZXGCI-USER-15>{ $incomeRange }</AZXGCI-USER-15>
                        else
                            <AZXGCI-USER-15 xsi:nil="true"/>
                }
                {
                    let $othersIncomes := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount/text())
                    return 
                        if($othersIncomes != "") then
                            <AZXGCI-USER-DEMO-1>{ $othersIncomes }</AZXGCI-USER-DEMO-1>
                        else
                            <AZXGCI-USER-DEMO-1 xsi:nil="true"/>
                }
                {
                    let $nacionality := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Nationality/text())
                    return 
                        if($nacionality != "") then
                            <AZXGCI-USER-DEMO-2>{ $nacionality }</AZXGCI-USER-DEMO-2>
                        else
                            <AZXGCI-USER-DEMO-2 xsi:nil="true"/>
                }
                {
                let $FLYER_TYPE := fn:data($UpdateCustomerRequest/ns1:FrequentFlyer/ns1:FlyerType)
                let $FLYER_NUMBER := fn:data($UpdateCustomerRequest/ns1:FrequentFlyer/ns1:FrequentFlyerNumber)
                return(
                  if($FLYER_TYPE != 'LM')then(
                    <AZXGCI-USER-DEMO-3 xsi:nil="true"/>
                  )else(
                    <AZXGCI-USER-DEMO-3>{fn:data($FLYER_NUMBER)}</AZXGCI-USER-DEMO-3>
                  )
                )
              }
                <AZXGCI-1099C-FOREIGN-IND xsi:nil="true"/>
                <AZXGCI-CR-1-2 xsi:nil="true"/>
                <AZXGCI-CR-3-4 xsi:nil="true"/>
                <AZXGCI-1099C-W9-DATE-SENT xsi:nil="true"/>
                <AZXGCI-STMT-MSG-INDIC xsi:nil="true"/>
                 {
                let $FLYER_TYPE := fn:data($UpdateCustomerRequest/ns1:FrequentFlyer/ns1:FlyerType)
                let $FLYER_NUMBER := fn:data($UpdateCustomerRequest/ns1:FrequentFlyer/ns1:FrequentFlyerNumber)
                return(
                  if($FLYER_TYPE != 'AA')then(
                    <AZXGCI-FF-NUMBER xsi:nil="true"/>
                  )else(
                    <AZXGCI-FF-NUMBER>{fn:data($FLYER_NUMBER)}</AZXGCI-FF-NUMBER>
                  )
                )
              }
                <AZXGCI-STMT-MSG-2-INDIC>1</AZXGCI-STMT-MSG-2-INDIC>		
                <AZXGCI-ADDR-2-INDIC>B</AZXGCI-ADDR-2-INDIC>		
                <AZXGCI-ADDR-3-INDIC>O</AZXGCI-ADDR-3-INDIC>
                {
                    let $workAddressLine1 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"][1]/ns1:AddressLine1/text())
                    let $workAddressLine2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"][1]/ns1:AddressLine2/text())
                    let $workAddress := concat($workAddressLine1, ' ', $workAddressLine2)
                    return (
                        if($workAddress != "") then (
                            <AZXGCI-ADDR-2-LINE-1>{ fn:substring($workAddress, 1, 40) }</AZXGCI-ADDR-2-LINE-1>,
                            <AZXGCI-ADDR-2-LINE-2>{ fn:substring($workAddress, 42, 40) }</AZXGCI-ADDR-2-LINE-2>
                        ) else (
                            <AZXGCI-ADDR-2-LINE-1 xsi:nil="true"/>,
                            <AZXGCI-ADDR-2-LINE-2 xsi:nil="true"/>
                        )
                    )
                }
                {
                    let $references := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"[1]]/ns1:References/text())
                    return 
                        if($references != "") then
                            <AZXGCI-ADDR-2-LINE-3>{ $references }</AZXGCI-ADDR-2-LINE-3>
                        else
                            <AZXGCI-ADDR-2-LINE-3 xsi:nil="true"/>
                }
                {
                    let $state := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"][1]/ns1:StateCode/text())
                    return 
                        if($state != "") then
                            <AZXGCI-CITY-2>{ local:CatalogValueOSBToAPP($state, 'VISION+GT', '8', $GetCatalogsEquivalenceResponse) }</AZXGCI-CITY-2>
                        else
                            <AZXGCI-CITY-2 xsi:nil="true"/>
                }
                {
                    let $city := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"][1]/ns1:CityCode/text())
                    return
                        if($city != "") then
                            <AZXGCI-PSTL-CD-2>{ local:CatalogValueOSBToAPP($city, 'VISION+GT', '7', $GetCatalogsEquivalenceResponse) }</AZXGCI-PSTL-CD-2>
                        else
                            <AZXGCI-PSTL-CD-2 xsi:nil="true"/>
                }
                {
                    let $country := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"][1]/ns1:CountryCode/text())
                    return 
                        if($country != "") then
                            <AZXGCI-CNTRY-CD-2>{ local:CatalogValueOSBToAPP($country, 'VISION+GT', '9', $GetCatalogsEquivalenceResponse) }</AZXGCI-CNTRY-CD-2>
                        else
                            <AZXGCI-CNTRY-CD-2 xsi:nil="true"/>
                }
                {
                    let $workAddressLine1 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"][1]/ns1:AddressLine1/text())
                    let $workAddressLine2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"][1]/ns1:AddressLine2/text())
                    let $workAddress := concat($workAddressLine1, ' ', $workAddressLine2)
                    return (
                        if($workAddress != "") then (
                            <AZXGCI-ADDR-3-LINE-1>{ fn:substring($workAddress, 1, 40) }</AZXGCI-ADDR-3-LINE-1>,
                            <AZXGCI-ADDR-3-LINE-2>{ fn:substring($workAddress, 42, 40) }</AZXGCI-ADDR-3-LINE-2>
                        ) else (
                            <AZXGCI-ADDR-3-LINE-1 xsi:nil="true"/>,
                            <AZXGCI-ADDR-3-LINE-2 xsi:nil="true"/>
                        )
                    )
                }
                {
                    let $references := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"[1]]/ns1:References/text())
                    return 
                        if($references != "") then
                            <AZXGCI-ADDR-3-LINE-3>{ $references }</AZXGCI-ADDR-3-LINE-3>
                        else
                            <AZXGCI-ADDR-3-LINE-3 xsi:nil="true"/>
                }
                {
                    let $state := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"][1]/ns1:StateCode/text())
                    return 
                        if($state != "") then
                            <AZXGCI-CITY-3>{ local:CatalogValueOSBToAPP($state, 'VISION+GT', '8', $GetCatalogsEquivalenceResponse) }</AZXGCI-CITY-3>
                        else
                            <AZXGCI-CITY-3 xsi:nil="true"/>
                }
                {
                    let $city := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"][1]/ns1:CityCode/text())
                    return
                        if($city != "") then
                            <AZXGCI-PSTL-CD-3>{ local:CatalogValueOSBToAPP($city, 'VISION+GT', '7', $GetCatalogsEquivalenceResponse) }</AZXGCI-PSTL-CD-3>
                        else
                            <AZXGCI-PSTL-CD-3 xsi:nil="true"/>
                }
                {
                    let $country := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"][1]/ns1:CountryCode/text())
                    return 
                        if($country != "") then
                            <AZXGCI-CNTRY-CD-3>{ local:CatalogValueOSBToAPP($country, 'VISION+GT', '9', $GetCatalogsEquivalenceResponse) }</AZXGCI-CNTRY-CD-3>
                        else
                            <AZXGCI-CNTRY-CD-3 xsi:nil="true"/>
                }
                <AZXGCI-USER-DATE-3 xsi:nil="true"/>
                <AZXGCI-INCOME xsi:nil="true"/>
                <AZXGCI-CUIT>0</AZXGCI-CUIT>
                <AZXGCI-OCCUP-CODE xsi:nil="true"/>
                <AZXGCI-IVA-POSITION xsi:nil="true"/>
    </ns3:CustomerUpdateL8V2Request>
};

local:func($UpdateCustomerRequest, $GetCatalogsEquivalenceResponse, $customerId)