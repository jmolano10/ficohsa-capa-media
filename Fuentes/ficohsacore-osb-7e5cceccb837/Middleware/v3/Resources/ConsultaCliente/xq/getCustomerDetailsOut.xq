xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$getCustomerDetailsResponse" element="ns0:getCustomerDetailsResponse" location="../../../../v2/BusinessServices/FPC/getCustomerDetails12c/xsd/getCustomerDetailsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns3:consultaClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/getCustomerDetailsOut/";
declare namespace ns2 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns1 = "https://www.ficohsa.com/regional/customer/commonTypes";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "https://www.ficohsa.com/regional/pension";

declare function local:format-date-from-FPC($textdate as xs:string?, $format as xs:string) as xs:string
{
  if(fn:exists($textdate) and fn-bea:trim($textdate) != "") then (
	fn-bea:date-to-string-with-format(
        "yyyyMMddHHmmss",
        fn-bea:date-from-string-with-format($format, $textdate)
        )
        )else("")
};

declare function local:obtenerXMLDocumentos()
    as element(*){
    	<LEGAL_ID_TYPES>
              <LEGAL_ID_TYPE name="CC">1</LEGAL_ID_TYPE>
              <LEGAL_ID_TYPE name="NIT">9</LEGAL_ID_TYPE>
              <LEGAL_ID_TYPE name="PAS">4</LEGAL_ID_TYPE>
              <LEGAL_ID_TYPE name="CAR">2</LEGAL_ID_TYPE>
        </LEGAL_ID_TYPES>
    };

declare function xf:getCustomerDetailsOut($getCustomerDetailsResponse as element(ns0:getCustomerDetailsResponse))
    as element(ns3:consultaClienteResponse) {
    <ns3:consultaClienteResponse>
	            <ns3:IDENTIFICATION_INFO>
				    {
                       for $item in $getCustomerDetailsResponse/IdentificationInfo/LegalIdentificationItem
                       return
	                <ns3:LEGAL_IDENTIFICATION_ITEM>
	                    <ns3:LEGAL_DOCUMENT_NAME>{ string(local:obtenerXMLDocumentos()/LEGAL_ID_TYPE[ @name=upper-case(data($item/LegalDocumentName)) ]/text())}</ns3:LEGAL_DOCUMENT_NAME>
	                    <ns3:LEGAL_ID>{fn:replace(data($item/LegalId), '^(\d{4})(\d{4})(\d{5})$', '$1-$2-$3')}</ns3:LEGAL_ID>
						<ns3:EXPIRATION_DATE>{ local:format-date-from-FPC(fn:string($item/ExpirationDate/text()),"yyyy-MM-ddXXX") }</ns3:EXPIRATION_DATE>
	                </ns3:LEGAL_IDENTIFICATION_ITEM>
					}
	            </ns3:IDENTIFICATION_INFO>
	            <ns3:FULL_NAME>{ data($getCustomerDetailsResponse/FullName) }</ns3:FULL_NAME>
	            <ns3:DATE_OF_BIRTH>{ local:format-date-from-FPC(fn:string($getCustomerDetailsResponse/DateOfBirth/text()),"yyyy-MM-ddXXX") }</ns3:DATE_OF_BIRTH>
	            <ns3:PHONE_INFO>
	            {
                      
	            	let $item := $getCustomerDetailsResponse/PhoneInfo/PhoneNumberItem[1]
	            	return
                            <ns3:PHONE_NUMBER_ITEM> 
                                <ns3:PHONE_LOCATION>{data($item/PhoneLocation)}</ns3:PHONE_LOCATION>
                                <ns3:PHONE_TYPE>{data($item/PhoneType)}</ns3:PHONE_TYPE>
								<ns3:PHONE_AREA_CODE>{ data($item/PhoneAreaCode) }</ns3:PHONE_AREA_CODE>
                                <ns3:PHONE_NUMBER>{data($item/PhoneNumber)}</ns3:PHONE_NUMBER>
                                <ns3:IS_DEFAULT>YES</ns3:IS_DEFAULT>
                            </ns3:PHONE_NUMBER_ITEM>						
	            }
	            </ns3:PHONE_INFO>
	            <ns3:ADDRESS_INFO>
	            {
                   
	            	for $item in $getCustomerDetailsResponse/AddressInfo/AddressItem
		            return
					if(data($item/AddressType) = 'HOME')then (
			               <ns3:ADDRESS_ITEM>
							    <ns3:ADDRESS_CODE>{ data($item/AddressCode) }</ns3:ADDRESS_CODE>
			            		<ns3:ADDRESS_TYPE>{data($item/AddressType) }</ns3:ADDRESS_TYPE>
			            		<ns3:POBOX/>
                                <ns3:ZIPCODE/>			            		
			                	<ns3:COUNTRY_CODE>{data($item/CountryCode) }</ns3:COUNTRY_CODE>
			                	<ns3:DEPARTMENT_CODE>{data($item/DepartmentCode) }</ns3:DEPARTMENT_CODE>
								<ns3:MUNICIPALITY_CODE>{ data($item/MunicipalityCode) }</ns3:MUNICIPALITY_CODE>
                                <ns3:CITY_CODE>{data($item/CityCode) }</ns3:CITY_CODE>
                                <ns3:DISTRICT_CODE/>
                                <ns3:ADDRESS_LINE_1/>
                                <ns3:ADDRESS_LINE_2/>
                                <ns3:ADDRESS_LINE_3/>
                                <ns3:ADDRESS_LINE_4/>                                
                                <ns3:ADDRESS_LINE_5>{ data($item/AddressLine5) }</ns3:ADDRESS_LINE_5>
			                	<ns3:IS_MAIN_ADDRESS>YES</ns3:IS_MAIN_ADDRESS>
			                	<ns3:COUNTRY_DESC>{data($item/CountryDesc) }</ns3:COUNTRY_DESC>
			                	<ns3:DEPARTMENT_DESC>{data($item/DepartmentDesc) }</ns3:DEPARTMENT_DESC>
			                	<ns3:MUNICIPALITY_DESC>{data($item/MunicipalityDesc) }</ns3:MUNICIPALITY_DESC>
			                	<ns3:CITY_DESC>{data($item/CityDesc) }</ns3:CITY_DESC>			                	
			                </ns3:ADDRESS_ITEM>
					)else(
			               <ns3:ADDRESS_ITEM>
							    <ns3:ADDRESS_CODE>{ data($item/AddressCode) }</ns3:ADDRESS_CODE>
			            		<ns3:ADDRESS_TYPE>{data($item/AddressType) }</ns3:ADDRESS_TYPE>
			            		<ns3:POBOX/>
                                <ns3:ZIPCODE/>
			                	<ns3:COUNTRY_CODE>{data($item/CountryCode) }</ns3:COUNTRY_CODE>
			                	<ns3:DEPARTMENT_CODE>{data($item/DepartmentCode) }</ns3:DEPARTMENT_CODE>
								<ns3:MUNICIPALITY_CODE>{ data($item/MunicipalityCode) }</ns3:MUNICIPALITY_CODE>
                                <ns3:CITY_CODE>{data($item/CityCode) }</ns3:CITY_CODE>
                                <ns3:DISTRICT_CODE/>
                                <ns3:ADDRESS_LINE_1/>
                                <ns3:ADDRESS_LINE_2/>
                                <ns3:ADDRESS_LINE_3/>
                                <ns3:ADDRESS_LINE_4/>
                                <ns3:ADDRESS_LINE_5>{ data($item/AddressLine5) }</ns3:ADDRESS_LINE_5>
			                	<ns3:IS_MAIN_ADDRESS>YES</ns3:IS_MAIN_ADDRESS>
			                	<ns3:COUNTRY_DESC>{data($item/CountryDesc) }</ns3:COUNTRY_DESC>
			                	<ns3:DEPARTMENT_DESC>{data($item/DepartmentDesc) }</ns3:DEPARTMENT_DESC>
			                	<ns3:MUNICIPALITY_DESC>{data($item/MunicipalityDesc) }</ns3:MUNICIPALITY_DESC>
			                	<ns3:CITY_DESC>{data($item/CityDesc) }</ns3:CITY_DESC>				                				                	
			                </ns3:ADDRESS_ITEM>
                   )							
		        }
	            </ns3:ADDRESS_INFO>
	            <ns3:EMAIL_INFO>
	            {
                      
	            	for $item in $getCustomerDetailsResponse/EmailInfo/EmailItem[1]
	            	return
                      <ns3:EMAIL_ITEM>
                           <ns3:EMAIL_CODE>{ data($item/EmailCode)}</ns3:EMAIL_CODE>
                           <ns3:EMAIL_ADDRESS>{ data($item/EmailAddress)}</ns3:EMAIL_ADDRESS>
                           <ns3:IS_DEFAULT>YES</ns3:IS_DEFAULT>
                      </ns3:EMAIL_ITEM>
	            }
	            </ns3:EMAIL_INFO>
	            <ns3:JOB_INFO>
				  {
                      
	            	for $item in $getCustomerDetailsResponse/JobInfo/JobItem
	            	return
	                <ns3:JOB_ITEM>
					    <ns3:EMPLOYER_CODE>{ data($item/EmployerCode) }</ns3:EMPLOYER_CODE>
					    <ns3:EMPLOYER_NAME>{ data($item/EmployerName) }</ns3:EMPLOYER_NAME>
					    <ns3:JOB_CODE/>
	                    <ns3:JOB_DESCRIPTION>{ data($item/JobDescription) }</ns3:JOB_DESCRIPTION>
						<ns3:INCOME_TYPE>SALARY</ns3:INCOME_TYPE>
						<ns3:SALARY_CURRENCY/>
	                    <ns3:SALARY_AMOUNT/>
	                    <ns3:START_DATE>{ local:format-date-from-FPC(fn:string($item/StartDate/text()),"dd/MM/yyyy") }</ns3:START_DATE>
						<ns3:END_DATE/>
                        <ns3:IS_CURRENT_JOB>{ data($item/IsCurrentJob) }</ns3:IS_CURRENT_JOB>
	                </ns3:JOB_ITEM>
			       }		
	            </ns3:JOB_INFO>
	                
	        </ns3:consultaClienteResponse>
};

declare variable $getCustomerDetailsResponse as element(ns0:getCustomerDetailsResponse) external;

xf:getCustomerDetailsOut($getCustomerDetailsResponse)