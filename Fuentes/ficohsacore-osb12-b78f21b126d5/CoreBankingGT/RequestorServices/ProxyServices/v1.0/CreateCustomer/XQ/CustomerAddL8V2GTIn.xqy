xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns3="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../../CreditCardProcessor/ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogsEquivalence";
(:: import schema at "../../../../../../CoreBankingHN/ProviderServices/XSD/GetCatalogsEquivalence/GetCatalogsEquivalence_sp.xsd" ::)

declare variable $customerId as xs:string external;
declare variable $CreateCustomerRequest as element() (:: schema-element(ns1:createCustomerRequest) ::) external;
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

declare function local:func($CreateCustomerRequest as element() (:: schema-element(ns1:createCustomerRequest) ::), 
                            $GetCatalogsEquivalenceResponse as element() (:: schema-element(ns2:OutputParameters) ::),
                            $customerId as xs:string) 
                            as element() (:: schema-element(ns3:CustomerAddL8V2Request) ::) {
    <ns3:CustomerAddL8V2Request>
        {
            let $IDENTIFICATION_ITEM := $CreateCustomerRequest/ns1:CustomerInfo/ns1:IdList
            let $ADDRESS_ITEM := $CreateCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList
                let $CONTACT_INFO := $CreateCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList
            return(
                <AZXNAI-LOCAL-ACCT-ORG>335</AZXNAI-LOCAL-ACCT-ORG>,
                <AZXNAI-CUST-NBR>{fn:data($customerId)}</AZXNAI-CUST-NBR>,
                <AZXNAI-BS-ACCT/>,
                let $MAKER_INDICATOR:= string($CreateCustomerRequest/ns1:CustomerInfo/ns1:MakerIndicator/text())
                return(
                    if($MAKER_INDICATOR != '')then(
                        <AZXNAI-NA-COMAKER-IND>{ data($MAKER_INDICATOR) }</AZXNAI-NA-COMAKER-IND>
                    )else(
                        <AZXNAI-NA-COMAKER-IND/>
                    )
                ),
                let $DOUBLE_CURRENCY_INDICATOR:= string($CreateCustomerRequest/ns1:CustomerInfo/ns1:DoubleCurrencyIndicator/text())
                return(
                    if($DOUBLE_CURRENCY_INDICATOR != '')then(
                        <AZXNAI-DUAL-FLAG>{ data($DOUBLE_CURRENCY_INDICATOR) }</AZXNAI-DUAL-FLAG>
                    )else(
                        <AZXNAI-DUAL-FLAG/>
                    )
                ),
                <AZXNAI-COMAKER-FILLER/>,
                let $VIP_CLIENT_INDICATOR := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:VipCustomerIndicator/text())
                return(
                    if($VIP_CLIENT_INDICATOR  != "")then(
                        <AZXNAI-VIP-STATUS>{ data($VIP_CLIENT_INDICATOR) }</AZXNAI-VIP-STATUS>
                    )else(
                        <AZXNAI-VIP-STATUS/>                    
                    )
                ),
                <AZXNAI-SIC-CODE>0</AZXNAI-SIC-CODE>,
                <AZXNAI-STATUS>0</AZXNAI-STATUS>,
                <AZXNAI-MISC-FILLER/>,
                <AZXNAI-M-TITLE/>,
                let $MARITAL_STATUS := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:MaritalStatus/text())
                return(
                    if($MARITAL_STATUS  != "")then(
                        <AZXNAI-M-MARITAL-STATUS>{ local:CatalogValueOSBToAPP(fn:upper-case($MARITAL_STATUS), 'VISION+GT', '2', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-MARITAL-STATUS>        
                    )else(
                        <AZXNAI-M-MARITAL-STATUS/>                  
                    )
                ),
                <AZXNAI-M-NAME-LINE-1>PRINCIPAL</AZXNAI-M-NAME-LINE-1>,
                <AZXNAI-M-NAME-TYPE-IND-1>0</AZXNAI-M-NAME-TYPE-IND-1>,
                <AZXNAI-M-NAME-LINE-2/>,
                <AZXNAI-M-NAME-TYPE-IND-2>0</AZXNAI-M-NAME-TYPE-IND-2>,
                <AZXNAI-M-NAME-LINE-3/>,
                <AZXNAI-M-NAME-TYPE-IND-3>0</AZXNAI-M-NAME-TYPE-IND-3>,
                let $HOUSE_NUMBER := string($ADDRESS_ITEM[ns1:Type = "1"]/ns1:HouseNumber/text())
                let $COLONY_DESCRIPTION := string($ADDRESS_ITEM[ns1:Type = "1"]/ns1:Domicile/text())
                let $ADDRESS_LINE1 := string($ADDRESS_ITEM[ns1:Type = "1"]/ns1:AddressLine1/text())
                let $ADDRESS_LINE2 := string($ADDRESS_ITEM[ns1:Type = "1"]/ns1:AddressLine2/text())
                let $DEPARMENT_CODE := string($ADDRESS_ITEM[ns1:Type = "1"]/ns1:StateCode/text())
                let $MUNICIPALITY_CODE := string($ADDRESS_ITEM[ns1:Type = "1"]/ns1:CityCode/text())
                let $COUNTRY_CODE := string($ADDRESS_ITEM[ns1:Type = "1"]/ns1:CountryCode/text())
                let $PHONE_NUMBER := string($CONTACT_INFO[fn:upper-case(ns1:Type) = "LANDLINE" and ns1:Ismain="Yes"]/ns1:Number/text())
                    let $PHONE_WORK := string($CONTACT_INFO[fn:upper-case(ns1:Type) = "REFERENCE" and ns1:Location="2"]/ns1:Number/text())
                let $PHONE_MOBILE := string($CONTACT_INFO[fn:upper-case(ns1:Type) = "MOBILE" and ns1:Ismain="Yes"]/ns1:Number/text())
                let $EMAIL := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:EmailList/ns1:Email/text())
                let $ADDRESS_LINE1_WORK := string($ADDRESS_ITEM[ns1:Type = "2"]/ns1:AddressLine1/text())
                let $ADDRESS_LINE2_WORK := string($ADDRESS_ITEM[ns1:Type = "2"]/ns1:AddressLine2/text())
                let $DEPARMENT_CODE_WORK := string($ADDRESS_ITEM[ns1:Type = "2"]/ns1:StateCode/text())
                let $MUNICIPALITY_CODE_WORK := string($ADDRESS_ITEM[ns1:Type = "2"]/ns1:CityCode/text())
                let $COUNTRY_CODE_WORK := string($ADDRESS_ITEM[ns1:Type = "2"]/ns1:CountryCode/text())
                let $ADDRESS_LINE1_OTHER := string($ADDRESS_ITEM[ns1:Type = "3"]/ns1:AddressLine1/text())
                let $ADDRESS_LINE2_OTHER := string($ADDRESS_ITEM[ns1:Type = "3"]/ns1:AddressLine2/text())
                let $DEPARMENT_CODE_OTHER := string($ADDRESS_ITEM[ns1:Type = "3"]/ns1:StateCode/text())
                let $MUNICIPALITY_CODE_OTHER := string($ADDRESS_ITEM[ns1:Type = "3"]/ns1:CityCode/text())
                let $COUNTRY_CODE_OTHER := string($ADDRESS_ITEM[ns1:Type = "3"]/ns1:CountryCode/text())
                let $ADDRESS_REFERENCE_HOME:= string($ADDRESS_ITEM[ns1:Type = "1"]/ns1:References/text())
                let $ADDRESS_REFERENCE_WORK := string($ADDRESS_ITEM[ns1:Type = "2"]/ns1:References/text())
                let $ADDRESS_REFERENCA_OTHER := string($ADDRESS_ITEM[ns1:Type = "3"]/ns1:References/text())
                let $FLYER_TYPE := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:FrequentFlyer/ns1:FlyerType/text())     
                let $FREQUENT_FLYER_NUMBER := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:FrequentFlyer/ns1:FrequentFlyerNumber/text())
	            return(	
	                if($HOUSE_NUMBER!= "")then(
	            		<AZXNAI-M-HOUSE-NBR>{ data($HOUSE_NUMBER) }</AZXNAI-M-HOUSE-NBR>
	            	)else(
	            		<AZXNAI-M-HOUSE-NBR/>
	            	),

                   if($COLONY_DESCRIPTION  != "")then(
                        <AZXNAI-M-HOUSE-NAME>{ data($COLONY_DESCRIPTION) }</AZXNAI-M-HOUSE-NAME>
                    )else(
                        <AZXNAI-M-HOUSE-NAME/>                  
                    ),
                    if($ADDRESS_LINE1 != "" and $ADDRESS_LINE2 !="")then(
                        let $ADREESS_LINE := concat($ADDRESS_LINE1,' ', $ADDRESS_LINE2)
                        return(
                            <AZXNAI-M-ADDR-1>{ fn:substring($ADREESS_LINE, 1, 40) }</AZXNAI-M-ADDR-1>,
                            <AZXNAI-M-ADDR-2>{ fn:substring($ADREESS_LINE, 41, 40) }</AZXNAI-M-ADDR-2>
                        )
                    )else(
                                        <AZXNAI-M-ADDR-1/>,
                            <AZXNAI-M-ADDR-2/>         
                    ),
                    let $ADDRESS_REFERENCE := $ADDRESS_REFERENCE_HOME
                    return(
                        if($ADDRESS_REFERENCE != "")then(
                                <AZXNAI-M-ADDR-3>{ fn:substring($ADDRESS_REFERENCE, 1, 40) }</AZXNAI-M-ADDR-3>,
                                <AZXNAI-M-ADDR-4>{ fn:substring($ADDRESS_REFERENCE, 41, 40) }</AZXNAI-M-ADDR-4>
                        )else(
                            <AZXNAI-M-ADDR-3/>,
                            <AZXNAI-M-ADDR-4/>
                            
                        )
                    ),
                    if($DEPARMENT_CODE != "")then(
                            <AZXNAI-M-CITY>{ local:CatalogValueOSBToAPP($DEPARMENT_CODE, 'VISION+GT', '8', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-CITY>
                    )else(
                            <AZXNAI-M-CITY/>    
                    ),
                    <AZXNAI-M-STATE/>,
                    if($MUNICIPALITY_CODE != "")then(
                        <AZXNAI-M-PSTL-CD>{ local:CatalogValueOSBToAPP($MUNICIPALITY_CODE, 'VISION+GT', '7', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-PSTL-CD>
                    )else(
                        <AZXNAI-M-PSTL-CD/>
                    ),
                    if($COUNTRY_CODE != "")then(
                             <AZXNAI-M-CNTRY-CD>{ local:CatalogValueOSBToAPP($COUNTRY_CODE, 'VISION+GT', '9', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-CNTRY-CD>
                    )else(
                        <AZXNAI-M-CNTRY-CD/>
                    ) ,
                    let $RESIDENCE_TYPE := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:ResidenceType/text())
                    return(
                        if($RESIDENCE_TYPE  != "")then(
                            <AZXNAI-M-OWN-RENT-RESIDFLAG>{ data($RESIDENCE_TYPE) }</AZXNAI-M-OWN-RENT-RESIDFLAG>
                        )else(
                            <AZXNAI-M-OWN-RENT-RESIDFLAG/>                  
                        )
                    ),
                     <AZXNAI-M-1099C-FOREIGN-IND/>,
                    <AZXNAI-M-LANGUAGE-IND>ESP</AZXNAI-M-LANGUAGE-IND>,
                    <AZXNAI-M-MAILING-LIST>N</AZXNAI-M-MAILING-LIST>,
                    <AZXNAI-M-CONTACT-IND>0</AZXNAI-M-CONTACT-IND>,
                    let $GENDER := fn:upper-case(string($CreateCustomerRequest/ns1:CustomerInfo/ns1:Gender/text()))
                    return(
                        if($GENDER  != "")then(
                            <AZXNAI-M-GENDER-CODE>{ local:CatalogValueOSBToAPP(fn:upper-case($GENDER), 'VISION+GT', '1', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-GENDER-CODE>
                        )else(
                            <AZXNAI-M-GENDER-CODE/>                 
                        )
                    ),
                    <AZXNAI-M-CR-1-2>01</AZXNAI-M-CR-1-2>,
                    <AZXNAI-M-CR-3-4>01</AZXNAI-M-CR-3-4>,  
                    if($PHONE_NUMBER  != "")then(
                        <AZXNAI-M-HOME-PHONE>{ data($PHONE_NUMBER) }</AZXNAI-M-HOME-PHONE>
                    )else(
                        <AZXNAI-M-HOME-PHONE/>  
                    ),
                    
                        <AZXNAI-M-FAX-PHONE/>,    
                    
                    if($PHONE_MOBILE  != "")then(
                            <AZXNAI-M-MOBILE-PHONE>{ data($PHONE_MOBILE) }</AZXNAI-M-MOBILE-PHONE>
                    )else(
                        <AZXNAI-M-MOBILE-PHONE/>
                    ),
                    let $DATE_OF_BIRTH := $CreateCustomerRequest/ns1:CustomerInfo/ns1:BirthDate
                    return(
                        if(string($DATE_OF_BIRTH/text()) != "")then(
                            <AZXNAI-M-DOB>{ fn-bea:date-to-string-with-format("yyyyDDD", xs:date($DATE_OF_BIRTH)) }</AZXNAI-M-DOB>
                        )else(
                            <AZXNAI-M-DOB/>                 
                        )
                    ),     
                        let $LEGAL_ID_OTHER := fn:string($IDENTIFICATION_ITEM[fn:upper-case(ns1:DocumentName) = "LICENCIA" or fn:upper-case(ns1:DocumentName) = "NUMERO DE ID TRIBUTA (NIT)"]/ns1:LegalId/text())
                        return(
                    if($LEGAL_ID_OTHER != "")then(
                            <AZXNAI-M-DL-NBR>{ data($LEGAL_ID_OTHER) }</AZXNAI-M-DL-NBR>
                    )else(
                            <AZXNAI-M-DL-NBR/>          
                    )
                        ),
                    <AZXNAI-M-DL-STATE/>,
                    let $COUNTRY_CODE_ISSUANCE := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:Nationality/text())
                    return(
                        if($COUNTRY_CODE_ISSUANCE  != "")then(
                             <AZXNAI-M-DL-CNTRY>{ data($COUNTRY_CODE_ISSUANCE) }</AZXNAI-M-DL-CNTRY>
                        )else(
                            <AZXNAI-M-DL-CNTRY/>                    
                        )
                    ),
                    let $LEGAL_ID_TYPE:= fn:upper-case(fn:string($IDENTIFICATION_ITEM[fn:upper-case(ns1:DocumentName) = "NUMERO DE PASAPORTE" or fn:upper-case(ns1:DocumentName) = "DOCTO PERSONAL DE ID (DPI)"]/ns1:DocumentName/text()))
                                        let $LEGAL_ID := string($IDENTIFICATION_ITEM[fn:upper-case(ns1:DocumentName) = "NUMERO DE PASAPORTE" or fn:upper-case(ns1:DocumentName) = "DOCTO PERSONAL DE ID (DPI)"]/ns1:LegalId/text())
                    return(
                        <AZXNAI-M-SSAN-FLAG>{ local:CatalogValueOSBToAPP($LEGAL_ID_TYPE, 'VISION+GT', '4', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-SSAN-FLAG>,
                        <AZXNAI-M-SSAN>{ data($LEGAL_ID) }</AZXNAI-M-SSAN>
                    ),
                    <AZXNAI-M-1099C-W9-DATE-FILED>2000-01-01</AZXNAI-M-1099C-W9-DATE-FILED>,
                    <AZXNAI-M-STMT-MSG-INDIC>0</AZXNAI-M-STMT-MSG-INDIC>,
                    let $COMPANY_NAME := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyName/text())
                    return(
                        if($COMPANY_NAME  != "")then(
                             <AZXNAI-M-EMPLOYER>{ data($COMPANY_NAME) }</AZXNAI-M-EMPLOYER>
                        )else(
                            <AZXNAI-M-EMPLOYER/>                    
                        )
                    ),
                     <AZXNAI-M-EMPLOYER-ADDR-1/>,
                     <AZXNAI-M-EMPLOYER-ADDR-2/>,
                        
                                        if($PHONE_WORK != "")then(
                                          <AZXNAI-M-EMP-PHONE>{ data($PHONE_WORK) }</AZXNAI-M-EMP-PHONE>
                                        )else(
                                          <AZXNAI-M-EMP-PHONE/> 
                                        ),
                        <AZXNAI-M-EMP-PHONE-EXTN/>,
                     <AZXNAI-M-PHONE-FLAG>0</AZXNAI-M-PHONE-FLAG>,
                     let $PROFESSION_CODE := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:ProfessionCode/text())
                     return(
                        if($PROFESSION_CODE  != "")then(
                            <AZXNAI-M-POSITION>{ local:CatalogValueOSBToAPP(fn:upper-case($PROFESSION_CODE), 'VISION+GT', '3', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-POSITION>
                        )else(
                            <AZXNAI-M-POSITION/>            
                        )
                     ),
                     let $SPOUSE_NAME := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:SpouseName/text())
                     return(
                        if($SPOUSE_NAME  != "")then(
                            <AZXNAI-M-RELATIVE-NAME>{ data($SPOUSE_NAME) }</AZXNAI-M-RELATIVE-NAME>
                        )else(
                            <AZXNAI-M-RELATIVE-NAME/>               
                        )
                    ),
                    let $NUMBER_OF_DEPENDENTS := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:NumberOfDependents/text())
                    return(
                        if($NUMBER_OF_DEPENDENTS != "")then(
                            <AZXNAI-M-NBR-OF-DEPENDENTS>{ data($NUMBER_OF_DEPENDENTS) }</AZXNAI-M-NBR-OF-DEPENDENTS>
                        )else(
                            <AZXNAI-M-NBR-OF-DEPENDENTS/>                   
                        )
                    ),  
                    if($EMAIL != "")then(
                        <AZXNAI-M-EMAIL>{ data($EMAIL) }</AZXNAI-M-EMAIL>
                    )else(
                        <AZXNAI-M-EMAIL/>
                    ), 
                    let $CHANNEL_CODE := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:ChannelCode/text())
                    return(
                        if($CHANNEL_CODE != "" )then(
                            <AZXNAI-M-MEMO-1>{ data($CHANNEL_CODE) }</AZXNAI-M-MEMO-1>
                        )else(
                            <AZXNAI-M-MEMO-1/>                      
                        )
                    ),
                    let $CHANNEL_CODE := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:ChannelCode/text())
                    return(
                        if($CHANNEL_CODE != "" )then(
                            <AZXNAI-M-MEMO-2>{ data($CHANNEL_CODE) }</AZXNAI-M-MEMO-2>
                        )else(
                            <AZXNAI-M-MEMO-2/>                          
                        )
                    ),
                    let $EMPLOYMENT_YEARS := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:EmploymentYears/text())
                    return(
                        if($EMPLOYMENT_YEARS != "")then(
                            <AZXNAI-M-USER-1>{ data($EMPLOYMENT_YEARS) }</AZXNAI-M-USER-1>
                        )else(
                            <AZXNAI-M-USER-1/>                  
                        )
                    ),
                    let $EMPLOYMENT_MONTHS := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:EmploymentMonths/text())
                    return(
                        if($EMPLOYMENT_MONTHS != "")then(
                            <AZXNAI-M-USER-2>{ data($EMPLOYMENT_MONTHS) }</AZXNAI-M-USER-2>
                        )else(
                            <AZXNAI-M-USER-2/>                  
                        )
                    ),
                    let $JOB_TITLE := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:JobTitle/text())
                    return(
                        if($JOB_TITLE != "")then(
                            <AZXNAI-M-USER-3>{ local:CatalogValueOSBToAPP($JOB_TITLE, 'VISION+GT', '11', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-USER-3>
                        )else(
                            <AZXNAI-M-USER-3/>                  
                        )
                    ),
                     <AZXNAI-M-USER-4/>,
                     <AZXNAI-M-USER-5/>,
                     <AZXNAI-M-USER-6/>,
                     <AZXNAI-M-USER-7/>,
                     let $IsPep := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:PepInfo/ns1:IsPepCustomer/text())
                     return(
                        if($IsPep != "")then(
                                                    if(fn:upper-case($IsPep) = "YES")then(
                                                      <AZXNAI-M-USER-8>Y</AZXNAI-M-USER-8>
                                                    )else(
                                                      <AZXNAI-M-USER-8>N</AZXNAI-M-USER-8>
                                                    )
                        )else(
                                                      <AZXNAI-M-USER-8/>                    
                        )
                    ),
                    <AZXNAI-M-USER-9/>,
					
                    let $EXPIRATION_DATE := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:IdList/ns1:MaturityDate/text())
                    return(
                        if($EXPIRATION_DATE != "")then(
                            <AZXNAI-M-USER-10>{ fn-bea:date-to-string-with-format("yyyyDDD", xs:date($EXPIRATION_DATE)) }</AZXNAI-M-USER-10>
                        )else(
                            <AZXNAI-M-USER-10>0</AZXNAI-M-USER-10>                  
                        )
                    ),
                    let $ISSUE_DATE := $IDENTIFICATION_ITEM/ns1:DateOfIssuance
                    return(
                        if(string($ISSUE_DATE/text())  != "")then(
                            <AZXNAI-M-USER-11>{ fn-bea:date-to-string-with-format("yyyyDDD", xs:date($ISSUE_DATE)) }</AZXNAI-M-USER-11>
                        )else(
                            <AZXNAI-M-USER-11>0</AZXNAI-M-USER-11>                  
                        )
                    ),
                    let $COUNTRY_CODE_ISSUANCE := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:Nationality/text())
                    return(
                        if($COUNTRY_CODE_ISSUANCE != "")then(
                            <AZXNAI-M-USER-12>{ local:CatalogValueOSBToAPP($COUNTRY_CODE_ISSUANCE, 'VISION+GT', '9', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-USER-12>
                        )else(
                            <AZXNAI-M-USER-12/>                 
                        )
                    ),
                    <AZXNAI-M-USER-13/>,
                    let $LEVEL_OF_EDUCATION := fn:upper-case(string($CreateCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:EducationLevel/text()))
                    return(
                        if($LEVEL_OF_EDUCATION != "")then(
                            <AZXNAI-M-USER-14>{ local:CatalogValueOSBToAPP($LEVEL_OF_EDUCATION, 'VISION+GT', '10', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-USER-14>
                        )else(
                            <AZXNAI-M-USER-14/>                 
                        )
                    ),
                    let $INCOMES := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeRange/text())
                    return(
                        if($INCOMES != "")then(
                            <AZXNAI-M-USER-15>{ data($INCOMES) }</AZXNAI-M-USER-15>
                        )else(
                            <AZXNAI-M-USER-15/>                 
                        )
                    ),
                     let $OTHERS_INCOMES := string($CreateCustomerRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount/text())
                    return(
                        if($OTHERS_INCOMES != "")then(
                            <AZXNAI-M-USER-DEMO-1>{ data($OTHERS_INCOMES) }</AZXNAI-M-USER-DEMO-1>
                        )else(
                            <AZXNAI-M-USER-DEMO-1/>                 
                        )
                    ),
                                        
                        if($COUNTRY_CODE != "")then(
                            <AZXNAI-M-USER-DEMO-2>{ local:CatalogValueOSBToAPP($COUNTRY_CODE, 'VISION+GT', '9', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-USER-DEMO-2>
                        )else(
                            <AZXNAI-M-USER-DEMO-2/>                 
                        ),
                    if($FLYER_TYPE = "LM")then(
                                                <AZXNAI-M-USER-DEMO-3>{ data($FREQUENT_FLYER_NUMBER) }</AZXNAI-M-USER-DEMO-3>
                                        )else(
                                                <AZXNAI-M-USER-DEMO-3/>
                                        ),
                    <AZXNAI-M-HOME-PHONE-FLAG>0</AZXNAI-M-HOME-PHONE-FLAG>,
                    <AZXNAI-M-FAX-PHONE-FLAG>0</AZXNAI-M-FAX-PHONE-FLAG>,
                    <AZXNAI-M-MOBILE-PHONE-FLAG>0</AZXNAI-M-MOBILE-PHONE-FLAG>,
                    <AZXNAI-M-EMAIL-FLAG>0</AZXNAI-M-EMAIL-FLAG>,
                    <AZXNAI-M-SMS-FLAG>0</AZXNAI-M-SMS-FLAG>,
                    <AZXNAI-M-LAST-NAME>{ concat($CreateCustomerRequest/ns1:CustomerInfo/ns1:FirstLastName ,' ' , $CreateCustomerRequest/ns1:CustomerInfo/ns1:SecondLastName) }</AZXNAI-M-LAST-NAME>,
                    <AZXNAI-M-MIDDLE-NAME/>,
                    <AZXNAI-M-FIRST-NAME>{ concat($CreateCustomerRequest/ns1:CustomerInfo/ns1:FirstName ,' ' , $CreateCustomerRequest/ns1:CustomerInfo/ns1:SecondName) }</AZXNAI-M-FIRST-NAME>,
                    <AZXNAI-M-SUFFIX/>,
                    <AZXNAI-M-COUNTY/>,
                    if($FLYER_TYPE = "AA")then(
                                                <AZXNAI-M-FF-NUMBER>{ data($FREQUENT_FLYER_NUMBER) }</AZXNAI-M-FF-NUMBER>
                                        )else(
                                                <AZXNAI-M-FF-NUMBER/>                                   
                                        ),
                
                    <AZXNAI-M-FILLER/>,
                    <AZXNAI-M-STMT-MSG-2-IND>1</AZXNAI-M-STMT-MSG-2-IND>,
                    <AZXNAI-M-ADDR-2-INDIC>B</AZXNAI-M-ADDR-2-INDIC>,
                    <AZXNAI-M-ADDR-3-INDIC>O</AZXNAI-M-ADDR-3-INDIC>,
                    let $ADDRESS_LINE := concat($ADDRESS_LINE1_WORK, $ADDRESS_LINE2_WORK)
                    return(
                        if($ADDRESS_LINE != "")then(
                            <AZXNAI-M-ADDR-2-LINE-1>{ fn:substring($ADDRESS_LINE, 1, 40) }</AZXNAI-M-ADDR-2-LINE-1>,
                            <AZXNAI-M-ADDR-2-LINE-2>{ fn:substring($ADDRESS_LINE, 41, 40) }</AZXNAI-M-ADDR-2-LINE-2>
                        )else(
                            <AZXNAI-M-ADDR-2-LINE-1/>,
                            <AZXNAI-M-ADDR-2-LINE-2/>                       
                        )
                    ),
                    let $ADDRESS_REFERENCE := $ADDRESS_REFERENCE_WORK
                    return(
                        if($ADDRESS_REFERENCE != "")then(
                                <AZXNAI-M-ADDR-2-LINE-3>{ fn:substring($ADDRESS_REFERENCE, 1, 40) }</AZXNAI-M-ADDR-2-LINE-3>
                        )else(
                            <AZXNAI-M-ADDR-2-LINE-3/>
                            
                        )
                    ),      
                    if($DEPARMENT_CODE_WORK != "")then(
                            <AZXNAI-M-CITY-2>{ local:CatalogValueOSBToAPP($DEPARMENT_CODE_WORK, 'VISION+GT', '8', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-CITY-2>
                        )else(
                            <AZXNAI-M-CITY-2/>  
                    ),
                    if($MUNICIPALITY_CODE_WORK != "")then(
                            <AZXNAI-M-PSTL-CD-2>{ local:CatalogValueOSBToAPP($MUNICIPALITY_CODE_WORK, 'VISION+GT', '7', $GetCatalogsEquivalenceResponse)}</AZXNAI-M-PSTL-CD-2>
                        )else(
                            <AZXNAI-M-PSTL-CD-2/>                   
                    ),
                    if($COUNTRY_CODE_WORK != "")then(
                        <AZXNAI-M-CNTRY-CD-2>{ local:CatalogValueOSBToAPP($COUNTRY_CODE_WORK, 'VISION+GT', '9', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-CNTRY-CD-2>
                    )else(
                        <AZXNAI-M-CNTRY-CD-2/>                      
                    ),
                    let $ADDRESS_LINE := concat($ADDRESS_LINE1_OTHER, $ADDRESS_LINE2_OTHER )
                    return(
                        if($ADDRESS_LINE != "")then(
                                <AZXNAI-M-ADDR-3-LINE-1>{ fn:substring($ADDRESS_LINE, 1, 40) }</AZXNAI-M-ADDR-3-LINE-1>,
                                <AZXNAI-M-ADDR-3-LINE-2>{ fn:substring($ADDRESS_LINE, 41, 40) }</AZXNAI-M-ADDR-3-LINE-2>
                        )else(
                            <AZXNAI-M-ADDR-3-LINE-1/>,
                            <AZXNAI-M-ADDR-3-LINE-2/>                               
                        )
                    ),
                    let $ADDRESS_REFERENCE := $ADDRESS_REFERENCA_OTHER
                    return(
                        if($ADDRESS_REFERENCE != "")then(
                                <AZXNAI-M-ADDR-3-LINE-3>{ fn:substring($ADDRESS_REFERENCE, 1, 40) }</AZXNAI-M-ADDR-3-LINE-3>
                        )else(
                            <AZXNAI-M-ADDR-3-LINE-3/>
                            
                        )
                    ),
                    if($DEPARMENT_CODE_OTHER != "")then(    
                            <AZXNAI-M-CITY-3>{ local:CatalogValueOSBToAPP($DEPARMENT_CODE_OTHER, 'VISION+GT', '8', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-CITY-3>
                    )else(
                            <AZXNAI-M-CITY-3/>          
                    ),
                    if($MUNICIPALITY_CODE_OTHER != "")then(
                            <AZXNAI-M-PSTL-CD-3>{ local:CatalogValueOSBToAPP($MUNICIPALITY_CODE_OTHER, 'VISION+GT', '7', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-PSTL-CD-3>
                    )else(
                            <AZXNAI-M-PSTL-CD-3/>           
                    ),
                    if($COUNTRY_CODE_OTHER != "")then(
                            <AZXNAI-M-CNTRY-CD-3>{ local:CatalogValueOSBToAPP($COUNTRY_CODE_OTHER, 'VISION+GT', '9', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-CNTRY-CD-3>
                        )else(
                            <AZXNAI-M-CNTRY-CD-3>{ local:CatalogValueOSBToAPP($COUNTRY_CODE, 'VISION+GT', '9', $GetCatalogsEquivalenceResponse) }</AZXNAI-M-CNTRY-CD-3>             
                     ),
                    <AZXNAI-M-USER-DATE-3>{ fn:adjust-date-to-timezone(current-date(),()) }</AZXNAI-M-USER-DATE-3>,
                    <AZXNAI-M-INCOME>0</AZXNAI-M-INCOME>,
                    <AZXNAI-M-CUIT>0</AZXNAI-M-CUIT>,
                    <AZXNAI-M-OCC-CODE>0</AZXNAI-M-OCC-CODE>,
                    <AZXNAI-M-IVA-POS>0</AZXNAI-M-IVA-POS>,
                    <AZXNAI-C-TITLE/>,
                    <AZXNAI-C-MARITAL-STATUS>0</AZXNAI-C-MARITAL-STATUS>,
                    <AZXNAI-C-NAME-LINE-1/>,
                    <AZXNAI-C-NAME-TYPE-IND-1>0</AZXNAI-C-NAME-TYPE-IND-1>,
                     <AZXNAI-C-NAME-LINE-2/>,
                    <AZXNAI-C-NAME-TYPE-IND-2>0</AZXNAI-C-NAME-TYPE-IND-2>,
                    <AZXNAI-C-NAME-LINE-3/>,
                    <AZXNAI-C-NAME-TYPE-IND-3>0</AZXNAI-C-NAME-TYPE-IND-3>,
                    <AZXNAI-C-HOUSE-NBR/>,
                    <AZXNAI-C-HOUSE-NAME/>,
                    <AZXNAI-C-ADDR-1/>,
                    <AZXNAI-C-ADDR-2/>,
                    <AZXNAI-C-ADDR-3/>,
                    <AZXNAI-C-ADDR-4/>,
                    <AZXNAI-C-CITY/>,
                    <AZXNAI-C-STATE/>,
                    <AZXNAI-C-PSTL-CD/>,
                    <AZXNAI-C-CNTRY-CD/>,
                    <AZXNAI-C-OWN-RENT-RESID-FLAG>1</AZXNAI-C-OWN-RENT-RESID-FLAG>,
                    <AZXNAI-C-1099C-FOREIGN-IND/>,
                    <AZXNAI-C-LANGUAGE-IND/>,
                    <AZXNAI-C-MAILING-LIST/>,
                    <AZXNAI-C-CONTACT-IND>0</AZXNAI-C-CONTACT-IND>,
                    <AZXNAI-C-GENDER-CODE>0</AZXNAI-C-GENDER-CODE>,
                    <AZXNAI-C-CR-1-2/>,
                    <AZXNAI-C-CR-3-4>01</AZXNAI-C-CR-3-4>,
                    <AZXNAI-C-HOME-PHONE/>,
                    <AZXNAI-C-FAX-PHONE/>,
                    <AZXNAI-C-MOBILE-PHONE/>,
                    <AZXNAI-C-DOB>0</AZXNAI-C-DOB>,
                    <AZXNAI-C-DL-NBR/>,
                    <AZXNAI-C-DL-STATE/>,
                    <AZXNAI-C-DL-CNTRY/>,
                    <AZXNAI-C-SSAN-FLAG>0</AZXNAI-C-SSAN-FLAG>,
                    <AZXNAI-C-SSAN/>,
                    <AZXNAI-C-1099C-W9-DATE-FILED>2000-01-01</AZXNAI-C-1099C-W9-DATE-FILED>,
                    <AZXNAI-C-STMT-MSG-INDIC>0</AZXNAI-C-STMT-MSG-INDIC>,
                    <AZXNAI-C-EMPLOYER/>,
                    <AZXNAI-C-EMPLOYER-ADDR-1/>,
                    <AZXNAI-C-EMPLOYER-ADDR-2/>,
                    <AZXNAI-C-EMP-PHONE/>,
                    <AZXNAI-C-EMP-PHONE-EXTN/>,
                    <AZXNAI-C-PHONE-FLAG>0</AZXNAI-C-PHONE-FLAG>,
                    <AZXNAI-C-POSITION/>,
                    <AZXNAI-C-RELATIVE-NAME/>,
                    <AZXNAI-C-NBR-OF-DEPENDENTS>011</AZXNAI-C-NBR-OF-DEPENDENTS>,
                    <AZXNAI-C-EMAIL/>,
                    <AZXNAI-C-MEMO-1/>,
                    <AZXNAI-C-MEMO-2/>,
                    <AZXNAI-C-USER-1/>,
                    <AZXNAI-C-USER-2/>,
                    <AZXNAI-C-USER-3/>,
                    <AZXNAI-C-USER-4/>,
                    <AZXNAI-C-USER-5/>,
                    <AZXNAI-C-USER-6/>,
                    <AZXNAI-C-USER-7/>,
                    <AZXNAI-C-USER-8/>,
                    <AZXNAI-C-USER-9/>,
                    <AZXNAI-C-USER-10>0</AZXNAI-C-USER-10>,
                    <AZXNAI-C-USER-11>0</AZXNAI-C-USER-11>,
                    <AZXNAI-C-USER-12/>,
                    <AZXNAI-C-USER-13/>,
                    <AZXNAI-C-USER-14/>,
                    <AZXNAI-C-USER-15/>,
                    <AZXNAI-C-USER-DEMO-1/>,
                    <AZXNAI-C-USER-DEMO-2/>,
                    <AZXNAI-C-USER-DEMO-3>{ data($CreateCustomerRequest/ns1:CustomerInfo/ns1:Nationality) }</AZXNAI-C-USER-DEMO-3>,        
                    <AZXNAI-C-HOME-PHONE-FLAG>0</AZXNAI-C-HOME-PHONE-FLAG>,
                    <AZXNAI-C-FAX-PHONE-FLAG>0</AZXNAI-C-FAX-PHONE-FLAG>,
                    <AZXNAI-C-MOBILE-PHONE-FLAG>0</AZXNAI-C-MOBILE-PHONE-FLAG>,
                    <AZXNAI-C-EMAIL-FLAG>0</AZXNAI-C-EMAIL-FLAG>,
                    <AZXNAI-C-SMS-FLAG>0</AZXNAI-C-SMS-FLAG>,
                    <AZXNAI-C-LAST-NAME/>,
                    <AZXNAI-C-MIDDLE-NAME/>,
                    <AZXNAI-C-FIRST-NAME/>,
                    <AZXNAI-C-SUFFIX/>,
                    <AZXNAI-C-COUNTY/>,
                    <AZXNAI-C-FF-NUMBER/>,
                    <AZXNAI-C-FILLER/>,
                    <AZXNAI-C-STMT-MSG-2-IND>0</AZXNAI-C-STMT-MSG-2-IND>,
                    <AZXNAI-C-ADDR-2-INDIC>0</AZXNAI-C-ADDR-2-INDIC>,
                    <AZXNAI-C-ADDR-3-INDIC>0</AZXNAI-C-ADDR-3-INDIC>,
                    <AZXNAI-C-ADDR-2-LINE-1/>,
                    <AZXNAI-C-ADDR-2-LINE-2/>,
                    <AZXNAI-C-ADDR-2-LINE-3/>,
                    <AZXNAI-C-CITY-2/>,
                    <AZXNAI-C-PSTL-CD-2/>,
                    <AZXNAI-C-CNTRY-CD-2/>,
                    <AZXNAI-C-ADDR-3-LINE-1/>,
                    <AZXNAI-C-ADDR-3-LINE-2/>,
                    <AZXNAI-C-ADDR-3-LINE-3/>,
                    <AZXNAI-C-CITY-3/>,
                    <AZXNAI-C-PSTL-CD-3/>,
                    <AZXNAI-C-CNTRY-CD-3/>,
                    <AZXNAI-C-USER-DATE-3>{ fn:adjust-date-to-timezone(current-date(),()) }</AZXNAI-C-USER-DATE-3>,
                    <AZXNAI-C-INCOME>0</AZXNAI-C-INCOME>,
                    <AZXNAI-C-CUIT>0</AZXNAI-C-CUIT>,
                    <AZXNAI-C-OCC-CODE>0</AZXNAI-C-OCC-CODE>,
                    <AZXNAI-C-IVA-POS>0</AZXNAI-C-IVA-POS>,
                    <AZXNAI-RESV-CODE-1/>,
                    <AZXNAI-RESV-CODE-2/>,
                    <AZXNAI-RESV-CODE-3/>,
                    <AZXNAI-RESV-CODE-4/>,
                    <AZXNAI-RESV-CODE-5/>,
                    <AZXNAI-RESV-DATE-1>2000-01-01</AZXNAI-RESV-DATE-1>,
                    <AZXNAI-RESV-DATE-2>2000-01-01</AZXNAI-RESV-DATE-2>,
                    <AZXNAI-RESV-DATE-3>2000-01-01</AZXNAI-RESV-DATE-3>,
                    <AZXNAI-RESV-DATE-4>2000-01-01</AZXNAI-RESV-DATE-4>,
                    <AZXNAI-RESV-DATE-5>2000-01-01</AZXNAI-RESV-DATE-5>,
                    <AZXNAI-RESV-AMT-1>0</AZXNAI-RESV-AMT-1>,
                    <AZXNAI-RESV-AMT-2>0</AZXNAI-RESV-AMT-2>,
                      <AZXNAI-RESV-AMT-3>0</AZXNAI-RESV-AMT-3>,
		            <AZXNAI-RESV-AMT-4>0</AZXNAI-RESV-AMT-4>,
		            <AZXNAI-RESV-AMT-5>0</AZXNAI-RESV-AMT-5>
			        
			    )
		    )

        }
    </ns3:CustomerAddL8V2Request>
};

local:func($CreateCustomerRequest, $GetCatalogsEquivalenceResponse, $customerId)