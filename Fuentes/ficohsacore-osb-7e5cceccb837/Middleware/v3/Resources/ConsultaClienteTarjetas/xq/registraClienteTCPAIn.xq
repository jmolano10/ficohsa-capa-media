(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/MasterDataPA/conDatoCliente/xsd/conDatoCliente_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$customerDemographicInquiryL8V2Response1" element="ns2:CustomerDemographicInquiryL8V2Response" location="../../../../v2/BusinessServices/VisionPlusPA/vmx/wsdl/VMX.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns3:OutputParameters" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/registraClienteTC/xsd/registraClienteTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraClienteTC";
declare namespace ns2 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaClienteTarjetas/xq/registraClienteTCPAIn/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";

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

declare function xf:registraClienteTCPAIn($outputParameters1 as element(ns1:OutputParameters),
    $customerDemographicInquiryL8V2Response1 as element(ns2:CustomerDemographicInquiryL8V2Response),
    $outputParameters2 as element(ns3:OutputParameters),
    $countryCode as xs:string,
    $searchCriteria as xs:string,
    $searchValue as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_PAIS>{ $countryCode }</ns0:PV_CODIGO_PAIS>
            <ns0:PV_SEARCH_CRITERIA>{ $searchCriteria }</ns0:PV_SEARCH_CRITERIA>
            <ns0:PV_SEARCH_VALUE>{ $searchValue }</ns0:PV_SEARCH_VALUE>
            <ns0:PT_CLIENTE_TARJETAS>
                    {
                    	let $conDatoCliente := $outputParameters1/ns1:RowSet/ns1:Row[1]
                    	let $demographic := $customerDemographicInquiryL8V2Response1/DemographicArray/DemographicElement[1]
                        return(
                        	<ns0:ORG>{ data($conDatoCliente/ns1:Column[@name = 'org']) }</ns0:ORG>,
        					<ns0:CUSTOMER_ID>{ data($conDatoCliente/ns1:Column[@name = 'numcliente']) }</ns0:CUSTOMER_ID>,
        					<ns0:RESIDENCE_ADDRESS>
        					{
        						fn-bea:serialize(
        							<addresInformationResidence>
        								<ADDRESS_LINE_1>{ data($demographic/AZXNDO-ADDR-1) }</ADDRESS_LINE_1>
        								<ADDRESS_LINE_2>{ data($demographic/AZXNDO-ADDR-2) }</ADDRESS_LINE_2>
        								<ADDRESS_LINE_3>{ data($demographic/AZXNDO-ADDR-3) }</ADDRESS_LINE_3>
        								<ADDRESS_LINE_4>{ data($demographic/AZXNDO-ADDR-4) }</ADDRESS_LINE_4>
        								{
	        								for $CITY in $demographic/AZXNDO-PSTL-CD
	        								return(
	        									<CITY>{ valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+PA', '7', $outputParameters2) }</CITY>
	        								)
	        							}
       									{
	        								for $STATE in $demographic/AZXNDO-CITY-STATE
	        								return(
	        									<STATE>{ valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+PA', '8', $outputParameters2) }</STATE>
	        								)
       									}
       									{
       										for $COUNTRY in $demographic/AZXNDO-CNTRY-CD
	        								return(
	        									<COUNTRY>{ valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+PA', '9', $outputParameters2) }</COUNTRY>
	        								)
       									}           			
					        			<MOBILE_NUMBER>{ data($demographic/AZXNDO-MOBILE-PHONE) }</MOBILE_NUMBER>
					        			<PHONE_NUMBER>{ data($demographic/AZXNDO-HOME-PHONE) }</PHONE_NUMBER>	
					        			<SUBURB>{ data($demographic/AZXNDO-HOUSE-NAME) }</SUBURB>
					        			<HOUSE_NUMBER>{ data($demographic/AZXNDO-HOUSE-NUMBER) }</HOUSE_NUMBER>
					        		</addresInformationResidence>
        						)
        					}
        					</ns0:RESIDENCE_ADDRESS>,
        					<ns0:WORK_ADDRESS>
        					{
        						fn-bea:serialize(
        							<addresInformationWork>
					        			<ADDRESS_TYPE>{ data($demographic/AZXNDO-ADDR-2-INDIC) }</ADDRESS_TYPE>
					        			<ADDRESS_LINE_1>{ data($demographic/AZXNDO-ADDR-2-LINE-1) }</ADDRESS_LINE_1>
					        			<ADDRESS_LINE_2>{ data($demographic/AZXNDO-ADDR-2-LINE-2) }</ADDRESS_LINE_2>
					        			<ADDRESS_LINE_3>{ data($demographic/AZXNDO-ADDR-2-LINE-3) }</ADDRESS_LINE_3>
					        			{
						        			for $CITY in $demographic/AZXNDO-PSTL-CD-2
						        			return(
						        				<CITY>{ valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+PA', '7', $outputParameters2) }</CITY>
						        			)
					       				}
					       				{
						        			for $STATE in $demographic/AZXNDO-CITY-2
						        			return(
						        				<STATE>{ valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+PA', '8', $outputParameters2) }</STATE>
						        			)
					       				}
					       				{
						        			for $COUNTRY in $demographic/AZXNDO-CNTRY-CD-2
						        			return(
						        				<COUNTRY>{ valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+PA', '9', $outputParameters2) }</COUNTRY>
						        			)
					       				}        			
					        			<EMPLOYERS_NAME>{ data($demographic/AZXNDO-EMPLOYER) }</EMPLOYERS_NAME>
					        			<PHONE_NUMBER>{ data($demographic/AZXNDO-EMP-PHONE) }</PHONE_NUMBER>
					        			<PHONE_EXT>{ data($demographic/AZXNDO-EMP-PHONE-EXTN) }</PHONE_EXT>        			
        							</addresInformationWork>
        						)
        					}
        					</ns0:WORK_ADDRESS>,
        					<ns0:ALTERN_ADDRESS>
        					{
        						fn-bea:serialize(
        							<addresInformationAltern>
					        			<ALTERN_ADDRESS>{ data($demographic/AZXNDO-ADDR-3-INDIC) }</ALTERN_ADDRESS>
					        			<ADDRESS_LINE_1>{ data($demographic/AZXNDO-ADDR-3-LINE-1) }</ADDRESS_LINE_1>
					        			<ADDRESS_LINE_2>{ data($demographic/AZXNDO-ADDR-3-LINE-2) }</ADDRESS_LINE_2>
					        			<ADDRESS_LINE_3>{ data($demographic/AZXNDO-ADDR-3-LINE-3) }</ADDRESS_LINE_3>
					        			{
						        			for $CITY in $demographic/AZXNDO-PSTL-CD-3
						        			return(
						        				<CITY>{ valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+PA', '7', $outputParameters2) }</CITY>
						        			)
					       				}
					       				{
						        			for $STATE in $demographic/AZXNDO-CITY-3
						        			return(
						        				<STATE>{ valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+PA', '8', $outputParameters2) }</STATE>
						        			)
					       				}
					       				{
						        			for $COUNTRY in $demographic/AZXNDO-CNTRY-CD-3
						        			return(
						        				<COUNTRY>{ valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+PA', '9', $outputParameters2) }</COUNTRY>
						        			)
					       				}
					        			<PHONE_NUMBER>{ data($demographic/AZXNDO-FAX-PHONE) }</PHONE_NUMBER>
					        		</addresInformationAltern>
        						)
        					}
        					</ns0:ALTERN_ADDRESS>,
        					<ns0:CUSTOMER_NAMES>
        					{
        						fn-bea:serialize(
        							<customerNames>
					        			<GIVEN_NAMES_1>{ data($conDatoCliente/ns1:Column[@name = 'nombre_1']) }</GIVEN_NAMES_1>
					        			<GIVEN_NAMES_2>{ data($conDatoCliente/ns1:Column[@name = 'nombre_2']) }</GIVEN_NAMES_2>
					        			<GIVEN_NAMES_3>{ data($conDatoCliente/ns1:Column[@name = 'Nombre_3']) }</GIVEN_NAMES_3>
        							</customerNames>
        						)
        					}
        					</ns0:CUSTOMER_NAMES>,
        					<ns0:BIRTH_DATE>{ data($demographic/AZXNDO-DOB) }</ns0:BIRTH_DATE>,
			        		for $MARITAL_STATUS in $conDatoCliente/ns1:Column[@name = 'estadocivil']
			        		return(
			        			<ns0:MARITAL_STATUS>{ valorCatalogoAPPToOSB(string($MARITAL_STATUS/text()), 'MASTERDATAPA', '2', $outputParameters2) }</ns0:MARITAL_STATUS>
			        		),       		
			        		
			        		for $LEGAL_DOCUMENT_TYPE in $demographic/AZXNDO-SSAN-FLAG
			        		return(
			        			<ns0:LEGAL_DOCUMENT_TYPE>{ valorCatalogoAPPToOSB(string($LEGAL_DOCUMENT_TYPE/text()), 'VISION+PA', '4', $outputParameters2) }</ns0:LEGAL_DOCUMENT_TYPE>
			        		),
											
							<ns0:LEGAL_DOCUMENT_NUMBER>{ data($conDatoCliente/ns1:Column[@name = 'numero_id']) }</ns0:LEGAL_DOCUMENT_NUMBER>,
							<ns0:FREQUENT_TRAVELERS_NUMBER>{ data($conDatoCliente/ns1:Column[@name = 'ff_nbr']) }</ns0:FREQUENT_TRAVELERS_NUMBER>,
							
							for $TRAVELERS_STATUS in $conDatoCliente/ns1:Column[@name = 'bus_id']
							return(
								<ns0:TRAVELERS_STATUS>{ valorCatalogoAPPToOSB(string($TRAVELERS_STATUS/text()), 'MASTERDATAPA', '5', $outputParameters2) }</ns0:TRAVELERS_STATUS>
							),				
							
							<ns0:MAIN_EMAIL>{ data($conDatoCliente/ns1:Column[@name = 'email']) }</ns0:MAIN_EMAIL>,
							<ns0:ALTERNATE_EMAIL>{ data($demographic/AZXNDO-EMAIL) }</ns0:ALTERNATE_EMAIL>,
							<ns0:NO_OF_DEPENDANTS>{ data($demographic/AZXNDO-NBR-OF-DEPENDENTS) }</ns0:NO_OF_DEPENDANTS>,
							
							for $EDUCATION_LEVEL in $demographic/AZXNDO-USER-14
							return(
								<ns0:EDUCATION_LEVEL>{ valorCatalogoAPPToOSB(string($EDUCATION_LEVEL/text()), 'VISION+PA', '10', $outputParameters2) }</ns0:EDUCATION_LEVEL>
							),
							
							for $GENDER in $demographic/AZXNDO-GENDER-CODE
							return(
								<ns0:GENDER>{ valorCatalogoAPPToOSB(string($GENDER/text()), 'VISION+PA', '1', $outputParameters2) }</ns0:GENDER>				
							),
							<ns0:PROFESSION>{ data($demographic/AZXNDO-POSITION) }</ns0:PROFESSION>, 
							<ns0:NATIONALITY>{ data($demographic/AZXNDO-USER-DEMO-2) }</ns0:NATIONALITY>,		
							<ns0:POSITION>{ data($demographic/AZXNDO-USER-3) }</ns0:POSITION>, 
							<ns0:PEP_INDICATOR>{ data($demographic/AZXNDO-USER-8) }</ns0:PEP_INDICATOR>,
							<ns0:LEGAL_DOCUMENT_COUNTRY_2>{ data($demographic/AZXNDO-DL-NBR) }</ns0:LEGAL_DOCUMENT_COUNTRY_2>,	
							<ns0:EMPLOYMENT_YEARS>{ data($demographic/AZXNDO-USER-1) }</ns0:EMPLOYMENT_YEARS>,				
							<ns0:EMPLOYMENT_MONTHS>{ data($demographic/AZXNDO-USER-2) }</ns0:EMPLOYMENT_MONTHS>,
							<ns0:CLIENT_SEGMENT>{ data($demographic/AZXNDO-USER-6) }</ns0:CLIENT_SEGMENT>,
							<ns0:VIP_INDICATOR>{ data($demographic/AZXNDO-USER-7) }</ns0:VIP_INDICATOR>,		
							<ns0:CONSUMPTION_SCORE>{ data($demographic/AZXNDO-USER-9) }</ns0:CONSUMPTION_SCORE>,
							<ns0:MAIN_INCOME>{ data($demographic/AZXNDO-USER-15) }</ns0:MAIN_INCOME>,	
							<ns0:SECONDARY_INCOME>{ data($demographic/AZXNDO-USER-DEMO-1) }</ns0:SECONDARY_INCOME>,
							<ns0:EXPIRATION_DATE>{ data($demographic/AZXNDO-USER-10) }</ns0:EXPIRATION_DATE>,					
							<ns0:DATE_ISSUE>{ data($demographic/AZXNDO-USER-11) }</ns0:DATE_ISSUE>,
							<ns0:COUNTRY_ISSUANCE_PASSAPORT>{ data($demographic/AZXNDO-DL-CNTRY) }</ns0:COUNTRY_ISSUANCE_PASSAPORT>,	
							<ns0:ACCOUNT_STATUS_INDICATOR>{ data($demographic/AZXNDO-STMT-MSG-2-INDIC) }</ns0:ACCOUNT_STATUS_INDICATOR>,
							<ns0:MAILING_LIST>{ data($demographic/AZXNDO-MAILING-LIST) }</ns0:MAILING_LIST>
        				)
                    }
            </ns0:PT_CLIENTE_TARJETAS>
        </ns0:InputParameters>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $customerDemographicInquiryL8V2Response1 as element(ns2:CustomerDemographicInquiryL8V2Response) external;
declare variable $outputParameters2 as element(ns3:OutputParameters) external;
declare variable $countryCode as xs:string external;
declare variable $searchCriteria as xs:string external;
declare variable $searchValue as xs:string external;

xf:registraClienteTCPAIn($outputParameters1,
    $customerDemographicInquiryL8V2Response1,
    $outputParameters2,
    $countryCode,
    $searchCriteria,
    $searchValue)