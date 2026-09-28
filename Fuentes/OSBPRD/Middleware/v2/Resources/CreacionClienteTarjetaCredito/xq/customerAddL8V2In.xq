(:: pragma bea:global-element-parameter parameter="$creacionClienteTarjetaCredito" element="ns1:creacionClienteTarjetaCredito" location="../xsd/creacionClienteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$ptEquivalencias" type="ns2:OutputParameters/ns2:PT_EQUIVALENCIAS" location="../../../BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CustomerAddL8V2Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creacionClienteTarjetaCreditoTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionClienteTarjetaCredito/xq/customerAddL8V2In/";

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

declare function xf:customerAddL8V2In($creacionClienteTarjetaCredito as element(ns1:creacionClienteTarjetaCredito),
    $customerId as xs:string,
    $ptEquivalencias as element())
    as element(ns0:CustomerAddL8V2Request) {
        <ns0:CustomerAddL8V2Request>
            <AZXNAI-LOCAL-ACCT-ORG>{ data($creacionClienteTarjetaCredito/ORG) }</AZXNAI-LOCAL-ACCT-ORG>
            <AZXNAI-CUST-NBR>{ $customerId }</AZXNAI-CUST-NBR>
            <AZXNAI-BS-ACCT/>
            <AZXNAI-NA-COMAKER-IND>{ data($creacionClienteTarjetaCredito/MAKER_INDICATOR) }</AZXNAI-NA-COMAKER-IND>
            <AZXNAI-DUAL-FLAG>{ data($creacionClienteTarjetaCredito/DOUBLE_CURRENCY_INDICATOR) }</AZXNAI-DUAL-FLAG>
            <AZXNAI-COMAKER-FILLER></AZXNAI-COMAKER-FILLER>
            <AZXNAI-VIP-STATUS>{ data($creacionClienteTarjetaCredito/VIP_CLIENT_INDICATOR) }</AZXNAI-VIP-STATUS>
            <AZXNAI-SIC-CODE>0</AZXNAI-SIC-CODE>
            <AZXNAI-STATUS>0</AZXNAI-STATUS>
            <AZXNAI-MISC-FILLER></AZXNAI-MISC-FILLER>
            <AZXNAI-M-TITLE/>
            <AZXNAI-M-MARITAL-STATUS>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/MARITAL_STATUS/text()), 'VISION+', '2', $ptEquivalencias) }</AZXNAI-M-MARITAL-STATUS>
            <AZXNAI-M-NAME-LINE-1>PRINCIPAL</AZXNAI-M-NAME-LINE-1> 
            <AZXNAI-M-NAME-TYPE-IND-1>0</AZXNAI-M-NAME-TYPE-IND-1>
            <AZXNAI-M-NAME-LINE-2/>
            <AZXNAI-M-NAME-TYPE-IND-2>0</AZXNAI-M-NAME-TYPE-IND-2>
            <AZXNAI-M-NAME-LINE-3/>
            <AZXNAI-M-NAME-TYPE-IND-3>0</AZXNAI-M-NAME-TYPE-IND-3>
            <AZXNAI-M-HOUSE-NBR/>
			<AZXNAI-M-HOUSE-NAME/>
            <AZXNAI-M-ADDR-1>{ fn:replace(data($creacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_1), "[Ññ]", "#") }</AZXNAI-M-ADDR-1>
            <AZXNAI-M-ADDR-2>{ fn:replace(data($creacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_2), "[Ññ]", "#") }</AZXNAI-M-ADDR-2>
            <AZXNAI-M-ADDR-3>{ fn:replace(data($creacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_3), "[Ññ]", "#") }</AZXNAI-M-ADDR-3>
            <AZXNAI-M-ADDR-4>{ fn:replace(data($creacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_4), "[Ññ]", "#") }</AZXNAI-M-ADDR-4>
            <AZXNAI-M-CITY>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/CITY/text()), 'VISION+', '7', $ptEquivalencias) }</AZXNAI-M-CITY>
            <AZXNAI-M-STATE>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/STATE/text()), 'VISION+', '35', $ptEquivalencias) }</AZXNAI-M-STATE>
            <AZXNAI-M-PSTL-CD>{ data($creacionClienteTarjetaCredito/ZIP_CODE) }</AZXNAI-M-PSTL-CD>
            <AZXNAI-M-CNTRY-CD>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/COUNTRY_OF_RESIDENCE/text()), 'VISION+', '9', $ptEquivalencias) }</AZXNAI-M-CNTRY-CD>
            <AZXNAI-M-OWN-RENT-RESIDFLAG>{ data($creacionClienteTarjetaCredito/RESIDENCE_TYPE)}</AZXNAI-M-OWN-RENT-RESIDFLAG>
            <AZXNAI-M-1099C-FOREIGN-IND/>
            <AZXNAI-M-LANGUAGE-IND>ESP</AZXNAI-M-LANGUAGE-IND>
            <AZXNAI-M-MAILING-LIST>E</AZXNAI-M-MAILING-LIST>
            <AZXNAI-M-CONTACT-IND>0</AZXNAI-M-CONTACT-IND>
            <AZXNAI-M-GENDER-CODE>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/GENDER/text()), 'VISION+', '1', $ptEquivalencias) }</AZXNAI-M-GENDER-CODE>
            <AZXNAI-M-CR-1-2>01</AZXNAI-M-CR-1-2>
            <AZXNAI-M-CR-3-4>01</AZXNAI-M-CR-3-4>
            <AZXNAI-M-HOME-PHONE>{ data($creacionClienteTarjetaCredito/HOME_PHONE_NUMBER) }</AZXNAI-M-HOME-PHONE>
            <AZXNAI-M-FAX-PHONE>{ data($creacionClienteTarjetaCredito/FAX_PHONE) }</AZXNAI-M-FAX-PHONE>
            <AZXNAI-M-MOBILE-PHONE>{ data($creacionClienteTarjetaCredito/MOBILE_PHONE) }</AZXNAI-M-MOBILE-PHONE>
            <AZXNAI-M-DOB>
            	{ 
            	for $birthDate in $creacionClienteTarjetaCredito/BIRTH_DATE
            	return
            		if(count($birthDate) > 0) then(
            			fn-bea:date-to-string-with-format('yyyyDDD', data($birthDate))
            		)else() 
            	}
            </AZXNAI-M-DOB>
            <AZXNAI-M-DL-NBR>{ data($creacionClienteTarjetaCredito/DRIVERS_LICENCE) }</AZXNAI-M-DL-NBR>
            <AZXNAI-M-DL-STATE/>
            <AZXNAI-M-DL-CNTRY/>
			{
			 if(data($creacionClienteTarjetaCredito/LEGAL_ID_TYPE) != 'CED') then (
			 <AZXNAI-M-SSAN-FLAG>2</AZXNAI-M-SSAN-FLAG>
			 )else (
            <AZXNAI-M-SSAN-FLAG>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/LEGAL_ID_TYPE/text()), 'VISION+', '4', $ptEquivalencias) }</AZXNAI-M-SSAN-FLAG>)
			}
            <AZXNAI-M-SSAN>{ fn:tokenize(data($creacionClienteTarjetaCredito/LEGAL_ID), '\|')[1] }</AZXNAI-M-SSAN>
            <AZXNAI-M-1099C-W9-DATE-FILED>2000-01-01</AZXNAI-M-1099C-W9-DATE-FILED>
            <AZXNAI-M-STMT-MSG-INDIC>0</AZXNAI-M-STMT-MSG-INDIC>
            <AZXNAI-M-EMPLOYER>{ data($creacionClienteTarjetaCredito/WORKPLACE) }</AZXNAI-M-EMPLOYER>
            {
            	for $workAddressLine1 in $creacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_LINE_1
            	return
	            	<AZXNAI-M-EMPLOYER-ADDR-1>{ fn:replace(data($workAddressLine1), "[Ññ]", "#") }</AZXNAI-M-EMPLOYER-ADDR-1>
            }
            {
            	for $workAddressLine2 in $creacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_LINE_2
            	return
	            	<AZXNAI-M-EMPLOYER-ADDR-2>{ fn:replace(data($workAddressLine2), "[Ññ]", "#") }</AZXNAI-M-EMPLOYER-ADDR-2>
            }
            <AZXNAI-M-EMP-PHONE>{ data($creacionClienteTarjetaCredito/WORK_PHONE_NUMBER) }</AZXNAI-M-EMP-PHONE>
            <AZXNAI-M-EMP-PHONE-EXTN>{ data($creacionClienteTarjetaCredito/WORK_EXTENSION) }</AZXNAI-M-EMP-PHONE-EXTN>
            <AZXNAI-M-PHONE-FLAG>0</AZXNAI-M-PHONE-FLAG>
            {
            	for $profession in $creacionClienteTarjetaCredito/PROFESSION
            	return
            	if(string($profession/text()) != "") then (
            		<AZXNAI-M-POSITION>{ valorCatalogoOSBToAPP(string($profession/text()), 'VISION+', '3', $ptEquivalencias) }</AZXNAI-M-POSITION>
            	)else(
            		<AZXNAI-M-POSITION>{ fn:string('') }</AZXNAI-M-POSITION>
            	)
            }
            <AZXNAI-M-RELATIVE-NAME>{ data($creacionClienteTarjetaCredito/WORK_ECONOMIC_ACTIVITY) }</AZXNAI-M-RELATIVE-NAME>
            <AZXNAI-M-NBR-OF-DEPENDENTS>{ data($creacionClienteTarjetaCredito/DEPENDENTS) }</AZXNAI-M-NBR-OF-DEPENDENTS>
            <AZXNAI-M-EMAIL>{ data($creacionClienteTarjetaCredito/EMAIL) }</AZXNAI-M-EMAIL>
            <AZXNAI-M-MEMO-1>{ fn:replace(concat(data($creacionClienteTarjetaCredito/COUNTRY_WORK),' ',data($creacionClienteTarjetaCredito/WORK_ADDRESS_3)), "[Ññ]", "#") }</AZXNAI-M-MEMO-1>
            <AZXNAI-M-MEMO-2>{ fn:replace(concat(data($creacionClienteTarjetaCredito/WORK_STATE),' ',data($creacionClienteTarjetaCredito/WORK_ADDRESS_4)), "[Ññ]", "#") }</AZXNAI-M-MEMO-2>
            <AZXNAI-M-USER-1>{ data($creacionClienteTarjetaCredito/EMPLOYMENT_YEARS) }</AZXNAI-M-USER-1>
            <AZXNAI-M-USER-2>{ data($creacionClienteTarjetaCredito/EMPLOYMENT_MONTHS) }</AZXNAI-M-USER-2>
            {
            	for $workTitle in $creacionClienteTarjetaCredito/WORK_TITLE
            	return
            	if(string($workTitle/text()) != "") then (
            		<AZXNAI-M-USER-3>{ data($workTitle) }</AZXNAI-M-USER-3>
            	)else(
            		<AZXNAI-M-USER-3>{ fn:string('') }</AZXNAI-M-USER-3>
            	)
            }
            <AZXNAI-M-USER-4>{ data($creacionClienteTarjetaCredito/NATURE_OF_BUSINESS)}</AZXNAI-M-USER-4>
            <AZXNAI-M-USER-5>{ data($creacionClienteTarjetaCredito/SALARY_RANGE)}</AZXNAI-M-USER-5>
            <AZXNAI-M-USER-6/>
            <AZXNAI-M-USER-7/>
            <AZXNAI-M-USER-8>{ data($creacionClienteTarjetaCredito/PEP_CLIENT) }</AZXNAI-M-USER-8>
            <AZXNAI-M-USER-9/>
            <AZXNAI-M-USER-10>
            	{ 
            		if(data($creacionClienteTarjetaCredito/EXPIRATION_DATE_CLIENT_ID) != '') then(
            			fn-bea:date-to-string-with-format('yyyyDDD', xs:date($creacionClienteTarjetaCredito/EXPIRATION_DATE_CLIENT_ID))
            		)else(0000000) 
            	}
            </AZXNAI-M-USER-10>
            <AZXNAI-M-USER-11>
            	{ 
            		if(data($creacionClienteTarjetaCredito/ISSUE_DATE_CLIENT_ID) != '') then(
            			fn-bea:date-to-string-with-format('yyyyDDD', xs:date($creacionClienteTarjetaCredito/ISSUE_DATE_CLIENT_ID))
            		)else(0000000) 
            	}
            </AZXNAI-M-USER-11>
            <AZXNAI-M-USER-12>{ data($creacionClienteTarjetaCredito/PROFESSION_DESC)}</AZXNAI-M-USER-12>
            <AZXNAI-M-USER-13>{ data($creacionClienteTarjetaCredito/CITY_OF_BIRTH)}</AZXNAI-M-USER-13>
            <AZXNAI-M-USER-14>{ data($creacionClienteTarjetaCredito/EDUCATION_LEVEL)}</AZXNAI-M-USER-14>
            <AZXNAI-M-USER-15>{ data($creacionClienteTarjetaCredito/MONTHLY_INCOME)}</AZXNAI-M-USER-15>
            <AZXNAI-M-USER-DEMO-1/>
			<AZXNAI-M-USER-DEMO-2/>
			{
				let $FLYER_TYPE := string($creacionClienteTarjetaCredito/FLYER_TYPE/text())
					 let $FREQUENT_FLYEER := string($creacionClienteTarjetaCredito/FREQUENT_FLYEER/text())
					return(
						if ($FLYER_TYPE != "LM") then (
			            <AZXNAI-M-USER-DEMO-3/>
			          ) else (
			            <AZXNAI-M-USER-DEMO-3>{ data($FREQUENT_FLYEER) }</AZXNAI-M-USER-DEMO-3>
			          )
					)
			}
            <AZXNAI-M-HOME-PHONE-FLAG>0</AZXNAI-M-HOME-PHONE-FLAG>
            <AZXNAI-M-FAX-PHONE-FLAG>0</AZXNAI-M-FAX-PHONE-FLAG>
            <AZXNAI-M-MOBILE-PHONE-FLAG>0</AZXNAI-M-MOBILE-PHONE-FLAG>
            <AZXNAI-M-EMAIL-FLAG>0</AZXNAI-M-EMAIL-FLAG>
            <AZXNAI-M-SMS-FLAG>0</AZXNAI-M-SMS-FLAG>
			<AZXNAI-M-LAST-NAME>{
				substring(
				    fn:replace(normalize-space(concat($creacionClienteTarjetaCredito/FIRST_SURNAME, ' ', $creacionClienteTarjetaCredito/SECOND_SURNAME)), "[Ññ]", "#"),
				    1,
				    20
				)
			}</AZXNAI-M-LAST-NAME>
            <AZXNAI-M-MIDDLE-NAME/>
			<AZXNAI-M-FIRST-NAME>{
			concat(
				substring(
				fn:replace(normalize-space(concat($creacionClienteTarjetaCredito/FIRST_NAME, ' ', $creacionClienteTarjetaCredito/SECOND_NAME)), "[Ññ]", "#"),
				1,
				18
				),
				','
			)
			}</AZXNAI-M-FIRST-NAME>
            <AZXNAI-M-SUFFIX/>
			<AZXNAI-M-COUNTY>{ valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/HOME_MUNICIPALITY/text()), 'VISION+', '34', $ptEquivalencias)}</AZXNAI-M-COUNTY>
            {
	            let $FLYER_TYPE := string($creacionClienteTarjetaCredito/FLYER_TYPE/text())
				let $FREQUENT_FLYEER := string($creacionClienteTarjetaCredito/FREQUENT_FLYEER/text())
				return(
						if ($FLYER_TYPE != "AA") then (
				            <AZXNAI-M-FF-NUMBER/>
				       ) else (
				            <AZXNAI-M-FF-NUMBER>{ data($FREQUENT_FLYEER) }</AZXNAI-M-FF-NUMBER>
				       )
				     )
			 }
			<AZXNAI-M-FILLER/>
			<AZXNAI-M-STMT-MSG-2-IND>1</AZXNAI-M-STMT-MSG-2-IND>
			<AZXNAI-M-ADDR-2-INDIC>B</AZXNAI-M-ADDR-2-INDIC>
			<AZXNAI-M-ADDR-3-INDIC>O</AZXNAI-M-ADDR-3-INDIC>
            <AZXNAI-M-ADDR-2-LINE-1/>
            <AZXNAI-M-ADDR-2-LINE-2/>
            <AZXNAI-M-ADDR-2-LINE-3/>
            <AZXNAI-M-CITY-2/>
            <AZXNAI-M-PSTL-CD-2/>
            <AZXNAI-M-CNTRY-CD-2>NIC</AZXNAI-M-CNTRY-CD-2>
            <AZXNAI-M-ADDR-3-LINE-1/>
            <AZXNAI-M-ADDR-3-LINE-2/>
            <AZXNAI-M-ADDR-3-LINE-3/>
            <AZXNAI-M-CITY-3/>
            <AZXNAI-M-PSTL-CD-3/>
            <AZXNAI-M-CNTRY-CD-3>NIC</AZXNAI-M-CNTRY-CD-3>
            <AZXNAI-M-USER-DATE-3>{ fn:adjust-date-to-timezone(current-date(),()) }</AZXNAI-M-USER-DATE-3>
            <AZXNAI-M-INCOME>0</AZXNAI-M-INCOME>
            <AZXNAI-M-CUIT>0</AZXNAI-M-CUIT>
            <AZXNAI-M-OCC-CODE>0</AZXNAI-M-OCC-CODE>
            <AZXNAI-M-IVA-POS>0</AZXNAI-M-IVA-POS>
			<AZXNAI-C-TITLE/>
			<AZXNAI-C-MARITAL-STATUS>0</AZXNAI-C-MARITAL-STATUS>
			<AZXNAI-C-NAME-LINE-1/>
            <AZXNAI-C-NAME-TYPE-IND-1>0</AZXNAI-C-NAME-TYPE-IND-1>
            <AZXNAI-C-NAME-LINE-2/>
            <AZXNAI-C-NAME-TYPE-IND-2>0</AZXNAI-C-NAME-TYPE-IND-2>
            <AZXNAI-C-NAME-LINE-3/>
            <AZXNAI-C-NAME-TYPE-IND-3>0</AZXNAI-C-NAME-TYPE-IND-3>
            <AZXNAI-C-HOUSE-NBR/>
            <AZXNAI-C-HOUSE-NAME/>
            <AZXNAI-C-ADDR-1>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_TYPE1)}</AZXNAI-C-ADDR-1>
			<AZXNAI-C-ADDR-2>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_PHONE1)}</AZXNAI-C-ADDR-2>
			<AZXNAI-C-ADDR-3>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_TYPE2)}</AZXNAI-C-ADDR-3>
			<AZXNAI-C-ADDR-4>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_PHONE2)}</AZXNAI-C-ADDR-4>
			<AZXNAI-C-CITY/>
			<AZXNAI-C-STATE/>
			<AZXNAI-C-PSTL-CD/>
			<AZXNAI-C-CNTRY-CD>{ data($creacionClienteTarjetaCredito/COUNTRY_OF_BIRTH)}</AZXNAI-C-CNTRY-CD>             
            <AZXNAI-C-OWN-RENT-RESID-FLAG>1</AZXNAI-C-OWN-RENT-RESID-FLAG>
            <AZXNAI-C-1099C-FOREIGN-IND/>
			<AZXNAI-C-LANGUAGE-IND/>
			<AZXNAI-C-MAILING-LIST/>
            <AZXNAI-C-CONTACT-IND>0</AZXNAI-C-CONTACT-IND>
            <AZXNAI-C-GENDER-CODE>0</AZXNAI-C-GENDER-CODE>
            <AZXNAI-C-CR-1-2/>
            <AZXNAI-C-CR-3-4>01</AZXNAI-C-CR-3-4>
            <AZXNAI-C-HOME-PHONE/>
			<AZXNAI-C-FAX-PHONE/>
			<AZXNAI-C-MOBILE-PHONE>{ data($creacionClienteTarjetaCredito/SPOUSE_PHONE)}</AZXNAI-C-MOBILE-PHONE>
            <AZXNAI-C-DOB>
            	{ 
            		if(data($creacionClienteTarjetaCredito/DATE_OF_BIRTH_SPOUSE) != '') then(
            			fn-bea:date-to-string-with-format('yyyyDDD', data($creacionClienteTarjetaCredito/DATE_OF_BIRTH_SPOUSE))
            		)else(0000000) 
            	}
            </AZXNAI-C-DOB>
            <AZXNAI-C-DL-NBR/>
			<AZXNAI-C-DL-STATE/>
			<AZXNAI-C-DL-CNTRY/>
            <AZXNAI-C-SSAN-FLAG>
            {  
               if(data($creacionClienteTarjetaCredito/SPOUSE_ID_TYPE) != '') then (
               
                 valorCatalogoOSBToAPP(string($creacionClienteTarjetaCredito/SPOUSE_ID_TYPE/text()), 'VISION+', '4', $ptEquivalencias)
                 
            ) else(0)
            }
            </AZXNAI-C-SSAN-FLAG>
            <AZXNAI-C-SSAN>{ data($creacionClienteTarjetaCredito/SPOUSE_ID)}</AZXNAI-C-SSAN>
            <AZXNAI-C-1099C-W9-DATE-FILED>2000-01-01</AZXNAI-C-1099C-W9-DATE-FILED>
            <AZXNAI-C-STMT-MSG-INDIC>0</AZXNAI-C-STMT-MSG-INDIC>
            <AZXNAI-C-EMPLOYER/>
			<AZXNAI-C-EMPLOYER-ADDR-1/>
			<AZXNAI-C-EMPLOYER-ADDR-2/>
			<AZXNAI-C-EMP-PHONE/>
			<AZXNAI-C-EMP-PHONE-EXTN/>
            <AZXNAI-C-PHONE-FLAG>0</AZXNAI-C-PHONE-FLAG>
            <AZXNAI-C-POSITION>{ data($creacionClienteTarjetaCredito/CLIENT_ECONOMIC_ACTIVITY)}</AZXNAI-C-POSITION>
			<AZXNAI-C-RELATIVE-NAME/>
            <AZXNAI-C-NBR-OF-DEPENDENTS>011</AZXNAI-C-NBR-OF-DEPENDENTS>
            <AZXNAI-C-EMAIL>{ data($creacionClienteTarjetaCredito/ALTERNATE_CLIENT_EMAIL)}</AZXNAI-C-EMAIL>
			<AZXNAI-C-MEMO-1>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_NAME1)}</AZXNAI-C-MEMO-1>
			<AZXNAI-C-MEMO-2>{ data($creacionClienteTarjetaCredito/PERSONAL_REFERENCE_NAME2)}</AZXNAI-C-MEMO-2>
			<AZXNAI-C-USER-1/>
			<AZXNAI-C-USER-2/>
			<AZXNAI-C-USER-3/>
			<AZXNAI-C-USER-4/>
			<AZXNAI-C-USER-5/>
			<AZXNAI-C-USER-6/>
			<AZXNAI-C-USER-7/>
			<AZXNAI-C-USER-8/>
			<AZXNAI-C-USER-9/>
            <AZXNAI-C-USER-10>0</AZXNAI-C-USER-10>
            <AZXNAI-C-USER-11>0</AZXNAI-C-USER-11>
            <AZXNAI-C-USER-12/>
			<AZXNAI-C-USER-13/>
			<AZXNAI-C-USER-14/>
			<AZXNAI-C-USER-15/>
			<AZXNAI-C-USER-DEMO-1/>
			<AZXNAI-C-USER-DEMO-2/>
			<AZXNAI-C-USER-DEMO-3/>
            <AZXNAI-C-HOME-PHONE-FLAG>0</AZXNAI-C-HOME-PHONE-FLAG>
            <AZXNAI-C-FAX-PHONE-FLAG>0</AZXNAI-C-FAX-PHONE-FLAG>
            <AZXNAI-C-MOBILE-PHONE-FLAG>0</AZXNAI-C-MOBILE-PHONE-FLAG>
            <AZXNAI-C-EMAIL-FLAG>0</AZXNAI-C-EMAIL-FLAG>
            <AZXNAI-C-SMS-FLAG>0</AZXNAI-C-SMS-FLAG>
            <AZXNAI-C-LAST-NAME>{ substring(normalize-space(data($creacionClienteTarjetaCredito/SURNAMES_SPOUSE)),1,40) }</AZXNAI-C-LAST-NAME>
			<AZXNAI-C-MIDDLE-NAME/>
			<AZXNAI-C-FIRST-NAME>
			{  
               if(data($creacionClienteTarjetaCredito/NAMES_SPOUSE) != '') then (
               
                 concat(substring(normalize-space(data($creacionClienteTarjetaCredito/NAMES_SPOUSE)),1,40),',')
                 
            ) else()
            }
			</AZXNAI-C-FIRST-NAME>
			<AZXNAI-C-SUFFIX/>
			<AZXNAI-C-COUNTY/>
			<AZXNAI-C-FF-NUMBER/>
            <AZXNAI-C-FILLER/>
            <AZXNAI-C-STMT-MSG-2-IND>0</AZXNAI-C-STMT-MSG-2-IND>
            <AZXNAI-C-ADDR-2-INDIC>0</AZXNAI-C-ADDR-2-INDIC>
            <AZXNAI-C-ADDR-3-INDIC>0</AZXNAI-C-ADDR-3-INDIC>
            <AZXNAI-C-ADDR-2-LINE-1/>
            <AZXNAI-C-ADDR-2-LINE-2/>
            <AZXNAI-C-ADDR-2-LINE-3/>
            <AZXNAI-C-CITY-2/>
            <AZXNAI-C-PSTL-CD-2/>
            <AZXNAI-C-CNTRY-CD-2/>
            <AZXNAI-C-ADDR-3-LINE-1/>
            <AZXNAI-C-ADDR-3-LINE-2/>
            <AZXNAI-C-ADDR-3-LINE-3/>
            <AZXNAI-C-CITY-3/>
            <AZXNAI-C-PSTL-CD-3/>
            <AZXNAI-C-CNTRY-CD-3/>
            <AZXNAI-C-USER-DATE-3>{ fn:adjust-date-to-timezone(current-date(),()) }</AZXNAI-C-USER-DATE-3>
            <AZXNAI-C-INCOME>0</AZXNAI-C-INCOME>
            <AZXNAI-C-CUIT>0</AZXNAI-C-CUIT>
            <AZXNAI-C-OCC-CODE>0</AZXNAI-C-OCC-CODE>
            <AZXNAI-C-IVA-POS>0</AZXNAI-C-IVA-POS>
			<AZXNAI-RESV-CODE-1/>
			<AZXNAI-RESV-CODE-2/>
			<AZXNAI-RESV-CODE-3/>
			<AZXNAI-RESV-CODE-4/>
			<AZXNAI-RESV-CODE-5/>
            <AZXNAI-RESV-DATE-1>2000-01-01</AZXNAI-RESV-DATE-1>
            <AZXNAI-RESV-DATE-2>2000-01-01</AZXNAI-RESV-DATE-2>
            <AZXNAI-RESV-DATE-3>2000-01-01</AZXNAI-RESV-DATE-3>
            <AZXNAI-RESV-DATE-4>2000-01-01</AZXNAI-RESV-DATE-4>
            <AZXNAI-RESV-DATE-5>2000-01-01</AZXNAI-RESV-DATE-5>
            <AZXNAI-RESV-AMT-1>0</AZXNAI-RESV-AMT-1>
            <AZXNAI-RESV-AMT-2>0</AZXNAI-RESV-AMT-2>
            <AZXNAI-RESV-AMT-3>0</AZXNAI-RESV-AMT-3>
            <AZXNAI-RESV-AMT-4>0</AZXNAI-RESV-AMT-4>
            <AZXNAI-RESV-AMT-5>0</AZXNAI-RESV-AMT-5>
        </ns0:CustomerAddL8V2Request>
};

declare variable $creacionClienteTarjetaCredito as element(ns1:creacionClienteTarjetaCredito) external;
declare variable $customerId as xs:string external;
declare variable $ptEquivalencias as element() external;

xf:customerAddL8V2In($creacionClienteTarjetaCredito,
    $customerId,
    $ptEquivalencias)