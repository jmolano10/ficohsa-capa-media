(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse" element="ns0:ConsultadeclienteResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteOut/";

declare function type-of-person 
  ( $sector as xs:string )  as xs:string {
  if (fn:string($sector) = "1000" or fn:string($sector) = "1001") then (
  	"N"
  ) else (
  	"J"
  )
};

declare function xf:consultaClienteOut($consultadeclienteResponse as element(ns0:ConsultadeclienteResponse))
    as element(ns1:consultaClienteResponse) {
    	if ($consultadeclienteResponse/Status/successIndicator = "Success" and 
    		fn:empty($consultadeclienteResponse/WSCUSTOMERType[1]/ZERORECORDS)) then (
	        <ns1:consultaClienteResponse>
	            {
	                for $CUSTOMER in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMER
	                return
	                    <ns1:CUSTOMER_ID>{ data($CUSTOMER) }</ns1:CUSTOMER_ID>
	            }
	            {
	                for $MNEMONIC in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/MNEMONIC
	                return
	                    <ns1:MNEMONIC>{ data($MNEMONIC) }</ns1:MNEMONIC>
	            }
	            <ns1:IDENTIFICATION_INFO>
	                <ns1:LEGAL_IDENTIFICATION_ITEM>
	                    <ns1:LEGAL_DOCUMENT_NAME>{ $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALDOCNAME/@* , $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALDOCNAME/node() }</ns1:LEGAL_DOCUMENT_NAME>
	                    <ns1:LEGAL_ID>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALID) }</ns1:LEGAL_ID>
	                </ns1:LEGAL_IDENTIFICATION_ITEM>
	            </ns1:IDENTIFICATION_INFO>
	            {
	                for $GIVENNAMES in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GIVENNAMES
	                return
	                    <ns1:GIVEN_NAMES>{ data($GIVENNAMES) }</ns1:GIVEN_NAMES>
	            }
	            {
	                for $FAMILYNAMES in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/FAMILYNAMES
	                return
	                    <ns1:FAMILY_NAME>{ data($FAMILYNAMES) }</ns1:FAMILY_NAME>
	            }
	            {
	                for $NAMEOFBUSINESS in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NAMEOFBUSINESS
	                return
	                    <ns1:NAME_OF_BUSINESS>{ data($NAMEOFBUSINESS) }</ns1:NAME_OF_BUSINESS>
	            }
	            {
	                for $COMMERCIALNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COMMERCIALNAME
	                return
	                    <ns1:COMMERCIAL_NAME>{ data($COMMERCIALNAME) }</ns1:COMMERCIAL_NAME>
	            }
	            {
	                for $LEGALHOLDERNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALHOLDERNAME
	                return
	                    <ns1:LEGAL_HOLDER_NAME>{ data($LEGALHOLDERNAME) }</ns1:LEGAL_HOLDER_NAME>
	            }
	            {
	                for $SHORTNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SHORTNAME
	                return
	                    <ns1:SHORT_NAME>{ data($SHORTNAME) }</ns1:SHORT_NAME>
	            }
	            {
	                for $DATEOFBIRTH in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DATEOFBIRTH
	                return
	                    <ns1:DATE_OF_BIRTH>{ data($DATEOFBIRTH) }</ns1:DATE_OF_BIRTH>
	            }
	            {
	                for $GENDER in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER
	                return
	                    <ns1:GENDER>{ data($GENDER) }</ns1:GENDER>
	            }
	            {
	                for $NATIONALITY in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NATIONALITY
	                return
	                    <ns1:NATIONALITY>{ data($NATIONALITY) }</ns1:NATIONALITY>
	            }
	            {
	                for $RESIDENCE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/RESIDENCE
	                return
	                    <ns1:RESIDENCE>{ data($RESIDENCE) }</ns1:RESIDENCE>
	            }
	            {
	                for $SECTOR in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTOR
	                return
	                    <ns1:SECTOR>{ data($SECTOR) }</ns1:SECTOR>
	            }
	            {
	                for $SECTORNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORNAME
	                return
	                    <ns1:SECTOR_DESCRIPTION>{ data($SECTORNAME) }</ns1:SECTOR_DESCRIPTION>
	            }
	            {
	                for $INDUSTRY in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/INDUSTRY
	                return
	                    <ns1:INDUSTRY>{ data($INDUSTRY) }</ns1:INDUSTRY>
	            }
	            {
	                for $INDUSTRYNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/INDUSTRYNAME
	                return
	                    <ns1:INDUSTRY_DESCRIPTION>{ data($INDUSTRYNAME) }</ns1:INDUSTRY_DESCRIPTION>
	            }
	            {
	                for $GENERATORTYPE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENERATORTYPE
	                return
	                    <ns1:FGN_CCY_GEN_TYP>{ data($GENERATORTYPE) }</ns1:FGN_CCY_GEN_TYP>
	            }
	            {
	                for $TARGET in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TARGET
	                return
	                    <ns1:TARGET>{ data($TARGET) }</ns1:TARGET>
	            }
	            {
	                for $TARGETNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TARGETNAME
	                return
	                    <ns1:TARGET_DESCRIPTION>{ data($TARGETNAME) }</ns1:TARGET_DESCRIPTION>
	            }
	            {
	                for $MARITALSTATUS in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/MARITALSTATUS
	                return
	                    <ns1:MARITAL_STATUS>{ data($MARITALSTATUS) }</ns1:MARITAL_STATUS>
	            }
	            {
	                for $CUSTOMERTYPE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMERTYPE
	                return
	                    <ns1:CUSTOMER_TYPE>{ data($CUSTOMERTYPE) }</ns1:CUSTOMER_TYPE>
	            }
	            {
	                for $CUSTOMERSTATUS in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMERSTATUS
	                return
	                    <ns1:CUSTOMER_STATUS>{ data($CUSTOMERSTATUS) }</ns1:CUSTOMER_STATUS>
	            }
	            {
	                for $LANGUAGE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LANGUAGE
	                return
	                    <ns1:LANGUAGE>{ data($LANGUAGE) }</ns1:LANGUAGE>
	            }
	            {
	                for $OCCUPATION in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/OCCUPATION
	                return
	                    <ns1:OCCUPATION>{ data($OCCUPATION) }</ns1:OCCUPATION>
	            }
	            {
	                for $EMPLOYMENTSTATUS in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMPLOYMENTSTATUS
	                return
	                    <ns1:EMPLOYMENT_STATUS>{ data($EMPLOYMENTSTATUS) }</ns1:EMPLOYMENT_STATUS>
	            }
	            {
	                for $EMPLOYERSNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMPLOYERSNAME
	                return
	                    <ns1:EMPLOYERS_NAME>{ data($EMPLOYERSNAME) }</ns1:EMPLOYERS_NAME>
	            }
	            {
	                for $MARRIEDLASTNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/MARRIEDLASTNAME
	                return
	                    <ns1:MARRIED_LAST_NAME>{ data($MARRIEDLASTNAME) }</ns1:MARRIED_LAST_NAME>
	            }
	            {
	                for $LEGALREPNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALREPNAME
	                return
	                    <ns1:LEGAL_REP_NAME>{ data($LEGALREPNAME) }</ns1:LEGAL_REP_NAME>
	            }
	            {
	                for $LEGALREPID in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALREPID
	                return
	                    <ns1:LEGAL_REP_ID>{ data($LEGALREPID) }</ns1:LEGAL_REP_ID>
	            }
	            {
	                for $TYPEOFCOMPANY in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TYPEOFCOMPANY
	                return
	                    <ns1:TYPE_OF_COMPANY>{ data($TYPEOFCOMPANY) }</ns1:TYPE_OF_COMPANY>
	            }
	            {
	                for $PROFESSIONORTRADE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE
	                return
	                    <ns1:PROFESSION>{ data($PROFESSIONORTRADE) }</ns1:PROFESSION>
	            }
	            {
	                for $NUMBEROFDEED in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NUMBEROFDEED
	                return
	                    <ns1:NUMBER_OF_DEED>{ data($NUMBEROFDEED) }</ns1:NUMBER_OF_DEED>
	            }
	            {
	                for $LEGALREPHOMEPHONE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALREPHOMEPHONE
	                return
	                    <ns1:LEGAL_REP_HOME_PHONE>{ data($LEGALREPHOMEPHONE) }</ns1:LEGAL_REP_HOME_PHONE>
	            }
	            {
	                for $SECTOR in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTOR
	                return
	                    <ns1:TYPE_OF_PERSON>{ type-of-person($SECTOR) }</ns1:TYPE_OF_PERSON>
	            }
	            {
	                for $INPUTTER in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/INPUTTER
	                return
	                    <ns1:INPUT_USER>{ data($INPUTTER) }</ns1:INPUT_USER>
	            }
	            {
	                for $DATETIME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DATETIME
	                return
	                    <ns1:DATE_TIME>{ concat(concat("20", data($DATETIME)), "00") }</ns1:DATE_TIME>
	            }
	            {
	                for $ACCOUNTOFFICER in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ACCOUNTOFFICER
	                return
	                    <ns1:ACCOUNT_OFFICER>{ data($ACCOUNTOFFICER) }</ns1:ACCOUNT_OFFICER>
	            }
	            {
	                for $BRANCHCODE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/BRANCHCODE
	                return
	                    <ns1:BRANCH_CODE>{ data($BRANCHCODE) }</ns1:BRANCH_CODE>
	            }
	            {
	                for $NOOFDEPENDENTS in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NOOFDEPENDENTS
	                return
	                    <ns1:NO_OF_DEPENDENTS>{ data($NOOFDEPENDENTS) }</ns1:NO_OF_DEPENDENTS>
	            }
	            {
	                for $EDUCATIONLEVEL in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EDUCATIONLEVEL
	                return
	                    <ns1:EDUCATION_LEVEL>{ data($EDUCATIONLEVEL) }</ns1:EDUCATION_LEVEL>
	            }
	            {
	                for $SPOUSENAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SPOUSENAME
	                return
	                    <ns1:SPOUSE_NAME>{ data($SPOUSENAME) }</ns1:SPOUSE_NAME>
	            }
	            {
	                for $CUSTOMERSINCE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CUSTOMERSINCE
	                return
	                    <ns1:CUSTOMER_SINCE>{ data($CUSTOMERSINCE) }</ns1:CUSTOMER_SINCE>
	            }
	            {
	                for $ECONOMICGROUPID in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ECONOMICGROUPID
	                return
	                    <ns1:ECONOMIC_GROUP_ID>{ data($ECONOMICGROUPID) }</ns1:ECONOMIC_GROUP_ID>
	            }
	            {
	                for $ECONOMICGROUPNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ECONOMICGROUPNAME
	                return
	                    <ns1:ECONOMIC_GROUP_NAME>{ data($ECONOMICGROUPNAME) }</ns1:ECONOMIC_GROUP_NAME>
	            }
	            <ns1:PHONE_INFO>
	            {
	            	let $PHONE_NUMBER := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PHONE/text(), "\|\|")
	            	let $PHONE_EXTENSION := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EXTENSION, "!!")
	            	let $PHONE_REFERRENCE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TELEPHONEREFER, "!!")
	            	for $PHONE_NUMBERR at $i in $PHONE_NUMBER
	            	return
	            		if($PHONE_NUMBER != "") then (
			                <ns1:PHONE_NUMBER_ITEM>
			                    <ns1:PHONE_TYPE>PHONE</ns1:PHONE_TYPE>
			                    <ns1:PHONE_NUMBER>{ $PHONE_NUMBERR }</ns1:PHONE_NUMBER>
			                    <ns1:PHONE_ORDER>{ $i }</ns1:PHONE_ORDER>
			                    <ns1:PHONE_EXTENSION>{ $PHONE_EXTENSION[$i] }</ns1:PHONE_EXTENSION>
			                    <ns1:PHONE_REFERRENCE>{ $PHONE_REFERRENCE[$i] }</ns1:PHONE_REFERRENCE>
			                </ns1:PHONE_NUMBER_ITEM>
	                	) else ()
	            }
	            {
	            	let $MOBILE_NUMBER := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SMS/text(), "\|\|")
	            	let $PHONE_EXTENSION := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EXTENSION, "!!")
	            	let $PHONE_REFERRENCE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TELEPHONEREFER, "!!")
	            	for $MOBILE_NUMBERR at $i in $MOBILE_NUMBER
	            	return
	            		if($MOBILE_NUMBER != "") then (
			                <ns1:PHONE_NUMBER_ITEM>
			                    <ns1:PHONE_TYPE>SMS</ns1:PHONE_TYPE>
			                    <ns1:PHONE_NUMBER>{ $MOBILE_NUMBERR }</ns1:PHONE_NUMBER>
			                    <ns1:PHONE_ORDER>{ $i }</ns1:PHONE_ORDER>
			                    <ns1:PHONE_EXTENSION>{ $PHONE_EXTENSION[$i] }</ns1:PHONE_EXTENSION>
			                    <ns1:PHONE_REFERRENCE>{ $PHONE_REFERRENCE[$i] }</ns1:PHONE_REFERRENCE>
			                </ns1:PHONE_NUMBER_ITEM>
	                	) else ()
	            }
	            </ns1:PHONE_INFO>
	            <ns1:ADDRESS_INFO>
	            {
	            	let $ADDRESS_TYPES := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSTYPE, "!!")
	            	let $MAIN_ADDRESS_YES_NO := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/MAINADDRESSYN, "!!")
	            	let $ADDRESS_LINE_1 := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE1, "!!")
	            	let $ADDRESS_LINE_2 := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE2, "!!")
	            	let $COUNTRY_CODE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COUNTRYCODE, "!!")
	            	let $STATE_CODE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/STATECODE, "!!")
	            	let $CITY_CODE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CITYCODE, "!!")
	            	let $COLONY_CODE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COLONYCODE, "!!")
	            	let $COLONY_CODE_DESC := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESCOLONYCODEDES, "!!")
	            	let $AVENUE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/AVENUE, "!!")
	            	let $ADDRESS_STREET := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDSTREET, "!!")
	            	let $BLOCK := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/BLOCK, "!!")
	            	let $HOUSE_NUMBER := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/HOUSENUMBER, "!!")
	            	let $ADDRESS_REFERENCES:= fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/REFERENCES, "!!")
					let $DEPARTMENT_CODE_DESC := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/STATECODEDES, "!!")
					let $CITY_CODE_DESC := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CITYCODEDES, "!!")
	            	
	            	for $ADDRESS_TYPE at $i in $ADDRESS_TYPES
		            return
		            	if ($ADDRESS_TYPE != "") then (
			            	<ns1:ADDRESS_ITEM>
			            		<ns1:ADDRESS_TYPE>{ $ADDRESS_TYPE }</ns1:ADDRESS_TYPE>
			                	<ns1:COUNTRY_CODE>{ $COUNTRY_CODE[$i] }</ns1:COUNTRY_CODE>
			                	<ns1:DEPARTMENT_CODE>{ $STATE_CODE[$i] }</ns1:DEPARTMENT_CODE>
			                	<ns1:CITY_CODE>{ $CITY_CODE[$i] }</ns1:CITY_CODE>
			                	<ns1:ADDRESS_LINE_1>{ $ADDRESS_LINE_1[$i] }</ns1:ADDRESS_LINE_1>
			                	<ns1:ADDRESS_LINE_2>{ $ADDRESS_LINE_2[$i] }</ns1:ADDRESS_LINE_2>
			                	<ns1:IS_MAIN_ADDRESS>{ $MAIN_ADDRESS_YES_NO[$i] }</ns1:IS_MAIN_ADDRESS>
			                	<ns1:COLONY_CODE>{ $COLONY_CODE[$i] }</ns1:COLONY_CODE>
			                	<ns1:COLONY_CODE_DESC>{ $COLONY_CODE_DESC[$i] }</ns1:COLONY_CODE_DESC>
			                	<ns1:AVENUE>{ $AVENUE[$i] }</ns1:AVENUE>
			                	<ns1:ADDRESS_STREET>{ $ADDRESS_STREET[$i] }</ns1:ADDRESS_STREET>
			                	<ns1:BLOCK>{ $BLOCK[$i] }</ns1:BLOCK>
			                	<ns1:HOUSE_NUMBER>{ $HOUSE_NUMBER[$i] }</ns1:HOUSE_NUMBER>
			                	<ns1:ADDRESS_REFERENCES>{ $ADDRESS_REFERENCES[$i] }</ns1:ADDRESS_REFERENCES>
								<ns1:DEPARTMENT_CODE_DESC>{ $DEPARTMENT_CODE_DESC[$i] }</ns1:DEPARTMENT_CODE_DESC>
								<ns1:CITY_CODE_DESC>{ $CITY_CODE_DESC[$i] }</ns1:CITY_CODE_DESC>
			                </ns1:ADDRESS_ITEM>
		                ) else ()
			    }
	            </ns1:ADDRESS_INFO>
	            <ns1:EMAIL_INFO>
	            {
	            	let $EMAIL_ADDRES := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMAIL/text(),"\|\|")
	            	let $IS_MAIN_EMAIL := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRMAINADELEC, "!!")
	            	for $EMAIL_ADDRESS at $i in $EMAIL_ADDRES
	            	return
	                <ns1:EMAIL_ITEM>
	                    <ns1:EMAIL_ADDRESS>{ $EMAIL_ADDRESS }</ns1:EMAIL_ADDRESS>
	                    <ns1:IS_MAIN_EMAIL>{ $IS_MAIN_EMAIL[$i] }</ns1:IS_MAIN_EMAIL>
	                </ns1:EMAIL_ITEM>
	            }
	            </ns1:EMAIL_INFO>
	            <ns1:JOB_INFO>
	                <ns1:JOB_ITEM>
	                	<ns1:JOB_CODE>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/JOBTITLE) }</ns1:JOB_CODE>
	                    <ns1:JOB_DESCRIPTION>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/JOBDESCRIPTION) }</ns1:JOB_DESCRIPTION>
	                    <ns1:SALARY_AMOUNT>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/INCOMERANGE) }</ns1:SALARY_AMOUNT>
	                    <ns1:START_DATE>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMPLOYMENTSTART) }</ns1:START_DATE>
	                </ns1:JOB_ITEM>
	            </ns1:JOB_INFO>
	            <ns1:SECTORIZATION_INFO>
	                {
	                    let $TYPE  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORIZATIONTYPE, "!!"))  
	                    let $CODE  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORIZATIONCODE, "!!"))
	                    let $DESC  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESSECTORIZCODEDES, "!!"))   
	                    for $i  in (1 to max((count($TYPE), count($CODE))))  
	                    return
	                        if (($TYPE != "" or $CODE != "" or $DESC != "")) then
	                            (<ns1:SECTORIZATION_ITEM>
		                            <ns1:SECTORIZATION_TYPE>{ $TYPE[$i] }</ns1:SECTORIZATION_TYPE>
		                            <ns1:SECTORIZATION_CODE>{ $CODE[$i] }</ns1:SECTORIZATION_CODE>
		                            <ns1:SECTORIZATION_DESC>{ $DESC[$i] }</ns1:SECTORIZATION_DESC>
	                            </ns1:SECTORIZATION_ITEM>)
	                        else 
	                            ()
	                }
				</ns1:SECTORIZATION_INFO>
				
				{
	                for $CONSTITUTION_DATE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CONSTITUTIONDATE
	                return
	                    <ns1:CONSTITUTION_DATE>{ data($CONSTITUTION_DATE) }</ns1:CONSTITUTION_DATE>
	            }
				
				 <ns1:OPERATION_COUNTRY_INFO>
	                {
	                    let $OPERATION_COUNTRY  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/OPERATIONCOUNTRY, "!!")) 
	                    for $i  in (1 to max((count($OPERATION_COUNTRY))))
	                    return
                            <ns1:OPERATION_COUNTRY_ITEM>
	                            <ns1:OPERATION_COUNTRY>{ $OPERATION_COUNTRY[$i] }</ns1:OPERATION_COUNTRY>
                            </ns1:OPERATION_COUNTRY_ITEM>
	                }
				</ns1:OPERATION_COUNTRY_INFO>
				
				{
	                for $IS_LOCAL_OPERATION in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ISLOCALOPERATION
	                return
	                    <ns1:IS_LOCAL_OPERATION>{ data($IS_LOCAL_OPERATION) }</ns1:IS_LOCAL_OPERATION>
	            }
	            
	             <ns1:OPERATION_DEPARTMENTS_INFO>
	                {
	                    let $OPERATION_DEPARTMENT  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/OPERATIONDEPARTMENTSINFO, "!!")) 
	                    for $i  in (1 to max((count($OPERATION_DEPARTMENT))))
	                    return
                            <ns1:OPERATION_DEPARTMENTS_ITEM>
	                            <ns1:OPERATION_DEPARTMENT>{ $OPERATION_DEPARTMENT[$i] }</ns1:OPERATION_DEPARTMENT>
                            </ns1:OPERATION_DEPARTMENTS_ITEM>
	                }
				</ns1:OPERATION_DEPARTMENTS_INFO>
	            
	            {
	                for $RESOURCE_ORIGIN in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/RESOURCEORIGIN
	                return
	                    <ns1:RESOURCE_ORIGIN>{ data($RESOURCE_ORIGIN) }</ns1:RESOURCE_ORIGIN>
	            }
	            
	            {
	                for $IS_ECONOMIC_GROUP in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ISECONOMICGROUP
	                return
	                    <ns1:IS_ECONOMIC_GROUP>{ data($IS_ECONOMIC_GROUP) }</ns1:IS_ECONOMIC_GROUP>
	            }
	            
	            {
	                for $IS_PUBLIC_CHARGE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ISPUBLICCHARGE
	                return
	                    <ns1:IS_PUBLIC_CHARGE>{ data($IS_PUBLIC_CHARGE) }</ns1:IS_PUBLIC_CHARGE>
	            }
	            
	             <ns1:PUBLIC_CHARGE_DESCRIPTION_INFO>
	                {
	                    let $PUBLIC_CHARGE_DESCRIPTION  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PUBLICCHARGEDESCRIPTION, "!!")) 
	                    for $i  in (1 to max((count($PUBLIC_CHARGE_DESCRIPTION))))
	                    return
                            <ns1:PUBLIC_CHARGE_DESCRIPTION_ITEM>
	                            <ns1:PUBLIC_CHARGE_DESCRIPTION>{ $PUBLIC_CHARGE_DESCRIPTION[$i] }</ns1:PUBLIC_CHARGE_DESCRIPTION>
                            </ns1:PUBLIC_CHARGE_DESCRIPTION_ITEM>
	                }
				</ns1:PUBLIC_CHARGE_DESCRIPTION_INFO>
				
				{
	                for $PUBLIC_CHARGE_INSTITUTION in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PUBLICCHARGEINSTITUTION
	                return
	                    <ns1:PUBLIC_CHARGE_INSTITUTION>{ data($PUBLIC_CHARGE_INSTITUTION) }</ns1:PUBLIC_CHARGE_INSTITUTION>
	            }
	            
	            {
	                for $LEGAL_IDENTIFICATION_EXPIRATION_DATE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALIDENTIFICATIONEXPIRATIONDAT
	                return
	                    <ns1:LEGAL_IDENTIFICATION_EXPIRATION_DATE>{ data($LEGAL_IDENTIFICATION_EXPIRATION_DATE) }</ns1:LEGAL_IDENTIFICATION_EXPIRATION_DATE>
	            }
				
				<ns1:OTHER_NATIONALITIES_INFO>
	                {
	                    let $OTHER_NATIONALITY  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/OTHERNATIONALITIESINFO, "!!")) 
	                    for $i  in (1 to max((count($OTHER_NATIONALITY))))
	                    return
                            <ns1:NATIONALITIES_INFO_ITEM>
	                            <ns1:OTHER_NATIONALITY>{ $OTHER_NATIONALITY[$i] }</ns1:OTHER_NATIONALITY>
                            </ns1:NATIONALITIES_INFO_ITEM>
	                }
				</ns1:OTHER_NATIONALITIES_INFO>
				
				{
	                for $DEPENDENCY_ID in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DEPENDENCYID
	                return
	                    <ns1:DEPENDENCY_ID>{ data($DEPENDENCY_ID) }</ns1:DEPENDENCY_ID>
	            }
	            
	            {
	                for $DEPENDENCY_NAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DEPENDENCYNAME
	                return
	                    <ns1:DEPENDENCY_NAME>{ data($DEPENDENCY_NAME) }</ns1:DEPENDENCY_NAME>
	            }
	            
	            {
	                for $DEPENDENCY_LASTNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DEPENDENCYLASTNAME
	                return
	                    <ns1:DEPENDENCY_LASTNAME>{ data($DEPENDENCY_LASTNAME) }</ns1:DEPENDENCY_LASTNAME>
	            }
				
				{
	                for $TOTAL_INCOME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SUMINGR
	                return
	                    <ns1:TOTAL_INCOME>{ data($TOTAL_INCOME) }</ns1:TOTAL_INCOME>
	            }
	            {
	                for $GIRO_NEGOCIO in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRGIRONEGOCIO
	                return
	                    <ns1:GIRO_NEGOCIO>{ data($GIRO_NEGOCIO) }</ns1:GIRO_NEGOCIO>
	            }
	            {
	                for $ECONOMICGROUP in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ECONOMICGROUPNAME1
	                return
	                    <ns1:ECONOMICGROUP>{ data($ECONOMICGROUP) }</ns1:ECONOMICGROUP>
	            }
				{
	                for $LEGAL_ISSUE_DATE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALISSDATE
	                return
	                    <ns1:LEGAL_ISSUE_DATE>{ data($LEGAL_ISSUE_DATE) }</ns1:LEGAL_ISSUE_DATE>
	            }
				{
	                for $RTN in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRRTN
	                return
	                    <ns1:RTN>{ data($RTN) }</ns1:RTN>
	            }
	            {
	                for $PLACE_OF_BIRTH in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PLACEOFBIRTH
	                return
	                    <ns1:PLACE_OF_BIRTH>{ data($PLACE_OF_BIRTH) }</ns1:PLACE_OF_BIRTH>
	            }
	            {
	                for $PLACE_OF_BIRTH_DESC in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESPLACEOFBIRTH
	                return
	                    <ns1:PLACE_OF_BIRTH_DESC>{ data($PLACE_OF_BIRTH_DESC) }</ns1:PLACE_OF_BIRTH_DESC>
	            }
				{
	                for $TOWN_COUNTRY in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TOWNCOUNTRY
	                return
	                    <ns1:TOWN_COUNTRY>{ data($TOWN_COUNTRY) }</ns1:TOWN_COUNTRY>
	            }
	            {
	                for $COUNTRY in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESTOWNCOUNTRY
	                return
	                    <ns1:COUNTRY>{ data($COUNTRY) }</ns1:COUNTRY>
	            }
	            {
	                for $DNFBP in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRCUSAPNFDS
	                return
	                    <ns1:DNFBP>{ data($DNFBP) }</ns1:DNFBP>
	            }
	            {
	                for $DNFBP_PROFESSION in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRPROFAPNF
	                return
	                    <ns1:DNFBP_PROFESSION>{ data($DNFBP_PROFESSION) }</ns1:DNFBP_PROFESSION>
	            }
	            <ns1:DEPENDENT_INFO>
                {
                    let $NAME  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NAMEDEPENDENT, "!!"))  
                    let $PROFESSION  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONDEP, "!!"))
                    let $PROFESSION_DESC  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESPROFESSIONDEP, "!!")) 
                    let $RELATIONSHIP  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/RELATIONSHIP, "!!"))   
                    let $RELATIONSHIP_DESC  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESRELATIONSHIP, "!!"))     
                    for $i  in (1 to max((count($NAME))))
                    return
                        <ns1:DEPENDENT_INFO_ITEM>
                            <ns1:NAME>{ $NAME[$i] }</ns1:NAME>
                            <ns1:PROFESSION>{ $PROFESSION[$i] }</ns1:PROFESSION>
                            <ns1:PROFESSION_DESC>{ $PROFESSION_DESC[$i] }</ns1:PROFESSION_DESC>
                            <ns1:RELATIONSHIP>{ $RELATIONSHIP[$i] }</ns1:RELATIONSHIP>
                             <ns1:RELATIONSHIP_DESC>{ $RELATIONSHIP_DESC[$i] }</ns1:RELATIONSHIP_DESC>
                        </ns1:DEPENDENT_INFO_ITEM>
                }
				</ns1:DEPENDENT_INFO>
				
				 <ns1:INCOME_CURRENCY>
                {
                    let $INCOME_CCY  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/INCOMECCY, "!!"))  
                    let $INCOME_CCY_DESC  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESINCOMECCYDES, "!!"))
                    for $i  in (1 to max((count($INCOME_CCY))))
                    return
                        <ns1:INCOME_CURRENCY_ITEM>
                            <ns1:INCOME_CCY>{ $INCOME_CCY[$i] }</ns1:INCOME_CCY>
                            <ns1:INCOME_CCY_DESC>{ $INCOME_CCY_DESC[$i] }</ns1:INCOME_CCY_DESC>
                        </ns1:INCOME_CURRENCY_ITEM>
                }
				</ns1:INCOME_CURRENCY>
				
				<ns1:OTHERS_INCOME>
                {
                    let $SOURCES  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRFOTRING, "!!"))  
                    let $AMOUNT  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRFOTRINGM, "!!"))
                    for $i  in (1 to max((count($SOURCES))))
                    return
                        <ns1:OTHERS_INCOME_ITEM>
                            <ns1:SOURCES>{ $SOURCES[$i] }</ns1:SOURCES>
                            <ns1:AMOUNT>{ $AMOUNT[$i] }</ns1:AMOUNT>
                        </ns1:OTHERS_INCOME_ITEM>
                }
				</ns1:OTHERS_INCOME>
				
				 {
	                for $LEGALISED_NAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALISEDNAME
	                return
	                    <ns1:LEGALISED_NAME>{ data($LEGALISED_NAME) }</ns1:LEGALISED_NAME>
	             }
				
				 {
	                for $LEGALISED_NAME_DESC in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESLEGALISEDNAMEDES
	                return
	                    <ns1:LEGALISED_NAME_DESC>{ data($LEGALISED_NAME_DESC) }</ns1:LEGALISED_NAME_DESC>
	             }
				 {
	                for $PROFESION_TRADE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESIONTRADE
	                return
	                    <ns1:PROFESION_TRADE>{ data($PROFESION_TRADE) }</ns1:PROFESION_TRADE>
	             }
	             {
	                for $PROFESION_TRADE_DESC in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESPROFESIONTRADE
	                return
	                    <ns1:PROFESION_TRADE_DESC>{ data($PROFESION_TRADE_DESC) }</ns1:PROFESION_TRADE_DESC>
	             }
				<ns1:REFERENCES_INFO>
                {
                    let $NAMES  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/NAMEPERSREF, "!!"))  
                    let $LAST_NAMES  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SELSTNMPRRF, "!!"))
                    let $RELATIONSHIP  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/RELWTHPERREF, "!!"))
                    let $RELATIONSHIP_DESC  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DESRELWTHPERREFDES, "!!"))
                    let $PHONE  := (fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TELNOPERREF, "!!"))
                    for $i  in (1 to max((count($NAMES))))
                    return
                        <ns1:REFERENCES_INFO_ITEM>
                            <ns1:NAMES>{ $NAMES[$i] }</ns1:NAMES>
                            <ns1:LAST_NAMES>{ $LAST_NAMES[$i] }</ns1:LAST_NAMES>
                            <ns1:RELATIONSHIP>{ $RELATIONSHIP[$i] }</ns1:RELATIONSHIP>
                            <ns1:RELATIONSHIP_DESC>{ $RELATIONSHIP_DESC[$i] }</ns1:RELATIONSHIP_DESC>
                            <ns1:PHONE>{ $PHONE[$i] }</ns1:PHONE>
                        </ns1:REFERENCES_INFO_ITEM>
                }
				</ns1:REFERENCES_INFO>

				{
	                for $MERCHANTTYPE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/TYPEOFMERCHNT
	                return
	                    <ns1:TYPE_MERCHANT>{ data($MERCHANTTYPE) }</ns1:TYPE_MERCHANT>
	            }
	            {
	                for $SMENAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SMENAME
	                return
	                    <ns1:SME_NAME>{ data($SMENAME) }</ns1:SME_NAME>
	            }
	            {
		             for $IS_MERCHANT_COMPANY in 
	                 $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LREMPMER
		             return
		        		<ns1:IS_MERCHANT_COMPANY>{ data($IS_MERCHANT_COMPANY) }</ns1:IS_MERCHANT_COMPANY>
	            }
	            {
	            	for $BELONGS_USA_BOARD in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRJUNTAEU
	                return
	            		<ns1:BELONGS_USA_BOARD>{ data($BELONGS_USA_BOARD) }</ns1:BELONGS_USA_BOARD>
	            }
	            {
	            	for $DESIGNATED_NON_FINANCIAL_PROFESSION in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRAPNFDPROF
	            	return
	            		<ns1:DESIGNATED_NON_FINANCIAL_PROFESSION>{ data($DESIGNATED_NON_FINANCIAL_PROFESSION) }</ns1:DESIGNATED_NON_FINANCIAL_PROFESSION>
	            }
	            {
	            	let $LOCAL_AMOUNT := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRMONVTAFS, "!!")
	            	let $YEAR := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRANIOVTAFS, "!!")
	            	let $FOREIGN_AMOUNT := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LREQUSDFV, "!!")
	            	for $i  in (1 to max((count($LOCAL_AMOUNT))))
	                return
		                <ns1:FISCAL_CLOSING_SALES>
			                <ns1:LOCAL_AMOUNT>{ data($LOCAL_AMOUNT[$i]) }</ns1:LOCAL_AMOUNT>
			                <ns1:YEAR>{ data($YEAR[$i]) }</ns1:YEAR>
			                <ns1:FOREIGN_AMOUNT>{ data($FOREIGN_AMOUNT[$i]) }</ns1:FOREIGN_AMOUNT>
			            </ns1:FISCAL_CLOSING_SALES>
	                	
	            }
	            {
	            	let $HAS_NEW_PRODUCTS := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRNEWPRDACCEPT, "!!")
	            	let $FUNDS_ORIGIN := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRNEWPRDPROCE, "!!")
	            	let $TYPE_OF_INSTRUMENT := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRNEWPRDTIP, "!!")
	            	let $COMMENTARY := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRNEWPRDCOMMENT, "!!")
	            	for $i  in (1 to max((count($FUNDS_ORIGIN))))
	                return
		                <ns1:NEW_PRODUCTS_DETAILS>
				            <ns1:HAS_NEW_PRODUCTS>{ $HAS_NEW_PRODUCTS[$i] }</ns1:HAS_NEW_PRODUCTS>
				            <ns1:FUNDS_ORIGIN>{ $FUNDS_ORIGIN[$i] }</ns1:FUNDS_ORIGIN>
				            <ns1:TYPE_OF_INSTRUMENT>{ $TYPE_OF_INSTRUMENT[$i] }</ns1:TYPE_OF_INSTRUMENT>
				            <ns1:COMMENTARY>{ $COMMENTARY[$i] }</ns1:COMMENTARY>
			           </ns1:NEW_PRODUCTS_DETAILS>
	                	
	            }
	            { 
	                for $IS_RENEWING_PRODUCT in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRRENPRDACCEPT
	                return
	          			<ns1:IS_RENEWING_PRODUCT>{ data($IS_RENEWING_PRODUCT) }</ns1:IS_RENEWING_PRODUCT>
	            }
	            {
	            	let $FUNDS_ORIGIN := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRRENPRDORIGIN, "!!")
	            	let $YEARS_OF_INVESTMENT := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRRENPRDINVYEARS, "!!")
	            	let $INVESTMENT_HISTORY := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRRENPRDINVHISTO, "!!")
	            	let $COMMENTARY := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRRENPRDCOMMENT, "!!")
		        	for $i  in (1 to max((count($FUNDS_ORIGIN))))
		            return
			            <ns1:RENEWAL_DETAILS>
			                <ns1:FUNDS_ORIGIN>{ $FUNDS_ORIGIN[$i] }</ns1:FUNDS_ORIGIN>
			                <ns1:YEARS_OF_INVESTMENT>{ $YEARS_OF_INVESTMENT[$i] }</ns1:YEARS_OF_INVESTMENT>
			                <ns1:INVESTMENT_HISTORY>{ $INVESTMENT_HISTORY[$i] }</ns1:INVESTMENT_HISTORY>
			                <ns1:COMMENTARY>{ $COMMENTARY[$i] }</ns1:COMMENTARY>
			            </ns1:RENEWAL_DETAILS>
	            }
	            {
	            	let $RECEIVED_INHERITANCE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRINHERITANCEACCEPT, "!!")
	            	let $HERITAGE_ORIGIN := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRINHERITANCEORIGIN, "!!")
            		for $i  in (1 to max((count($RECEIVED_INHERITANCE))))
	                return
			            <ns1:INHERITANCE_DETAILS>
			                <ns1:RECEIVED_INHERITANCE>{ $RECEIVED_INHERITANCE[$i] }</ns1:RECEIVED_INHERITANCE>
			                <ns1:HERITAGE_ORIGIN>{ $HERITAGE_ORIGIN[$i] }</ns1:HERITAGE_ORIGIN>
			            </ns1:INHERITANCE_DETAILS>
	            }
	            {
	            	 for $IS_STATE_CONTRACTOR in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRSTATECNTR
	                 return
	           		 	<ns1:IS_STATE_CONTRACTOR>{ data($IS_STATE_CONTRACTOR) }</ns1:IS_STATE_CONTRACTOR>
	          	}
	          	{
	          		let $RECEIVED_INHERITANCE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRINHERITANCEACCEPT, "!!")
	            	let $HERITAGE_ORIGIN := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRINHERITANCEORIGIN, "!!")
	            		for $i  in (1 to max((count($RECEIVED_INHERITANCE))))
		                return
			            <ns1:CONTRACT_DETAILS>
			                <ns1:TYPE>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRCNTRPROTYPE) }</ns1:TYPE>
			                <ns1:NAME>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRCNTRPRONAME) }</ns1:NAME>
			                <ns1:ADDRESS>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRCNTRPROLOCATION) }</ns1:ADDRESS>
			                <ns1:FUNDS_DESTINATION>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRCNTRFUNDS) }</ns1:FUNDS_DESTINATION>
			                <ns1:BENEFICIARIES>
			                    <ns1:BENEFICIARY>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRCNTRPROBENEF) }</ns1:BENEFICIARY>
			                </ns1:BENEFICIARIES>
			            </ns1:CONTRACT_DETAILS>
	            }
	            {
	            	 for $IS_NGO_NPO in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRISNGONFP
	                 return
	            		<ns1:IS_NGO_NPO>{ data($IS_NGO_NPO) }</ns1:IS_NGO_NPO>
	            }
	            {
	            	let $TYPE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRONGTIPDON, "!!")
	            	let $NAME := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRONGDONNAME, "!!")
	            	let $ADDRESS := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRINGDONDOM, "!!")
	            	let $LOCAL_AMOUNT := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRINGDONAMMOUNT, "!!")
	            	let $FREQ_PAYMENTS_RECEIVED := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRINGDONFREQ, "!!")
	            	let $AVERAGE_PAYMENT := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRINFDONPAYAVE, "!!")
	            	for $i  in (1 to max((count($TYPE))))
	                return
		                 <ns1:DONATIONS_DETAILS>
			                <ns1:TYPE>{ $TYPE[$i] }</ns1:TYPE>
			                <ns1:NAME>{ $NAME[$i] }</ns1:NAME>
			                <ns1:ADDRESS>{ $ADDRESS[$i] }</ns1:ADDRESS>
			                <ns1:LOCAL_AMOUNT>{ $LOCAL_AMOUNT[$i] }</ns1:LOCAL_AMOUNT>
			                <ns1:FREQ_PAYMENTS_RECEIVED>{ $FREQ_PAYMENTS_RECEIVED[$i] }</ns1:FREQ_PAYMENTS_RECEIVED>
			                <ns1:AVERAGE_PAYMENT>{ $AVERAGE_PAYMENT }</ns1:AVERAGE_PAYMENT>
			            </ns1:DONATIONS_DETAILS>
	                	
	            }
	            {
	            	let $VOLUME := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRSALESMONTHVOL, "!!")
	            	let $REVENUE := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LROTHERINCOMEMONTHTOTAL, "!!")
	        		for $i  in (1 to max((count($VOLUME))))
	                return
			            <ns1:MONTHLY_SALES>
			                <ns1:VOLUME>{ $VOLUME[$i] }</ns1:VOLUME>
			                <ns1:REVENUE>{ $REVENUE[$i] }</ns1:REVENUE>
			            </ns1:MONTHLY_SALES>
	            }
	            {
	            	let $INCOME := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LROTHRINCMO, "!!")
	            	let $AMOUNT := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LROTHRINCMOAMT, "!!")
	        		for $i  in (1 to max((count($INCOME))))
	                return
                   	<ns1:OTHER_INCOME_DETAILS>
		                <ns1:INCOME>{ $INCOME[$i] }</ns1:INCOME>
		                <ns1:AMOUNT>{ $AMOUNT[$i] }</ns1:AMOUNT>
		            </ns1:OTHER_INCOME_DETAILS>
	                	
	            }
	            {
	            	 for $IS_NGO_NPO in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRPEPRELPR
	                 return
	            	<ns1:IS_PEP_BY_RELATION>{ data($IS_NGO_NPO) }</ns1:IS_PEP_BY_RELATION>
	            }
	            <ns1:PEP_DETAILS>
	            {
	            	let $PRODUCT := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LROTHRINCMO, "!!")
	                for $i  in (1 to max((count($PRODUCT))))
		            return
		                <ns1:RELATIONS>
		                    <ns1:PRODUCT>{ $PRODUCT }</ns1:PRODUCT>
		                </ns1:RELATIONS>
	            }
	                <ns1:TYPE_OF_RELATIONSHIP>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRTIPOPDREL) }</ns1:TYPE_OF_RELATIONSHIP>
	                <ns1:IS_DIRECT>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRPEPDIRECT) }</ns1:IS_DIRECT>
	                <ns1:IS_INDIRECT>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRPEPINDIRLINK) }</ns1:IS_INDIRECT>
	                <ns1:IS_RELATED>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRPEPRELA) }</ns1:IS_RELATED>
	                <ns1:LAST_UPDATE_DATE>{ data($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRPEPUPDU) }</ns1:LAST_UPDATE_DATE>
	            </ns1:PEP_DETAILS>
	            {
	                for $LRCUSCLASSRI in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRCUSCLASSRI
	                return
	                    <ns1:CLIENT_RISK>{ data($LRCUSCLASSRI) }</ns1:CLIENT_RISK>
	            }
	            <ns1:FAXES_INFO>
	            {
	            	let $FAX := fn:tokenize($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/FAX/text(),"\|\|")
	            	for $FAXR at $i in $FAX
	            	return
	                <ns1:FAX_ITEM>
	                    <ns1:FAX_ORDER>{ $i }</ns1:FAX_ORDER>
	                    <ns1:FAX>{ $FAXR }</ns1:FAX>
	                </ns1:FAX_ITEM>
	            }
	            </ns1:FAXES_INFO>
	            {
	                for $RECORDSTATUS in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/RECORDSTATUS
	                return
	                    <ns1:RECORD_STATUS>{ data($RECORDSTATUS) }</ns1:RECORD_STATUS>
	            }
	            {
	                for $COSTUMERTYPE in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LRPROFILETYPE
	                return
	                    <ns1:COSTUMER_TYPE>{ data($COSTUMERTYPE) }</ns1:COSTUMER_TYPE>
	           }
	        </ns1:consultaClienteResponse>
	    ) else 
	    (
	    	<ns1:consultaClienteResponse/>
	    )
};

declare variable $consultadeclienteResponse as element(ns0:ConsultadeclienteResponse) external;

xf:consultaClienteOut($consultadeclienteResponse)