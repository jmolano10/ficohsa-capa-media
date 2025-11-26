xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/updateCustomerTypesNI";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/updateCustomerNI.xsd" ::)
declare namespace ns3="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../CreditCardProcessor/ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogEquivalence";
(:: import schema at "../../../../../CreditCardProcessor/ProviderServices/XSD/GetCatalogEquivalence/GetCatalogEquivalence_sp.xsd" ::)

declare variable $ReqUpdateCustomerUpdate as element() (:: schema-element(ns1:updateCustomerRequest) ::) external;
declare variable $pTEquivalences as element() external;
declare variable $customerId as xs:string external;

declare function local:func($ReqUpdateCustomerUpdate as element() (:: schema-element(ns1:updateCustomerRequest) ::), 
                            $pTEquivalences as element(),
                            $customerId as xs:string) 
                            as element() (:: schema-element(ns3:CustomerUpdateRequest) ::) {
    <ns3:CustomerUpdateRequest>
         <ARXGCI-ORG>{ data($ReqUpdateCustomerUpdate/ns1:Org) }</ARXGCI-ORG>
         <ARXGCI-CARD-NBR>{fn:data($customerId)}</ARXGCI-CARD-NBR>
         <ARXGCI-NBR-TYPE>1</ARXGCI-NBR-TYPE>
         <ARXGCI-FOREIGN-USE-FLAG>0</ARXGCI-FOREIGN-USE-FLAG> 
         <ARXGCI-DEMOGRAPHIC-DATAIND>1</ARXGCI-DEMOGRAPHIC-DATAIND>
         <ARXGCI-USER-DATA-IND>1</ARXGCI-USER-DATA-IND>
         <ARXGCI-VIP-STATUS>1</ARXGCI-VIP-STATUS>
         <ARXGCI-STATUS>0</ARXGCI-STATUS>
         <ARXGCI-SIC-CODE>000000</ARXGCI-SIC-CODE>
         <ARXGCI-TITLE xsi:nil="true" />	
            	           
         {
              let $MARITAL_STATUS := fn:upper-case(fn:string($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:MaritalStatus/text()))
              return
                   if($MARITAL_STATUS != "") then (  
            	        <ARXGCI-MARITAL-STATUS>{ local:catalogValueOSBToAPP($MARITAL_STATUS, 'VISION+', '2', $pTEquivalences) }</ARXGCI-MARITAL-STATUS>
                   ) else (
                        <ARXGCI-MARITAL-STATUS xsi:nil="true" />
                   )	
         }
            	
         <ARXGCI-NAME-LINE-1 xsi:nil="true"/>
         <ARXGCI-NAME-LINE-1-TYP xsi:nil="true"/>
         <ARXGCI-NAME-LINE-2 xsi:nil="true"/>
         <ARXGCI-NAME-LINE-2-TYP xsi:nil="true"/>
         <ARXGCI-NAME-LINE-3 xsi:nil="true"/>
         <ARXGCI-NAME-LINE-3-TYP xsi:nil="true"/>
         <ARXGCI-HOUSE-NBR  xsi:nil="true" />
         <ARXGCI-HOUSE-NAME   xsi:nil="true" />
         
         {
              let $HOME_ADDRESS_LINE_1 := fn:string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:AddressLine1/text())
              let $HOME_ADDRESS_LINE_2 := fn:string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:AddressLine2/text())
              let $HOME_ADDRESS := concat($HOME_ADDRESS_LINE_1, $HOME_ADDRESS_LINE_2)
              return
                   if($HOME_ADDRESS != "") then (
                        <ARXGCI-ADDR-1>{ fn:substring($HOME_ADDRESS, 1, 40) }</ARXGCI-ADDR-1>,
                        <ARXGCI-ADDR-2>{ fn:substring($HOME_ADDRESS, 41, 40) }</ARXGCI-ADDR-2>
                   ) else (
                        <ARXGCI-ADDR-1 xsi:nil="true"/>,
                        <ARXGCI-ADDR-2 xsi:nil="true"/>  	  	            	
                   )
                      
         }
         {
              let $REFERENCES := fn:string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:References/text())
              return
                   if($REFERENCES != "") then (
                        <ARXGCI-ADDR-3>{ fn:substring($REFERENCES, 1, 40) }</ARXGCI-ADDR-3>,
                        <ARXGCI-ADDR-4>{ fn:substring($REFERENCES, 41, 40) }</ARXGCI-ADDR-4>
                   ) else (
        	        <ARXGCI-ADDR-3 xsi:nil="true"/>,
                        <ARXGCI-ADDR-4 xsi:nil="true"/>
        	   )
         }
         {
              let $CITY := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:CityCode/text())
              return
                   if($CITY != "") then (  
                        <ARXGCI-CITY>{ $CITY }</ARXGCI-CITY>
                   ) else (
                        <ARXGCI-CITY xsi:nil="true" />
                   )	
         }
         {
              let $STATE := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:StateCode/text())
              return
                   if($STATE != "") then (  
                       <ARXGCI-STATE>{ local:catalogValueOSBToAPP($STATE, 'VISION+', '35', $pTEquivalences) }</ARXGCI-STATE>
                   ) else (
                       <ARXGCI-STATE xsi:nil="true" />
                   )	
         }
         {
              let $ZIP_CODE := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:CityCode/text())
              return
                   if($ZIP_CODE != "") then (  
                        <ARXGCI-PSTL-CD>{ $ZIP_CODE }</ARXGCI-PSTL-CD>
                   ) else (
                        <ARXGCI-PSTL-CD xsi:nil="true" />
                   )	
         }
         {
               let $COUNTRY_OF_RESIDENCE := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:CountryCode/text())
               return
                   if($COUNTRY_OF_RESIDENCE != "") then (  
                       <ARXGCI-CNTRY-CD>{ $COUNTRY_OF_RESIDENCE }</ARXGCI-CNTRY-CD>
            	   ) else (
                       <ARXGCI-CNTRY-CD xsi:nil="true" />
                   )
         }
         
         <ARXGCI-OWN-RENT-RESID-FLAG>1</ARXGCI-OWN-RENT-RESID-FLAG>		
         <ARXGCI-LANGUAGE-IND>ESP</ARXGCI-LANGUAGE-IND>		
         <ARXGCI-MAILING-LIST>N</ARXGCI-MAILING-LIST>		
         <ARXGCI-CONTACT-IND>0</ARXGCI-CONTACT-IND>
         
         {
             let $GENDER := fn:upper-case(string($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:Gender/text()))
             return
                  if($GENDER != "") then (  
                       <ARXGCI-GENDER-CODE>{ local:catalogValueOSBToAPP($GENDER, 'VISION+', '1', $pTEquivalences) }</ARXGCI-GENDER-CODE>
                  ) else (
                       <ARXGCI-GENDER-CODE xsi:nil="true" />
                  )	
         }
         {
              let $HOME_PHONE_NUMBER := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "LANDLINE"]/ns1:Number/text())
              return
                  if($HOME_PHONE_NUMBER != "") then (  
                       <ARXGCI-HOME-PHONE>{ $HOME_PHONE_NUMBER }</ARXGCI-HOME-PHONE>
                  ) else (
                       <ARXGCI-HOME-PHONE xsi:nil="true" />
                  )	
         }
         
         <ARXGCI-HOME-PHONE-IND xsi:nil="true" />
         
         {
             let $FAX_PHONE := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "FAX"]/ns1:Number/text())
             return
                 if($FAX_PHONE != "") then (  
                     <ARXGCI-FAX-PHONE>{ $FAX_PHONE }</ARXGCI-FAX-PHONE>
                ) else (
                     <ARXGCI-FAX-PHONE xsi:nil="true" />
                )	
         }
         
         <ARXGCI-FAX-PHONE-IND xsi:nil="true"/>
         
         {
              let $MOBILE_PHONE := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "MOBILE"]/ns1:Number/text())
              return
                   if($MOBILE_PHONE != "") then (  
                        <ARXGCI-MOBILE-PHONE>{ $MOBILE_PHONE }</ARXGCI-MOBILE-PHONE>
                   ) else (
                       <ARXGCI-MOBILE-PHONE xsi:nil="true" />
                   )	
         }
         
         <ARXGCI-MOBILE-PHONE-IND xsi:nil="true" />
         
         { 
              let $birthDate := string($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:BirthDate/text())
              return
                   if($birthDate != "") then (
                        <ARXGCI-DOB>{fn-bea:date-to-string-with-format('yyyyDDD', xs:date($birthDate))}</ARXGCI-DOB>
                   ) else (
                        <ARXGCI-DOB xsi:nil="true" />
                   ) 
         }
         
         <ARXGCI-DL-CNTRY xsi:nil="true" />
         <ARXGCI-DL-STATE xsi:nil="true" />
         
         {
              let $DRIVERS_LICENSE := string($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "LICENCIA" or fn:upper-case(ns1:DocumentName) = "RTN"]/ns1:LegalId/text())
              return
                   if($DRIVERS_LICENSE != "") then (  
                       <ARXGCI-DL-NBR>{ $DRIVERS_LICENSE }</ARXGCI-DL-NBR>
                   ) else (
                       <ARXGCI-DL-NBR xsi:nil="true" />
                   )	
         }        
        
         <ARXGCI-TAX-ID-TYP xsi:nil="true" />
         <ARXGCI-TAX-ID xsi:nil="true" />
         <ARXGCI-1099C-W9-DATE-FILED xsi:nil="true" />
         
         {
              let $WORKPLACE := string($ReqUpdateCustomerUpdate/ns1:IncomeSourceList/ns1:CompanyName/text())
              return
                  if($WORKPLACE != "") then (  
                       <ARXGCI-EMPLOYER>{ $WORKPLACE }</ARXGCI-EMPLOYER>
                  ) else (
                       <ARXGCI-EMPLOYER xsi:nil="true" />
                  )	
         }
         {
              let $WORK_ADDRESS_1 := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:AddressLine1/text())
              return
                   if($WORK_ADDRESS_1 != "") then (  
                       <ARXGCI-EMPLOYER-ADDR-1>{ data($WORK_ADDRESS_1) }</ARXGCI-EMPLOYER-ADDR-1>
                   ) else (
                       <ARXGCI-EMPLOYER-ADDR-1 xsi:nil="true" />
                   )	
        }
        {
              let $WORK_ADDRESS_2 := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:AddressList[ns1:Type = "2"]/ns1:AddressLine2/text())
              return
                   if($WORK_ADDRESS_2 != "") then (  
                       <ARXGCI-EMPLOYER-ADDR-2>{ $WORK_ADDRESS_2 }</ARXGCI-EMPLOYER-ADDR-2>
                   ) else (
                       <ARXGCI-EMPLOYER-ADDR-2 xsi:nil="true" />
                   )	
         }
         {
              let $WORK_PHONE_NUMBER := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "REFERENCE" and ns1:Location="2"]/ns1:Number/text())
              return
                   if($WORK_PHONE_NUMBER != "") then (  
                       <ARXGCI-EMP-PHONE>{ $WORK_PHONE_NUMBER }</ARXGCI-EMP-PHONE>
                   ) else (
                       <ARXGCI-EMP-PHONE xsi:nil="true" />
                   )	
         }
         {
              let $WORK_EXTENSION := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type) = "FAX" and ns1:Location="2"]/ns1:Number/text())
              return
                   if($WORK_EXTENSION != "") then (  
                       <ARXGCI-EMP-PHONE-EXTN>{ $WORK_EXTENSION }</ARXGCI-EMP-PHONE-EXTN>
                   ) else (
                       <ARXGCI-EMP-PHONE-EXTN xsi:nil="true" />
                   )	
         }
         
         <ARXGCI-EMP-PHONE-FLAG  xsi:nil="true" />
        
         {
              let $WORK_TITLE := string($ReqUpdateCustomerUpdate/ns1:IncomeSourceList/ns1:ProfessionCode/text())
              return
                   if($WORK_TITLE != "") then (  
                       <ARXGCI-POSITION>{ local:catalogValueOSBToAPP($WORK_TITLE, 'VISION+', '3', $pTEquivalences) }</ARXGCI-POSITION>     	
                   ) else (
                       <ARXGCI-POSITION xsi:nil="true" />
                   )		
         }
         {
              let $WORK_ECONOMIC_ACTIVITY := string($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:SpouseName/text())
              return
                   if($WORK_ECONOMIC_ACTIVITY != "") then (  
                       <ARXGCI-RELATIVE-NAME>{ $WORK_ECONOMIC_ACTIVITY }</ARXGCI-RELATIVE-NAME>
                   ) else (
                       <ARXGCI-RELATIVE-NAME xsi:nil="true" />
                   )	
         }
         {
              let $DEPENDENTS := string($ReqUpdateCustomerUpdate/ns1:NumberOfDependents/text())
              return
                   if($DEPENDENTS != "") then (  
                       <ARXGCI-NBR-OF-DEPENDENTS>{ $DEPENDENTS }</ARXGCI-NBR-OF-DEPENDENTS>
                   ) else (
                       <ARXGCI-NBR-OF-DEPENDENTS xsi:nil="true" />
                   )	
         }
         {
              let $EMAIL := string($ReqUpdateCustomerUpdate/ns1:ContactInfo/ns1:EmailList[fn:upper-case(ns1:IsMain) = "YES"]/ns1:Email)
              return
                   if($EMAIL != "") then (  
                       <ARXGCI-EMAIL>{ $EMAIL }</ARXGCI-EMAIL>
                   ) else (
                       <ARXGCI-EMAIL xsi:nil="true" />
                   )	
        }
        
        <ARXGCI-EMAIL-IND xsi:nil="true" />
        <ARXGCI-SMS-IND xsi:nil="true" />
        
        {
             let $NAMES := fn:concat(fn:data($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:FirstName),' ', fn:data($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:SecondName),' ',fn:data($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:ThirdName))
             return
                   if($NAMES != "") then (  
                            <ARXGCI-FIRST-NAME>{ $NAMES }</ARXGCI-FIRST-NAME>
                   ) else (
                       <ARXGCI-FIRST-NAME xsi:nil="true" />
                   )	
        }
        
        <ARXGCI-MIDDLE-NAME xsi:nil="true" />
        
        {
              let $LAST_NAMES := fn:concat(fn:data($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:FirstLastName),' ',fn:data($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:SecondLastName))
              return
                   if($LAST_NAMES != "") then (  
                       <ARXGCI-LAST-NAME>{ $LAST_NAMES }</ARXGCI-LAST-NAME>
                   ) else (
                       <ARXGCI-LAST-NAME xsi:nil="true" />
                   )	
        }
        
        <ARXGCI-SUFFIX  xsi:nil="true" />
        <ARXGCI-COUNTY>{ string($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:BirthPlace/text()) }</ARXGCI-COUNTY>
        
        {
              let $MEMO-1 := string($ReqUpdateCustomerUpdate/ns1:ChanelCode/text())
              return
                   if($MEMO-1 != "") then (  
                       <ARXGCI-MEMO-1>{ $MEMO-1 }</ARXGCI-MEMO-1>
                   ) else (
                       <ARXGCI-MEMO-1 xsi:nil="true" />
                   )	
        }
        
        <ARXGCI-MEMO-2 xsi:nil="true"/>
        
        {
              let $EMPLOYMENT_YEARS := string($ReqUpdateCustomerUpdate/ns1:IncomeSourceList/ns1:EmploymentYears/text())
              return
                   if($EMPLOYMENT_YEARS != "") then (  
                       <ARXGCI-USER-1>{ $EMPLOYMENT_YEARS }</ARXGCI-USER-1>
                   ) else (
                       <ARXGCI-USER-1 xsi:nil="true" />
                   )	
        }
        {
              let $EMPLOYMENT_MONTHS := string($ReqUpdateCustomerUpdate/ns1:IncomeSourceList/ns1:EmploymentMonths/text())
              return
                   if($EMPLOYMENT_MONTHS != "") then (  
                       <ARXGCI-USER-2>{ $EMPLOYMENT_MONTHS }</ARXGCI-USER-2>
                   ) else (
                       <ARXGCI-USER-2 xsi:nil="true" />
                   )	
        }
        {
              let $PROFESSION := string($ReqUpdateCustomerUpdate/ns1:IncomeSourceList/ns1:JobTitle/text())
              return
                   if($PROFESSION != "") then (  
                       <ARXGCI-USER-3>{ $PROFESSION }</ARXGCI-USER-3>     	
                   ) else (
                       <ARXGCI-USER-3 xsi:nil="true" />
                   )	
        }	
                 
        <ARXGCI-USER-4 xsi:nil="true"/>
        <ARXGCI-USER-5 xsi:nil="true"/>
        <ARXGCI-USER-6 xsi:nil="true" />
        <ARXGCI-USER-7 xsi:nil="true" />
        
        {
              let $PEP_CLIENT := string($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:Segment/text())
              return
                   if($PEP_CLIENT != "") then (  
                       <ARXGCI-USER-8>{ $PEP_CLIENT }</ARXGCI-USER-8>
                   ) else (
                       <ARXGCI-USER-8 xsi:nil="true" />
                   )	
        }
        
        <ARXGCI-USER-9  xsi:nil="true" />
        
        { 
              let $expirationDate := string($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "CEDULA" ]/ns1:MaturityDate/text())
              return
                   if($expirationDate != "") then (
                       <ARXGCI-USER-10>{ fn-bea:date-to-string-with-format('yyyyDDD', xs:date($expirationDate))} </ARXGCI-USER-10>
                   ) else (
                       <ARXGCI-USER-10 xsi:nil="true" />
                   ) 
        }
        { 
              let $issueDate := string($ReqUpdateCustomerUpdate/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName) = "CEDULA" ]/ns1:DateOfIssuance/text())
              return
                   if($issueDate != "") then (
                       <ARXGCI-USER-11>{ fn-bea:date-to-string-with-format('yyyyDDD', xs:date($issueDate)) }</ARXGCI-USER-11>
                   ) else (
                       <ARXGCI-USER-11 xsi:nil="true" />
                   ) 
        }
        <ARXGCI-USER-12>{ string($ReqUpdateCustomerUpdate/ns1:CountryIssuePassport/text()) }</ARXGCI-USER-12>
        <ARXGCI-USER-13 xsi:nil="true" />
        <ARXGCI-USER-14>{ string($ReqUpdateCustomerUpdate/ns1:IncomeSourceList/ns1:EducationLevel/text()) }</ARXGCI-USER-14>
        <ARXGCI-USER-15>{ string($ReqUpdateCustomerUpdate/ns1:IncomeSourceList/ns1:IncomeRange/text()) }</ARXGCI-USER-15>
        <ARXGCI-USER-DEMO-1    xsi:nil="true" />
        <ARXGCI-USER-DEMO-2  xsi:nil="true" />
        <ARXGCI-USER-DEMO-3   xsi:nil="true" />
        <ARXGCI-1099C-FOREIGN-IND   xsi:nil="true" />
        <ARXGCI-CR-1-2   xsi:nil="true" />
        <ARXGCI-CR-3-4   xsi:nil="true" />
        <ARXGCI-1099C-W9-DATE-SENT  xsi:nil="true" />
        <ARXGCI-STMT-MSG-INDIC   xsi:nil="true" />
    </ns3:CustomerUpdateRequest>
};



declare function local:catalogValueOSBToAPP($value as xs:string,
                                            $application as xs:string,
                                            $catalogId as xs:string,
                                            $equivalencies as element(*))
                                            as xs:string {
     let $return := fn:string($equivalencies/ns2:PT_EQUIVALENCIAS/ns2:PT_EQUIVALENCIAS_ITEM[ns2:CATALOGO_ID = $catalogId and 
                                                              ns2:APLICACION_DESC = $application and 
                                                              ns2:VALOR_DESC = $value]/ns2:EQUIVALENCIA_DESC/text())
     return
          if($return != "") then (
               $return
          ) else (
               $value
          )
};

local:func($ReqUpdateCustomerUpdate, $pTEquivalences, $customerId)