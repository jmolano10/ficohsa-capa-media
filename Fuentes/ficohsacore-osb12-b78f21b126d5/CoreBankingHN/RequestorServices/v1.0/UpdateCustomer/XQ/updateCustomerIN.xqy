xquery version "1.0" encoding "utf-8";
(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/UpdateCustomerDynamo/UpdateCustomerDYN.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns3="http://www.ficohsa.com/midleware.services/updateCustomerIN";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $request as element() (:: schema-element(ns1:updateCustomerRequest) ::) external;

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
 
 

declare function ns1:updateCustomerIN($username as xs:string, 
                                      $password as xs:string, 
                                      $request as element() (:: schema-element(ns1:updateCustomerRequest) ::)) 
                                      as element() (:: schema-element(ns2:ActualizaciondatosClientesDYNAMO) ::) {
    <ns2:ActualizaciondatosClientesDYNAMO>
    <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction>
            <noOfAuth>0</noOfAuth>
        </OfsFunction>
        <CUSTOMERINDIVIDUALACTDATOSWSDYNType id = "{ data($request/ns1:CustomerId) }">
            {
                if ($request/ns1:CustomerInfo/ns1:Nationality)
                then <NATIONALITY>{upper-case(fn:data($request/ns1:CustomerInfo/ns1:Nationality))}</NATIONALITY>
                else ()
            }  
            {
                if ($request/ns1:CustomerInfo/ns1:Residence)
                then <RESIDENCE>{upper-case(fn:data($request/ns1:CustomerInfo/ns1:Residence))}</RESIDENCE>
                else ()
            }        
            {
                if ($request/ns1:CustomerInfo/ns1:MaritalStatus)
                then <MARITALSTATUS>{upper-case(fn:data($request/ns1:CustomerInfo/ns1:MaritalStatus))}</MARITALSTATUS>
                else ()
            }
            {
                if ($request/ns1:ContactInfo/ns1:PhoneList) then
                <gPHONE1>
                    {
                    for $PhoneList in $request/ns1:ContactInfo/ns1:PhoneList
                    return
                      if (data($PhoneList/ns1:Type) = 'PHONE') then (
                        if (data($PhoneList/ns1:ZipCode)!='') then(
                          <PHONE>{concat(replace(data($PhoneList/ns1:ZipCode),'-',''), replace(fn:data($PhoneList/ns1:Number),'-',''))}</PHONE>
                        ) else (
                          <PHONE>{concat('504', replace(fn:data($PhoneList/ns1:Number),'-',''))}</PHONE>
                        )
                      ) else ()
                    }
                </gPHONE1>
                else ()
            }
            {
                if ($request/ns1:ContactInfo/ns1:PhoneList) then
                <gSMS1>
                    {
                    for $PhoneList in $request/ns1:ContactInfo/ns1:PhoneList
                    return
                      if (data($PhoneList/ns1:Type) = 'SMS') then (
                        if (data($PhoneList/ns1:ZipCode)!='') then(
                          <CELLPHONENUMBER>{concat(replace(data($PhoneList/ns1:ZipCode),'-',''), replace(fn:data($PhoneList/ns1:Number),'-',''))}</CELLPHONENUMBER>
                        ) else (
                          <CELLPHONENUMBER>{concat('504', replace(fn:data($PhoneList/ns1:Number),'-',''))}</CELLPHONENUMBER>
                        )
                      ) else ()
                    }
                </gSMS1>
                else ()
            }
            {
                if ($request/ns1:ContactInfo/ns1:EmailList) then
                <gEMAIL1>
                    {
                    for $EmailList in $request/ns1:ContactInfo/ns1:EmailList
                    return <EMAIL>{fn:data($EmailList/ns1:Email)}</EMAIL>
                    }
                </gEMAIL1>
                else ()
            }
            {
                if ($request/ns1:IncomeSourceList/ns1:JobTitle)
                then <JOBTITLE>{fn:data($request/ns1:IncomeSourceList/ns1:JobTitle)}</JOBTITLE>
                else ()
            }
            {
                if ($request/ns1:IncomeSourceList/ns1:CompanyName)
                then <EMPLOYERSNAME>{fn:data($request/ns1:IncomeSourceList/ns1:CompanyName)}</EMPLOYERSNAME>
                else ()
            }
            {
                if ($request/ns1:IncomeSourceList/ns1:ProfessionCode)
                then <PROFESIONTRADE>{fn:data($request/ns1:IncomeSourceList/ns1:ProfessionCode)}</PROFESIONTRADE>
                else ()
            }
            {
                if ($request/ns1:CustomerInfo/ns1:SpouseName)
                then <SPOUSENAME>{fn:data($request/ns1:CustomerInfo/ns1:SpouseName)}</SPOUSENAME>
                else ()
            }
            {
                if ($request/ns1:ContactInfo/ns1:AddressList) then
                <gADDRESS.TYPE>
                    {
                        for $AddressList in $request/ns1:ContactInfo/ns1:AddressList
                        return 
                        <mADDRESS.TYPE>
                            {
                                if ($AddressList/ns1:Type)
                                then <ADDRESSTYPE>{fn:data($AddressList/ns1:Type)}</ADDRESSTYPE>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:IsMain)
                                then <MAINADPHYCOR>{ upper-case(fn:data($AddressList/ns1:IsMain)) }</MAINADPHYCOR>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:CountryCode)
                                then <COUNTRYCODE>{fn:data($AddressList/ns1:CountryCode)}</COUNTRYCODE>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:StateCode)
                                then <STATECODE>{fn:data($AddressList/ns1:StateCode)}</STATECODE>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:CityCode)
                                then <CITYCODE>{fn:data($AddressList/ns1:CityCode)}</CITYCODE>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:DistrictCode)
                                then <COLONYCODE>{fn:data($AddressList/ns1:DistrictCode)}</COLONYCODE>
                                else <COLONYCODE>HN.00.0000.000000</COLONYCODE>
                            }
                            {
                                if ($AddressList/ns1:Neighborhood)
                                then <NEIGHBPENDING>{fn:data($AddressList/ns1:Neighborhood)}</NEIGHBPENDING>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:Avenue)
                                then <AVENUE>{fn:data($AddressList/ns1:Avenue)}</AVENUE>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:Street)
                                then <ADDSTREET>{fn:data($AddressList/ns1:Street)}</ADDSTREET>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:Block)
                                then <BLOCK>{fn:data($AddressList/ns1:Block)}</BLOCK>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:HouseNumber)
                                then <HOUSENUMBER>{fn:data($AddressList/ns1:HouseNumber)}</HOUSENUMBER>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:References)
                                then <REFERENCES>{fn:data($AddressList/ns1:References)}</REFERENCES>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:AddressLine1)
                                then <COMPLETEADDRES>{fn:data($AddressList/ns1:AddressLine1)}</COMPLETEADDRES>
                                else ()
                            }
                            {
                                if ($AddressList/ns1:AddressLine2)
                                then <COMPLETADDRESS>{fn:data($AddressList/ns1:AddressLine2)}</COMPLETADDRESS>
                                else ()
                            }</mADDRESS.TYPE>
                    }
                </gADDRESS.TYPE>
                else ()
            }
           {
                if ($request/ns1:IncomeSourceList/ns1:IncomeRange)
                then <INCOMERANGES>{fn:data($request/ns1:IncomeSourceList/ns1:IncomeRange)}</INCOMERANGES>
                else ()
            }
           {
                if ($request/ns1:CustomerInfo/ns1:ProviderName) then
                <gPROVIDER.NAME>
                    <mPROVIDER.NAME>
                        <PROVIDERNAME>{fn:data($request/ns1:CustomerInfo/ns1:ProviderName)}</PROVIDERNAME>
                    </mPROVIDER.NAME>
                </gPROVIDER.NAME>
                else ()
            }
            <gCLINET.NAME>
                <mCLINET.NAME>
                    <CLINETNAME></CLINETNAME>
                    <CLIENTTELNOS></CLIENTTELNOS>
                </mCLINET.NAME>
            </gCLINET.NAME>
			{
				if(fn:exists($request/ns1:ReferenceList[ns1:Type="Commercial"])) then (
					<gNAME.COMM.REF>
					{
						for $Reference in $request/ns1:ReferenceList[ns1:Type="Commercial"]
						return(
							<mNAME.COMM.REF>
							{
								for $GivenNames in $Reference/ns1:GivenNames
								return
								<NAMECOMMREF>{fn:data($GivenNames)}</NAMECOMMREF>
							}
							{
								for $FamilyNames in $Reference/ns1:FamilyNames
								return
								<COMMREFCONN>{fn:data($FamilyNames)}</COMMREFCONN>
							}
							{
								for $PhoneNumber in $Reference/ns1:PhoneNumber
								return
								<TELNOCOMMREF>{fn:data($PhoneNumber)}</TELNOCOMMREF>
							}
							</mNAME.COMM.REF>
						)
					}
					</gNAME.COMM.REF>
				) else ()
			}
			{
				if(fn:exists($request/ns1:ReferenceList[ns1:Type="Personal"])) then (
					<gNAME.PERS.REF>
					{
						for $Reference in $request/ns1:ReferenceList[ns1:Type="Personal"]
						return(
							<mNAME.PERS.REF>
							{
								for $GivenNames in $Reference/ns1:GivenNames
								return
								<NAMEPERSREF>{fn:data($GivenNames)}</NAMEPERSREF>
							}
							{
								for $FamilyNames in $Reference/ns1:FamilyNames
								return
								<SELSTNMPRRF>{fn:data($FamilyNames)}</SELSTNMPRRF>
							}
							{
								for $MarriedName in $Reference/ns1:MarriedName
								return
								<MRLSTNMPRRF>{fn:data($MarriedName)}</MRLSTNMPRRF>
							}
							{
								for $PhoneNumber in $Reference/ns1:PhoneNumber
								return
								<TELNOPERREF>{fn:data($PhoneNumber)}</TELNOPERREF>
							}
							{
								for $Relationship in $Reference/ns1:Relationship
								return
								<RELWTHPERREF>{fn:data($Relationship)}</RELWTHPERREF>
							}
							</mNAME.PERS.REF>
						)
					}
					</gNAME.PERS.REF>
				) else ()
			}
            <VOLUMEOFSALES></VOLUMEOFSALES>
            {
                if ($request/ns1:CustomerInfo/ns1:BusinessName) then
                <SMENAME>{fn:data($request/ns1:CustomerInfo/ns1:BusinessName)}</SMENAME>
                else ()
            }
            {
                if ($request/ns1:CustomerInfo/ns1:Nationality) then
                <gLR.NAC.MUL.VAL>
                    <LRNACMULVAL>{fn:data($request/ns1:CustomerInfo/ns1:Nationality)}</LRNACMULVAL>
                </gLR.NAC.MUL.VAL>
                else ()
            }
            {
                if ($request/ns1:CustomerInfo/ns1:TotalIncome)
                then <LRFSUMINGR>{fn:data($request/ns1:CustomerInfo/ns1:TotalIncome)}</LRFSUMINGR>
                else ()
            }
            {
                if ($request/ns1:CustomerInfo/ns1:LineOfBusiness)
                then <LRGIRONEGOCIO>{fn:data($request/ns1:CustomerInfo/ns1:LineOfBusiness)}</LRGIRONEGOCIO>
                else ()
            }
            {
                if ($request/ns1:CustomerInfo/ns1:Nationality)
                then <gLR.PAIS.EF.F><LRPAISEFF>{upper-case(fn:data($request/ns1:CustomerInfo/ns1:Nationality))}</LRPAISEFF></gLR.PAIS.EF.F>
                else ()
            }
           {
                if ($request/ns1:CustomerInfo/ns1:ClosingTax) then
                <gLR.MON.VTA.FS>
                    <mLR.MON.VTA.FS>
                        <LRMONVTAFS>{fn:data($request/ns1:CustomerInfo/ns1:ClosingTax)}</LRMONVTAFS>
                    </mLR.MON.VTA.FS>
                </gLR.MON.VTA.FS>
                else ()
            }
            {
                if ($request/ns1:CustomerInfo/ns1:Target)
                then <TARGET>{fn:data($request/ns1:CustomerInfo/ns1:Target)}</TARGET>
                else ()
            }
        </CUSTOMERINDIVIDUALACTDATOSWSDYNType>
    </ns2:ActualizaciondatosClientesDYNAMO>
};

ns1:updateCustomerIN($username, $password, $request)