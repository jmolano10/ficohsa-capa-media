xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/CrearClienteNormalIntermedio/v1.0/CrearClienteNormalIntermedio.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $password as xs:string external;
declare variable $userName as xs:string external;
declare variable $crearClienteRequest as element() (:: schema-element(ns2:createCustomerRequest) ::) external;

(: Se encarga de retornar el wsa:Action correspondiente a la operación que se desea invocar :)
declare function xq:getGender($type as xs:string) as xs:string {
	if ($type = "Male") then
	  "01"
   else if ($type = "Female") then
	  "02"
	else 
		"Invalid Operation"
};

(: Se encarga de retornar el tipo correspondiente segun la palabra ingresada :)
declare function xq:getObjectType($type as xs:string) as xs:string {
	if (fn:upper-case($type) = "HOME") then
	  "1"
	else if (fn:upper-case($type) = "WORK") then
	  "2"
	else  if (fn:upper-case($type) = "OTHER") then
		"3"
	else
		$type
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

declare function local:CrearClienteNormalIntermedioHNIn($password as xs:string, 
                                                        $userName as xs:string, 
                                                        $crearClienteRequest as element() (:: schema-element(ns2:createCustomerRequest) ::)) 
                                                        as element() (:: schema-element(ns1:CreacionClientesparaDynamo) ::) {
    <ns1:CreacionClientesparaDynamo>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction>
            <gtsControl></gtsControl>
            <messageId></messageId>
            <noOfAuth>0</noOfAuth>
            <replace></replace>
        </OfsFunction>
        <FICOBULKPRODUCTINPUTDYNWSType>
{       
		if (data($crearClienteRequest/ns2:ProcessType)='8.1' or data($crearClienteRequest/ns2:ProcessType)='8.2' or data($crearClienteRequest/ns2:ProcessType)='12.2') then(
		  <PROCESSTYPE>8</PROCESSTYPE>
		) else (
		  <PROCESSTYPE>{fn:data($crearClienteRequest/ns2:ProcessType)}</PROCESSTYPE>
		)
} 

    {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:Category)
                then <CATEGORY>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:Category)}</CATEGORY>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:Currency)
                then <CURRENCY>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:Currency)}</CURRENCY>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:CustomerCode)
                then <CUSTOMER>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:CustomerCode)}</CUSTOMER>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:ReferredType)
                then <REFEREDTYPE>{fn:upper-case(fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:ReferredType))}</REFEREDTYPE>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:Passbook)
                then <PASSBOOK>{fn:upper-case(fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:Passbook))}</PASSBOOK>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:PassbookNumber)
                then <PASSBOOKNUMBER>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:PassbookNumber)}</PASSBOOKNUMBER>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:PayrollGroup)
                then <LRPAYROLLGRP>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:PayrollGroup)}</LRPAYROLLGRP>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:InitialDeposit)
                then <INITIALDEPOSIT>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:InitialDeposit)}</INITIALDEPOSIT>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:Purpose)
                then <LRPURPOSE>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:Purpose)}</LRPURPOSE>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:OrigenOfFunds)
                then <LRORGOFFUNDS>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:OrigenOfFunds)}</LRORGOFFUNDS>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:MonthlyTxnVolume)
                then <LRMONTXVOL>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:MonthlyTxnVolume)}</LRMONTXVOL>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:AddressType) then
				(					
					<ADDRESSTYPE>{xq:getObjectType(fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:AddressType))}</ADDRESSTYPE>
				)
                else 
				()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:SignatoryDetails/ns2:RegisteredSignatory)
                then <REGISTEREDSIGN>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:SignatoryDetails[1]/ns2:RegisteredSignatory)}</REGISTEREDSIGN>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:SignatoryDetails/ns2:RequiredSignatory)
                then <REQUIREDSIGN>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:SignatoryDetails[1]/ns2:RequiredSignatory)}</REQUIREDSIGN>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:SignatoryDetails/ns2:SignatoryDescription)
                then <LRADDDESC>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:SignatoryDetails[1]/ns2:SignatoryDescription)}</LRADDDESC>
                else ()
            }
            <MODOFDEPOSIT></MODOFDEPOSIT>
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:ThirdPartyRepresentative)
                then <LRCUSREP>{fn:upper-case(fn:data($crearClienteRequest/ns2:AccountInfo/ns2:ThirdPartyRepresentative))}</LRCUSREP>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:CardNumber)
                then <TDCODID>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:CardNumber)}</TDCODID>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:PrimaryAccount)
                then <PRIMARYACCT>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:PrimaryAccount)}</PRIMARYACCT>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:DeliveryBranch)
                then <TOAGENCY>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:DeliveryBranch)}</TOAGENCY>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:EmissionPay)
                then <LRREEMISIONTD>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:EmissionPay)}</LRREEMISIONTD>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:CardType)
                then <CARDTYPE>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:CardInformation/ns2:CardType)}</CARDTYPE>
                else ()
            }
            <gFIELDS81>
                <LROPRTTYPE>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:OperationType)}</LROPRTTYPE>
            </gFIELDS81>
            <gFIELDS82>
                <LRSIGNID></LRSIGNID>
            </gFIELDS82>
            <gFIELDS83>
                <LRSIGNTYPE></LRSIGNTYPE>
            </gFIELDS83>
            <gFIELDS84>
                <JOINTHOLDER></JOINTHOLDER>
            </gFIELDS84>
            <gFIELDS85>
                <RELATIONCODE></RELATIONCODE>
            </gFIELDS85>
			
			<gFIELDS86>
	{
		for $Beneficiary in $crearClienteRequest/ns2:AccountInfo/ns2:BeneficiaryDetails
			return
				<LRBENNAME>{fn:data($Beneficiary/ns2:Name)}</LRBENNAME>	
	}
</gFIELDS86>
                        
                        <gFIELDS87>
						{
							for $Beneficiary in $crearClienteRequest/ns2:AccountInfo/ns2:BeneficiaryDetails
									return
								<LRBENRELN>{fn:data($Beneficiary/ns2:Relationship)}</LRBENRELN>
						}                       
                        </gFIELDS87>
            
                        <gFIELDS88>
						{
							for $Beneficiary in $crearClienteRequest/ns2:AccountInfo/ns2:BeneficiaryDetails
									return
								<LRBENPRG>{fn:data($Beneficiary/ns2:Percentage)}</LRBENPRG>
						}
                        </gFIELDS88>
            
                        <gFIELDS89>
						{
							for $Beneficiary in $crearClienteRequest/ns2:AccountInfo/ns2:BeneficiaryDetails
									return
								<LRTINACT>{fn:upper-case(fn:data($Beneficiary/ns2:DocumentName))}</LRTINACT>
						} 
                        </gFIELDS89>
            
                        <gFIELDS90>
						{
							for $Beneficiary in $crearClienteRequest/ns2:AccountInfo/ns2:BeneficiaryDetails
									return
								<LRNUMACT>{fn:data($Beneficiary/ns2:LegalId)}</LRNUMACT>
						}  
                        </gFIELDS90>
                    
            
            <gFIELDS91>
                <LRBENIDTYPE></LRBENIDTYPE>
            </gFIELDS91>
            <gFIELDS92>
                <LRBENID></LRBENID>
            </gFIELDS92>
            <gFIELDS93>
                 
{
  for $PhoneList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:PhoneList
  return 
    if (fn:upper-case(data($PhoneList/ns2:Type)) = 'LANDLINE') then (
      if (data($PhoneList/ns2:Extension) != '') then (
        <EXTENSION>{fn:data($PhoneList/ns2:Extension)}</EXTENSION>
      ) else (
        <EXTENSION>{''}</EXTENSION>
      )
    ) else ()
}

            </gFIELDS93>
            <gFIELDS94>
                 {               
                for $PhoneList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:PhoneList
                return 
                  if (fn:upper-case(data($PhoneList/ns2:Type)) = 'LANDLINE') then (
                    if (data($PhoneList/ns2:Reference)!='') then(
                      <TELEPHONEREFER>{fn:data($PhoneList/ns2:Reference)}</TELEPHONEREFER>
                    ) else (
                      <TELEPHONEREFER>{concat('504', fn:data($PhoneList/ns2:Number))}</TELEPHONEREFER>
                    )
                   ) 
                  else ()
                }
            </gFIELDS94>
            <USERID>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</USERID>
            <PROFILETYPE>
            {
                if(fn:upper-case(fn:data($crearClienteRequest/ns2:Type)) = 'NORMALCREDITCUSTOMER')then(
                  'NORMAL'
                )else(
                
                  if(fn:upper-case(fn:data($crearClienteRequest/ns2:Type)) = 'PROSPECTCREDITCUSTOMER')then(
                    'PROSPECT'
                  )else(
                    fn:upper-case(fn:data($crearClienteRequest/ns2:Type))
                  )
                )
            }
            </PROFILETYPE>
	    {
            	if ($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='Cedula']/ns2:LegalId)
		then <LEGALID>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='Cedula']/ns2:LegalId)}</LEGALID>
		else ()
	    }
	    {
            	if ($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='Cedula']/ns2:DocumentName)
		then <LEGALDOCNAME>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='Cedula']/ns2:DocumentName))}</LEGALDOCNAME>
		else ()
	    }
	    {
            	if ($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='Cedula']/ns2:DateOfIssuance)
		then <LEGALISSDATE>{fn:replace(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='Cedula']/ns2:DateOfIssuance),'-','')}</LEGALISSDATE>
		else ()
	    }
	    {
            	if ($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='Cedula']/ns2:MaturityDate)
		then <LRFECVENCUS>{fn:replace(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='Cedula']/ns2:MaturityDate),'-','')}</LRFECVENCUS>
		else ()
	    }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:GivenNames)
                then <GIVENNAMES>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:GivenNames)}</GIVENNAMES>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:FamilyNames)
                then <FAMILYNAME>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:FamilyNames)}</FAMILYNAME>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:MarriedName)
                then <MARRLASTNAME>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:MarriedName)}</MARRLASTNAME>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:BirthDate)
                then <DATEOFBIRTH>{fn:replace(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BirthDate),'-','')}</DATEOFBIRTH>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:Gender)
                then <GENDER>{xq:getGender(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:Gender))}</GENDER>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:MaritalStatus)
                then <MARITALSTATUS>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:MaritalStatus))}</MARITALSTATUS>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:SpouseName)
                then <SPOUSENAME>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:SpouseName)}</SPOUSENAME>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:MultipleNationality)
                then <LRPOSNACMUL>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:MultipleNationality)}</LRPOSNACMUL>
                else ()
            }
            <gFIELDS142>
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:Nationality)
                then <LRNACMULVAL>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:Nationality)}</LRNACMULVAL>
                else ()
            }
            </gFIELDS142>
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:BirthPlace)
                then <PLACEOFBIRTH>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BirthPlace)}</PLACEOFBIRTH>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:BirthCountry)
                then <TOWNCOUNTRY>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BirthCountry)}</TOWNCOUNTRY>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:AccountOfficer)
                then <ACCOUNTOFFICER>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:AccountOfficer)}</ACCOUNTOFFICER>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:GeneralInfo/com:BranchId)
                then <OTHEROFFICER>{fn:data($crearClienteRequest/ns2:GeneralInfo/com:BranchId)}</OTHEROFFICER>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:Residence)
                then <RESIDENCE>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:Residence)}</RESIDENCE>
                else ()
            }
            {
                if(fn:upper-case(fn:data($crearClienteRequest/ns2:Type)) = 'PROSPECTCREDITCUSTOMER')then(
                    <LRRTN/>
                  )else(
                    if ($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='RTN']/ns2:LegalId)then(
                        <LRRTN>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IdList[ns2:DocumentName='RTN']/ns2:LegalId)}</LRRTN>
                    )else(
                        <LRRTN/>
                    )
                  )
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:LegalRepresentative/ns2:LegalId)
                then <LRLEGALISEDID>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:LegalRepresentative/ns2:LegalId)}</LRLEGALISEDID>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:LegalRepresentative/ns2:DocumentName)
                then <LEGALISEDNAME>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:LegalRepresentative/ns2:DocumentName)}</LEGALISEDNAME>
                else ()
            }
            <LRGIVENNAMES>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:LegalRepresentative/ns2:Name)}</LRGIVENNAMES>
            <LRFAMILYNAMES>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:LegalRepresentative/ns2:LastName)}</LRFAMILYNAMES>
            <gFIELDS153>
	    	{	
			for $AddressList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList
                        return 
                	<ADDRESSTYPECUS>{xq:getObjectType(fn:data($AddressList/ns2:Type))}</ADDRESSTYPECUS>
		}
            </gFIELDS153>
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList[1]/ns2:IsMain)
                then <MAINADPHYCOR>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList[1]/ns2:IsMain))}</MAINADPHYCOR>
                else ()
            }
            <gFIELDS155>
	    	{	
			for $AddressList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList
                        return 
                	<COLONYCODE>{fn:data($AddressList/ns2:DistrictCode)}</COLONYCODE>
		}
            </gFIELDS155>
            <gFIELDS156>
	    	{	
			for $AddressList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList
                        return 
                        <AVENUE>{fn:data($AddressList/ns2:Avenue)}</AVENUE>
		}
            </gFIELDS156>
            <gFIELDS157>
	    	{	
			for $AddressList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList
                        return 
                        <ADDSTREET>{fn:data($AddressList/ns2:Street)}</ADDSTREET>
		}
            </gFIELDS157>
            <gFIELDS158>
	    	{	
			for $AddressList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList
                        return 
                        <BLOCK>{fn:data($AddressList/ns2:Block)}</BLOCK>
		}
            </gFIELDS158>
            <gFIELDS159>
	    	{	
			for $AddressList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList
                        return 
                        <HOUSENUMBER>{fn:data($AddressList/ns2:HouseNumber)}</HOUSENUMBER>
		}
            </gFIELDS159>
            <gFIELDS160>
	    	{	
			for $AddressList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList
                        return 
                        <REFERENCES>{fn:data($AddressList/ns2:References)}</REFERENCES>
		}
            </gFIELDS160>
            <gFIELDS161>
	    	{	
                        for $EmailList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:EmailList
                        return ( 
                            <EMAIL1>{fn:data($EmailList/ns2:Email)}</EMAIL1>
                        )
		}
            </gFIELDS161>
            <gFIELDS162>
	    	{	
                        for $EmailList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:EmailList
                        return ( 
                            <LRMAINADELEC>{fn:upper-case(fn:data($EmailList/ns2:IsMain))}</LRMAINADELEC>
                        )
		}
            </gFIELDS162>
            <gFIELDS163>
                {
                for $PhoneList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:PhoneList
                return 
                  if (fn:upper-case(data($PhoneList/ns2:Type)) = 'SMS') then (
                    if (data($PhoneList/ns2:ZipCode)!='') then(
                      <SMS1>{concat(data($PhoneList/ns2:ZipCode), fn:data($PhoneList/ns2:Number))}</SMS1>
                    ) else (
                      <SMS1>{concat('504', fn:data($PhoneList/ns2:Number))}</SMS1>
                    )
                  ) else ()
                }                
            </gFIELDS163>
            <gFIELDS164>
                {
                for $PhoneList in $crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:PhoneList
                return 
                  if (fn:upper-case(data($PhoneList/ns2:Type)) = 'LANDLINE') then (
                    if (data($PhoneList/ns2:ZipCode)!='') then(
                      <PHONE1>{concat(data($PhoneList/ns2:ZipCode), fn:data($PhoneList/ns2:Number))}</PHONE1>
                    ) else (
                      <PHONE1>{concat('504', fn:data($PhoneList/ns2:Number))}</PHONE1>
                    )
                  ) else ()
                }                     
            </gFIELDS164>
            
            
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:EducationLevel)
                then <EDUCATIONLEVEL>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:EducationLevel))}</EDUCATIONLEVEL>
                else ()
            }
            <LRWORK>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:CurrentlyEmployed))}</LRWORK>
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:Occupation)
                then <OCCUPATION>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:Occupation)}</OCCUPATION>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:MerchantType)
                then <TYPEOFMERCHNT>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:MerchantType))}</TYPEOFMERCHNT>
                else ()
            }
            {
                (: Si el MerchantType es diferente de cadena vacía o No entonces se mapean los siguientes campos :)
                if 	(
				data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:MerchantType) != '' and data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:MerchantType) != 'No'
			)
                then 
			(
					<SMENAME>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:BusinessName)}</SMENAME>,
					<LRGIRONEGOCIO>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:LineOfBusiness)}</LRGIRONEGOCIO>,
					<LRFECINSCGIR>{fn:replace(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:InscriptionDate),'-','')}</LRFECINSCGIR>,
					<VOLUMEOFSALES>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:SalesVolume)}</VOLUMEOFSALES>,
					<LRMONVTAFS>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:PeriodClosingSales)}</LRMONVTAFS>,
					<LRANIOVTAFS>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:FiscalYear)}</LRANIOVTAFS>
			)
                else 
					()
            }
            <LREQUSDFV> </LREQUSDFV>
            <PROFESIONTRADE>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:ProfessionCode)}</PROFESIONTRADE>
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:CompanyType)
                then <TYPEOFCOMPANY>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:CompanyType))}</TYPEOFCOMPANY>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:CompanyName)
                then <EMPLOYERSNAME>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:CompanyName)}</EMPLOYERSNAME>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:StartDate)
                then <EMPLOYMENTSTART>{fn:replace(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:StartDate),'-','')}</EMPLOYMENTSTART>
                else ()
            }
            <JOBTITLE>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:JobTitle)}</JOBTITLE>
            <SRCOFINCOME>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:IncomeSource)}</SRCOFINCOME>
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:BenefactorsList[1]/ns2:FullName)
                then <NAMEDEPENDENT>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:BenefactorsList[1]/ns2:FullName)}</NAMEDEPENDENT>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:BenefactorsList[1]/ns2:Profession)
                then <PROFESSIONDEP>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:BenefactorsList[1]/ns2:Profession)}</PROFESSIONDEP>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:BenefactorsList[1]/ns2:Relationship)
                then <RELATIONSHIP>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:BenefactorsList[1]/ns2:Relationship)}</RELATIONSHIP>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:IncomeCurrency)
                then <INCOMECCY>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:IncomeCurrency)}</INCOMECCY>
                else ()
            }
            <INCOMERANGES>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:IncomeRange)}</INCOMERANGES>
            <LRFOTRING>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:OtherIncomeSourceList[1]/ns2:SourceName))}</LRFOTRING>
            <LRFOTRINGM>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:IncomeSourceList/ns2:OtherIncomeSourceList[1]/ns2:Amount)}</LRFOTRINGM>
            <gFIELDS191>
                <NAMEPERSREF>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ReferenceList[ns2:Type='Personal']/ns2:GivenNames)}</NAMEPERSREF>
            </gFIELDS191>
            <gFIELDS192>
                <SELSTNMPRRF>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ReferenceList[ns2:Type='Personal']/ns2:FamilyNames)}</SELSTNMPRRF>
            </gFIELDS192>
            <gFIELDS193>
                <MRLSTNMPRRF>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ReferenceList[ns2:Type='Personal']/ns2:MarriedName)}</MRLSTNMPRRF>
            </gFIELDS193>
            <gFIELDS194>
                <TELNOPERREF>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ReferenceList[ns2:Type='Personal']/ns2:PhoneNumber)}</TELNOPERREF>
            </gFIELDS194>
            <gFIELDS195>
                <RELWTHPERREF>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ReferenceList[ns2:Type='Personal']/ns2:Relationship)}</RELWTHPERREF>
            </gFIELDS195>
            <gFIELDS196>
                <NAMECOMMREF>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ReferenceList[ns2:Type='Commercial']/ns2:GivenNames)}</NAMECOMMREF>
            </gFIELDS196>
            <gFIELDS197>
                <COMMREFCONN>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ReferenceList[ns2:Type='Commercial']/ns2:FamilyNames)}</COMMREFCONN>
            </gFIELDS197>
            <gFIELDS198>
                <TELNOCOMMREF>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ReferenceList[ns2:Type='Commercial']/ns2:PhoneNumber)}</TELNOCOMMREF>
            </gFIELDS198>
            <gFIELDS199>
                <PROVIDERNAME>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList[ns2:Type='Supplier']/ns2:Name)}</PROVIDERNAME>
            </gFIELDS199>
            <gFIELDS200>
                <GEOPROVILOC>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList[ns2:Type='Supplier']/ns2:Location)}</GEOPROVILOC>
            </gFIELDS200>
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList/ns2:Description)
                then <PRDPROVIDES>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList[ns2:Type='Supplier']/ns2:Description)}</PRDPROVIDES>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList/ns2:PhoneNumber)
                then <PROVIDERTELNO>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList[ns2:Type='Supplier']/ns2:PhoneNumber)}</PROVIDERTELNO>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList/ns2:Name)
                then <CLINETNAME>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList[ns2:Type='Customer']/ns2:Name)}</CLINETNAME>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList/ns2:Location)
                then <GEOCLIENTLOC>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList[ns2:Type='Customer']/ns2:Location)}</GEOCLIENTLOC>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList/ns2:Description)
                then <SRVPRODOFFER>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList[ns2:Type='Customer']/ns2:Description)}</SRVPRODOFFER>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList/ns2:PhoneNumber)
                then <CLIENTTELNOS>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:BusinessPartnerList[ns2:Type='Customer']/ns2:PhoneNumber)}</CLIENTTELNOS>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:HasProducts)
                then <LRPRODPASIAB>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:HasProducts))}</LRPRODPASIAB>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:IsUSResident)
                then <LRCIUDAUSA>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:IsUSResident))}</LRCIUDAUSA>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:CountryOfResidence)
                then <LRPAISEFF>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:CountryOfResidence)}</LRPAISEFF>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:HasEvidenceOfLostResidence)
                then <LRPERNAC>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:HasEvidenceOfLostResidence)}</LRPERNAC>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:USFiscallId)
                then <LRCUSTIN>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:USFiscallId)}</LRCUSTIN>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:PlaceOfBirth)
                then <LRLUGNA>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:PlaceOfBirth)}</LRLUGNA>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:AdditionalFiscalId)
                then <LRNUMIDP>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:FatcaInfo/ns2:AdditionalFiscalId)}</LRNUMIDP>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:ApnfdCustomer)
                then <LRCUSAPNFDS>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ApnfdCustomer)}</LRCUSAPNFDS>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:ApnfdProfession)
                then <LRAPNFDPROF>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ApnfdProfession)}</LRAPNFDPROF>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:GovernmentContractor)
                then <LRSTATECNTR>{fn:upper-case(fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:GovernmentContractor))}</LRSTATECNTR>
                else ()
            }
            {
                if ($crearClienteRequest/ns2:CustomerInfo/ns2:Target)
                then <TARGET>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:Target)}</TARGET>
                else ()
            }
            <NEIGHBPENDING>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:ContactInfo/ns2:AddressList/ns2:Neighborhood)}</NEIGHBPENDING>
            <FGNCCYGENTYP></FGNCCYGENTYP>
            <LANGUAGE></LANGUAGE>
            <INDUSTRY>{fn:data($crearClienteRequest/ns2:CustomerInfo/ns2:Industry)}</INDUSTRY>
            {
                if ($crearClienteRequest/ns2:Migrate)
                then <LRMIGRATECUS>{fn:data($crearClienteRequest/ns2:Migrate)}</LRMIGRATECUS>
                else ()
            }
            
           {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:AccountOfficialDetail/ns2:OfficialCode)
                then  <OFFICIALCODE>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:AccountOfficialDetail/ns2:OfficialCode)}</OFFICIALCODE>
                else ()
            }
            
            {
                if ($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:AccountOfficialDetail/ns2:AgencyCode)
                then  <AGENCYCODE>{fn:data($crearClienteRequest/ns2:AccountInfo/ns2:AccountDetail/ns2:AccountOfficialDetail/ns2:AgencyCode)}</AGENCYCODE>
                else ()
            }
            
        </FICOBULKPRODUCTINPUTDYNWSType>
    </ns1:CreacionClientesparaDynamo>
};

local:CrearClienteNormalIntermedioHNIn($password, $userName, $crearClienteRequest)