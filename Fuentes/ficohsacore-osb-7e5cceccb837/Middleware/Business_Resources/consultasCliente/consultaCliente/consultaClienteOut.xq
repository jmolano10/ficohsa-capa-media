(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse1" element="ns0:ConsultadeclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteResponse" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaCliente/consultaClienteOut/";

(: Retorna el tipo de persona :)
declare function type-of-person 
  ( $sector as xs:string )  as xs:string {
  if (fn:string($sector) = "1000" or fn:string($sector) = "1001") then (
  	"N"
  ) else (
  	"J"
  )
};

declare function xf:consultaClienteOut($consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse))
    as element(ns1:consultaClienteResponse) {
        <ns1:consultaClienteResponse>
            {
                for $CUSTOMER in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMER
                return
                    <CUSTOMER_ID>{ data($CUSTOMER) }</CUSTOMER_ID>
            }
            {
                for $MNEMONIC in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/MNEMONIC
                return
                    <MNEMONIC>{ data($MNEMONIC) }</MNEMONIC>
            }
            {
                for $LEGALID in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALID
                return
                    <LEGAL_ID>{ data($LEGALID) }</LEGAL_ID>
            }
            {
                for $LEGALDOCNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALDOCNAME
                return
                    <LEGAL_DOC_NAME>{ data($LEGALDOCNAME) }</LEGAL_DOC_NAME>
            }
            {
                for $GIVENNAMES in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GIVENNAMES
                return
                    <GIVEN_NAMES>{ data($GIVENNAMES) }</GIVEN_NAMES>
            }
            {
                for $FAMILYNAMES in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/FAMILYNAMES
                return
                    <FAMILY_NAME>{ data($FAMILYNAMES) }</FAMILY_NAME>
            }
            {
                for $NAMEOFBUSINESS in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NAMEOFBUSINESS
                return
                    <NAME_OF_BUSINESS>{ data($NAMEOFBUSINESS) }</NAME_OF_BUSINESS>
            }
            {
                for $COMMERCIALNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COMMERCIALNAME
                return
                    <COMMERCIAL_NAME>{ data($COMMERCIALNAME) }</COMMERCIAL_NAME>
            }
            {
                for $LEGALHOLDERNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALHOLDERNAME
                return
                    <LEGAL_HOLDER_NAME>{ data($LEGALHOLDERNAME) }</LEGAL_HOLDER_NAME>
            }
            {
                for $SHORTNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SHORTNAME
                return
                    <SHORT_NAME>{ data($SHORTNAME) }</SHORT_NAME>
            }
            {
                for $DATEOFBIRTH in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DATEOFBIRTH
                return
                    <DATE_OF_BIRTH>{ data($DATEOFBIRTH) }</DATE_OF_BIRTH>
            }
            {
                for $GENDER in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER
                return
                    <GENDER>{ data($GENDER) }</GENDER>
            }
            {
                for $NATIONALITY in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NATIONALITY
                return
                    <NATIONALITY>{ data($NATIONALITY) }</NATIONALITY>
            }
            {
                for $RESIDENCE in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/RESIDENCE
                return
                    <RESIDENCE>{ data($RESIDENCE) }</RESIDENCE>
            }
            {
                for $SECTOR in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTOR
                return
                    <SECTOR>{ data($SECTOR) }</SECTOR>
            }
            {
                for $SECTORNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORNAME
                return
                    <SECTOR_DESCRIPTION>{ data($SECTORNAME) }</SECTOR_DESCRIPTION>
            }
            {
                for $INDUSTRY in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/INDUSTRY
                return
                    <INDUSTRY>{ data($INDUSTRY) }</INDUSTRY>
            }
            {
                for $INDUSTRYNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/INDUSTRYNAME
                return
                    <INDUSTRY_DESCRIPTION>{ data($INDUSTRYNAME) }</INDUSTRY_DESCRIPTION>
            }
            {
                for $GENERATORTYPE in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENERATORTYPE
                return
                    <FGN_CCY_GEN_TYP>{ data($GENERATORTYPE) }</FGN_CCY_GEN_TYP>
            }
            {
                for $TARGET in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TARGET
                return
                    <TARGET>{ data($TARGET) }</TARGET>
            }
            {
                for $TARGETNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TARGETNAME
                return
                    <TARGET_DESCRIPTION>{ data($TARGETNAME) }</TARGET_DESCRIPTION>
            }
            {
                for $MARITALSTATUS in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/MARITALSTATUS
                return
                    <MARITAL_STATUS>{ data($MARITALSTATUS) }</MARITAL_STATUS>
            }
            {
                for $CUSTOMERTYPE in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMERTYPE
                return
                    <CUSTOMER_TYPE>{ data($CUSTOMERTYPE) }</CUSTOMER_TYPE>
            }
            {
                for $CUSTOMERSTATUS in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMERSTATUS
                return
                    <CUSTOMER_STATUS>{ data($CUSTOMERSTATUS) }</CUSTOMER_STATUS>
            }
            {
                for $LANGUAGE in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LANGUAGE
                return
                    <LANGUAGE>{ data($LANGUAGE) }</LANGUAGE>
            }
            {
                for $EMAIL in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMAIL
                return
                    <EMAIL>{ data($EMAIL) }</EMAIL>
            }
            {
                for $SMS in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SMS
                return
                    <MOBILE>{ data($SMS) }</MOBILE>
            }
            {
                for $PHONE in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PHONE
                return
                    <PHONE>{ data($PHONE) }</PHONE>
            }
            {
                for $FAX in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/FAX
                return
                    <FAX>{ data($FAX) }</FAX>
            }
            {
                for $OCCUPATION in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/OCCUPATION
                return
                    <OCCUPATION>{ data($OCCUPATION) }</OCCUPATION>
            }
            {
                for $EMPLOYMENTSTATUS in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMPLOYMENTSTATUS
                return
                    <EMPLOYMENT_STATUS>{ data($EMPLOYMENTSTATUS) }</EMPLOYMENT_STATUS>
            }
            {
                for $EMPLOYERSNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMPLOYERSNAME
                return
                    <EMPLOYERS_NAME>{ data($EMPLOYERSNAME) }</EMPLOYERS_NAME>
            }
            {
                for $MARRIEDLASTNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/MARRIEDLASTNAME
                return
                    <MARRIED_LAST_NAME>{ data($MARRIEDLASTNAME) }</MARRIED_LAST_NAME>
            }
            {
                for $LEGALREPNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALREPNAME
                return
                    <LEGAL_REP_NAME>{ data($LEGALREPNAME) }</LEGAL_REP_NAME>
            }
            {
                for $LEGALREPID in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALREPID
                return
                    <LEGAL_REP_ID>{ data($LEGALREPID) }</LEGAL_REP_ID>
            }
            {
                for $TYPEOFCOMPANY in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TYPEOFCOMPANY
                return
                    <TYPE_OF_COMPANY>{ data($TYPEOFCOMPANY) }</TYPE_OF_COMPANY>
            }
            {
                for $PROFESSIONORTRADE in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE
                return
                    <PROFESSION>{ data($PROFESSIONORTRADE) }</PROFESSION>
            }
            {
                for $NUMBEROFDEED in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NUMBEROFDEED
                return
                    <NUMBER_OF_DEED>{ data($NUMBEROFDEED) }</NUMBER_OF_DEED>
            }
            {
                for $LEGALREPHOMEPHONE in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALREPHOMEPHONE
                return
                    <LEGAL_REP_HOME_PHONE>{ data($LEGALREPHOMEPHONE) }</LEGAL_REP_HOME_PHONE>
            }
            {
                for $SECTOR in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTOR
                return
                    <TYPE_OF_PERSON>{ type-of-person(data($SECTOR)) }</TYPE_OF_PERSON>
            }
            {
                for $INPUTTER in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/INPUTTER
                return
                    <INPUT_USER>{ data($INPUTTER) }</INPUT_USER>
            }
            {
                for $DATETIME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DATETIME
                return
                    <DATE_TIME>{ concat(concat("20", data($DATETIME)), "00") }</DATE_TIME>
            }
            {
                for $ACCOUNTOFFICER in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ACCOUNTOFFICER
                return
                    <ACCOUNT_OFFICER>{ data($ACCOUNTOFFICER) }</ACCOUNT_OFFICER>
            }            
            {
                for $BRANCHCODE in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/BRANCHCODE
                return
                    <BRANCH_CODE>{ data($BRANCHCODE) }</BRANCH_CODE>
            }
            {
                for $NOOFDEPENDENTS in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NOOFDEPENDENTS
                return
                    <NO_OF_DEPENDENTS>{ data($NOOFDEPENDENTS) }</NO_OF_DEPENDENTS>
            }
            {
                for $EDUCATIONLEVEL in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EDUCATIONLEVEL
                return
                    <EDUCATION_LEVEL>{ data($EDUCATIONLEVEL) }</EDUCATION_LEVEL>
            }
            {
                for $SPOUSENAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SPOUSENAME
                return
                    <SPOUSE_NAME>{ data($SPOUSENAME) }</SPOUSE_NAME>
            }   
			{
                for $CUSTOMERSINCE in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMERSINCE
                return
                    <CUSTOMER_SINCE>{ data($CUSTOMERSINCE) }</CUSTOMER_SINCE>
            } 
			{
                for $ECONOMICGROUPID in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ECONOMICGROUPID
                return
                    <ECONOMIC_GROUP_ID>{ data($ECONOMICGROUPID) }</ECONOMIC_GROUP_ID>
            }
			{
                for $ECONOMICGROUPNAME in $consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ECONOMICGROUPNAME
                return
                    <ECONOMIC_GROUP_NAME>{ data($ECONOMICGROUPNAME) }</ECONOMIC_GROUP_NAME>
            }
            <ADDRESSES>
            {
            	let $ADDRESS_TYPES := fn:tokenize($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSTYPE, "!!")
            	let $MAIN_ADDRESS_YES_NO := fn:tokenize($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/MAINADDRESSYN, "!!")
            	let $ADDRESS_LINE_1 := fn:tokenize($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE1, "!!")
            	let $ADDRESS_LINE_2 := fn:tokenize($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE2, "!!")
            	let $COUNTRY_CODE := fn:tokenize($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COUNTRYCODE, "!!")
            	let $STATE_CODE := fn:tokenize($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/STATECODE, "!!")
            	let $CITY_CODE := fn:tokenize($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CITYCODE, "!!")
            	
            	for $ADDRESS_TYPE at $i in $ADDRESS_TYPES
	            return
	            	if ($ADDRESS_TYPE != "") then (
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
            <consultaClienteResponseRecordType>
            {
            	let $TYPE := fn:tokenize($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORIZATIONTYPE, "!!")
            	let $CODE := fn:tokenize($consultadeclienteResponse1/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORIZATIONCODE, "!!")
            	for $i in (1 to max((count($TYPE), count($CODE))))
	            return
	            	if ($TYPE != "" or $CODE != "") then (
		            	<consultaClienteResponseRecordArrayType>
		                	<SECTORIZATION_TYPE>{ $TYPE[$i] }</SECTORIZATION_TYPE>
		                	<SECTORIZATION_CODE>{ $CODE[$i] }</SECTORIZATION_CODE>
		                </consultaClienteResponseRecordArrayType>
	                ) else ()
		    }
            </consultaClienteResponseRecordType>
        </ns1:consultaClienteResponse>
};

declare variable $consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse) external;

xf:consultaClienteOut($consultadeclienteResponse1)