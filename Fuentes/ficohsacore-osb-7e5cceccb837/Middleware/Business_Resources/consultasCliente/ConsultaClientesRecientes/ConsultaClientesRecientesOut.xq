(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse1" element="ns0:ConsultadeclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClientesRecientesResponse" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/ConsultaClientesRecientes/ConsultaClientesRecientesOut/";

(: Retorna el tipo de persona :)
declare function type-of-person 
  ( $sector as xs:string )  as xs:string {
  if (fn:string($sector) = "1000" or fn:string($sector) = "1001") then (
  	"N"
  ) else (
  	"J"
  )
};

declare function xf:ConsultaClientesRecientesOut($consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse))
    as element(ns1:consultaClientesRecientesResponse) {
        <ns1:consultaClientesRecientesResponse>
            {
                for $mWSCUSTOMERDetailType in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType
                return
                    <ns1:consultaClientesRecientesResponseType>
                        {
                            for $CUSTOMER in $mWSCUSTOMERDetailType/CUSTOMER
                            return
                                <CUSTOMER_ID>{ data($CUSTOMER) }</CUSTOMER_ID>
                        }
                        {
                            for $MNEMONIC in $mWSCUSTOMERDetailType/MNEMONIC
                            return
                                <MNEMONIC>{ data($MNEMONIC) }</MNEMONIC>
                        }
                        {
                            for $LEGALID in $mWSCUSTOMERDetailType/LEGALID
                            return
                                <LEGAL_ID>{ data($LEGALID) }</LEGAL_ID>
                        }
                        {
                            for $LEGALDOCNAME in $mWSCUSTOMERDetailType/LEGALDOCNAME
                            return
                                <LEGAL_DOC_NAME>{ data($LEGALDOCNAME) }</LEGAL_DOC_NAME>
                        }
                        {
                            for $GIVENNAMES in $mWSCUSTOMERDetailType/GIVENNAMES
                            return
                                <GIVEN_NAMES>{ data($GIVENNAMES) }</GIVEN_NAMES>
                        }
                        {
                            for $FAMILYNAMES in $mWSCUSTOMERDetailType/FAMILYNAMES
                            return
                                <FAMILY_NAMES>{ data($FAMILYNAMES) }</FAMILY_NAMES>
                        }
                        {
                            for $NAMEOFBUSINESS in $mWSCUSTOMERDetailType/NAMEOFBUSINESS
                            return
                                <NAME_OF_BUSINESS>{ data($NAMEOFBUSINESS) }</NAME_OF_BUSINESS>
                        }
                        {
                            for $COMMERCIALNAME in $mWSCUSTOMERDetailType/COMMERCIALNAME
                            return
                                <COMMERCIAL_NAME>{ data($COMMERCIALNAME) }</COMMERCIAL_NAME>
                        }
                        {
                            for $LEGALHOLDERNAME in $mWSCUSTOMERDetailType/LEGALHOLDERNAME
                            return
                                <LEGAL_HOLDER_NAME>{ data($LEGALHOLDERNAME) }</LEGAL_HOLDER_NAME>
                        }
                        {
                            for $SHORTNAME in $mWSCUSTOMERDetailType/SHORTNAME
                            return
                                <SHORT_NAME>{ data($SHORTNAME) }</SHORT_NAME>
                        }
                        {
                            for $DATEOFBIRTH in $mWSCUSTOMERDetailType/DATEOFBIRTH
                            return
                                <DATE_OF_BIRTH>{ data($DATEOFBIRTH) }</DATE_OF_BIRTH>
                        }
                        {
                            for $GENDER in $mWSCUSTOMERDetailType/GENDER
                            return
                                <GENDER>{ data($GENDER) }</GENDER>
                        }
                        {
                            for $NATIONALITY in $mWSCUSTOMERDetailType/NATIONALITY
                            return
                                <NATIONALITY>{ data($NATIONALITY) }</NATIONALITY>
                        }
                        {
                            for $RESIDENCE in $mWSCUSTOMERDetailType/RESIDENCE
                            return
                                <RESIDENCE>{ data($RESIDENCE) }</RESIDENCE>
                        }
                        {
                            for $SECTOR in $mWSCUSTOMERDetailType/SECTOR
                            return
                                <SECTOR>{ data($SECTOR) }</SECTOR>
                        }
                        {
                            for $SECTORNAME in $mWSCUSTOMERDetailType/SECTORNAME
                            return
                                <SECTOR_DESCRIPTION>{ data($SECTORNAME) }</SECTOR_DESCRIPTION>
                        }
                        {
                            for $INDUSTRY in $mWSCUSTOMERDetailType/INDUSTRY
                            return
                                <INDUSTRY>{ data($INDUSTRY) }</INDUSTRY>
                        }
                        {
                            for $INDUSTRYNAME in $mWSCUSTOMERDetailType/INDUSTRYNAME
                            return
                                <INDUSTRY_DESCRIPTION>{ data($INDUSTRYNAME) }</INDUSTRY_DESCRIPTION>
                        }
                        {
                            for $GENERATORTYPE in $mWSCUSTOMERDetailType/GENERATORTYPE
                            return
                                <FGN_CCY_GEN_TYP>{ data($GENERATORTYPE) }</FGN_CCY_GEN_TYP>
                        }
                        {
                            for $TARGET in $mWSCUSTOMERDetailType/TARGET
                            return
                                <TARGET>{ data($TARGET) }</TARGET>
                        }
                        {
                            for $TARGETNAME in $mWSCUSTOMERDetailType/TARGETNAME
                            return
                                <TARGET_DESCRIPTION>{ data($TARGETNAME) }</TARGET_DESCRIPTION>
                        }
                        {
                            for $MARITALSTATUS in $mWSCUSTOMERDetailType/MARITALSTATUS
                            return
                                <MARITAL_STATUS>{ data($MARITALSTATUS) }</MARITAL_STATUS>
                        }
                        {
                            for $CUSTOMERTYPE in $mWSCUSTOMERDetailType/CUSTOMERTYPE
                            return
                                <CUSTOMER_TYPE>{ data($CUSTOMERTYPE) }</CUSTOMER_TYPE>
                        }
                        {
                            for $CUSTOMERSTATUS in $mWSCUSTOMERDetailType/CUSTOMERSTATUS
                            return
                                <CUSTOMER_STATUS>{ data($CUSTOMERSTATUS) }</CUSTOMER_STATUS>
                        }
                        {
                            for $LANGUAGE in $mWSCUSTOMERDetailType/LANGUAGE
                            return
                                <LANGUAGE>{ data($LANGUAGE) }</LANGUAGE>
                        }
                        {
                            for $EMAIL in $mWSCUSTOMERDetailType/EMAIL
                            return
                                <EMAIL>{ data($EMAIL) }</EMAIL>
                        }
                        {
                            for $SMS in $mWSCUSTOMERDetailType/SMS
                            return
                                <MOBILE>{ data($SMS) }</MOBILE>
                        }
                        {
                            for $PHONE in $mWSCUSTOMERDetailType/PHONE
                            return
                                <PHONE>{ data($PHONE) }</PHONE>
                        }
                        {
                            for $FAX in $mWSCUSTOMERDetailType/FAX
                            return
                                <FAX>{ data($FAX) }</FAX>
                        }
                        {
                            for $OCCUPATION in $mWSCUSTOMERDetailType/OCCUPATION
                            return
                                <OCCUPATION>{ data($OCCUPATION) }</OCCUPATION>
                        }
                        {
                            for $EMPLOYMENTSTATUS in $mWSCUSTOMERDetailType/EMPLOYMENTSTATUS
                            return
                                <EMPLOYMENT_STATUS>{ data($EMPLOYMENTSTATUS) }</EMPLOYMENT_STATUS>
                        }
                        {
                            for $EMPLOYERSNAME in $mWSCUSTOMERDetailType/EMPLOYERSNAME
                            return
                                <EMPLOYERS_NAME>{ data($EMPLOYERSNAME) }</EMPLOYERS_NAME>
                        }
                        {
                            for $MARRIEDLASTNAME in $mWSCUSTOMERDetailType/MARRIEDLASTNAME
                            return
                                <MARRIED_LAST_NAME>{ data($MARRIEDLASTNAME) }</MARRIED_LAST_NAME>
                        }
                        {
                            for $LEGALREPNAME in $mWSCUSTOMERDetailType/LEGALREPNAME
                            return
                                <LEGAL_REP_NAME>{ data($LEGALREPNAME) }</LEGAL_REP_NAME>
                        }
                        {
                            for $LEGALREPID in $mWSCUSTOMERDetailType/LEGALREPID
                            return
                                <LEGAL_REP_ID>{ data($LEGALREPID) }</LEGAL_REP_ID>
                        }
                        {
                            for $TYPEOFCOMPANY in $mWSCUSTOMERDetailType/TYPEOFCOMPANY
                            return
                                <TYPE_OF_COMPANY>{ data($TYPEOFCOMPANY) }</TYPE_OF_COMPANY>
                        }
                        {
                            for $PROFESSIONORTRADE in $mWSCUSTOMERDetailType/PROFESSIONORTRADE
                            return
                                <PROFESSION>{ data($PROFESSIONORTRADE) }</PROFESSION>
                        }
                        {
                            for $NUMBEROFDEED in $mWSCUSTOMERDetailType/NUMBEROFDEED
                            return
                                <NUMBER_OF_DEED>{ data($NUMBEROFDEED) }</NUMBER_OF_DEED>
                        }
                        {
                            for $LEGALREPHOMEPHONE in $mWSCUSTOMERDetailType/LEGALREPHOMEPHONE
                            return
                                <LEGAL_REP_HOME_PHONE>{ data($LEGALREPHOMEPHONE) }</LEGAL_REP_HOME_PHONE>
                        }
                        {
                            for $SECTOR in $mWSCUSTOMERDetailType/SECTOR
                            return
                                <TYPE_OF_PERSON>{ type-of-person(data($SECTOR)) }</TYPE_OF_PERSON>
                        }
                        {
                            for $INPUTTER in $mWSCUSTOMERDetailType/INPUTTER
                            return
                                <INPUT_USER>{ data($INPUTTER) }</INPUT_USER>
                        }
                        {
                            for $DATETIME in $mWSCUSTOMERDetailType/DATETIME
                            return
                                <DATE_TIME>{ concat(concat("20", data($DATETIME)), "00") }</DATE_TIME>
                        }
                        {
                            for $ACCOUNTOFFICER in $mWSCUSTOMERDetailType/ACCOUNTOFFICER
                            return
                                <ACCOUNT_OFFICER>{ data($ACCOUNTOFFICER) }</ACCOUNT_OFFICER>
                        }                        
                        {
                            for $BRANCHCODE in $mWSCUSTOMERDetailType/BRANCHCODE
                            return
                                <BRANCH_CODE>{ data($BRANCHCODE) }</BRANCH_CODE>
                        }
			            {
			                for $NOOFDEPENDENTS in $mWSCUSTOMERDetailType/NOOFDEPENDENTS
			                return
			                    <NO_OF_DEPENDENTS>{ data($NOOFDEPENDENTS) }</NO_OF_DEPENDENTS>
			            }
			            {
			                for $EDUCATIONLEVEL in $mWSCUSTOMERDetailType/EDUCATIONLEVEL
			                return
			                    <EDUCATION_LEVEL>{ data($EDUCATIONLEVEL) }</EDUCATION_LEVEL>
			            }
			            {
			                for $SPOUSENAME in $mWSCUSTOMERDetailType/SPOUSENAME
			                return
			                    <SPOUSE_NAME>{ data($SPOUSENAME) }</SPOUSE_NAME>
			            }
			            {
			                for $EMPLOYMENTSTART in $mWSCUSTOMERDetailType/EMPLOYMENTSTART
			                return
			                    <EMPLOYMENTSTART>{ data($EMPLOYMENTSTART) }</EMPLOYMENTSTART>
			            }				             
			            {
			                for $INCOMERANGE in $mWSCUSTOMERDetailType/INCOMERANGE
			                return
			                    <INCOME_RANGE>{ data($INCOMERANGE) }</INCOME_RANGE>
			            }		            		                                   
			            <ADDRESSES>
			            {
			            	let $ADDRESS_TYPES := fn:tokenize($mWSCUSTOMERDetailType/ADDRESSTYPE, "!!")
			            	let $MAIN_ADDRESS_YES_NO := fn:tokenize($mWSCUSTOMERDetailType/MAINADDRESSYN, "!!")
			            	let $ADDRESS_LINE_1 := fn:tokenize($mWSCUSTOMERDetailType/ADDRESSLINE1, "!!")
			            	let $ADDRESS_LINE_2 := fn:tokenize($mWSCUSTOMERDetailType/ADDRESSLINE2, "!!")
			            	let $COUNTRY_CODE := fn:tokenize($mWSCUSTOMERDetailType/COUNTRYCODE, "!!")
			            	let $STATE_CODE := fn:tokenize($mWSCUSTOMERDetailType/STATECODE, "!!")
			            	let $CITY_CODE := fn:tokenize($mWSCUSTOMERDetailType/CITYCODE, "!!")
			            	
			            	for $ADDRESS_TYPE at $i in $ADDRESS_TYPES
				            return
				            	if ( $ADDRESS_TYPE != "" ) then (
					            	<ADDRESS>
					                	<ADDRESS_TYPE>{ $ADDRESS_TYPE }</ADDRESS_TYPE>
					                	<MAIN_ADDRESS_YES_NO>{ $MAIN_ADDRESS_YES_NO[$i] }</MAIN_ADDRESS_YES_NO>
					                	<ADDRESS_LINE_1>{ $ADDRESS_LINE_1[$i] }</ADDRESS_LINE_1>
					                	<ADDRESS_LINE_2>{ $ADDRESS_LINE_2[$i] }</ADDRESS_LINE_2>
					                	<COUNTRY_CODE>{ $COUNTRY_CODE[$i] }</COUNTRY_CODE>
					                	<STATE_CODE>{ $STATE_CODE[$i] }</STATE_CODE>
					                	<CITY_CODE>{ $CITY_CODE[$i] }</CITY_CODE>
					                </ADDRESS>
					            ) else ()
					    }
					    </ADDRESSES>
                        <consultaClientesRecientesResponseDetailType>
			            {
			            	let $TYPE := fn:tokenize($mWSCUSTOMERDetailType/SECTORIZATIONTYPE, "!!")
			            	let $CODE := fn:tokenize($mWSCUSTOMERDetailType/SECTORIZATIONCODE, "!!")
			            	for $i in (1 to max((count($TYPE), count($CODE))))
				            return
				            	if ($TYPE != "" or $CODE != "") then (
					            	<consultaClientesRecientesResponseDetailRecordType>
					                	<SECTORIZATION_TYPE>{ $TYPE[$i] }</SECTORIZATION_TYPE>
					                	<SECTORIZATION_CODE>{ $CODE[$i] }</SECTORIZATION_CODE>
					                </consultaClientesRecientesResponseDetailRecordType>
					            ) else ()
					    }
            			</consultaClientesRecientesResponseDetailType>
                    </ns1:consultaClientesRecientesResponseType>
            }
        </ns1:consultaClientesRecientesResponse>
};

declare variable $consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse) external;

xf:ConsultaClientesRecientesOut($consultadeclienteResponse1)