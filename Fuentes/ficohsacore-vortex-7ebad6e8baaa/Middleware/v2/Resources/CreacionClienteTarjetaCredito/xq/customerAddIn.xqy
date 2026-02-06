xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creacionClienteTarjetaCredito" element="ns0:creacionClienteTarjetaCredito" location="../xsd/creacionClienteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$ptEquivalencias" type="ns2:OutputParameters/ns2:PT_EQUIVALENCIAS" location="../../../BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CustomerAddRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creacionClienteTarjetaCreditoTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionClienteTarjetaCredito/xq/customerAddIn/";

declare function valorCatalogoOSBToAPP($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns2:EQUIVALENCIA[ns2:CATALOGO_ID = $catalogoId and 
															  ns2:APLICACION_DESC = $aplicacion and 
															  ns2:VALOR_DESC = $valor]/ns2:EQUIVALENCIA_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:customerAddIn($creacionClienteTarjetaCredito as element(ns0:creacionClienteTarjetaCredito),
    $customerId as xs:string,
    $ptEquivalencias as element())
    as element(ns1:CustomerAddRequest) {
        <ns1:CustomerAddRequest>
            <ARXNAI-LOCAL-ACCT-ORG>{ data($creacionClienteTarjetaCredito/ORG) }</ARXNAI-LOCAL-ACCT-ORG>
            <ARXNAI-CUST-NBR>{ $customerId }</ARXNAI-CUST-NBR>
            <ARXNAI-BS-ACCT></ARXNAI-BS-ACCT>
            <ARXNAI-NA-COMAKER-IND>{ data($creacionClienteTarjetaCredito/MAKER_INDICATOR) }</ARXNAI-NA-COMAKER-IND>
            <ARXNAI-DUAL-FLAG>{ data($creacionClienteTarjetaCredito/DOUBLE_CURRENCY_INDICATOR) }</ARXNAI-DUAL-FLAG>
            <ARXNAI-COMAKER-FILLER>{ fn-bea:pad-left('', 50, ' ') }</ARXNAI-COMAKER-FILLER>
            <ARXNAI-VIP-STATUS>{ data($creacionClienteTarjetaCredito/VIP_CLIENT_INDICATOR) }</ARXNAI-VIP-STATUS>
            <ARXNAI-SIC-CODE>0</ARXNAI-SIC-CODE>
            <ARXNAI-STATUS>0</ARXNAI-STATUS>
            <ARXNAI-MISC-FILLER>{ fn-bea:pad-left('', 100, ' ') }</ARXNAI-MISC-FILLER>
            <ARXNAI-M-TITLE></ARXNAI-M-TITLE>
            <ARXNAI-M-MARITAL-STATUS>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/MARITAL_STATUS/text()), 'VISION+', '2', $ptEquivalencias) }</ARXNAI-M-MARITAL-STATUS>
            <ARXNAI-M-NAME-LINE-1>PRINCIPAL</ARXNAI-M-NAME-LINE-1> 
            <ARXNAI-M-NAME-TYPE-IND-1>0</ARXNAI-M-NAME-TYPE-IND-1>
            <ARXNAI-M-NAME-LINE-2></ARXNAI-M-NAME-LINE-2>
            <ARXNAI-M-NAME-TYPE-IND-2>0</ARXNAI-M-NAME-TYPE-IND-2>
            <ARXNAI-M-NAME-LINE-3></ARXNAI-M-NAME-LINE-3>
            <ARXNAI-M-NAME-TYPE-IND-3>0</ARXNAI-M-NAME-TYPE-IND-3>
            <ARXNAI-M-HOUSE-NBR></ARXNAI-M-HOUSE-NBR>
			<ARXNAI-M-HOUSE-NAME></ARXNAI-M-HOUSE-NAME>
            <ARXNAI-M-ADDR-1>{ data($creacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_1) }</ARXNAI-M-ADDR-1>
            <ARXNAI-M-ADDR-2>{ data($creacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_2) }</ARXNAI-M-ADDR-2>
            <ARXNAI-M-ADDR-3>{ data($creacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_3) }</ARXNAI-M-ADDR-3>
            <ARXNAI-M-ADDR-4>{ data($creacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_4) }</ARXNAI-M-ADDR-4>
            <ARXNAI-M-CITY>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/CITY/text()), 'VISION+', '7', $ptEquivalencias) }</ARXNAI-M-CITY>
            <ARXNAI-M-STATE>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/STATE/text()), 'VISION+', '35', $ptEquivalencias) }</ARXNAI-M-STATE>
            <ARXNAI-M-PSTL-CD>{ data($creacionClienteTarjetaCredito/ZIP_CODE) }</ARXNAI-M-PSTL-CD>
            <ARXNAI-M-CNTRY-CD>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/COUNTRY_OF_RESIDENCE/text()), 'VISION+', '9', $ptEquivalencias) }</ARXNAI-M-CNTRY-CD>
            <ARXNAI-M-OWN-RENT-RESIDFLAG>{ data($creacionClienteTarjetaCredito/RESIDENCE_TYPE)}</ARXNAI-M-OWN-RENT-RESIDFLAG>
            <ARXNAI-M-1099C-FOREIGN-IND></ARXNAI-M-1099C-FOREIGN-IND>
            <ARXNAI-M-LANGUAGE-IND>ESP</ARXNAI-M-LANGUAGE-IND>
            <ARXNAI-M-MAILING-LIST>N</ARXNAI-M-MAILING-LIST>
            <ARXNAI-M-CONTACT-IND>0</ARXNAI-M-CONTACT-IND>
            <ARXNAI-M-GENDER-CODE>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/GENDER/text()), 'VISION+', '1', $ptEquivalencias) }</ARXNAI-M-GENDER-CODE>
            <ARXNAI-M-CR-1-2>01</ARXNAI-M-CR-1-2>
            <ARXNAI-M-CR-3-4>01</ARXNAI-M-CR-3-4>
            <ARXNAI-M-HOME-PHONE>{ data($creacionClienteTarjetaCredito/HOME_PHONE_NUMBER) }</ARXNAI-M-HOME-PHONE>
            <ARXNAI-M-FAX-PHONE>{ data($creacionClienteTarjetaCredito/FAX_PHONE) }</ARXNAI-M-FAX-PHONE>
            <ARXNAI-M-MOBILE-PHONE>{ data($creacionClienteTarjetaCredito/MOBILE_PHONE) }</ARXNAI-M-MOBILE-PHONE>
            <ARXNAI-M-DOB>
            	{ 
            	for $birthDate in $creacionClienteTarjetaCredito/BIRTH_DATE
            	return
            		if(count($birthDate) > 0) then(
            			fn-bea:date-to-string-with-format('yyyyDDD', data($birthDate))
            		)else() 
            	}
            </ARXNAI-M-DOB>
            <ARXNAI-M-DL-NBR>{ data($creacionClienteTarjetaCredito/DRIVERS_LICENCE) }</ARXNAI-M-DL-NBR>
            <ARXNAI-M-DL-STATE></ARXNAI-M-DL-STATE>
            <ARXNAI-M-DL-CNTRY></ARXNAI-M-DL-CNTRY>
            <ARXNAI-M-SSAN-FLAG>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/LEGAL_ID_TYPE/text()), 'VISION+', '4', $ptEquivalencias) }</ARXNAI-M-SSAN-FLAG>
            <ARXNAI-M-SSAN>{ data($creacionClienteTarjetaCredito/LEGAL_ID) }</ARXNAI-M-SSAN>
            <ARXNAI-M-1099C-W9-DATE-FILED>0</ARXNAI-M-1099C-W9-DATE-FILED>
            <ARXNAI-M-STMT-MSG-INDIC>0</ARXNAI-M-STMT-MSG-INDIC>
            <ARXNAI-M-EMPLOYER>{ data($creacionClienteTarjetaCredito/WORKPLACE) }</ARXNAI-M-EMPLOYER>
            {
            	for $workAddressLine1 in $creacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_LINE_1
            	return
	            	<ARXNAI-M-EMPLOYER-ADDR-1>{ data($workAddressLine1) }</ARXNAI-M-EMPLOYER-ADDR-1>
            }
            {
            	for $workAddressLine2 in $creacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_LINE_2
            	return
	            	<ARXNAI-M-EMPLOYER-ADDR-2>{ data($workAddressLine2) }</ARXNAI-M-EMPLOYER-ADDR-2>
            }
            <ARXNAI-M-EMP-PHONE>{ data($creacionClienteTarjetaCredito/WORK_PHONE_NUMBER) }</ARXNAI-M-EMP-PHONE>
            <ARXNAI-M-EMP-PHONE-EXTN>{ data($creacionClienteTarjetaCredito/WORK_EXTENSION) }</ARXNAI-M-EMP-PHONE-EXTN>
            <ARXNAI-M-PHONE-FLAG>0</ARXNAI-M-PHONE-FLAG>
            {
            	for $profession in $creacionClienteTarjetaCredito/PROFESSION
            	return
            	if(string($profession/text()) != "") then (
            		<ARXNAI-M-POSITION>{ valorCatalogoOSBToAPP(string($profession/text()), 'VISION+', '3', $ptEquivalencias) }</ARXNAI-M-POSITION>
            	)else(
            		<ARXNAI-M-POSITION>{ fn:string('') }</ARXNAI-M-POSITION>
            	)
            }
            <ARXNAI-M-RELATIVE-NAME>{ data($creacionClienteTarjetaCredito/WORK_ECONOMIC_ACTIVITY) }</ARXNAI-M-RELATIVE-NAME>
            <ARXNAI-M-NBR-OF-DEPENDENTS>{ data($creacionClienteTarjetaCredito/DEPENDENTS) }</ARXNAI-M-NBR-OF-DEPENDENTS>
            <ARXNAI-M-EMAIL>{ data($creacionClienteTarjetaCredito/EMAIL) }</ARXNAI-M-EMAIL>
            <ARXNAI-M-MEMO-1>{ concat(data($creacionClienteTarjetaCredito/WORK_COUNTRY),' ',data($creacionClienteTarjetaCredito/WORK_ADDRESS_3)) }</ARXNAI-M-MEMO-1>
            <ARXNAI-M-MEMO-2>{ concat(data($creacionClienteTarjetaCredito/WORK_STATE),' ',data($creacionClienteTarjetaCredito/WORK_ADDRESS_4)) }</ARXNAI-M-MEMO-2>
            <ARXNAI-M-USER-1>{ data($creacionClienteTarjetaCredito/EMPLOYMENT_YEARS) }</ARXNAI-M-USER-1>
            <ARXNAI-M-USER-2>{ data($creacionClienteTarjetaCredito/EMPLOYMENT_MONTHS) }</ARXNAI-M-USER-2>
            {
            	for $profession in $creacionClienteTarjetaCredito/PROFESSION
            	return
            	if(string($profession/text()) != "") then (
            		<ARXNAI-M-USER-3>{ data($profession) }</ARXNAI-M-USER-3>
            	)else(
            		<ARXNAI-M-USER-3>{ fn:string('') }</ARXNAI-M-USER-3>
            	)
            }
            <ARXNAI-M-USER-4>{ data($creacionClienteTarjetaCredito/NATURE_OF_BUSINESS)}</ARXNAI-M-USER-4>
            <ARXNAI-M-USER-5>{ data($creacionClienteTarjetaCredito/SALARY_RANGE)}</ARXNAI-M-USER-5>
            <ARXNAI-M-USER-6></ARXNAI-M-USER-6>
            <ARXNAI-M-USER-7></ARXNAI-M-USER-7>
            <ARXNAI-M-USER-8>{ data($creacionClienteTarjetaCredito/PEP_CLIENT) }</ARXNAI-M-USER-8>
            <ARXNAI-M-USER-9></ARXNAI-M-USER-9>
            <ARXNAI-M-USER-10>
            	{ 
            		if(data($creacionClienteTarjetaCredito/EXPIRATION_DATE_CLIENT_ID) != '') then(
            			fn-bea:date-to-string-with-format('yyyyDDD', xs:date($creacionClienteTarjetaCredito/EXPIRATION_DATE_CLIENT_ID))
            		)else(0000000) 
            	}
            </ARXNAI-M-USER-10>
            <ARXNAI-M-USER-11>
            	{ 
            		if(data($creacionClienteTarjetaCredito/ISSUE_DATE_CLIENT_ID) != '') then(
            			fn-bea:date-to-string-with-format('yyyyDDD', xs:date($creacionClienteTarjetaCredito/ISSUE_DATE_CLIENT_ID))
            		)else(0000000) 
            	}
            </ARXNAI-M-USER-11>
            <ARXNAI-M-USER-12>{ data($creacionClienteTarjetaCredito/PROFESSION_DESC)}</ARXNAI-M-USER-12>
            <ARXNAI-M-USER-13>{ data($creacionClienteTarjetaCredito/CITY_OF_BIRTH)}</ARXNAI-M-USER-13>
            <ARXNAI-M-USER-14>{ data($creacionClienteTarjetaCredito/EDUCATION_LEVEL)}</ARXNAI-M-USER-14>
            <ARXNAI-M-USER-15>{ data($creacionClienteTarjetaCredito/MONTHLY_INCOME)}</ARXNAI-M-USER-15>
            <ARXNAI-M-USER-DEMO-1></ARXNAI-M-USER-DEMO-1>
			<ARXNAI-M-USER-DEMO-2></ARXNAI-M-USER-DEMO-2>
			<ARXNAI-M-USER-DEMO-3></ARXNAI-M-USER-DEMO-3>
            <ARXNAI-M-HOME-PHONE-FLAG>0</ARXNAI-M-HOME-PHONE-FLAG>
            <ARXNAI-M-FAX-PHONE-FLAG>0</ARXNAI-M-FAX-PHONE-FLAG>
            <ARXNAI-M-MOBILE-PHONE-FLAG>0</ARXNAI-M-MOBILE-PHONE-FLAG>
            <ARXNAI-M-EMAIL-FLAG>0</ARXNAI-M-EMAIL-FLAG>
            <ARXNAI-M-SMS-FLAG>0</ARXNAI-M-SMS-FLAG>
            <ARXNAI-M-LAST-NAME>{ substring(normalize-space(concat($creacionClienteTarjetaCredito/FIRST_SURNAME ,' ', $creacionClienteTarjetaCredito/SECOND_SURNAME)), 1, 20) }</ARXNAI-M-LAST-NAME>
            <ARXNAI-M-MIDDLE-NAME></ARXNAI-M-MIDDLE-NAME>
            <ARXNAI-M-FIRST-NAME>{ concat(substring(normalize-space(concat($creacionClienteTarjetaCredito/FIRST_NAME ,' ', $creacionClienteTarjetaCredito/SECOND_NAME)),1,18), ',') }</ARXNAI-M-FIRST-NAME>
            <ARXNAI-M-SUFFIX></ARXNAI-M-SUFFIX>
			<ARXNAI-M-COUNTY>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/HOME_MUNICIPALITY/text()), 'VISION+', '34', $ptEquivalencias)}</ARXNAI-M-COUNTY>
			<ARXNAI-M-C-FILLER></ARXNAI-M-C-FILLER>
			<ARXNAI-C-TITLE></ARXNAI-C-TITLE>
			<ARXNAI-C-MARITAL-STATUS>0</ARXNAI-C-MARITAL-STATUS>
			<ARXNAI-C-NAME-LINE-1></ARXNAI-C-NAME-LINE-1>
            <ARXNAI-C-NAME-TYPE-IND-1>0</ARXNAI-C-NAME-TYPE-IND-1>
            <ARXNAI-C-NAME-LINE-2></ARXNAI-C-NAME-LINE-2>
            <ARXNAI-C-NAME-TYPE-IND-2>0</ARXNAI-C-NAME-TYPE-IND-2>
            <ARXNAI-C-NAME-LINE-3></ARXNAI-C-NAME-LINE-3>
            <ARXNAI-C-NAME-TYPE-IND-3>0</ARXNAI-C-NAME-TYPE-IND-3>
            <ARXNAI-C-HOUSE-NBR></ARXNAI-C-HOUSE-NBR>
            <ARXNAI-C-HOUSE-NAME></ARXNAI-C-HOUSE-NAME>
            <ARXNAI-C-ADDR-1>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_TYPE1)}</ARXNAI-C-ADDR-1>
			<ARXNAI-C-ADDR-2>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_PHONE1)}</ARXNAI-C-ADDR-2>
			<ARXNAI-C-ADDR-3>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_TYPE2)}</ARXNAI-C-ADDR-3>
			<ARXNAI-C-ADDR-4>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_PHONE2)}</ARXNAI-C-ADDR-4>
			<ARXNAI-C-CITY></ARXNAI-C-CITY>
			<ARXNAI-C-STATE></ARXNAI-C-STATE>
			<ARXNAI-C-PSTL-CD></ARXNAI-C-PSTL-CD>
			<ARXNAI-C-CNTRY-CD>{ data($creacionClienteTarjetaCredito/COUNTRY_OF_BIRTH)}</ARXNAI-C-CNTRY-CD>             
            <ARXNAI-C-OWN-RENT-RESID-FLAG>1</ARXNAI-C-OWN-RENT-RESID-FLAG>
            <ARXNAI-C-1099C-FOREIGN-IND></ARXNAI-C-1099C-FOREIGN-IND>
			<ARXNAI-C-LANGUAGE-IND></ARXNAI-C-LANGUAGE-IND>
			<ARXNAI-C-MAILING-LIST></ARXNAI-C-MAILING-LIST>
            <ARXNAI-C-CONTACT-IND>0</ARXNAI-C-CONTACT-IND>
            <ARXNAI-C-GENDER-CODE>0</ARXNAI-C-GENDER-CODE>
            <ARXNAI-C-CR-1-2></ARXNAI-C-CR-1-2>
            <ARXNAI-C-CR-3-4>01</ARXNAI-C-CR-3-4>
            <ARXNAI-C-HOME-PHONE></ARXNAI-C-HOME-PHONE>
			<ARXNAI-C-FAX-PHONE></ARXNAI-C-FAX-PHONE>
			<ARXNAI-C-MOBILE-PHONE>{ data($creacionClienteTarjetaCredito/SPOUSE_PHONE)}</ARXNAI-C-MOBILE-PHONE>
            <ARXNAI-C-DOB>
            	{ 
            		if(data($creacionClienteTarjetaCredito/DATE_OF_BIRTH_SPOUSE) != '') then(
            			fn-bea:date-to-string-with-format('yyyyDDD', data($creacionClienteTarjetaCredito/DATE_OF_BIRTH_SPOUSE))
            		)else(0000000) 
            	}
            </ARXNAI-C-DOB>
            <ARXNAI-C-DL-NBR></ARXNAI-C-DL-NBR>
			<ARXNAI-C-DL-STATE></ARXNAI-C-DL-STATE>
			<ARXNAI-C-DL-CNTRY></ARXNAI-C-DL-CNTRY>
            <ARXNAI-C-SSAN-FLAG>
            {  
               if(data($creacionClienteTarjetaCredito/SPOUSE_ID_TYPE) != '') then (
               
                 valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/SPOUSE_ID_TYPE/text()), 'VISION+', '4', $ptEquivalencias)
                 
            ) else(0)
            }
            </ARXNAI-C-SSAN-FLAG>
            <ARXNAI-C-SSAN>{ data($creacionClienteTarjetaCredito/SPOUSE_ID)}</ARXNAI-C-SSAN>
            <ARXNAI-C-1099C-W9-DATE-FILED>0000000</ARXNAI-C-1099C-W9-DATE-FILED>
            <ARXNAI-C-STMT-MSG-INDIC>0</ARXNAI-C-STMT-MSG-INDIC>
            <ARXNAI-C-EMPLOYER></ARXNAI-C-EMPLOYER>
			<ARXNAI-C-EMPLOYER-ADDR-1></ARXNAI-C-EMPLOYER-ADDR-1>
			<ARXNAI-C-EMPLOYER-ADDR-2></ARXNAI-C-EMPLOYER-ADDR-2>
			<ARXNAI-C-EMP-PHONE></ARXNAI-C-EMP-PHONE>
			<ARXNAI-C-EMP-PHONE-EXTN></ARXNAI-C-EMP-PHONE-EXTN>
            <ARXNAI-C-PHONE-FLAG>0</ARXNAI-C-PHONE-FLAG>
            <ARXNAI-C-POSITION>{ data($creacionClienteTarjetaCredito/CLIENT_ECONOMIC_ACTIVITY)}</ARXNAI-C-POSITION>
			<ARXNAI-C-RELATIVE-NAME></ARXNAI-C-RELATIVE-NAME>
            <ARXNAI-C-NBR-OF-DEPENDENTS>011</ARXNAI-C-NBR-OF-DEPENDENTS>
            <ARXNAI-C-EMAIL>{ data($creacionClienteTarjetaCredito/ALTERNATE_CLIENT_EMAIL)}</ARXNAI-C-EMAIL>
			<ARXNAI-C-MEMO-1>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_NAME1)}</ARXNAI-C-MEMO-1>
			<ARXNAI-C-MEMO-2>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_NAME2)}</ARXNAI-C-MEMO-2>
			<ARXNAI-C-USER-1></ARXNAI-C-USER-1>
			<ARXNAI-C-USER-2></ARXNAI-C-USER-2>
			<ARXNAI-C-USER-3></ARXNAI-C-USER-3>
			<ARXNAI-C-USER-4></ARXNAI-C-USER-4>
			<ARXNAI-C-USER-5></ARXNAI-C-USER-5>
			<ARXNAI-C-USER-6></ARXNAI-C-USER-6>
			<ARXNAI-C-USER-7></ARXNAI-C-USER-7>
			<ARXNAI-C-USER-8></ARXNAI-C-USER-8>
			<ARXNAI-C-USER-9></ARXNAI-C-USER-9>
            <ARXNAI-C-USER-10>0</ARXNAI-C-USER-10>
            <ARXNAI-C-USER-11>0</ARXNAI-C-USER-11>
            <ARXNAI-C-USER-12></ARXNAI-C-USER-12>
			<ARXNAI-C-USER-13></ARXNAI-C-USER-13>
			<ARXNAI-C-USER-14></ARXNAI-C-USER-14>
			<ARXNAI-C-USER-15></ARXNAI-C-USER-15>
			<ARXNAI-C-USER-DEMO-1></ARXNAI-C-USER-DEMO-1>
			<ARXNAI-C-USER-DEMO-2></ARXNAI-C-USER-DEMO-2>
			<ARXNAI-C-USER-DEMO-3>{ data($creacionClienteTarjetaCredito/SALARY_RANGE_DESC)}</ARXNAI-C-USER-DEMO-3>
            <ARXNAI-C-HOME-PHONE-FLAG>0</ARXNAI-C-HOME-PHONE-FLAG>
            <ARXNAI-C-FAX-PHONE-FLAG>0</ARXNAI-C-FAX-PHONE-FLAG>
            <ARXNAI-C-MOBILE-PHONE-FLAG>0</ARXNAI-C-MOBILE-PHONE-FLAG>
            <ARXNAI-C-EMAIL-FLAG>0</ARXNAI-C-EMAIL-FLAG>
            <ARXNAI-C-SMS-FLAG>0</ARXNAI-C-SMS-FLAG>
            <ARXNAI-C-LAST-NAME>{ substring(normalize-space(data($creacionClienteTarjetaCredito/SURNAMES_SPOUSE)),1,40) }</ARXNAI-C-LAST-NAME>
			<ARXNAI-C-MIDDLE-NAME></ARXNAI-C-MIDDLE-NAME>
			<ARXNAI-C-FIRST-NAME>
			{  
               if(data($creacionClienteTarjetaCredito/NAMES_SPOUSE) != '') then (
               
                 concat(substring(normalize-space(data($creacionClienteTarjetaCredito/NAMES_SPOUSE)),1,40),',')
                 
            ) else()
            }
			</ARXNAI-C-FIRST-NAME>
			<ARXNAI-C-SUFFIX></ARXNAI-C-SUFFIX>
			<ARXNAI-C-COUNTY></ARXNAI-C-COUNTY>
			<ARXNAI-MAKER-FILLER></ARXNAI-MAKER-FILLER>
			<ARXNAI-RESV-CODE-1></ARXNAI-RESV-CODE-1>
			<ARXNAI-RESV-CODE-2></ARXNAI-RESV-CODE-2>
			<ARXNAI-RESV-CODE-3></ARXNAI-RESV-CODE-3>
			<ARXNAI-RESV-CODE-4></ARXNAI-RESV-CODE-4>
			<ARXNAI-RESV-CODE-5></ARXNAI-RESV-CODE-5>
            <ARXNAI-RESV-DATE-1>0000000</ARXNAI-RESV-DATE-1>
            <ARXNAI-RESV-DATE-2>0000000</ARXNAI-RESV-DATE-2>
            <ARXNAI-RESV-DATE-3>0000000</ARXNAI-RESV-DATE-3>
            <ARXNAI-RESV-DATE-4>0000000</ARXNAI-RESV-DATE-4>
            <ARXNAI-RESV-DATE-5>0000000</ARXNAI-RESV-DATE-5>
            <ARXNAI-RESV-AMT-1>0</ARXNAI-RESV-AMT-1>
            <ARXNAI-RESV-AMT-2>0</ARXNAI-RESV-AMT-2>
            <ARXNAI-RESV-AMT-3>0</ARXNAI-RESV-AMT-3>
            <ARXNAI-RESV-AMT-4>0</ARXNAI-RESV-AMT-4>
            <ARXNAI-RESV-AMT-5>0</ARXNAI-RESV-AMT-5>
        </ns1:CustomerAddRequest>
};

declare variable $creacionClienteTarjetaCredito as element(ns0:creacionClienteTarjetaCredito) external;
declare variable $customerId as xs:string external;
declare variable $ptEquivalencias as element() external;

xf:customerAddIn($creacionClienteTarjetaCredito,
    $customerId,
    $ptEquivalencias)