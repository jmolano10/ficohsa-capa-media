xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/CrearClienteSimplificado/CrearClienteSimplificado_BS.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/crearClienteSimplificadoHNIN";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $createCustomerRequest as element() (:: schema-element(ns2:createCustomerRequest) ::) external;

(: Se encarga de retornar el wsa:Action correspondiente a la operación que se desea invocar :)
declare function xq:getGender($type as xs:string) as xs:string {
	if ($type = "Male") then
	  "01"
   else if ($type = "Female") then
	  "02"
	else 
		"Invalid Operation"
};

(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function ns1:crearClienteSimplificadoHNIN($username as xs:string, 
                                                  $password as xs:string, 
                                                  $createCustomerRequest as element() (:: schema-element(ns2:createCustomerRequest) ::)) 
                                                  as element() (:: schema-element(ns3:CreaciondeClienteSimplificado) ::) {
    <ns3:CreaciondeClienteSimplificado>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction>
            <noOfAuth>0</noOfAuth>
        </OfsFunction>
        <CUSTOMERINDIVIDUALSIMPLIOPENWSType>
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:AccountOfficer)
                then <ACCOUNTOFFICER>{fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:AccountOfficer)}</ACCOUNTOFFICER>
                else ()
            }
            <gOTHEROFFICER>
                <OTHEROFFICER>{fn:data($createCustomerRequest/ns2:GeneralInfo/com:BranchId)}</OTHEROFFICER>
            </gOTHEROFFICER>
            <gLEGALID>
                {
                    for $IdList in $createCustomerRequest/ns2:CustomerInfo/ns2:IdList
                    return 
                    <mLEGALID>
                        {
                            if ($IdList/ns2:LegalId)
                            then <LEGALID>{fn:data($IdList/ns2:LegalId)}</LEGALID>
                            else ()
                        }
                        {
                            if ($IdList/ns2:DateOfIssuance)
                            then <LEGALISSDATE>{fn:data($IdList/ns2:DateOfIssuance)}</LEGALISSDATE>
                            else ()
                        }</mLEGALID>
                }
            </gLEGALID>
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:FirstName)
                then <GIVENNAMES>{concat(fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:FirstName),fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:SecondName))}</GIVENNAMES>
                else ()
            }
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:FirstLastName)
                then <FAMILYNAME>{concat(fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:FirstLastName),fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:SecondLastName))}</FAMILYNAME>
                else ()
            }
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:Gender)
                then <GENDER>{xq:getGender(fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:Gender))}</GENDER>
                else ()
            }
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:BirthDate)
                then <DATEOFBIRTH>{fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:BirthDate)}</DATEOFBIRTH>
                else ()
            }
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:MaritalStatus)
                then <MARITALSTATUS>{fn:upper-case(fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:MaritalStatus))}</MARITALSTATUS>
                else ()
            }
            <gPHONE1>
                {
                for $PhoneList in $createCustomerRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:PhoneList
                return 
                  if (data($PhoneList/ns2:Type) = 'PHONE') then (
                    if (data($PhoneList/ns2:ZipCode)!='') then(
                      <PHONE1>{concat(data($PhoneList/ns2:ZipCode), fn:data($PhoneList/ns2:Number))}</PHONE1>
                    ) else (
                      <PHONE1>{concat('504', fn:data($PhoneList/ns2:Number))}</PHONE1>
                    )
                  ) else ()
                }
            </gPHONE1>
            <gSMS1>
                {
                for $PhoneList in $createCustomerRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:PhoneList
                return 
                  if (data($PhoneList/ns2:Type) = 'SMS') then (
                    if (data($PhoneList/ns2:ZipCode)!='') then(
                      <SMS1>{concat(data($PhoneList/ns2:ZipCode), fn:data($PhoneList/ns2:Number))}</SMS1>
                    ) else (
                      <SMS1>{concat('504', fn:data($PhoneList/ns2:Number))}</SMS1>
                    )
                  ) else ()
                }
            </gSMS1>
            <gEMAIL1>
                {
                for $EmailList in $createCustomerRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:EmailList
                return <EMAIL1>{fn:data($EmailList/ns2:Email)}</EMAIL1>
                }
            </gEMAIL1>
            <gEMPLOYMENTSTATUS>
                <mEMPLOYMENTSTATUS>
                    {
                        if ($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:JobTitle)
                        then <EMPLOYERSNAME>{fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList[1]/ns2:JobTitle)}</EMPLOYERSNAME>
                        else ()
                    }
                </mEMPLOYMENTSTATUS>
            </gEMPLOYMENTSTATUS>
            <CUSTOMERTYPE>ACTIVE</CUSTOMERTYPE>
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:ProfessionCode)
                then <PROFESIONTRADE>{fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList[1]/ns2:ProfessionCode)}</PROFESIONTRADE>
                else ()
            }
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:IncomeSource)
                then <SRCOFINCOME>{fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList[1]/ns2:IncomeSource)}</SRCOFINCOME>
                else ()
            }
            <gADDRESS.TYPE>
                {
                    for $AddressList in $createCustomerRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList
                    return 
                    <mADDRESS.TYPE>
                        {
                            if ($AddressList/ns2:Type)
                            then <ADDRESSTYPE>{fn:data($AddressList/ns2:Type)}</ADDRESSTYPE>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:IsMain)
                            then <MAINADPHYCOR>{fn:upper-case(fn:data($AddressList/ns2:IsMain))}</MAINADPHYCOR>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:CountryCode)
                            then <COUNTRYCODE>{fn:data($AddressList/ns2:CountryCode)}</COUNTRYCODE>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:StateCode)
                            then <STATECODE>{fn:data($AddressList/ns2:StateCode)}</STATECODE>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:CityCode)
                            then <CITYCODE>{fn:data($AddressList/ns2:CityCode)}</CITYCODE>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:DistrictCode)
                            then <COLONYCODE>{fn:data($AddressList/ns2:DistrictCode)}</COLONYCODE>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:Neighborhood)
                            then <NEIGHBPENDING>{fn:data($AddressList/ns2:Neighborhood)}</NEIGHBPENDING>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:Avenue)
                            then <AVENUE>{fn:data($AddressList/ns2:Avenue)}</AVENUE>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:Street)
                            then <ADDSTREET>{fn:data($AddressList/ns2:Street)}</ADDSTREET>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:Block)
                            then <BLOCK>{fn:data($AddressList/ns2:Block)}</BLOCK>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:HouseNumber)
                            then <HOUSENUMBER>{fn:data($AddressList/ns2:HouseNumber)}</HOUSENUMBER>
                            else ()
                        }
                        {
                            if ($AddressList/ns2:References)
                            then <REFERENCES>{fn:data($AddressList/ns2:References)}</REFERENCES>
                            else ()
                        }</mADDRESS.TYPE>
                }
            </gADDRESS.TYPE>
            <gINCOME.CCY>
                <mINCOME.CCY>
                    {
                        if ($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList[1]/ns2:IncomeRange)
                        then <INCOMERANGES>{fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList[1]/ns2:IncomeRange)}</INCOMERANGES>
                        else ()
                    }
                </mINCOME.CCY>
            </gINCOME.CCY>
            <gEXTENSION>
                {
                for $PhoneList in $createCustomerRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:PhoneList
                return 
                  <mEXTENSION>
                      {
                          if ($PhoneList/ns2:Reference)
                          then <TELEPHONEREFER>{fn:data($PhoneList/ns2:Reference)}</TELEPHONEREFER>
                          else ()
                      }
                  </mEXTENSION>
                }
            </gEXTENSION>
            <gLR.MAIN.AD.ELEC>
                {
                for $EmailList in $createCustomerRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:EmailList
                return <LRMAINADELEC>{fn:upper-case(fn:data($EmailList/ns2:IsMain))}</LRMAINADELEC>
                }
                
            </gLR.MAIN.AD.ELEC>
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList[1]/ns2:CurrentlyEmployed)
                then <LRWORK>{fn:upper-case(fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:IncomeSourceList[1]/ns2:CurrentlyEmployed))}</LRWORK>
                else ()
            }
            {
                if ($createCustomerRequest/ns2:CustomerInfo/ns2:MontlhyTransactionVolume)
                then <LRFSUMINGR>{fn:data($createCustomerRequest/ns2:CustomerInfo/ns2:MontlhyTransactionVolume)}</LRFSUMINGR>
                else ()
            }
        </CUSTOMERINDIVIDUALSIMPLIOPENWSType>
    </ns3:CreaciondeClienteSimplificado>
};

ns1:crearClienteSimplificadoHNIN($username, $password, $createCustomerRequest)