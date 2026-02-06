xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$conDatoCliente" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/MasterDataGT/conDatoCliente/xsd/conDatoCliente_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$customerDemographicInquiryL8V2Response" element="ns0:CustomerDemographicInquiryL8V2Response" location="../../../../v2/BusinessServices/VisionPlusGT/vmx/wsdl/VMX.wsdl" ::)
(:: pragma bea:schema-type-parameter parameter="$ptEquivalencias" type="ns3:TEQUIVALENCIA_CATALOGO" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaClienteTarjetasResponse" location="../xsd/consultaClienteTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns4:OutputParameters" location="../../../BusinessServices/consultaClienteTC/xsd/consultaClientesTC_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaClienteTarjetas/xq/consultaClienteTarjetasGTOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClienteTarjetasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCliente";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClientesTC";

declare function valorCatalogoAPPToOSB($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns3:EQUIVALENCIA[ns3:CATALOGO_ID = $catalogoId and 
															  ns3:APLICACION_DESC = $aplicacion and 
															  ns3:EQUIVALENCIA_DESC = $valor]/ns3:VALOR_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:consultaClienteTarjetasGTOut($conDatoCliente as element(ns1:OutputParameters)?,
    $customerDemographicInquiryL8V2Response as element(ns0:CustomerDemographicInquiryL8V2Response)?,
    $ptEquivalencias as element()?,
    $outputParameters1 as element(ns4:OutputParameters)?)
    as element(ns2:consultaClienteTarjetasResponse) {
        <ns2:consultaClienteTarjetasResponse>
        {
        	if(not(empty($outputParameters1/ns4:PT_CLIENTE_TARJETAS/ns4:ORG))) then (	
        		let $clientesTarjetas := $outputParameters1/ns4:PT_CLIENTE_TARJETAS
        		return(
        			<ORG>{ data($clientesTarjetas/ns4:ORG) }</ORG>,
        			<CUSTOMER_ID>{ data($clientesTarjetas/ns4:CUSTOMER_ID) }</CUSTOMER_ID>,
        				let $addresInformationResidence := fn-bea:inlinedXML($clientesTarjetas/ns4:RESIDENCE_ADDRESS)
        				return(
        				<addresInformationResidence>
		        			<ADDRESS_LINE_1>{ data($addresInformationResidence/ADDRESS_LINE_1) }</ADDRESS_LINE_1>
		        			<ADDRESS_LINE_2>{ data($addresInformationResidence/ADDRESS_LINE_2) }</ADDRESS_LINE_2>
		        			<ADDRESS_LINE_3>{ data($addresInformationResidence/ADDRESS_LINE_3) }</ADDRESS_LINE_3>
		        			<ADDRESS_LINE_4>{ data($addresInformationResidence/ADDRESS_LINE_4) }</ADDRESS_LINE_4>
		        			<CITY>{ data($addresInformationResidence/CITY) }</CITY>
			        		<STATE>{data($addresInformationResidence/STATE) }</STATE>
			        		<COUNTRY>{data($addresInformationResidence/COUNTRY) }</COUNTRY>			        		          			
		        			<MOBILE_NUMBER>{ data($addresInformationResidence/MOBILE_NUMBER) }</MOBILE_NUMBER>
		        			<PHONE_NUMBER>{ data($addresInformationResidence/PHONE_NUMBER) }</PHONE_NUMBER>	
		        			<SUBURB>{ data($addresInformationResidence/SUBURB) }</SUBURB>
		        			<HOUSE_NUMBER>{ data($addresInformationResidence/HOUSE_NUMBER) }</HOUSE_NUMBER>
        				</addresInformationResidence>
        				),
        				let $addresInformationWork := fn-bea:inlinedXML($clientesTarjetas/ns4:WORK_ADDRESS)
        				return(
        					<addresInformationWork>
			        			<ADDRESS_TYPE>{ data($addresInformationWork/ADDRESS_TYPE) }</ADDRESS_TYPE>
			        			<ADDRESS_LINE_1>{ data($addresInformationWork/ADDRESS_LINE_1) }</ADDRESS_LINE_1>
			        			<ADDRESS_LINE_2>{ data($addresInformationWork/ADDRESS_LINE_2) }</ADDRESS_LINE_2>
			        			<ADDRESS_LINE_3>{ data($addresInformationWork/ADDRESS_LINE_3) }</ADDRESS_LINE_3>
				        		<CITY>{ data($addresInformationWork/CITY) }</CITY>
				        		<STATE>{data($addresInformationWork/STATE) }</STATE>
				        		<COUNTRY>{ data($addresInformationWork/COUNTRY) }</COUNTRY>				        		      			
			        			<EMPLOYERS_NAME>{ data($addresInformationWork/EMPLOYERS_NAME) }</EMPLOYERS_NAME>
			        			<PHONE_NUMBER>{ data($addresInformationWork/PHONE_NUMBER) }</PHONE_NUMBER>
			        			<PHONE_EXT>{ data($addresInformationWork/PHONE_EXT) }</PHONE_EXT>        			
			        		</addresInformationWork>
			        					
        				),
        				let $addresInformationAltern := fn-bea:inlinedXML($clientesTarjetas/ns4:ALTERN_ADDRESS)
        				return(
        					<addresInformationAltern>
			        			<ALTERN_ADDRESS>{ data($addresInformationAltern/ALTERN_ADDRESS) }</ALTERN_ADDRESS>
			        			<ADDRESS_LINE_1>{ data($addresInformationAltern/ADDRESS_LINE_1) }</ADDRESS_LINE_1>
			        			<ADDRESS_LINE_2>{ data($addresInformationAltern/ADDRESS_LINE_2) }</ADDRESS_LINE_2>
			        			<ADDRESS_LINE_3>{ data($addresInformationAltern/ADDRESS_LINE_3) }</ADDRESS_LINE_3>
			        			<CITY>{ data($addresInformationAltern/CITY) }</CITY>
			        			<STATE>{ data($addresInformationAltern/STATE) }</STATE>
			        			<COUNTRY>{ data($addresInformationAltern/COUNTRY) }</COUNTRY>
			        			<PHONE_NUMBER>{ data($addresInformationAltern/PHONE_NUMBER) }</PHONE_NUMBER>
			        		</addresInformationAltern>
        				),
        				let $customerNames := fn-bea:inlinedXML($clientesTarjetas/ns4:CUSTOMER_NAMES)
        				return(
        					<customerNames>
			        			<GIVEN_NAMES_1>{ data($customerNames/GIVEN_NAMES_1) }</GIVEN_NAMES_1>
			        			<GIVEN_NAMES_2>{ data($customerNames/GIVEN_NAMES_2) }</GIVEN_NAMES_2>
			        			<GIVEN_NAMES_3>{ data($customerNames/GIVEN_NAMES_3) }</GIVEN_NAMES_3>
			        		</customerNames>
        				),
        				<BIRTH_DATE>{ data($clientesTarjetas/ns4:BIRTH_DATE) }</BIRTH_DATE>,
        				<MARITAL_STATUS>{ data($clientesTarjetas/ns4:MARITAL_STATUS) }</MARITAL_STATUS>,
        				<LEGAL_DOCUMENT_TYPE>{ data($clientesTarjetas/ns4:LEGAL_DOCUMENT_TYPE) }</LEGAL_DOCUMENT_TYPE>,
        				<LEGAL_DOCUMENT_NUMBER>{ data($clientesTarjetas/ns4:LEGAL_DOCUMENT_NUMBER) }</LEGAL_DOCUMENT_NUMBER>,
        				<FREQUENT_TRAVELERS_NUMBER>{ data($clientesTarjetas/ns4:FREQUENT_TRAVELERS_NUMBER) }</FREQUENT_TRAVELERS_NUMBER>,
        				<TRAVELERS_STATUS>{ data($clientesTarjetas/ns4:TRAVELERS_STATUS) }</TRAVELERS_STATUS>,
        				<MAIN_EMAIL>{ data($clientesTarjetas/ns4:MAIN_EMAIL) }</MAIN_EMAIL>,
        				<ALTERNATE_EMAIL>{ data($clientesTarjetas/ns4:ALTERNATE_EMAIL) }</ALTERNATE_EMAIL>,
        				<NO_OF_DEPENDANTS>{ data($clientesTarjetas/ns4:NO_OF_DEPENDANTS) }</NO_OF_DEPENDANTS>,
        				<EDUCATION_LEVEL>{ data($clientesTarjetas/ns4:EDUCATION_LEVEL) }</EDUCATION_LEVEL>,
        				<GENDER>{ data($clientesTarjetas/ns4:GENDER) }</GENDER>,
        				<PROFESSION>{ data($clientesTarjetas/ns4:PROFESSION) }</PROFESSION>,
        				<NATIONALITY>{ data($clientesTarjetas/ns4:NATIONALITY) }</NATIONALITY>,
        				<POSITION>{ data($clientesTarjetas/ns4:POSITION) }</POSITION>,
        				<PEP_INDICATOR>{ data($clientesTarjetas/ns4:PEP_INDICATOR) }</PEP_INDICATOR>,
        				<LEGAL_DOCUMENT_COUNTRY_2>{ data($clientesTarjetas/ns4:PEP_INDICATOR) }</LEGAL_DOCUMENT_COUNTRY_2>,	
						<EMPLOYMENT_YEARS>{ data($clientesTarjetas/ns4:EMPLOYMENT_YEARS) }</EMPLOYMENT_YEARS>,				
						<EMPLOYMENT_MONTHS>{ data($clientesTarjetas/ns4:EMPLOYMENT_MONTHS) }</EMPLOYMENT_MONTHS>,
						<CLIENT_SEGMENT>{ data($clientesTarjetas/ns4:CLIENT_SEGMENT) }</CLIENT_SEGMENT>,
						<VIP_INDICATOR>{ data($clientesTarjetas/ns4:VIP_INDICATOR) }</VIP_INDICATOR>,		
						<CONSUMPTION_SCORE>{ data($clientesTarjetas/ns4:CONSUMPTION_SCORE) }</CONSUMPTION_SCORE>,
						<MAIN_INCOME>{ data($clientesTarjetas/ns4:MAIN_INCOME) }</MAIN_INCOME>,	
						<SECONDARY_INCOME>{ data($clientesTarjetas/ns4:SECONDARY_INCOME) }</SECONDARY_INCOME>,
						<EXPIRATION_DATE>{ data($clientesTarjetas/ns4:EXPIRATION_DATE) }</EXPIRATION_DATE>,					
						<DATE_ISSUE>{ data($clientesTarjetas/ns4:DATE_ISSUE) }</DATE_ISSUE>,
						<COUNTRY_ISSUANCE_PASSAPORT>{ data($clientesTarjetas/ns4:COUNTRY_ISSUANCE_PASSAPORT) }</COUNTRY_ISSUANCE_PASSAPORT>,	
						<ACCOUNT_STATUS_INDICATOR>{ data($clientesTarjetas/ns4:ACCOUNT_STATUS_INDICATOR) }</ACCOUNT_STATUS_INDICATOR>,
						<COUNTRY_2>{ data($clientesTarjetas/ns4:COUNTRY_2) }</COUNTRY_2>,
						<MAILING_LIST>{ data($clientesTarjetas/ns4:MAILING_LIST) }</MAILING_LIST>
        		)
        	) else (
        	let $conDatoCliente := $conDatoCliente/ns1:RowSet/ns1:Row[1]
        	let $demographic := $customerDemographicInquiryL8V2Response/DemographicArray/DemographicElement[1]
        	return(
        		<ORG>{ data($conDatoCliente/ns1:Column[@name = 'org']) }</ORG>,
        		<CUSTOMER_ID>{ data($conDatoCliente/ns1:Column[@name = 'numcliente']) }</CUSTOMER_ID>,
        		<addresInformationResidence>
        			<ADDRESS_LINE_1>{ data($demographic/AZXNDO-ADDR-1) }</ADDRESS_LINE_1>
        			<ADDRESS_LINE_2>{ data($demographic/AZXNDO-ADDR-2) }</ADDRESS_LINE_2>
        			<ADDRESS_LINE_3>{ data($demographic/AZXNDO-ADDR-3) }</ADDRESS_LINE_3>
        			<ADDRESS_LINE_4>{ data($demographic/AZXNDO-ADDR-4) }</ADDRESS_LINE_4>
        			{
	        			for $CITY in $demographic/AZXNDO-PSTL-CD
	        			return(
	        				<CITY>{ valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+GT', '7', $ptEquivalencias) }</CITY>
	        			)
       				}
       				{
	        			for $STATE in $demographic/AZXNDO-CITY-STATE
	        			return(
	        				<STATE>{ valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+GT', '8', $ptEquivalencias) }</STATE>
	        			)
       				}
       				{
	        			for $COUNTRY in $demographic/AZXNDO-CNTRY-CD
	        			return(
	        				<COUNTRY>{ valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+GT', '9', $ptEquivalencias) }</COUNTRY>
	        			)
       				}           			
        			<MOBILE_NUMBER>{ data($demographic/AZXNDO-MOBILE-PHONE) }</MOBILE_NUMBER>
        			<PHONE_NUMBER>{ data($demographic/AZXNDO-HOME-PHONE) }</PHONE_NUMBER>	
        			<SUBURB>{ data($demographic/AZXNDO-HOUSE-NAME) }</SUBURB>
        			<HOUSE_NUMBER>{ data($demographic/AZXNDO-HOUSE-NUMBER) }</HOUSE_NUMBER>
        		</addresInformationResidence>,
        		<addresInformationWork>
        			<ADDRESS_TYPE>{ data($demographic/AZXNDO-ADDR-2-INDIC) }</ADDRESS_TYPE>
        			<ADDRESS_LINE_1>{ data($demographic/AZXNDO-ADDR-2-LINE-1) }</ADDRESS_LINE_1>
        			<ADDRESS_LINE_2>{ data($demographic/AZXNDO-ADDR-2-LINE-2) }</ADDRESS_LINE_2>
        			<ADDRESS_LINE_3>{ data($demographic/AZXNDO-ADDR-2-LINE-3) }</ADDRESS_LINE_3>
        			{
	        			for $CITY in $demographic/AZXNDO-PSTL-CD-2
	        			return(
	        				<CITY>{ valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+GT', '7', $ptEquivalencias) }</CITY>
	        			)
       				}
       				{
	        			for $STATE in $demographic/AZXNDO-CITY-2
	        			return(
	        				<STATE>{ valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+GT', '8', $ptEquivalencias) }</STATE>
	        			)
       				}
       				{
	        			for $COUNTRY in $demographic/AZXNDO-CNTRY-CD-2
	        			return(
	        				<COUNTRY>{ valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+GT', '9', $ptEquivalencias) }</COUNTRY>
	        			)
       				}        			
        			<EMPLOYERS_NAME>{ data($demographic/AZXNDO-EMPLOYER) }</EMPLOYERS_NAME>
        			<PHONE_NUMBER>{ data($demographic/AZXNDO-EMP-PHONE) }</PHONE_NUMBER>
        			<PHONE_EXT>{ data($demographic/AZXNDO-EMP-PHONE-EXTN) }</PHONE_EXT>        			
        		</addresInformationWork>,
        		<addresInformationAltern>
        			<ALTERN_ADDRESS>{ data($demographic/AZXNDO-ADDR-3-INDIC) }</ALTERN_ADDRESS>
        			<ADDRESS_LINE_1>{ data($demographic/AZXNDO-ADDR-3-LINE-1) }</ADDRESS_LINE_1>
        			<ADDRESS_LINE_2>{ data($demographic/AZXNDO-ADDR-3-LINE-2) }</ADDRESS_LINE_2>
        			<ADDRESS_LINE_3>{ data($demographic/AZXNDO-ADDR-3-LINE-3) }</ADDRESS_LINE_3>
        			{
	        			for $CITY in $demographic/AZXNDO-PSTL-CD-3
	        			return(
	        				<CITY>{ valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+GT', '7', $ptEquivalencias) }</CITY>
	        			)
       				}
       				{
	        			for $STATE in $demographic/AZXNDO-CITY-3
	        			return(
	        				<STATE>{ valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+GT', '8', $ptEquivalencias) }</STATE>
	        			)
       				}
       				{
	        			for $COUNTRY in $demographic/AZXNDO-CNTRY-CD-3
	        			return(
	        				<COUNTRY>{ valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+GT', '9', $ptEquivalencias) }</COUNTRY>
	        			)
       				}
        			<PHONE_NUMBER>{ data($demographic/AZXNDO-FAX-PHONE) }</PHONE_NUMBER>
        		</addresInformationAltern>,
        		<customerNames>
        			<GIVEN_NAMES_1>{ data($conDatoCliente/ns1:Column[@name = 'nombre_1']) }</GIVEN_NAMES_1>
        			<GIVEN_NAMES_2>{ data($conDatoCliente/ns1:Column[@name = 'nombre_2']) }</GIVEN_NAMES_2>
        			<GIVEN_NAMES_3>{ data($conDatoCliente/ns1:Column[@name = 'Nombre_3']) }</GIVEN_NAMES_3>
        		</customerNames>,
        		<BIRTH_DATE>{ data($demographic/AZXNDO-DOB) }</BIRTH_DATE>,
        		
        		for $MARITAL_STATUS in $conDatoCliente/ns1:Column[@name = 'estadocivil']
        		return(
        			<MARITAL_STATUS>{ valorCatalogoAPPToOSB(string($MARITAL_STATUS/text()), 'MASTERDATAGT', '2', $ptEquivalencias) }</MARITAL_STATUS>
        		),       		
        		
        		for $LEGAL_DOCUMENT_TYPE in $demographic/AZXNDO-SSAN-FLAG
        		return(
        			<LEGAL_DOCUMENT_TYPE>{ valorCatalogoAPPToOSB(string($LEGAL_DOCUMENT_TYPE/text()), 'VISION+GT', '4', $ptEquivalencias) }</LEGAL_DOCUMENT_TYPE>
        		),
								
				<LEGAL_DOCUMENT_NUMBER>{ data($conDatoCliente/ns1:Column[@name = 'numero_id']) }</LEGAL_DOCUMENT_NUMBER>,
				<FREQUENT_TRAVELERS_NUMBER>{ data($conDatoCliente/ns1:Column[@name = 'ff_nbr']) }</FREQUENT_TRAVELERS_NUMBER>,
				
				for $TRAVELERS_STATUS in $conDatoCliente/ns1:Column[@name = 'bus_id']
				return(
					<TRAVELERS_STATUS>{ valorCatalogoAPPToOSB(string($TRAVELERS_STATUS/text()), 'MASTERDATAGT', '5', $ptEquivalencias) }</TRAVELERS_STATUS>
				),				
				
				<MAIN_EMAIL>{ data($conDatoCliente/ns1:Column[@name = 'email']) }</MAIN_EMAIL>,
				<ALTERNATE_EMAIL>{ data($demographic/AZXNDO-EMAIL) }</ALTERNATE_EMAIL>,
				<NO_OF_DEPENDANTS>{ data($demographic/AZXNDO-NBR-OF-DEPENDENTS) }</NO_OF_DEPENDANTS>,
				
				for $EDUCATION_LEVEL in $demographic/AZXNDO-USER-14
				return(
					<EDUCATION_LEVEL>{ valorCatalogoAPPToOSB(string($EDUCATION_LEVEL/text()), 'VISION+GT', '10', $ptEquivalencias) }</EDUCATION_LEVEL>
				),
				
				for $GENDER in $demographic/AZXNDO-GENDER-CODE
				return(
					<GENDER>{ valorCatalogoAPPToOSB(string($GENDER/text()), 'VISION+GT', '1', $ptEquivalencias) }</GENDER>				
				),
				<PROFESSION>{ data($demographic/AZXNDO-POSITION) }</PROFESSION>, 
				<NATIONALITY>{ data($demographic/AZXNDO-USER-DEMO-2) }</NATIONALITY>,		
				<POSITION>{ data($demographic/AZXNDO-USER-3) }</POSITION>, 
				<PEP_INDICATOR>{ data($demographic/AZXNDO-USER-8) }</PEP_INDICATOR>,
				<LEGAL_DOCUMENT_COUNTRY_2>{ data($demographic/AZXNDO-DL-NBR) }</LEGAL_DOCUMENT_COUNTRY_2>,	
				<EMPLOYMENT_YEARS>{ data($demographic/AZXNDO-USER-1) }</EMPLOYMENT_YEARS>,				
				<EMPLOYMENT_MONTHS>{ data($demographic/AZXNDO-USER-2) }</EMPLOYMENT_MONTHS>,
				<CLIENT_SEGMENT>{ data($demographic/AZXNDO-USER-6) }</CLIENT_SEGMENT>,
				<VIP_INDICATOR>{ data($demographic/AZXNDO-USER-7) }</VIP_INDICATOR>,		
				<CONSUMPTION_SCORE>{ data($demographic/AZXNDO-USER-9) }</CONSUMPTION_SCORE>,
				<MAIN_INCOME>{ data($demographic/AZXNDO-USER-15) }</MAIN_INCOME>,	
				<SECONDARY_INCOME>{ data($demographic/AZXNDO-USER-DEMO-1) }</SECONDARY_INCOME>,
				<EXPIRATION_DATE>{ data($demographic/AZXNDO-USER-10) }</EXPIRATION_DATE>,					
				<DATE_ISSUE>{ data($demographic/AZXNDO-USER-11) }</DATE_ISSUE>,
				<COUNTRY_ISSUANCE_PASSAPORT>{ data($demographic/AZXNDO-USER-12) }</COUNTRY_ISSUANCE_PASSAPORT>,	
				<ACCOUNT_STATUS_INDICATOR>{ data($demographic/AZXNDO-STMT-MSG-2-INDIC) }</ACCOUNT_STATUS_INDICATOR>,
				<COUNTRY_2>{ data($demographic/AZXNDO-DL-CNTRY) }</COUNTRY_2>,	
				<MAILING_LIST>{ data($demographic/AZXNDO-MAILING-LIST) }</MAILING_LIST>									
        	)  
        	)
        } 
        </ns2:consultaClienteTarjetasResponse>
};

declare variable $conDatoCliente as element(ns1:OutputParameters)? external;
declare variable $customerDemographicInquiryL8V2Response as element(ns0:CustomerDemographicInquiryL8V2Response)? external;
declare variable $ptEquivalencias as element()? external;
declare variable $outputParameters1 as element(ns4:OutputParameters)? external;

xf:consultaClienteTarjetasGTOut($conDatoCliente,
    $customerDemographicInquiryL8V2Response,
    $ptEquivalencias,
    $outputParameters1)