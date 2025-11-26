xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns3="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../CreditCardProcessor/ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogsEquivalence";
(:: import schema at "../../../../ProviderServices/XSD/GetCatalogsEquivalence/GetCatalogsEquivalence_sp.xsd" ::)

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
                      let $MARITAL_STATUS := fn:upper-case(fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:MaritalStatus/text()))
                      return 
                                if($MARITAL_STATUS != "") then (  
                                        <AZXGCI-MARITAL-STATUS>{ local:CatalogValueOSBToAPP($MARITAL_STATUS, 'VISION+HN', '2', $GetCatalogsEquivalenceResponse) }</AZXGCI-MARITAL-STATUS>
                                )else(
                                        <AZXGCI-MARITAL-STATUS xsi:nil="true"/>
                                )
                }
                <AZXGCI-NAME-LINE-1 xsi:nil="true"/>
                <AZXGCI-NAME-LINE-1-TYP xsi:nil="true"/> 
                <AZXGCI-NAME-LINE-2 xsi:nil="true"/>
                <AZXGCI-NAME-LINE-2-TYP xsi:nil="true"/>
                <AZXGCI-NAME-LINE-3 xsi:nil="true"/>		
                <AZXGCI-NAME-LINE-3-TYP xsi:nil="true"/>		     
                {
                      let $HOUSE_NUMBER := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:HouseNumber/text())
                      return 
                                if($HOUSE_NUMBER != "") then(
                                        <AZXGCI-HOUSE-NBR>{ $HOUSE_NUMBER }</AZXGCI-HOUSE-NBR>
                                )else(
                                        <AZXGCI-HOUSE-NBR xsi:nil="true"/>
                                )
                }
                {
                      let $HOUSE_NAME := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:Domicile/text())
                      return
                                if($HOUSE_NAME != "") then(
                                        <AZXGCI-HOUSE-NAME>{ $HOUSE_NAME }</AZXGCI-HOUSE-NAME>			
                                )else(
                                        <AZXGCI-HOUSE-NAME xsi:nil="true"/>
                                )
                }
        	{
        		
                      let $HOME_ADDRESS_LINE_1 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:AddressLine1/text())
                      let $HOME_ADDRESS_LINE_2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:AddressLine2/text())
                      let $HOME_ADDRESS := concat($HOME_ADDRESS_LINE_1, $HOME_ADDRESS_LINE_2)
                      return
                                if($HOME_ADDRESS != "")then(
                                        <AZXGCI-ADDR-1>{ fn:substring($HOME_ADDRESS, 1, 40) }</AZXGCI-ADDR-1>,
                                        <AZXGCI-ADDR-2>{ fn:substring($HOME_ADDRESS, 41, 40) }</AZXGCI-ADDR-2>
                                )else(
                                        <AZXGCI-ADDR-1 xsi:nil="true"/>,
                                        <AZXGCI-ADDR-2 xsi:nil="true"/>  	  	            	
                                )
                      
        	}
        	{
        		let $REFERENCES := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:References/text())
        		return
        			if($REFERENCES != "") then(
        				<AZXGCI-ADDR-3>{ fn:substring($REFERENCES, 1, 40) }</AZXGCI-ADDR-3>,
                                        <AZXGCI-ADDR-4>{ fn:substring($REFERENCES, 41, 40) }</AZXGCI-ADDR-4>
        			)else(
        				<AZXGCI-ADDR-3 xsi:nil="true"/>,
                                        <AZXGCI-ADDR-4 xsi:nil="true"/>
        			)
        	}
        	{
        		let $STATE := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:StateCode/text())
        		return
        			if($STATE != "") then(
        				<AZXGCI-CITY>{ local:CatalogValueOSBToAPP($STATE, 'VISION+HN', '8', $GetCatalogsEquivalenceResponse) }</AZXGCI-CITY>			
        			)else(
        				<AZXGCI-CITY xsi:nil="true"/>
        			)
        	}
        	{
        		let $CITY := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:CityCode/text())
        		return
        			if($CITY != "") then(
        				<AZXGCI-STATE>{ local:CatalogValueOSBToAPP($CITY, 'VISION+HN', '7', $GetCatalogsEquivalenceResponse) }</AZXGCI-STATE>		
        			)else(
        				<AZXGCI-STATE xsi:nil="true"/>
        			)
        	}
        	{
        		let $CITY := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:CityCode/text())
        		return
        			if($CITY != "") then(
						<AZXGCI-PSTL-CD>{ local:CatalogValueOSBToAPP($CITY, 'VISION+HN', '7', $GetCatalogsEquivalenceResponse) }</AZXGCI-PSTL-CD>        			
        			)else(
        				<AZXGCI-PSTL-CD xsi:nil="true"/>
        			)
        	}
        	{
				let $COUNTRY := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:CountryCode/text())
				return
					if($COUNTRY != "") then(
						<AZXGCI-CNTRY-CD>{ local:CatalogValueOSBToAPP($COUNTRY, 'VISION+HN', '9', $GetCatalogsEquivalenceResponse) }</AZXGCI-CNTRY-CD>		
					)else(
						<AZXGCI-CNTRY-CD xsi:nil="true"/>
					)
        	}
                <AZXGCI-OWN-RENT-RESID-FLAG>1</AZXGCI-OWN-RENT-RESID-FLAG>		
                <AZXGCI-LANGUAGE-IND>ESP</AZXGCI-LANGUAGE-IND>		
        	<AZXGCI-MAILING-LIST>N</AZXGCI-MAILING-LIST>		
                <AZXGCI-CONTACT-IND>0</AZXGCI-CONTACT-IND>		
                {
            	let $GENDER := fn:upper-case(fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Gender/text()))
        		return
        			if($GENDER != "") then(
        				<AZXGCI-GENDER-CODE>{ local:CatalogValueOSBToAPP(data($GENDER), 'VISION+HN', '1', $GetCatalogsEquivalenceResponse) }</AZXGCI-GENDER-CODE>		
        			)else(
        				<AZXGCI-GENDER-CODE xsi:nil="true"/>
        			)
                }
                {
            	let $HOME_PHONE_NUMBER := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "LANDLINE"]/ns1:Number/text())
        		return
        			if($HOME_PHONE_NUMBER != "") then(
        				<AZXGCI-HOME-PHONE>{ $HOME_PHONE_NUMBER }</AZXGCI-HOME-PHONE>		
        			)else(
        				<AZXGCI-HOME-PHONE xsi:nil="true"/>
        			)
                }
                <AZXGCI-HOME-PHONE-IND xsi:nil="true"/>
                {
            	let $FAX_PHONE := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "FAX"]/ns1:Number/text())
        		return
        			if($FAX_PHONE != "") then(
        				<AZXGCI-FAX-PHONE>{ $FAX_PHONE }</AZXGCI-FAX-PHONE>		
        			)else(
        				<AZXGCI-FAX-PHONE xsi:nil="true"/>
        			)
                }
                <AZXGCI-FAX-PHONE-IND xsi:nil="true"/>		
                {
            	let $MOBILE_PHONE := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "MOBILE"]/ns1:Number/text())
        		return
        			if($MOBILE_PHONE != "") then(
        				<AZXGCI-MOBILE-PHONE>{ $MOBILE_PHONE }</AZXGCI-MOBILE-PHONE>		
        			)else(
        				<AZXGCI-MOBILE-PHONE xsi:nil="true"/>
        			)
                }
                <AZXGCI-MOBILE-PHONE-IND xsi:nil="true"/>		
                {
            	let $BIRTH_DATE := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:BirthDate/text())
        		return
        			if($BIRTH_DATE != "") then(
        				<AZXGCI-DOB>{ data($BIRTH_DATE) }</AZXGCI-DOB>		
        			)else(
        				<AZXGCI-DOB xsi:nil="true"/>
        			)
                }
                {
            	let $NATIONALITY := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Nationality/text())
        		return
        			if($NATIONALITY != "") then(
        				<AZXGCI-DL-CNTRY>{ $NATIONALITY }</AZXGCI-DL-CNTRY>		
        			)else(
        				<AZXGCI-DL-CNTRY xsi:nil="true"/>
        			)
                }
                <AZXGCI-DL-STATE xsi:nil="true"/>
                {
                    let $DRIVERS_LICENSE := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "LICENCIA" or fn:upper-case(ns1:DocumentName) = "RTN"]/ns1:LegalId/text())
                            return
                                    if($DRIVERS_LICENSE != "") then(
                                            <AZXGCI-DL-NBR>{ $DRIVERS_LICENSE }</AZXGCI-DL-NBR>		
                                    )else(
                                            <AZXGCI-DL-NBR xsi:nil="true"/>
                                    )
                }
                {
                    let $DOCUMENT_TYPE_1 := fn:upper-case(fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "CEDULA" ]/ns1:DocumentName/text()))
                            return
                                    if($DOCUMENT_TYPE_1 != "") then(
                                            <AZXGCI-TAX-ID-TYP>{ local:CatalogValueOSBToAPP(data($DOCUMENT_TYPE_1), 'VISION+HN', '4', $GetCatalogsEquivalenceResponse) }</AZXGCI-TAX-ID-TYP>		
                                    )else(
                                            <AZXGCI-TAX-ID-TYP xsi:nil="true"/>
                                    )
                }
                {
                    let $DOCUMENT_ID_1 := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "CEDULA" ]/ns1:LegalId/text())
                            return
                                    if($DOCUMENT_ID_1 != "") then(
                                            <AZXGCI-TAX-ID>{ $DOCUMENT_ID_1 }</AZXGCI-TAX-ID>		
                                    )else(
                                            <AZXGCI-TAX-ID xsi:nil="true"/>
                                    )
                }
                <AZXGCI-1099C-W9-DATE-FILED xsi:nil="true"/>
                {
                    let $WORKPLACE := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:CompanyName/text())
                            return
                                    if($WORKPLACE != "") then(
                                            <AZXGCI-EMPLOYER>{ $WORKPLACE }</AZXGCI-EMPLOYER>		
                                    )else(
                                            <AZXGCI-EMPLOYER xsi:nil="true"/>
                                    )
                }
          	{
        		
                      let $WORK_ADDRESS_1 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:AddressLine1/text())
                      let $WORK_ADDRESS_2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:AddressLine2/text())
                      let $WORK_ADDRESS := concat($WORK_ADDRESS_1, $WORK_ADDRESS_2)
                      return
                                if($WORK_ADDRESS != "")then(
                                        <AZXGCI-EMPLOYER-ADDR-1>{ fn:substring($WORK_ADDRESS, 1, 40) }</AZXGCI-EMPLOYER-ADDR-1>,
                                        <AZXGCI-EMPLOYER-ADDR-2>{ fn:substring($WORK_ADDRESS, 41, 40) }</AZXGCI-EMPLOYER-ADDR-2>
                                )else(
                                        <AZXGCI-EMPLOYER-ADDR-1 xsi:nil="true"/>,
                                        <AZXGCI-EMPLOYER-ADDR-2 xsi:nil="true"/>  	  	            	
                                )
                      
        	}
                {
                    let $WORK_PHONE_NUMBER := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "REFERENCE" and ns1:Location="2"]/ns1:Number/text())
                            return
                                    if($WORK_PHONE_NUMBER != "") then(
                                            <AZXGCI-EMP-PHONE>{ $WORK_PHONE_NUMBER }</AZXGCI-EMP-PHONE>		
                                    )else(
                                            <AZXGCI-EMP-PHONE xsi:nil="true"/>
                                    )
                }
                {
                    let $WORK_FAX := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "FAX" and ns1:Location="2"]/ns1:Number/text())
                            return
                                    if($WORK_FAX != "") then(
                                            <AZXGCI-EMP-PHONE-EXTN>{ $WORK_FAX }</AZXGCI-EMP-PHONE-EXTN>		
                                    )else(
                                            <AZXGCI-EMP-PHONE-EXTN xsi:nil="true"/>
                                    )
                }            
                <AZXGCI-EMP-PHONE-FLAG xsi:nil="true"/>
                {
                    let $PROFESSION := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:ProfessionCode/text())
                            return
                                    if($PROFESSION != "") then(
                                            <AZXGCI-POSITION>{ local:CatalogValueOSBToAPP($PROFESSION, 'VISION+HN', '3', $GetCatalogsEquivalenceResponse) }</AZXGCI-POSITION>		
                                    )else(
                                            <AZXGCI-POSITION xsi:nil="true"/>
                                    )
                }
                {
                    let $RELATIVE_NAME := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SpouseName/text())
                            return
                                    if($RELATIVE_NAME != "") then(
                                            <AZXGCI-RELATIVE-NAME>{ $RELATIVE_NAME }</AZXGCI-RELATIVE-NAME>		
                                    )else(
                                            <AZXGCI-RELATIVE-NAME xsi:nil="true"/>
                                    )
                }
                {
                    let $DEPENDENTS := fn:string($UpdateCustomerRequest/ns1:NumberOfDependents/text())
                            return
                                    if($DEPENDENTS != "") then(
                                            <AZXGCI-NBR-OF-DEPENDENTS>{ data($DEPENDENTS) }</AZXGCI-NBR-OF-DEPENDENTS>		
                                    )else(
                                            <AZXGCI-NBR-OF-DEPENDENTS xsi:nil="true"/>
                                    )
                }
                {
                    for $EMAIL in data($UpdateCustomerRequest/ns1:ContactInfo/ns1:EmailList[fn:upper-case(ns1:IsMain) = "YES"]/ns1:Email)
                    return
                        <AZXGCI-EMAIL>{ $EMAIL }</AZXGCI-EMAIL>
                }
                <AZXGCI-EMAIL-IND xsi:nil="true"/>
                <AZXGCI-SMS-IND xsi:nil="true"/>
                {
                    let $NAMES := fn:concat(fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:FirstName),' ', fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SecondName),' ',fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:ThirdName))
                            return
                                    if(fn:normalize-space($NAMES) != "") then(
                                            <AZXGCI-FIRST-NAME>{ $NAMES }</AZXGCI-FIRST-NAME>		
                                    )else(
                                            <AZXGCI-FIRST-NAME xsi:nil="true"/>
                                    )
                }
                <AZXGCI-MIDDLE-NAME xsi:nil="true"/>
                {
                    let $LAST_NAMES := fn:concat(fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:FirstLastName),' ',fn:data($UpdateCustomerRequest/ns1:CustomerInfo/ns1:SecondLastName))
                            return
                                    if(fn:normalize-space($LAST_NAMES) != "") then(
                                            <AZXGCI-LAST-NAME>{ $LAST_NAMES }</AZXGCI-LAST-NAME>		
                                    )else(
                                            <AZXGCI-LAST-NAME xsi:nil="true"/>
                                    )
                }
                <AZXGCI-SUFFIX xsi:nil="true"/>
                {
                    let $BIRTH_COUNTRY := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:BirthPlace/text())
                            return
                                    if($BIRTH_COUNTRY != "") then(
                                            <AZXGCI-COUNTY>{ $BIRTH_COUNTRY }</AZXGCI-COUNTY>		
                                    )else(
                                            <AZXGCI-COUNTY xsi:nil="true"/>
                                    )
                }
                {
                    let $CHANEL_CODE := fn:string($UpdateCustomerRequest/ns1:ChanelCode/text())
                            return
                                    if($CHANEL_CODE != "") then(
                                            <AZXGCI-MEMO-1>{ $CHANEL_CODE }</AZXGCI-MEMO-1>		
                                    )else(
                                            <AZXGCI-MEMO-1 xsi:nil="true"/>
                                    )
                }
                <AZXGCI-MEMO-2 xsi:nil="true"/>
                {
                    let $EMPLOYMENT_YEARS := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:EmploymentYears/text())
                            return
                                    if($EMPLOYMENT_YEARS != "") then(
                                            <AZXGCI-USER-1>{ $EMPLOYMENT_YEARS }</AZXGCI-USER-1>		
                                    )else(
                                            <AZXGCI-USER-1 xsi:nil="true"/>
                                    )
                }
                {
                    let $EMPLOYMENT_MONTHS := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:EmploymentMonths/text())
                            return
                                    if($EMPLOYMENT_MONTHS != "") then(
                                            <AZXGCI-USER-2>{ $EMPLOYMENT_MONTHS }</AZXGCI-USER-2>		
                                    )else(
                                            <AZXGCI-USER-2 xsi:nil="true"/>
                                    )
                }
                {
                    let $JOB_TITLE := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:JobTitle/text())
                            return
                                    if($JOB_TITLE != "") then(
                                            <AZXGCI-USER-3>{ $JOB_TITLE }</AZXGCI-USER-3>		
                                    )else(
                                            <AZXGCI-USER-3 xsi:nil="true"/>
                                    )
                }
                <AZXGCI-USER-4 xsi:nil="true"/>
                <AZXGCI-USER-5 xsi:nil="true"/>
                {
                    let $SEGMENT := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Segment/text())
                            return
                                    if($SEGMENT != "") then(
                                            <AZXGCI-USER-6>{ $SEGMENT }</AZXGCI-USER-6>		
                                    )else(
                                            <AZXGCI-USER-6 xsi:nil="true"/>
                                    )
                }
                <AZXGCI-USER-7 xsi:nil="true"/>
                {
                    let $IsPep := string($UpdateCustomerRequest/ns1:IsPep/text())
                            return
                                    if($IsPep != "")then(
                                                        if(fn:upper-case($IsPep) = "YES")then(
                                                          <AZXGCI-USER-8>Y</AZXGCI-USER-8>
                                                        )else(
                                                          <AZXGCI-USER-8>N</AZXGCI-USER-8>
                                                        )
                                                    )else(
                                                          <AZXGCI-USER-8/>	            	
                                                    )
                }
                <AZXGCI-USER-9 xsi:nil="true"/>
                {
                    let $EXPIRATION_DATE_1 := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "CEDULA" ]/ns1:MaturityDate/text())
                            return
                                    if($EXPIRATION_DATE_1 != "") then(
                                            <AZXGCI-USER-10>{ data($EXPIRATION_DATE_1) }</AZXGCI-USER-10>		
                                    )else(
                                            <AZXGCI-USER-10 xsi:nil="true"/>
                                    )
                }
                {
                    let $ISSUE_DATE_1 := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "CEDULA" ]/ns1:DateOfIssuance/text())
                            return
                                    if($ISSUE_DATE_1 != "") then(
                                            <AZXGCI-USER-11>{ data($ISSUE_DATE_1) }</AZXGCI-USER-11>		
                                    )else(
                                            <AZXGCI-USER-11 xsi:nil="true"/>
                                    )
                }
                {
                    let $COUNTRY_ISSUE_PASSPORT := fn:string($UpdateCustomerRequest/ns1:CountryIssuePassport/text())
                            return
                                    if($COUNTRY_ISSUE_PASSPORT != "") then(
                                            <AZXGCI-USER-12>{ $COUNTRY_ISSUE_PASSPORT }</AZXGCI-USER-12>		
                                    )else(
                                            <AZXGCI-USER-12 xsi:nil="true"/>
                                    )
                }
                <AZXGCI-USER-13 xsi:nil="true"/>
                {
                    let $EDUCATION_LEVEL := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:EducationLevel/text())
                            return
                                    if($EDUCATION_LEVEL != "") then(
                                            <AZXGCI-USER-14>{ $EDUCATION_LEVEL }</AZXGCI-USER-14>		
                                    )else(
                                            <AZXGCI-USER-14 xsi:nil="true"/>
                                    )
                }
                {
                    let $INCOME_RANGE := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:IncomeRange/text())
                            return
                                    if($INCOME_RANGE != "") then(
                                            <AZXGCI-USER-15>{ $INCOME_RANGE }</AZXGCI-USER-15>		
                                    )else(
                                            <AZXGCI-USER-15 xsi:nil="true"/>
                                    )
                }
                {
                    let $OTHERS_INCOMES := fn:string($UpdateCustomerRequest/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount/text())
                            return
                                    if($OTHERS_INCOMES != "") then(
                                            <AZXGCI-USER-DEMO-1>{ $OTHERS_INCOMES }</AZXGCI-USER-DEMO-1>		
                                    )else(
                                            <AZXGCI-USER-DEMO-1 xsi:nil="true"/>
                                    )
                }
                {
                    let $NATIONALITY := fn:string($UpdateCustomerRequest/ns1:CustomerInfo/ns1:Nationality/text())
                            return
                                    if($NATIONALITY != "") then(
                                            <AZXGCI-USER-DEMO-2>{ $NATIONALITY }</AZXGCI-USER-DEMO-2>		
                                    )else(
                                            <AZXGCI-USER-DEMO-2 xsi:nil="true"/>
                                    )
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
        		
                      let $WORK_ADRRESS_2_LINE_1 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:AddressLine1/text())
                      let $WORK_ADRRESS_2_LINE_2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:AddressLine2/text())
                      let $WORK_ADDRESS := concat($WORK_ADRRESS_2_LINE_1, $WORK_ADRRESS_2_LINE_2)
                      return
                                if($WORK_ADDRESS != "")then(
                                        <AZXGCI-ADDR-2-LINE-1>{ fn:substring($WORK_ADDRESS, 1, 40) }</AZXGCI-ADDR-2-LINE-1>,
                                        <AZXGCI-ADDR-2-LINE-2>{ fn:substring($WORK_ADDRESS, 41, 40) }</AZXGCI-ADDR-2-LINE-2>
                                )else(
                                        <AZXGCI-ADDR-2-LINE-1 xsi:nil="true"/>,
                                        <AZXGCI-ADDR-2-LINE-2 xsi:nil="true"/>  	  	            	
                                )
                      
        	}
                {
                    let $REFERENCES := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:References/text())
                            return
                                    if($REFERENCES != "") then(
                                            <AZXGCI-ADDR-2-LINE-3>{ $REFERENCES }</AZXGCI-ADDR-2-LINE-3>		
                                    )else(
                                            <AZXGCI-ADDR-2-LINE-3 xsi:nil="true"/>
                                    )
                }
                {
                    let $STATE-2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:StateCode/text())
                            return
                                    if($STATE-2 != "") then(
                                            <AZXGCI-CITY-2>{ local:CatalogValueOSBToAPP($STATE-2, 'VISION+HN', '8', $GetCatalogsEquivalenceResponse) }</AZXGCI-CITY-2>		
                                    )else(
                                            <AZXGCI-CITY-2 xsi:nil="true"/>
                                    )
                }
                {
                    let $CITY-2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:CityCode/text())
                            return
                                    if($CITY-2 != "") then(
                                            <AZXGCI-PSTL-CD-2>{ local:CatalogValueOSBToAPP($CITY-2, 'VISION+HN', '7', $GetCatalogsEquivalenceResponse) }</AZXGCI-PSTL-CD-2>
                                    )else(
                                            <AZXGCI-PSTL-CD-2 xsi:nil="true"/>
                                    )
                }
                {
                    let $COUNTRY-2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:CountryCode/text())
                            return
                                    if($COUNTRY-2 != "") then(
                                            <AZXGCI-CNTRY-CD-2>{ local:CatalogValueOSBToAPP($COUNTRY-2, 'VISION+HN', '9', $GetCatalogsEquivalenceResponse) }</AZXGCI-CNTRY-CD-2>
                                    )else(
                                            <AZXGCI-CNTRY-CD-2 xsi:nil="true"/>
                                    )
                }
                {
        		
                      let $WORK_ADDRESS_3_LINE_1 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"]/ns1:AddressLine1/text())
                      let $WORK_ADDRESS_3_LINE_2 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"]/ns1:AddressLine2/text())
                      let $WORK_ADDRESS := concat($WORK_ADDRESS_3_LINE_1, $WORK_ADDRESS_3_LINE_2)
                      return
                                if($WORK_ADDRESS != "")then(
                                        <AZXGCI-ADDR-3-LINE-1>{ fn:substring($WORK_ADDRESS, 1, 40) }</AZXGCI-ADDR-3-LINE-1>,
                                        <AZXGCI-ADDR-3-LINE-2>{ fn:substring($WORK_ADDRESS, 41, 40) }</AZXGCI-ADDR-3-LINE-2>
                                )else(
                                        <AZXGCI-ADDR-3-LINE-1 xsi:nil="true"/>,
                                        <AZXGCI-ADDR-3-LINE-2 xsi:nil="true"/>  	  	            	
                                )
                      
        	}
                {
                    let $REFERENCES := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"]/ns1:References/text())
                            return
                                    if($REFERENCES != "") then(
                                            <AZXGCI-ADDR-3-LINE-3>{ $REFERENCES }</AZXGCI-ADDR-3-LINE-3>
                                    )else(
                                            <AZXGCI-ADDR-3-LINE-3 xsi:nil="true"/>
                                    )
                }
                {
                    let $STATE-3 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"]/ns1:StateCode/text())
                            return
                                    if($STATE-3 != "") then(
                                            <AZXGCI-CITY-3>{ local:CatalogValueOSBToAPP($STATE-3, 'VISION+HN', '8', $GetCatalogsEquivalenceResponse) }</AZXGCI-CITY-3>
                                    )else(
                                            <AZXGCI-CITY-3 xsi:nil="true"/>
                                    )
                }
                {
                    let $CITY-3 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"]/ns1:CityCode/text())
                            return
                                    if($CITY-3 != "") then(
                                            <AZXGCI-PSTL-CD-3>{ local:CatalogValueOSBToAPP($CITY-3, 'VISION+HN', '7', $GetCatalogsEquivalenceResponse) }</AZXGCI-PSTL-CD-3>
                                    )else(
                                            <AZXGCI-PSTL-CD-3 xsi:nil="true"/>
                                    )
                }
                {
                    let $COUNTRY-3 := fn:string($UpdateCustomerRequest/ns1:ContactInfo/ns1:AddressList[ns1:Type = "3"]/ns1:CountryCode/text())
                            return
                                    if($COUNTRY-3 != "") then(
                                            <AZXGCI-CNTRY-CD-3>{ local:CatalogValueOSBToAPP($COUNTRY-3, 'VISION+HN', '9', $GetCatalogsEquivalenceResponse) }</AZXGCI-CNTRY-CD-3>
                                    )else(
                                            <AZXGCI-CNTRY-CD-3 xsi:nil="true"/>
                                    )
                }
                <AZXGCI-USER-DATE-3 xsi:nil="true"/>
                <AZXGCI-INCOME xsi:nil="true"/>
                <AZXGCI-CUIT>0</AZXGCI-CUIT>
                <AZXGCI-OCCUP-CODE xsi:nil="true"/>
                <AZXGCI-IVA-POSITION xsi:nil="true"/>
    </ns3:CustomerUpdateL8V2Request>
};

local:func($UpdateCustomerRequest, $GetCatalogsEquivalenceResponse, $customerId)