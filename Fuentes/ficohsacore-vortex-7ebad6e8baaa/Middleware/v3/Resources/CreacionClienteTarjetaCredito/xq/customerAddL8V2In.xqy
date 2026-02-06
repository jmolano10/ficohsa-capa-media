xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creacionClienteTarjetaCredito" element="ns1:creacionClienteTarjetaCredito" location="../xsd/creacionClienteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CustomerAddL8V2Request" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$ptEquivalencias" type="ns2:TEQUIVALENCIA_CATALOGO" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creacionClienteTarjetaCreditoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/CreacionClienteTarjetaCredito/xq/customerAddL8V2In/";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";

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
    $codigoCliente as xs:string, 
    $ptEquivalencias as element())
    as element(ns0:CustomerAddL8V2Request) {
        <ns0:CustomerAddL8V2Request>
            <AZXNAI-LOCAL-ACCT-ORG>{ data($creacionClienteTarjetaCredito/ORG) }</AZXNAI-LOCAL-ACCT-ORG>
            <AZXNAI-CUST-NBR>{ fn-bea:pad-left($codigoCliente, 19, '0') }</AZXNAI-CUST-NBR>
            <AZXNAI-BS-ACCT/>
            {
            	let $MAKER_INDICATOR := string($creacionClienteTarjetaCredito/MAKER_INDICATOR/text())
            	return(
            		if($MAKER_INDICATOR != '')then(
            			<AZXNAI-NA-COMAKER-IND>{ data($MAKER_INDICATOR) }</AZXNAI-NA-COMAKER-IND>
            		)else(
            			<AZXNAI-NA-COMAKER-IND/>
            		)
            	)
            }
            {
            	let $DOUBLE_CURRENCY_INDICATOR := string($creacionClienteTarjetaCredito/DOUBLE_CURRENCY_INDICATOR/text())
            	return(
            		if($DOUBLE_CURRENCY_INDICATOR != '')then(
            			<AZXNAI-DUAL-FLAG>{ data($DOUBLE_CURRENCY_INDICATOR) }</AZXNAI-DUAL-FLAG>
            		)else(
            			<AZXNAI-DUAL-FLAG/>
            		)
            	)
            }           
            <AZXNAI-COMAKER-FILLER/>
            {
            	let $VIP_CLIENT_INDICATOR := string($creacionClienteTarjetaCredito/VIP_CLIENT_INDICATOR/text())
	            return(
		            if($VIP_CLIENT_INDICATOR  != "")then(
		            	<AZXNAI-VIP-STATUS>{ data($VIP_CLIENT_INDICATOR) }</AZXNAI-VIP-STATUS>
		            )else(
		            	<AZXNAI-VIP-STATUS/>	            	
		            )
	            )
            }
            <AZXNAI-SIC-CODE>0</AZXNAI-SIC-CODE>
            <AZXNAI-STATUS>0</AZXNAI-STATUS>
            <AZXNAI-MISC-FILLER/>
            <AZXNAI-M-TITLE/>
            {
            	let $MARITAL_STATUS := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/MARITAL_STATUS/text())
	            return(
		            if($MARITAL_STATUS  != "")then(
		            	<AZXNAI-M-MARITAL-STATUS>{ valorCatalogoOSBToAPP($MARITAL_STATUS, 'VISION+PA', '2', $ptEquivalencias) }</AZXNAI-M-MARITAL-STATUS>    	
		            )else(
		            	<AZXNAI-M-MARITAL-STATUS/>	            	
		            )
	            )
            }
            <AZXNAI-M-NAME-LINE-1>PRINCIPAL</AZXNAI-M-NAME-LINE-1>
            <AZXNAI-M-NAME-TYPE-IND-1>0</AZXNAI-M-NAME-TYPE-IND-1>
            <AZXNAI-M-NAME-LINE-2/>
            <AZXNAI-M-NAME-TYPE-IND-2>0</AZXNAI-M-NAME-TYPE-IND-2>
            <AZXNAI-M-NAME-LINE-3/>
            <AZXNAI-M-NAME-TYPE-IND-3>0</AZXNAI-M-NAME-TYPE-IND-3>
            {
	            let $rowResidencia := ($creacionClienteTarjetaCredito/ns1:CUSTOMER_ADDRESSES/ns1:CUSTOMER_ADDRESS[ADDRESS_TYPE_CODE/text() = '1'])[1]
	            let $rowTrabajo := ($creacionClienteTarjetaCredito/ns1:CUSTOMER_ADDRESSES/ns1:CUSTOMER_ADDRESS[ADDRESS_TYPE_CODE/text() = '2'])[1]
	            let $rowCorrespondencia := ($creacionClienteTarjetaCredito/ns1:CUSTOMER_ADDRESSES/ns1:CUSTOMER_ADDRESS[ADDRESS_TYPE_CODE/text() = '5'])[1]
	            return(       
	            	let $HOUSE_NUMBER := string($rowResidencia/HOUSE_NUMBER/text())
		            return(
			            if($HOUSE_NUMBER  != "")then(
			            	<AZXNAI-M-HOUSE-NBR>{ data($HOUSE_NUMBER) }</AZXNAI-M-HOUSE-NBR>
			            )else(
			            	<AZXNAI-M-HOUSE-NBR/>	            	
			            )
		            ),
	            	let $COLONY := string($rowResidencia/COLONY/text())
		            return(
			            if($COLONY  != "")then(
			            	 <AZXNAI-M-HOUSE-NAME>{ data($COLONY) }</AZXNAI-M-HOUSE-NAME>
			            )else(
			            	<AZXNAI-M-HOUSE-NAME/>	            	
			            )
		            ),
	            	let $REFERENCE := string($rowResidencia/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-1>{ fn:substring($REFERENCE, 1, 40) }</AZXNAI-M-ADDR-1>
			            )else(
			            	<AZXNAI-M-ADDR-1/>	            	
			            )
		            ),
	            	let $REFERENCE := string($rowResidencia/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-2>{ fn:substring($REFERENCE, 41, 40) }</AZXNAI-M-ADDR-2>
			            )else(
			            	<AZXNAI-M-ADDR-2/>	            	
			            )
		            ),
	            	let $REFERENCE := string($rowResidencia/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-3>{ fn:substring($REFERENCE, 81, 40) }</AZXNAI-M-ADDR-3>
			            )else(
			            	<AZXNAI-M-ADDR-3/>	            	
			            )
		            ),
	            	let $REFERENCE := string($rowResidencia/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-4>{ fn:substring($REFERENCE, 121, 40) }</AZXNAI-M-ADDR-4>
			            )else(
			            	<AZXNAI-M-ADDR-4/>	            	
			            )
		            ),
	            	let $DEPARMENT_CODE := string($rowResidencia/DEPARMENT_CODE/text())
		            return(
			            if($DEPARMENT_CODE  != "")then(
			            	<AZXNAI-M-CITY>{ valorCatalogoOSBToAPP($DEPARMENT_CODE, 'VISION+PA', '8', $ptEquivalencias) }</AZXNAI-M-CITY>,
			            	<AZXNAI-M-STATE/>
			            )else(
			            	<AZXNAI-M-CITY/>
			            )
		            ),
	            	let $MUNICIPALITY_CODE := string($rowResidencia/MUNICIPALITY_CODE/text())
		            return(
			            if($MUNICIPALITY_CODE  != "")then(
			            	<AZXNAI-M-PSTL-CD>{ valorCatalogoOSBToAPP($MUNICIPALITY_CODE, 'VISION+PA', '7', $ptEquivalencias) }</AZXNAI-M-PSTL-CD>
			            )else(
			            	<AZXNAI-M-PSTL-CD/>	            	
			            )
		            ),
	            	let $COUNTRY_CODE := string($rowResidencia/COUNTRY_CODE/text())
		            return(
			            if($COUNTRY_CODE  != "")then(
			            	<AZXNAI-M-CNTRY-CD>{ valorCatalogoOSBToAPP($COUNTRY_CODE, 'VISION+PA', '9', $ptEquivalencias) }</AZXNAI-M-CNTRY-CD>
			            )else(
			            	<AZXNAI-M-CNTRY-CD/>	            	
			            )
		            ),
	            	let $RESIDENCE_TYPE := string($creacionClienteTarjetaCredito/RESIDENCE_TYPE/text())
		            return(
			            if($RESIDENCE_TYPE  != "")then(
			            	<AZXNAI-M-OWN-RENT-RESIDFLAG>{ data($RESIDENCE_TYPE) }</AZXNAI-M-OWN-RENT-RESIDFLAG>
			            )else(
			            	<AZXNAI-M-OWN-RENT-RESIDFLAG/>	            	
			            )
		            ),           
		            <AZXNAI-M-1099C-FOREIGN-IND/>,
		            <AZXNAI-M-LANGUAGE-IND>ESP</AZXNAI-M-LANGUAGE-IND>,
		            <AZXNAI-M-MAILING-LIST>E</AZXNAI-M-MAILING-LIST>,
		            <AZXNAI-M-CONTACT-IND>0</AZXNAI-M-CONTACT-IND>,
					let $GENDER := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/GENDER/text())
					return(
						<AZXNAI-M-GENDER-CODE>{ valorCatalogoOSBToAPP($GENDER, 'VISION+PA', '1', $ptEquivalencias) }</AZXNAI-M-GENDER-CODE>
					), 
		            <AZXNAI-M-CR-1-2>01</AZXNAI-M-CR-1-2>,
		            <AZXNAI-M-CR-3-4>01</AZXNAI-M-CR-3-4>,
	            	let $PHONES := string($rowResidencia/PHONES/text())
		        	return(		        			           			        
			        	if($PHONES  != "")then(			           
				        	<AZXNAI-M-HOME-PHONE>{ data($PHONES) }</AZXNAI-M-HOME-PHONE>			            	
				         )else(
				            <AZXNAI-M-HOME-PHONE/>	            	
				         )				 	  
			     	),
			     	let $FAX := string($rowResidencia/FAX/text())
		        	return(		        			        
			            if($FAX  != "")then(
			            	<AZXNAI-M-FAX-PHONE>{ data($FAX) }</AZXNAI-M-FAX-PHONE>
			            )else(
			            	<AZXNAI-M-FAX-PHONE/>	            	
			            )
		         	
		         	),
		         	let $PHONE_MOBILE := string($rowResidencia/PHONE_MOBILE/text())
			        return(
			        	
				            if($PHONE_MOBILE  != "")then(
				            	<AZXNAI-M-MOBILE-PHONE>{ data($PHONE_MOBILE) }</AZXNAI-M-MOBILE-PHONE>
				            )else(
				            	<AZXNAI-M-MOBILE-PHONE/>	            	
				            )
				       	
			        ),
			        let $DATE_OF_BIRTH := $creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/DATE_OF_BIRTH
		            return(
			            if(string($DATE_OF_BIRTH/text())  != "")then(
			            	 <AZXNAI-M-DOB>{ fn-bea:date-to-string-with-format("yyyyDDD", data($DATE_OF_BIRTH)) }</AZXNAI-M-DOB>
			            )else(
			            	<AZXNAI-M-DOB/>	            	
			            )
		            ),	           	
	            	let $DRIVERS_LICENCE := string($creacionClienteTarjetaCredito/DRIVERS_LICENCE/text())
		            return(
			            if($DRIVERS_LICENCE  != "")then(
			            	 <AZXNAI-M-DL-NBR>{ data($DRIVERS_LICENCE) }</AZXNAI-M-DL-NBR>
			            )else(
			            	<AZXNAI-M-DL-NBR/>	            	
			            )
		            ),	                       
	            	<AZXNAI-M-DL-STATE/>,	            
	            	let $COUNTRY_OF_ISSUE_DOCUMENT := string($creacionClienteTarjetaCredito/COUNTRY_OF_ISSUE_DOCUMENT/text())
		            return(
			            if($COUNTRY_OF_ISSUE_DOCUMENT  != "")then(
			            	<AZXNAI-M-DL-CNTRY>{ data($COUNTRY_OF_ISSUE_DOCUMENT) }</AZXNAI-M-DL-CNTRY>
			            )else(
			            	<AZXNAI-M-DL-CNTRY/>	            	
			            )
		            ),
					let $IDENTIFICATION_TYPE := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/IDENTIFICATION_TYPE/text())
					return(
						<AZXNAI-M-SSAN-FLAG>{ valorCatalogoOSBToAPP($IDENTIFICATION_TYPE, 'VISION+PA', '4', $ptEquivalencias) }</AZXNAI-M-SSAN-FLAG>
					),	            			
				    <AZXNAI-M-SSAN>{ data($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/IDENTIFICATION_NUMBER) }</AZXNAI-M-SSAN>,           
		            <AZXNAI-M-1099C-W9-DATE-FILED>2000-01-01</AZXNAI-M-1099C-W9-DATE-FILED>,
		            <AZXNAI-M-STMT-MSG-INDIC>0</AZXNAI-M-STMT-MSG-INDIC>,	      
	            	let $COMPANY_NAME := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_TYPE_OF_EMPLOYMENTS/ns1:CUSTOMER_TYPE_OF_EMPLOYMENT/COMPANY_NAME/text())
		            return(
			            if($COMPANY_NAME  != "")then(
			            	<AZXNAI-M-EMPLOYER>{ data($COMPANY_NAME) }</AZXNAI-M-EMPLOYER>
			            )else(
			            	<AZXNAI-M-EMPLOYER/>	            	
			            )
		            ),	                      
		            <AZXNAI-M-EMPLOYER-ADDR-1/>,
		            <AZXNAI-M-EMPLOYER-ADDR-2/>,
	            	let $PHONES := string($rowTrabajo/PHONES/text())
		            return(
			            if($PHONES  != "")then(
			            	<AZXNAI-M-EMP-PHONE>{ data($PHONES) }</AZXNAI-M-EMP-PHONE>
			            )else(
			            	<AZXNAI-M-EMP-PHONE/>	            	
			            )
		            ),
	            	let $EXT := string($rowTrabajo/EXT/text())
		            return(
			            if($EXT  != "")then(
			            	<AZXNAI-M-EMP-PHONE-EXTN>{ data($EXT) }</AZXNAI-M-EMP-PHONE-EXTN>
			            )else(
			            	<AZXNAI-M-EMP-PHONE-EXTN/>	            	
			            )
		            ),                    
	            	<AZXNAI-M-PHONE-FLAG>0</AZXNAI-M-PHONE-FLAG>,
	            
	            	let $PROFESSION_CODE := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/PROFESSION_CODE/text())
		            return(
			            if($PROFESSION_CODE  != "")then(
			            	<AZXNAI-M-POSITION>{ valorCatalogoOSBToAPP($PROFESSION_CODE, 'VISION+PA', '3', $ptEquivalencias) }</AZXNAI-M-POSITION>
			            )else(
			            	<AZXNAI-M-POSITION/>	            	
			            )
		            ),
	            	let $SPOUSE_NAME := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/SPOUSE_NAME/text())
		            return(
			            if($SPOUSE_NAME  != "")then(
			            	<AZXNAI-M-RELATIVE-NAME>{ data($SPOUSE_NAME) }</AZXNAI-M-RELATIVE-NAME>
			            )else(
			            	<AZXNAI-M-RELATIVE-NAME/>	            	
			            )
		            ),
	            	let $CHILDREN_NUMBERS := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/CHILDREN_NUMBERS/text())
		            return(
			            if($CHILDREN_NUMBERS  != "")then(
			            	<AZXNAI-M-NBR-OF-DEPENDENTS>{ data($CHILDREN_NUMBERS) }</AZXNAI-M-NBR-OF-DEPENDENTS>
			            )else(
			            	<AZXNAI-M-NBR-OF-DEPENDENTS/>	            	
			            )
		            ),
	            	let $EMAIL := string($rowTrabajo/EMAIL/text())
		            return(
			            if($EMAIL  != "")then(
			            	<AZXNAI-M-EMAIL>{ data($EMAIL) }</AZXNAI-M-EMAIL>
			            )else(
			            	<AZXNAI-M-EMAIL/>	            	
			            )
		            ),
	            	let $CHANNEL_CODE := string($creacionClienteTarjetaCredito/ns1:LIST_OF_CHANNELS/ns1:CHANNEL[1]/CHANNEL_CODE/text())
		            return(
			            if($CHANNEL_CODE  != "")then(
			            	<AZXNAI-M-MEMO-1>{ data($CHANNEL_CODE) }</AZXNAI-M-MEMO-1>
			            )else(
			            	<AZXNAI-M-MEMO-1/>	            	
			            )
		            ),
	            	let $CHANNEL_CODE := string($creacionClienteTarjetaCredito/ns1:LIST_OF_CHANNELS/ns1:CHANNEL[2]/CHANNEL_CODE/text())
		            return(
			            if($CHANNEL_CODE  != "")then(
			            	<AZXNAI-M-MEMO-2>{ data($CHANNEL_CODE) }</AZXNAI-M-MEMO-2>
			            )else(
			            	<AZXNAI-M-MEMO-2/>	            	
			            )
		            ),
	            	let $EMPLOYMENT_YEARS := string($creacionClienteTarjetaCredito/EMPLOYMENT_YEARS/text())
		            return(
			            if($EMPLOYMENT_YEARS  != "")then(
			            	<AZXNAI-M-USER-1>{ data($EMPLOYMENT_YEARS) }</AZXNAI-M-USER-1>
			            )else(
			            	<AZXNAI-M-USER-1/>	            	
			            )
		            ),
	            	let $EMPLOYMENT_MONTHS := string($creacionClienteTarjetaCredito/EMPLOYMENT_MONTHS/text())
		            return(
			            if($EMPLOYMENT_MONTHS  != "")then(
			            	<AZXNAI-M-USER-2>{ data($EMPLOYMENT_MONTHS) }</AZXNAI-M-USER-2>
			            )else(
			            	<AZXNAI-M-USER-2/>	            	
			            )
		            ),
	            	let $codeOcupacion := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/CODE_OCUPACION/text())
		            return(
			            if($codeOcupacion  != "")then(
			            	<AZXNAI-M-USER-3>{ valorCatalogoOSBToAPP($codeOcupacion, 'VISION+PA', '23', $ptEquivalencias) }</AZXNAI-M-USER-3>
			            )else(
			            	<AZXNAI-M-USER-3/>	            	
			            )
		            ),
		            <AZXNAI-M-USER-4/>,
		            <AZXNAI-M-USER-5/>,
		            <AZXNAI-M-USER-6/>,
	            	let $SEGMENT_CODE := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/SEGMENT_CODE/POSITION/text())
		            return(
			            if($SEGMENT_CODE  != "")then(
			            	<AZXNAI-M-USER-7>{ data($SEGMENT_CODE) }</AZXNAI-M-USER-7>
			            )else(
			            	<AZXNAI-M-USER-7/>	            	
			            )
		            ),
	            	let $PEPS := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/PEPS/text())
		            return(
			            if($PEPS  != "")then(
			            	<AZXNAI-M-USER-8>{ data($PEPS) }</AZXNAI-M-USER-8>
			            )else(
			            	<AZXNAI-M-USER-8/>	            	
			            )
		            ),          
	            	<AZXNAI-M-USER-9/>,
	            	let $EXPIRATION_DATE := $creacionClienteTarjetaCredito/EXPIRATION_DATE
		            return(
			            if(string($EXPIRATION_DATE/text())  != "")then(
			            	<AZXNAI-M-USER-10>{ fn-bea:date-to-string-with-format("yyyyDDD", data($EXPIRATION_DATE)) }</AZXNAI-M-USER-10>
			            )else(
			            	<AZXNAI-M-USER-10/>	            	
			            )
		            ),
	            	let $ISSUE_DATE := $creacionClienteTarjetaCredito/ISSUE_DATE
		            return(
			            if(string($ISSUE_DATE/text())  != "")then(
			            	<AZXNAI-M-USER-11>{ fn-bea:date-to-string-with-format("yyyyDDD", data($ISSUE_DATE)) }</AZXNAI-M-USER-11>
			            )else(
			            	<AZXNAI-M-USER-11/>	            	
			            )
		            ),
	            	let $COUNTRY_OF_ISSUE_PASSAPORT := string($creacionClienteTarjetaCredito/COUNTRY_OF_ISSUE_PASSAPORT/text())
		            return(
			            if($COUNTRY_OF_ISSUE_PASSAPORT  != "")then(
			            	<AZXNAI-M-USER-12>{ data($COUNTRY_OF_ISSUE_PASSAPORT) }</AZXNAI-M-USER-12>
			            )else(
			            	<AZXNAI-M-USER-12/>	            	
			            )
		            ),           
	            	<AZXNAI-M-USER-13/>,
	            	let $EDUCATION_LEVEL := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/EDUCATION_LEVEL/text())
		            return(
			            if($EDUCATION_LEVEL  != "")then(
			            	<AZXNAI-M-USER-14>{ data($EDUCATION_LEVEL) }</AZXNAI-M-USER-14>
			            )else(
			            	<AZXNAI-M-USER-14/>	            	
			            )
		            ),
	            	let $INCOMES := string($creacionClienteTarjetaCredito/INCOMES/text())
		            return(
			            if($INCOMES  != "")then(
			            	<AZXNAI-M-USER-15>{ data($INCOMES) }</AZXNAI-M-USER-15>
			            )else(
			            	<AZXNAI-M-USER-15/>	            	
			            )
		            ),
	            	let $OTHERS_INCOMES := string($creacionClienteTarjetaCredito/OTHERS_INCOMES/text())
		            return(
			            if($OTHERS_INCOMES  != "")then(
			            	<AZXNAI-M-USER-DEMO-1>{ data($OTHERS_INCOMES) }</AZXNAI-M-USER-DEMO-1>
			            )else(
			            	<AZXNAI-M-USER-DEMO-1/>	            	
			            )
		            ),
	            	let $COUNTRY_CODE := string($creacionClienteTarjetaCredito/ns1:CUSTOMER_ADDRESS/COUNTRY_CODE/text())
		            return(
			            if($COUNTRY_CODE  != "")then(
			            	<AZXNAI-M-USER-DEMO-2>{ valorCatalogoOSBToAPP($COUNTRY_CODE, 'VISION+PA', '9', $ptEquivalencias) }</AZXNAI-M-USER-DEMO-2>
			            )else(
			            	<AZXNAI-M-USER-DEMO-2/>	            	
			            )
		            ),             
		            <AZXNAI-M-USER-DEMO-3/>,
		            <AZXNAI-M-HOME-PHONE-FLAG>0</AZXNAI-M-HOME-PHONE-FLAG>,
		            <AZXNAI-M-FAX-PHONE-FLAG>0</AZXNAI-M-FAX-PHONE-FLAG>,
		            <AZXNAI-M-MOBILE-PHONE-FLAG>0</AZXNAI-M-MOBILE-PHONE-FLAG>,
		            <AZXNAI-M-EMAIL-FLAG>0</AZXNAI-M-EMAIL-FLAG>,
		            <AZXNAI-M-SMS-FLAG>0</AZXNAI-M-SMS-FLAG>,
		            <AZXNAI-M-LAST-NAME>{ concat(data($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/FIRST_SURNAME)," ",data($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/SECOND_SURNAME)) }</AZXNAI-M-LAST-NAME>,
		            <AZXNAI-M-MIDDLE-NAME/>,
		            <AZXNAI-M-FIRST-NAME>{ data($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/NAMES) }</AZXNAI-M-FIRST-NAME>,
		            <AZXNAI-M-SUFFIX/>,
		            <AZXNAI-M-COUNTY/>,
		            <AZXNAI-M-FF-NUMBER/>,
		            <AZXNAI-M-FILLER/>,
		            <AZXNAI-M-STMT-MSG-2-IND>1</AZXNAI-M-STMT-MSG-2-IND>,
		            <AZXNAI-M-ADDR-2-INDIC>B</AZXNAI-M-ADDR-2-INDIC>,
		            <AZXNAI-M-ADDR-3-INDIC>O</AZXNAI-M-ADDR-3-INDIC>,
	            	let $REFERENCE := string($rowTrabajo/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-2-LINE-1>{ fn:substring($REFERENCE, 1, 40) }</AZXNAI-M-ADDR-2-LINE-1>
			            )else(
			            	<AZXNAI-M-ADDR-2-LINE-1/>	            	
			            )
		            ),
	            	let $REFERENCE := string($rowTrabajo/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-2-LINE-2>{ fn:substring($REFERENCE, 41, 40) }</AZXNAI-M-ADDR-2-LINE-2>
			            )else(
			            	<AZXNAI-M-ADDR-2-LINE-2/>	            	
			            )
		            ),
	            	let $REFERENCE := string($rowTrabajo/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-2-LINE-3>{ fn:substring($REFERENCE, 81, 40) }</AZXNAI-M-ADDR-2-LINE-3>
			            )else(
			            	<AZXNAI-M-ADDR-2-LINE-3/>	            	
			            )
		            ),
	            	let $DEPARMENT_CODE := string($rowTrabajo/DEPARMENT_CODE/text())
		            return(
			            if($DEPARMENT_CODE  != "")then(
			            	<AZXNAI-M-CITY-2>{ valorCatalogoOSBToAPP($DEPARMENT_CODE, 'VISION+PA', '8', $ptEquivalencias) }</AZXNAI-M-CITY-2>
			            )else(
			            	<AZXNAI-M-CITY-2/>	            	
			            )
		            ),
	            	let $MUNICIPALITY_CODE := string($rowTrabajo/MUNICIPALITY_CODE/text())
		            return(
			            if($MUNICIPALITY_CODE  != "")then(
			            	<AZXNAI-M-PSTL-CD-2>{ valorCatalogoOSBToAPP($MUNICIPALITY_CODE, 'VISION+PA', '7', $ptEquivalencias) }</AZXNAI-M-PSTL-CD-2>
			            )else(
			            	<AZXNAI-M-PSTL-CD-2/>	            	
			            )
		            ),
	            	let $COUNTRY_CODE := string($rowTrabajo/COUNTRY_CODE/text())
		            return(
			            if($COUNTRY_CODE  != "")then(
			            	<AZXNAI-M-CNTRY-CD-2>{ valorCatalogoOSBToAPP($COUNTRY_CODE, 'VISION+PA', '9', $ptEquivalencias) }</AZXNAI-M-CNTRY-CD-2>
			            )else(
			            	<AZXNAI-M-CNTRY-CD-2/>	            	
			            )
		            ),
	            	let $REFERENCE := string($rowCorrespondencia/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-3-LINE-1>{ fn:substring($REFERENCE, 1, 40) }</AZXNAI-M-ADDR-3-LINE-1>
			            )else(
			            	<AZXNAI-M-ADDR-3-LINE-1/>	            	
			            )
		            ),
	            	let $REFERENCE := string($rowCorrespondencia/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-3-LINE-2>{ fn:substring($REFERENCE, 41, 40) }</AZXNAI-M-ADDR-3-LINE-2>
			            )else(
			            	<AZXNAI-M-ADDR-3-LINE-2/>	            	
			            )
		            ),
	            	let $REFERENCE := string($rowCorrespondencia/REFERENCE/text())
		            return(
			            if($REFERENCE  != "")then(
			            	<AZXNAI-M-ADDR-3-LINE-3>{ fn:substring($REFERENCE, 81, 40) }</AZXNAI-M-ADDR-3-LINE-3>
			            )else(
			            	<AZXNAI-M-ADDR-3-LINE-3/>	            	
			            )
		            ),
	            	let $DEPARMENT_CODE := string($rowCorrespondencia/DEPARMENT_CODE/text())
		            return(
			            if($DEPARMENT_CODE  != "")then(
			            	<AZXNAI-M-CITY-3>{ valorCatalogoOSBToAPP($DEPARMENT_CODE, 'VISION+PA', '8', $ptEquivalencias) }</AZXNAI-M-CITY-3>
			            )else(
			            	<AZXNAI-M-CITY-3/>	            	
			            )
		            ),
	            	let $MUNICIPALITY_CODE := string($rowCorrespondencia/MUNICIPALITY_CODE/text())
		            return(
			            if($MUNICIPALITY_CODE  != "")then(
			            	<AZXNAI-M-PSTL-CD-3>{ valorCatalogoOSBToAPP($MUNICIPALITY_CODE, 'VISION+PA', '7', $ptEquivalencias) }</AZXNAI-M-PSTL-CD-3>
			            )else(
			            	<AZXNAI-M-PSTL-CD-3/>	            	
			            )
		            ),
	            	let $COUNTRY_CODE := string($rowCorrespondencia/COUNTRY_CODE/text())
		            return(
			            if($COUNTRY_CODE  != "")then(
			            	<AZXNAI-M-CNTRY-CD-3>{ valorCatalogoOSBToAPP($COUNTRY_CODE, 'VISION+PA', '9', $ptEquivalencias) }</AZXNAI-M-CNTRY-CD-3>
			            )else(
			            	<AZXNAI-M-CNTRY-CD-3/>	            	
			            )
		            )
				)  
            }            
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
            <AZXNAI-C-ADDR-1/>
            <AZXNAI-C-ADDR-2/>
            <AZXNAI-C-ADDR-3/>
            <AZXNAI-C-ADDR-4/>
            <AZXNAI-C-CITY/>
            <AZXNAI-C-STATE/>
            <AZXNAI-C-PSTL-CD/>
            <AZXNAI-C-CNTRY-CD/>
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
            <AZXNAI-C-MOBILE-PHONE/>
            <AZXNAI-C-DOB>0</AZXNAI-C-DOB>
            <AZXNAI-C-DL-NBR/>
            <AZXNAI-C-DL-STATE/>
            <AZXNAI-C-DL-CNTRY/>
            <AZXNAI-C-SSAN-FLAG>0</AZXNAI-C-SSAN-FLAG>
            <AZXNAI-C-SSAN/>
            <AZXNAI-C-1099C-W9-DATE-FILED>2000-01-01</AZXNAI-C-1099C-W9-DATE-FILED>
            <AZXNAI-C-STMT-MSG-INDIC>0</AZXNAI-C-STMT-MSG-INDIC>
            <AZXNAI-C-EMPLOYER/>
            <AZXNAI-C-EMPLOYER-ADDR-1/>
            <AZXNAI-C-EMPLOYER-ADDR-2/>
            <AZXNAI-C-EMP-PHONE/>
            <AZXNAI-C-EMP-PHONE-EXTN/>
            <AZXNAI-C-PHONE-FLAG>0</AZXNAI-C-PHONE-FLAG>
            <AZXNAI-C-POSITION/>
            <AZXNAI-C-RELATIVE-NAME/>
            <AZXNAI-C-NBR-OF-DEPENDENTS>011</AZXNAI-C-NBR-OF-DEPENDENTS>
            <AZXNAI-C-EMAIL/>
            <AZXNAI-C-MEMO-1/>
            <AZXNAI-C-MEMO-2/>
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
            <AZXNAI-C-USER-DEMO-3>{ data($creacionClienteTarjetaCredito/ns1:CUSTOMER_INFO/COUNTRY_ID) }</AZXNAI-C-USER-DEMO-3>
            <AZXNAI-C-HOME-PHONE-FLAG>0</AZXNAI-C-HOME-PHONE-FLAG>
            <AZXNAI-C-FAX-PHONE-FLAG>0</AZXNAI-C-FAX-PHONE-FLAG>
            <AZXNAI-C-MOBILE-PHONE-FLAG>0</AZXNAI-C-MOBILE-PHONE-FLAG>
            <AZXNAI-C-EMAIL-FLAG>0</AZXNAI-C-EMAIL-FLAG>
            <AZXNAI-C-SMS-FLAG>0</AZXNAI-C-SMS-FLAG>
            <AZXNAI-C-LAST-NAME/>
            <AZXNAI-C-MIDDLE-NAME/>
            <AZXNAI-C-FIRST-NAME/>
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
declare variable $codigoCliente as xs:string external;
declare variable $ptEquivalencias as element() external;

xf:customerAddL8V2In($creacionClienteTarjetaCredito,
    $codigoCliente,
    $ptEquivalencias)