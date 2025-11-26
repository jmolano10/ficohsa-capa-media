(:: pragma bea:global-element-parameter parameter="$creacionClienteNaturalBanco1" element="ns2:creacionClienteNaturalBanco" location="../xsd/creacionClienteBancoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CreacionClienteNatural" location="../../../BusinessServices/T24/creacionCliente/xsd/XMLSchema_1413221226.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/creacionClienteBancoTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionClienteBanco/xq/creacionClienteNaturalBancoIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:creacionClienteNaturalBancoIn($creacionClienteNaturalBanco1 as element(ns2:creacionClienteNaturalBanco),
	$uuid as xs:string,
    $accountOfficer as xs:string,
    $username as xs:string,
    $password as xs:string)
    as element(ns1:CreacionClienteNatural) {
        <ns1:CreacionClienteNatural>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($username),$username) }</userName>
                <password>{ fn-bea:fail-over( getPassword($username),$password) }</password>
            </WebRequestCommon>
            <OfsFunction>
            	<messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <CUSTOMERNONLEGALINPUTWSType id = "{ data($creacionClienteNaturalBanco1/ns2:BANK_INFO/ns2:SUGGESTED_ID) }">
                <gSHORTNAME>
                    <SHORTNAME>{ concat($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:FIRST_NAME , " ",$creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:FIRST_LASTNAME) }</SHORTNAME>
                </gSHORTNAME>
                <gNAME1>
                    <NAME1>{ concat($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:FIRST_NAME , $creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:SECOND_NAME) }</NAME1>
                    <NAME1>{ concat($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:FIRST_LASTNAME , $creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:SECOND_LASTNAME) }</NAME1>
                </gNAME1>
                <gTOWNCOUNTRY>
                    <TOWNCOUNTRY>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:COUNTRY_OF_BIRTH) }</TOWNCOUNTRY>
                </gTOWNCOUNTRY>
                <gRELATIONCODE>
                {
                    for $RELATIONSHIP_ITEM in $creacionClienteNaturalBanco1/ns2:RELATIONSHIPS_INFO/ns2:RELATIONSHIP_ITEM
                    return
                        <mRELATIONCODE>
                        	<RELATIONCODE>{ fn:string($RELATIONSHIP_ITEM/CODE/text()) }</RELATIONCODE>
                        	<RELCUSTOMER>{ fn:string($RELATIONSHIP_ITEM/CUSTOMER/text()) }</RELCUSTOMER>
                        </mRELATIONCODE>
                }
                </gRELATIONCODE>
                {
                    for $SECTOR in $creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:SECTOR
                    return
                        <SECTOR>{ data($SECTOR) }</SECTOR>
                }
                <ACCOUNTOFFICER>{ $accountOfficer }</ACCOUNTOFFICER>
                {
                    for $INDUSTRY in $creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:INDUSTRY
                    return
                        <INDUSTRY>{ data($INDUSTRY) }</INDUSTRY>
                }
                {
                    for $TARGET in $creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:TARGET
                    return
                        <TARGET>{ data($TARGET) }</TARGET>
                }
                <NATIONALITY>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:NATIONALITY) }</NATIONALITY>
                <RESIDENCE>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:RESIDENCE) }</RESIDENCE>
                <gLEGALID>
                    <mLEGALID>
                        <LEGALID>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:IDENTIFICATION/ns2:LEGAL_IDENTIFICATION_ITEM[1]/ns2:LEGAL_ID) }</LEGALID>
                        <LEGALDOCNAME>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:IDENTIFICATION/ns2:LEGAL_IDENTIFICATION_ITEM[1]/ns2:LEGAL_DOCUMENT_NAME) }</LEGALDOCNAME>
                        <LEGALISSDATE>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:IDENTIFICATION/ns2:LEGAL_IDENTIFICATION_ITEM[1]/ns2:DATE_OF_ISSUANCE) }</LEGALISSDATE>
                        <LEGALEXPDATE>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:IDENTIFICATION/ns2:LEGAL_IDENTIFICATION_ITEM[1]/ns2:MATURITY_DATE) }</LEGALEXPDATE>
                    </mLEGALID>
                </gLEGALID>
                <LANGUAGE>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:LANGUAGE) }</LANGUAGE>
                <GIVENNAMES>
                {
                    let $FIRST_NAME := fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:FIRST_NAME/text())
                    let $SECOND_NAME := fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:SECOND_NAME/text())
                    let $THIRD_NAME := fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:THIRD_NAME/text())
                    return
                    if ($SECOND_NAME != "" and $THIRD_NAME != "") then (
                    	fn:concat($FIRST_NAME," ",$SECOND_NAME, " ", $THIRD_NAME)
                    ) else if ($SECOND_NAME != "") then (
                    	fn:concat($FIRST_NAME," ",$SECOND_NAME)
                    ) else if ($THIRD_NAME != "") then (
                    	fn:concat($FIRST_NAME," ",$THIRD_NAME)
                    ) else (
                    	$FIRST_NAME
                    ) 
                }
                </GIVENNAMES>
                <FAMILYNAME>
                {
                    let $FIRST_LASTNAME := fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:FIRST_LASTNAME/text())
                    let $SECOND_LASTNAME := fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:SECOND_LASTNAME/text())
					return
					if ($SECOND_LASTNAME = "") then (
						$FIRST_LASTNAME
					) else (
						fn:concat($FIRST_LASTNAME, " ", $SECOND_LASTNAME)
					)
                }
                </FAMILYNAME>
                <GENDER>
                    {
                        let $gender  := (fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:GENDER/text()))  
                        return
                            if ($gender = "MALE") then
                                ("01")
                            else 
                                "02"
                    }
</GENDER>
                <DATEOFBIRTH>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:DATE_OF_BIRTH) }</DATEOFBIRTH>
                <MARITALSTATUS>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:MARITAL_STATUS) }</MARITALSTATUS>
				<gPHONE1>
               	{
               		for $PHONE_NUMBER_ITEM in $creacionClienteNaturalBanco1/ns2:CONTACT_INFO/ns2:PHONE_NUMBER_INFO/ns2:PHONE_NUMBER_ITEM[ns2:PHONE_TYPE!="MOBILE"]
               		return
           				<PHONE1>{ concat($PHONE_NUMBER_ITEM/ns2:PHONE_AREA_CODE , $PHONE_NUMBER_ITEM/ns2:PHONE_NUMBER) }</PHONE1>
               	}
                </gPHONE1>
                <gSMS1>
               	{
               		for $PHONE_NUMBER_ITEM in $creacionClienteNaturalBanco1/ns2:CONTACT_INFO/ns2:PHONE_NUMBER_INFO/ns2:PHONE_NUMBER_ITEM[ns2:PHONE_TYPE="MOBILE"]
               		return
           				<SMS1>{ concat($PHONE_NUMBER_ITEM/ns2:PHONE_AREA_CODE , $PHONE_NUMBER_ITEM/ns2:PHONE_NUMBER) }</SMS1>
               	}
                </gSMS1>
                <gEMAIL1>
                    {
                        for $EMAIL_ADDRESS  in ($creacionClienteNaturalBanco1/ns2:CONTACT_INFO/ns2:EMAIL_ADDRESS_INFO/ns2:EMAIL_ADDRESS)  
                        return
                            (<EMAIL1>{ data($EMAIL_ADDRESS) }</EMAIL1>)
                    }
				</gEMAIL1>
                <gEMPLOYMENTSTATUS>
                    <mEMPLOYMENTSTATUS>
                        <OCCUPATION>{ data($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:OCCUPATION) }</OCCUPATION>
                        {
                        	if (fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:MERCHANT_TYPE/text()) = "INDIVIDUAL" and
                			fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:OCCUPATION/text()) = "MERCHANT") then (
	                				<JOBTITLE/>,
	                				<EMPLOYERSNAME/>
	                		) else (
	                			<JOBTITLE>{ fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:JOB_TITLE/text()) }</JOBTITLE>,
	                			<EMPLOYERSNAME>{ fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:COMPANY_NAME/text()) }</EMPLOYERSNAME>
	                		)
                        }
                        {
                            for $EMPLOYMENT_START in $creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:EMPLOYMENT_START
                            return
                                <EMPLOYMENTSTART>{ data($EMPLOYMENT_START) }</EMPLOYMENTSTART>
                        }
                    </mEMPLOYMENTSTATUS>
                </gEMPLOYMENTSTATUS>
                <gRESIDENCESTATUS>
                {
                	for $HOUSEHOLD_ITEM in $creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:HOUSEHOLDS/ns2:HOUSEHOLD_ITEM
                	return
                	<mRESIDENCESTATUS>
                		<RESIDENCESTATUS>{ fn:string($HOUSEHOLD_ITEM/ns2:STATUS/text()) }</RESIDENCESTATUS>
                		<RESIDENCETYPE>{ fn:string($HOUSEHOLD_ITEM/ns2:TYPE/text()) }</RESIDENCETYPE>
                		<RESIDENCESINCE>{ fn:string($HOUSEHOLD_ITEM/ns2:OWNER_SINCE/text()) }</RESIDENCESINCE>
                		<RESIDENCEVALUE>{ fn:string($HOUSEHOLD_ITEM/ns2:ESTIMATED_VALUE/text()) }</RESIDENCEVALUE>
                	</mRESIDENCESTATUS>
                }
                </gRESIDENCESTATUS>
                {
                    for $MARRIED_NAME in $creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:MARRIED_NAME
                    return
                        <MARRLASTNAME>{ data($MARRIED_NAME) }</MARRLASTNAME>
                }
                <EDUCATIONLEVEL>
                { 
                	let $EDUCATION_LEVEL := fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:LEVEL_OF_EDUCATION/text())
                	return
                	if ($EDUCATION_LEVEL = "NONE") then (
                		"NINGUNA"
                	) else if ($EDUCATION_LEVEL = "ELEMENTARY") then (
                		"PRIMARIA"
                	) else if ($EDUCATION_LEVEL = "MIDDLE") then (
                		"SECUNDARIA"
                	) else if ($EDUCATION_LEVEL = "UNIVERSITY") then (
                		"SUPERIOR"
                	) else if ($EDUCATION_LEVEL = "MASTERS") then (
                		"POSTGRADO"
                	) else if ($EDUCATION_LEVEL = "DOCTORAL") then (
                		"DOCTORADO"
                	) else (
                		""
                	)
                }
                </EDUCATIONLEVEL>
                <PROFESIONTRADE>{ data($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:PROFESSION) }</PROFESIONTRADE>
                <TYPEOFCOMPANY>
                {
                    let $COMPANY_TYPE := fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:COMPANY_TYPE/text())
                    return
                         if ($COMPANY_TYPE = "GOVERNMENT") then (
                         	"PUBLICA"
                         ) else if ($COMPANY_TYPE = "PRIVATE") then (
                         	"PRIVADA"
                         ) else (
                         	""
                         )
                }
                </TYPEOFCOMPANY>
                <SRCOFINCOME>{ fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:SOURCE_OF_INCOME/text()) }</SRCOFINCOME>
                <PLACEOFBIRTH>{ data($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:BIRTHPLACE) }</PLACEOFBIRTH>
                <SPOUSENAME>{ fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:SPOUSE_NAME/text()) }</SPOUSENAME>
                <gADDRESS.TYPE>
                    {
                        for $ADDRESS_ITEM in $creacionClienteNaturalBanco1/ns2:CONTACT_INFO/ns2:ADDRESS_INFO/ns2:ADDRESS_ITEM
                        return
                            <mADDRESS.TYPE>
                                <ADDRESSTYPE>
                                { 
                                	let $ADDRESS_TYPE := fn:string($ADDRESS_ITEM/ns2:ADDRESS_TYPE/text())
                                	return
                                		if ($ADDRESS_TYPE = "HOME") then (
                                			"1"
                                		) else if ($ADDRESS_TYPE = "WORK") then (
                                			"2"
                                		) else (
                                			"3" 
                                		)
                                }
                                </ADDRESSTYPE>
                                <MAINADPHYCOR>{ data($ADDRESS_ITEM/ns2:MAIN_ADDRESS) }</MAINADPHYCOR>
                                <COLONYCODE>{ concat($ADDRESS_ITEM/ns2:COUNTRY_CODE , ".", $ADDRESS_ITEM/ns2:DEPARTMENT_CODE , ".", $ADDRESS_ITEM/ns2:CITY_CODE , ".", $ADDRESS_ITEM/ns2:DISTRICT_CODE) }</COLONYCODE>
                                <AVENUE>{ data($ADDRESS_ITEM/ns2:AVENUE) }</AVENUE>
                                <ADDSTREET>{ data($ADDRESS_ITEM/ns2:STREET) }</ADDSTREET>                                
                                <BLOCK>{ data($ADDRESS_ITEM/ns2:BLOCK) }</BLOCK>
                                <HOUSENUMBER>{ data($ADDRESS_ITEM/ns2:HOUSE_NUMBER) }</HOUSENUMBER>
                                <REFERENCES>{ data($ADDRESS_ITEM/ns2:DETAILS) }</REFERENCES>
                            </mADDRESS.TYPE>
                    }
                </gADDRESS.TYPE>
                <TYPEOFMERCHNT>{ fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:MERCHANT_TYPE/text()) }</TYPEOFMERCHNT>
                <gINCOME.CCY>
                    <mINCOME.CCY>
                        {
                            for $INCOME_CURRENCY in $creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:INCOME_CURRENCY
                            return
                                <INCOMECCY>{ data($INCOME_CURRENCY) }</INCOMECCY>
                        }
                        {
                            for $INCOME_RANGE in $creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:INCOME_RANGE
                            return
                                <INCOMERANGES>{ data($INCOME_RANGE) }</INCOMERANGES>
                        }
                    </mINCOME.CCY>
                </gINCOME.CCY>
                {
                	if (fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:MERCHANT_TYPE/text()) = "INDIVIDUAL" and
                		fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:OCCUPATION/text()) = "MERCHANT") then (
		                <gPROVIDER.NAME>
		                	<mPROVIDER.NAME>
		                		<PROVIDERNAME>Sin Información</PROVIDERNAME>
		                		<GEOPROVILOC>Sin Información</GEOPROVILOC>
		                		<PRDPROVIDES>Sin Información</PRDPROVIDES>
		                		<PROVIDERTELNO>22000000</PROVIDERTELNO>
		                	</mPROVIDER.NAME>
		                </gPROVIDER.NAME>
		            ) else ()
                }
                {
                	if (fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:MERCHANT_TYPE/text()) = "INDIVIDUAL" and
                		fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:OCCUPATION/text()) = "MERCHANT") then (
		                <gCLINET.NAME>
		                	<mCLINET.NAME>
		                		<CLINETNAME>Sin Información</CLINETNAME>
		                		<GEOCLIENTLOC>Sin Información</GEOCLIENTLOC>
		                		<SRVPRODOFFER>Sin Información</SRVPRODOFFER>
		                	</mCLINET.NAME>
		                </gCLINET.NAME>
		            ) else ()
                }                
                <gNAME.COMM.REF>
                    {
                        for $COMMERCIAL_REFERENCE in $creacionClienteNaturalBanco1/ns2:REFERENCES_INFO/ns2:COMMERCIAL_REFERENCE
                        return
                            <mNAME.COMM.REF>
                                <NAMECOMMREF>{ data($COMMERCIAL_REFERENCE/ns2:COMPANY_NAME) }</NAMECOMMREF>
                                <COMMREFCONN>{ data($COMMERCIAL_REFERENCE/ns2:CONTACT_NAME) }</COMMREFCONN>
                                <TELNOCOMMREF>{ data($COMMERCIAL_REFERENCE/ns2:TELEPHONE_NUMBER) }</TELNOCOMMREF>
                            </mNAME.COMM.REF>
                    }
                </gNAME.COMM.REF>
                <OWNVEHICLE>{ data($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:OWNS_VEHICLE) }</OWNVEHICLE>
                <gNAME.PERS.REF>
                    {
                        for $PERSONAL_REFERENCE in $creacionClienteNaturalBanco1/ns2:REFERENCES_INFO/ns2:PERSONAL_REFERENCE
                        return
                            <mNAME.PERS.REF>
                                <NAMEPERSREF>{ data($PERSONAL_REFERENCE/ns2:FIRST_NAME) }</NAMEPERSREF>
                                <SELSTNMPRRF>{ data($PERSONAL_REFERENCE/ns2:LAST_NAME) }</SELSTNMPRRF>
                                {
                                    for $MARRIED_NAME in $PERSONAL_REFERENCE/ns2:MARRIED_NAME
                                    return
                                        <MRLSTNMPRRF>{ data($MARRIED_NAME) }</MRLSTNMPRRF>
                                }
                                <TELNOPERREF>{ data($PERSONAL_REFERENCE/ns2:TELEPHONE_NUMBER) }</TELNOPERREF>
                                <RELWTHPERREF>{ data($PERSONAL_REFERENCE/ns2:RELATION_WITH_CUSTOMER) }</RELWTHPERREF>
                            </mNAME.PERS.REF>
                    }
                </gNAME.PERS.REF>
                <VOLUMEOFSALES>{ data($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:SALES_VOLUME) }</VOLUMEOFSALES>
                {
                	if (fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:MERCHANT_TYPE/text()) = "INDIVIDUAL" and
                		fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:OCCUPATION/text()) = "MERCHANT") then (
		          			<SMENAME>{ fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:COMPANY_NAME/text()) }</SMENAME>
		            ) else ()
                } 
                <FGNCCYGENTYP>NG</FGNCCYGENTYP>
                {
            	<gEXTENSION>
               	{
               		for $PHONE_NUMBER_ITEM in $creacionClienteNaturalBanco1/ns2:CONTACT_INFO/ns2:PHONE_NUMBER_INFO/ns2:PHONE_NUMBER_ITEM[ns2:PHONE_TYPE!="MOBILE"]
               		return
               			<mEXTENSION>
           					<TELEPHONEREFER>
           					{ 
           						let $PHONE_LOCATION := fn:string($PHONE_NUMBER_ITEM/ns2:PHONE_LOCATION/text())
           						return
           						if ($PHONE_LOCATION = "HOME") then (
           							"CASA"
           						) else if ($PHONE_LOCATION = "WORK") then (
           							"TRABAJO"
           						) else (
           							"OTRO"
           						)  
           					}
           					</TELEPHONEREFER>
           				</mEXTENSION>
               	}                	
				</gEXTENSION>
                }
                {
                	if (fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:MERCHANT_TYPE/text()) = "INDIVIDUAL" and
                		fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:OCCUPATION/text()) = "MERCHANT") then (
		          		<NOOFCOMPUTERS>1</NOOFCOMPUTERS>
		            ) else ()
                }                 
                <HASINTERNET>{ fn:string($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:INTERNET_ACCESS/text()) }</HASINTERNET>
                <TYPEOFCONN>{ fn:string($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:TYPE_OF_CONNECTION/text()) }</TYPEOFCONN>
                <BUSINESSAREA>{ fn:string($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:BUSINESS_AREA/text()) }</BUSINESSAREA>
                <INTLBUSINES>{ fn:string($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:INTL_BUSINESS/text()) }</INTLBUSINES>
                <TYPINTBUSINES>{ fn:string($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:INTL_BUSINESS_TYPE/text()) }</TYPINTBUSINES>
                {
                	if (fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:MERCHANT_TYPE/text()) = "INDIVIDUAL" and
                		fn:string($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:OCCUPATION/text()) = "MERCHANT") then (
		          		<gBUSINESS.COUNTR>
		          			<BUSINESSCOUNTR>HN</BUSINESSCOUNTR>
		          		</gBUSINESS.COUNTR>
		            ) else ()
                }                
                <PROJECTS>{ fn:string($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:CURRENT_PROJECTS/text()) }</PROJECTS>
                <BANKSWTHWORKS>{ fn:string($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:BANKS_OF_BUSINESS/text()) }</BANKSWTHWORKS>
                <BANKPRODUCT>{ fn:string($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:BANKING_PRODUCTS/text()) }</BANKPRODUCT>
                <gSECTORIZ.TYPE>
                    {
                        for $SECTORIZATION_ITEM in $creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:SECTORIZATION/ns2:SECTORIZATION_ITEM
                        return
                            <mSECTORIZ.TYPE>
                                <SECTORIZTYPE>{ data($SECTORIZATION_ITEM/ns2:SECTORIZATION_TYPE) }</SECTORIZTYPE>
                                <SECTORIZCODE>{ data($SECTORIZATION_ITEM/ns2:SECTORIZATION_CODE) }</SECTORIZCODE>
                            </mSECTORIZ.TYPE>
                    }
                </gSECTORIZ.TYPE>
                <LRPEPLIST>
	                {
	                	let $ISPEP_FLAG := fn:string($creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:PEP)
	                	return
	                	if ($ISPEP_FLAG = "YES") then
	                		"Y"
	                	else
	                		"N"
	                }
                </LRPEPLIST>
                <DEPENNAME>{ fn:string($creacionClienteNaturalBanco1/ns2:MARKETING_INFO/ns2:NUMBER_OF_DEPENDENTS/text()) }</DEPENNAME>
                <gLR.MAIN.AD.ELEC>
                    <LRMAINADELEC>YES</LRMAINADELEC>
                </gLR.MAIN.AD.ELEC>
                <LRWORK>{ data($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:CURRENTLY_EMPLOYED) }</LRWORK>
                <LRGIVENNAMES>{ fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:LEGAL_GIVEN_NAMES/text()) }</LRGIVENNAMES>
                <LRFAMILYNAMES>{ fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:LEGAL_FAMILY_NAMES/text()) }</LRFAMILYNAMES>
                <LRPOSNACMUL>
                	{ 
                		let $OWNMULTIPLENAN := fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:MULTIPLE_NATIONALITY/text())
                		return
                		if ( $OWNMULTIPLENAN = "YES") then 
                			"SI"
                	    else
                	    	"NO" 
                	}
                </LRPOSNACMUL>                
                <gLR.F.OTR.ING>
	                {
                        for $OTHER_INCOME_ITEM in $creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:OTHERS_INCOME/ns2:INCOME_ITEM
                        return
                            <mLR.F.OTR.ING>
                                <LRFOTRING>{ data($OTHER_INCOME_ITEM/ns2:TYPE) }</LRFOTRING>
                                <LRFOTRINGM>{ data($OTHER_INCOME_ITEM/ns2:MONTHLY_AMOUNT) }</LRFOTRINGM>
                            </mLR.F.OTR.ING>  	                	
	                }
                </gLR.F.OTR.ING>
                <LRGIRONEGOCIO>{ data($creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:BUSINESS_SEGMENT/text()) }</LRGIRONEGOCIO>
                <LRCUSAPNFDS>
                	{
                		let $IS_DNFBP := fn:string(data($creacionClienteNaturalBanco1/ns2:DNFBP_INFO/ns2:DNFBP/text()))
                		return
                		if ( $IS_DNFBP= "YES") then
                			"Y"
                		else
                			"N"
                	}                
                </LRCUSAPNFDS>
                <LRCARGPUB>{ fn:string(data($creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:JOB_TITLE/text())) }</LRCARGPUB>
                <LRINSTPEP>{ fn:string(data($creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:INSTITUTION_NAME/text())) }</LRINSTPEP>                
                <gLR.FIG.PUBL>
	                {
	                	for $PEP_TITLE_ITEM in $creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:JOB_TITLES/ns2:TITLE_ITEM
	                	return
		                	<mLR.FIG.PUBL>
		                		<LRFIGPUBL>
		                		{
		                			let $ISPEP := fn:string(data($PEP_TITLE_ITEM/ns2:POLITICAL_FIGURE))
		                			return
			                		if ($ISPEP = "YES") then (
			                			"SI"
			                		) else (
			                			"NO"
			                		)
		                		}
		                		</LRFIGPUBL>
		                		<LRNOMBTITULAR>{ data($PEP_TITLE_ITEM/ns2:HOLDER_NAME) }</LRNOMBTITULAR>
		                		<LRPEPCARGO>{ data($PEP_TITLE_ITEM/ns2:JOB_TITLE) }</LRPEPCARGO>
		                		<LRPEPPERIODO>{ data($PEP_TITLE_ITEM/ns2:PERIOD) }</LRPEPPERIODO>
		                	</mLR.FIG.PUBL>
	                }
                </gLR.FIG.PUBL> 
                <gLR.TIENE.FAM>
	                {
	                	for $PEP_FAMILIAR_iITEM in $creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:FAMILIAR_PUBLIC_FIGURE/ns2:FAMILIAR_ITEM
	                	return
		                	<mLR.TIENE.FAM>
		                		<LRTIENEFAM>
		                		{
		                			let $PEP_FAMILIAR_FIGURE := fn:string(data($PEP_FAMILIAR_iITEM/ns2:POLITICAL_FIGURE))
		                			return
			                		if ($PEP_FAMILIAR_FIGURE = "YES") then (
			                			"SI"
			                		) else (
			                			"NO"
			                		)
		                		}
		                		</LRTIENEFAM>           		
		                		<LRTIPARFAM>
		                			{ 
		                				let $PEP_FAM_REL_TYPE := fn:string(data($PEP_FAMILIAR_iITEM/ns2:RELATION_TYPE/text()))
		                				return
		                				if  ($PEP_FAM_REL_TYPE="AFFINITY") then ( 
		                					"AFINIDAD"
		                				)
		                				else if ($PEP_FAM_REL_TYPE="CONSANGUINITY") then (
		                					"CONSANGUINIDAD"
		                			    )
		                			    else (
		                			    	""
		                				)		                				
		                			}
		                		</LRTIPARFAM>
		                		<LRDETALLE>{ data($PEP_FAMILIAR_iITEM/ns2:RELATIONSHIP_DETAIL) }</LRDETALLE>
		                		<LRNOMFAMI>{ data($PEP_FAMILIAR_iITEM/ns2:FULL_NAME) }</LRNOMFAMI>
		                		<LRCARGFAMI>{ data($PEP_FAMILIAR_iITEM/ns2:JOB_TITLE) }</LRCARGFAMI>
		                		<LRPERFAMI>{ data($PEP_FAMILIAR_iITEM/ns2:PERIOD) }</LRPERFAMI>
		                	</mLR.TIENE.FAM>
	                }
                </gLR.TIENE.FAM>            
		        <gLR.HIJ.NOMB>
		        {
		        	for $PEP_FAMILY_DET_CHILDREN in $creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:FAMILY_MEMBERS_INFO/ns2:MEMBER_ITEM[ns2:RELATIONSHIP_TYPE = "CHILDREN"]
		             return
		               	<mLR.HIJ.NOMB>
			                  <LRHIJNOMB>{data($PEP_FAMILY_DET_CHILDREN/ns2:FULL_NAME)}</LRHIJNOMB>
			                  <LRHIJED></LRHIJED>
			                  <LRHIJIDEN>{data($PEP_FAMILY_DET_CHILDREN/ns2:LEGAL_ID)}</LRHIJIDEN>
			                  <LRHIJDIR></LRHIJDIR>
		               	</mLR.HIJ.NOMB>
		        }
		        </gLR.HIJ.NOMB>		 	                                                                                         
		        <gLR.NOM.PA>
		        {
		        	for $PEP_FAMILY_DET_FATHER in $creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:FAMILY_MEMBERS_INFO/ns2:MEMBER_ITEM[ns2:RELATIONSHIP_TYPE = "FATHER"]
		             return
		               	<mLR.NOM.PA>
			                  <LRNOMPA>{data($PEP_FAMILY_DET_FATHER/ns2:FULL_NAME)}</LRNOMPA>
			                  <LRIDENPA>{data($PEP_FAMILY_DET_FATHER/ns2:LEGAL_ID)}</LRIDENPA>
			                  <LREDADPA></LREDADPA>
			                  <LRDIRPA></LRDIRPA>
		               	</mLR.NOM.PA>
		        }
		        </gLR.NOM.PA>
		        <gLR.NOM.MA>
		        {
		        	for $PEP_FAMILY_DET_MOTHER in $creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:FAMILY_MEMBERS_INFO/ns2:MEMBER_ITEM[ns2:RELATIONSHIP_TYPE = "MOTHER"]
		             return
		               	<mLR.NOM.MA>
			                  <LRNOMMA>{data($PEP_FAMILY_DET_MOTHER/ns2:FULL_NAME)}</LRNOMMA>
			                  <LRIDENMA>{data($PEP_FAMILY_DET_MOTHER/ns2:LEGAL_ID)}</LRIDENMA>
			                  <LREDADMA></LREDADMA>
			                  <LRDIRMA></LRDIRMA>
		               	</mLR.NOM.MA>
		        }
		        </gLR.NOM.MA>
		        <gLR.NOM.CON>
		        {
		        	for $PEP_FAMILY_DET_SPOUSE in $creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:FAMILY_MEMBERS_INFO/ns2:MEMBER_ITEM[ns2:RELATIONSHIP_TYPE = "SPOUSE"]
		             return
		               	<mLR.NOM.CON>
			                  <LRNOMCON>{data($PEP_FAMILY_DET_SPOUSE/ns2:FULL_NAME)}</LRNOMCON>
			                  <LRIDENCON>{data($PEP_FAMILY_DET_SPOUSE/ns2:LEGAL_ID)}</LRIDENCON>
			                  <LREDADCON></LREDADCON>
			                  <LRDIRCON></LRDIRCON>
		               	</mLR.NOM.CON>
		        }
		        </gLR.NOM.CON>
                <NOMBREAUTH>{ fn:string(data($creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:AUTHORIZATION_INFO/ns2:AUTHORISER_NAME/text())) }</NOMBREAUTH>
                <CARGOAUTH>{ fn:string(data($creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:AUTHORIZATION_INFO/ns2:AUTHORISER_JOB_TITLE/text())) }</CARGOAUTH>
                <FECHAAUTH>{ fn:string(data($creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:AUTHORIZATION_INFO/ns2:AUTHORIZATION_DATE/text())) }</FECHAAUTH>		        
		        <LRCUSPEPAC>
			        {
			        	let $PEP_CUST_ACCEPTANCE :=  data($creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:PEP_CUSTOMER_ACCEPTANCE/text())
			        	return
			        	if ($PEP_CUST_ACCEPTANCE="YES") then (
			        		"SI"
			        	) else if ($PEP_CUST_ACCEPTANCE="NO") then (
			        		"NO"
			        	) else (
			        		""
			        	)
			        }
		        </LRCUSPEPAC>
                <gLR.MON.VTA.FS>
                	{
                        for $FISCAL_YEAR_ITEM in $creacionClienteNaturalBanco1/ns2:FINANCIAL_INFO/ns2:FISCAL_YEAR_INFO/ns2:FISCAL_ITEM
                        return
                            <mLR.MON.VTA.FS>
                                <LRMONVTAFS>{ data($FISCAL_YEAR_ITEM/ns2:LOCAL_AMOUNT) }</LRMONVTAFS>
                                <LRANIOVTAFS>{ data($FISCAL_YEAR_ITEM/ns2:YEAR) }</LRANIOVTAFS>
                                <LREQUSDFV>{ data($FISCAL_YEAR_ITEM/ns2:FCY_AMOUNT) }</LREQUSDFV>
                            </mLR.MON.VTA.FS>                		
                	}
                </gLR.MON.VTA.FS>
                <LRAPNFDPROF>{ data($creacionClienteNaturalBanco1/ns2:DNFBP_INFO/ns2:DNFBP_PROFESSION/text) }</LRAPNFDPROF>
                <LRSTATECNTR>
                	{ 
                		let $GOVMNT_CONTRACTOR := fn:string($creacionClienteNaturalBanco1/ns2:BASIC_INFO/ns2:GOVERMENT_CONTRACTOR/text()) 
                		return
                		if ($GOVMNT_CONTRACTOR = "YES") then (
                			"SI"
                		)
                		else if ($GOVMNT_CONTRACTOR = "NO")  then (
                			"NO"
                		)
                		else if ($GOVMNT_CONTRACTOR = "INPROCESS")  then (
                			"EN PROCESO"
                		)
                		else (
                			"NO"
                		)               		
                	}
                </LRSTATECNTR>
                <LRCUSRELPRO>
                	{
                		let $IS_PEP_CUS_RELBYPROD := fn:string(data($creacionClienteNaturalBanco1/ns2:PEP_INFO/ns2:PEP_RELATED_PRODUCT/text()))
                		return
                		if ($IS_PEP_CUS_RELBYPROD = "YES") then 
                			"Si"
                		else
                			"No"
                	}
                </LRCUSRELPRO>
            </CUSTOMERNONLEGALINPUTWSType>
        </ns1:CreacionClienteNatural>
};

declare variable $creacionClienteNaturalBanco1 as element(ns2:creacionClienteNaturalBanco) external;
declare variable $uuid as xs:string external;
declare variable $accountOfficer as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:creacionClienteNaturalBancoIn($creacionClienteNaturalBanco1,
	$uuid,
    $accountOfficer,
    $username,
    $password)