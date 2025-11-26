xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerData";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerLiabilities/GetCustomerData_sp.xsd" ::)
declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegisterCustomerCC";
(:: import schema at "../../../../../ProviderServices/XSD/RegisterCustomerCC/RegisterCustomerCC_sp.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogEquivalence";
(:: import schema at "../../../../../ProviderServices/XSD/GetCatalogEquivalence/GetCatalogEquivalence_sp.xsd" ::)

declare variable $searchCriteria as xs:string external;
declare variable $rspGetCatalogEquivalence as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $rspGetCustomerData as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $searchValue as xs:string external;
declare variable $countryCode as xs:string external;
declare variable $rspCustomerDemographicInquiryL8V2 as element() (:: schema-element(ns3:CustomerDemographicInquiryL8V2Response) ::) external;


declare function local:valorCatalogoAPPToOSB($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns1:PT_EQUIVALENCIAS_ITEM[ns1:CATALOGO_ID = $catalogoId and 
                                                 ns1:APLICACION_DESC = $aplicacion and 
                                                 ns1:EQUIVALENCIA_DESC = $valor]/ns1:VALOR_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function local:func($searchCriteria as xs:string, 
                            $rspGetCatalogEquivalence as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $rspGetCustomerData as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $searchValue as xs:string, 
                            $countryCode as xs:string, 
                            $rspCustomerDemographicInquiryL8V2 as element() (:: schema-element(ns3:CustomerDemographicInquiryL8V2Response) ::)) 
                            as element() (:: schema-element(ns4:InputParameters) ::) {
    <ns4:InputParameters>
            <ns4:PV_CODIGO_PAIS>{ $countryCode }</ns4:PV_CODIGO_PAIS>
            <ns4:PV_SEARCH_CRITERIA>{ $searchCriteria }</ns4:PV_SEARCH_CRITERIA>
            <ns4:PV_SEARCH_VALUE>{ $searchValue }</ns4:PV_SEARCH_VALUE>
            <ns4:PT_CLIENTE_TARJETAS>
                    {
                    	let $conDatoCliente := $rspGetCustomerData/ns2:RowSet/ns2:Row[1]
                    	let $demographic := $rspCustomerDemographicInquiryL8V2/DemographicArray/DemographicElement[1]
                        return(
                        	<ns4:ORG>{ data($conDatoCliente/ns2:Column[@name = 'org']) }</ns4:ORG>,
        					<ns4:CUSTOMER_ID>{ data($conDatoCliente/ns2:Column[@name = 'numcliente']) }</ns4:CUSTOMER_ID>,
        					<ns4:RESIDENCE_ADDRESS>
        					{
        						fn-bea:serialize(
        							<addresInformationResidence>
                                                                
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-1))) != "") then
                                                                        <ADDRESS_LINE_1>{ data($demographic/AZXNDO-ADDR-1) }</ADDRESS_LINE_1>
                                                                        else(
                                                                        <ADDRESS_LINE_1/>
                                                                        )
                                                                        }
                                                                        
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2))) != "") then
                                                                        <ADDRESS_LINE_2>{ data($demographic/AZXNDO-ADDR-2) }</ADDRESS_LINE_2>
                                                                        else(
                                                                        <ADDRESS_LINE_2/>
                                                                        )
                                                                        }
                                                                        
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3))) != "") then
                                                                        <ADDRESS_LINE_3>{ data($demographic/AZXNDO-ADDR-3) }</ADDRESS_LINE_3>
                                                                        else(
                                                                        <ADDRESS_LINE_3/>
                                                                        )
                                                                        }
                                                                        
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-4))) != "") then
                                                                        <ADDRESS_LINE_4>{ data($demographic/AZXNDO-ADDR-4) }</ADDRESS_LINE_4>
                                                                        else(
                                                                        <ADDRESS_LINE_4/>
                                                                        )
                                                                        }
        								
        								{
                                                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-PSTL-CD))) != "") then
	        								for $CITY in $demographic/AZXNDO-PSTL-CD
	        								return(
	        									<CITY>{ local:valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+HN', '7', $rspGetCatalogEquivalence) }</CITY>
	        								)else(
                                                                                <CITY/>
                                                                                )
	        							}
                                                                        
       									{       
                                                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CITY-STATE))) != "") then
	        								for $STATE in $demographic/AZXNDO-CITY-STATE
	        								return(
	        									<STATE>{ local:valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+HN', '8', $rspGetCatalogEquivalence) }</STATE>
	        								)
                                                                                else(
                                                                                <STATE/>
                                                                                )
       									}
                                                                        
       									{
                                                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CNTRY-CD))) != "") then
       										for $COUNTRY in $demographic/AZXNDO-CNTRY-CD
	        								return(
	        									<COUNTRY>{ local:valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+HN', '9', $rspGetCatalogEquivalence) }</COUNTRY>
	        								)
                                                                                else(
                                                                                <COUNTRY/>
                                                                                )
       									}
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-MOBILE-PHONE))) != "") then
                                                                            <MOBILE_NUMBER>{ data($demographic/AZXNDO-MOBILE-PHONE) }</MOBILE_NUMBER>
                                                                          else(
                                                                            <MOBILE_NUMBER/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-HOME-PHONE))) != "") then
                                                                            <PHONE_NUMBER>{ data($demographic/AZXNDO-HOME-PHONE) }</PHONE_NUMBER>
                                                                          else(
                                                                            <PHONE_NUMBER/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-HOUSE-NAME))) != "") then
                                                                            <SUBURB>{ data($demographic/AZXNDO-HOUSE-NAME) }</SUBURB>
                                                                          else(
                                                                            <SUBURB/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-HOUSE-NUMBER))) != "") then
                                                                            <HOUSE_NUMBER>{ data($demographic/AZXNDO-HOUSE-NUMBER) }</HOUSE_NUMBER>
                                                                          else(
                                                                            <HOUSE_NUMBER/>
                                                                          )
                                                                        }
					        		</addresInformationResidence>
        						)
        					}
        					</ns4:RESIDENCE_ADDRESS>,
        					<ns4:WORK_ADDRESS>
        					{
        						fn-bea:serialize(
        							<addresInformationWork>
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2-INDIC))) != "") then
                                                                            <ADDRESS_TYPE>{ data($demographic/AZXNDO-ADDR-2-INDIC) }</ADDRESS_TYPE>
                                                                          else(
                                                                            <ADDRESS_TYPE/>
                                                                            )
                                                                        }
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2-LINE-1))) != "") then
                                                                            <ADDRESS_LINE_1>{ data($demographic/AZXNDO-ADDR-2-LINE-1) }</ADDRESS_LINE_1>
                                                                          else(
                                                                            <ADDRESS_LINE_1/>
                                                                            )
                                                                        }
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2-LINE-2))) != "") then
                                                                            <ADDRESS_LINE_2>{ data($demographic/AZXNDO-ADDR-2-LINE-2) }</ADDRESS_LINE_2>
                                                                          else(
                                                                            <ADDRESS_LINE_2/>
                                                                            )
                                                                        }
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2-LINE-3))) != "") then
                                                                            <ADDRESS_LINE_3>{ data($demographic/AZXNDO-ADDR-2-LINE-3) }</ADDRESS_LINE_3>
                                                                          else(
                                                                            <ADDRESS_LINE_3/>
                                                                            )
                                                                        }
					        			
					        			
					        			
					        			
					        			{
                                                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-PSTL-CD-2))) != "") then
						        			for $CITY in $demographic/AZXNDO-PSTL-CD-2
						        			return(
						        				<CITY>{ local:valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+HN', '7', $rspGetCatalogEquivalence) }</CITY>
						        			)
                                                                                else(
                                                                                <CITY/>
                                                                                )
					       				}
					       				{
                                                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CITY-2))) != "") then
						        			for $STATE in $demographic/AZXNDO-CITY-2
						        			return(
						        				<STATE>{ local:valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+HN', '8', $rspGetCatalogEquivalence) }</STATE>
						        			)
                                                                                else(
                                                                                <STATE/>
                                                                                )
					       				}
					       				{
                                                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CNTRY-CD-2))) != "") then
						        			for $COUNTRY in $demographic/AZXNDO-CNTRY-CD-2
						        			return(
						        				<COUNTRY>{ local:valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+HN', '9', $rspGetCatalogEquivalence) }</COUNTRY>
						        			)
                                                                                else(
                                                                                <COUNTRY/>
                                                                                )
					       				}
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CNTRY-CD-2))) != "") then
                                                                          <EMPLOYERS_NAME>{ data($demographic/AZXNDO-EMPLOYER) }</EMPLOYERS_NAME>
                                                                          else(
                                                                          <EMPLOYERS_NAME/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-EMP-PHONE))) != "") then
                                                                          <PHONE_NUMBER>{ data($demographic/AZXNDO-EMP-PHONE) }</PHONE_NUMBER>
                                                                          else(<PHONE_NUMBER/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-EMP-PHONE-EXTN))) != "") then
                                                                          <PHONE_EXT>{ data($demographic/AZXNDO-EMP-PHONE-EXTN) }</PHONE_EXT>
                                                                          else(
                                                                          <PHONE_EXT/>
                                                                          )
                                                                        }
              			
        							</addresInformationWork>
        						)
        					}
        					</ns4:WORK_ADDRESS>,
        					<ns4:ALTERN_ADDRESS>
        					{
        						fn-bea:serialize(
        							<addresInformationAltern>
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3-INDIC))) != "") then
                                                                          <ALTERN_ADDRESS>{ data($demographic/AZXNDO-ADDR-3-INDIC) }</ALTERN_ADDRESS>
                                                                          else(
                                                                          <ALTERN_ADDRESS/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3-LINE-1))) != "") then
                                                                          <ADDRESS_LINE_1>{ data($demographic/AZXNDO-ADDR-3-LINE-1) }</ADDRESS_LINE_1>
                                                                          else(
                                                                          <ADDRESS_LINE_1/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3-LINE-2))) != "") then
                                                                          <ADDRESS_LINE_2>{ data($demographic/AZXNDO-ADDR-3-LINE-2) }</ADDRESS_LINE_2>
                                                                          else(
                                                                          <ADDRESS_LINE_2/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3-LINE-3))) != "") then
                                                                          <ADDRESS_LINE_3>{ data($demographic/AZXNDO-ADDR-3-LINE-3) }</ADDRESS_LINE_3>
                                                                          else(
                                                                          <ADDRESS_LINE_3/>
                                                                          )
                                                                        }
         
					        			{
                                                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-PSTL-CD-3))) != "") then
                                                                                for $CITY in $demographic/AZXNDO-PSTL-CD-3
						        			return(
						        				<CITY>{ local:valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+HN', '7', $rspGetCatalogEquivalence) }</CITY>
						        			)
                                                                                else(
                                                                                <CITY/>
                                                                                )
					       				}
                                                                        
					       				{
                                                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CITY-3))) != "") then
						        			for $STATE in $demographic/AZXNDO-CITY-3
						        			return(
						        				<STATE>{ local:valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+HN', '8', $rspGetCatalogEquivalence) }</STATE>
						        			)
                                                                                else(
                                                                                <STATE/>
                                                                                )
					       				}
                                                                        
					       				{       
                                                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CNTRY-CD-3))) != "") then
						        			for $COUNTRY in $demographic/AZXNDO-CNTRY-CD-3
						        			return(
						        				<COUNTRY>{ local:valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+HN', '9', $rspGetCatalogEquivalence) }</COUNTRY>
						        			)
                                                                                else(
                                                                                <COUNTRY/>
                                                                                )
					       				}
                                                                        
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-FAX-PHONE))) != "") then
                                                                            <PHONE_NUMBER>{ data($demographic/AZXNDO-FAX-PHONE) }</PHONE_NUMBER>
                                                                          else(
                                                                            <PHONE_NUMBER/>
                                                                          )
                                                                        }
					        			
					        		</addresInformationAltern>
        						)
        					}
        					</ns4:ALTERN_ADDRESS>,
        					<ns4:CUSTOMER_NAMES>
        					{
        						fn-bea:serialize(
        							<customerNames>
                                                                        {
                                                                          if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'nombre_1']))) != "") then
                                                                          <GIVEN_NAMES_1>{ data($conDatoCliente/ns2:Column[@name = 'nombre_1']) }</GIVEN_NAMES_1>
                                                                          else(
                                                                          <GIVEN_NAMES_1/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'nombre_2']))) != "") then
                                                                          <GIVEN_NAMES_2>{ data($conDatoCliente/ns2:Column[@name = 'nombre_1']) }</GIVEN_NAMES_2>
                                                                          else(
                                                                          <GIVEN_NAMES_2/>
                                                                          )
                                                                        }
                                                                        
                                                                        {
                                                                        if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'Nombre_3']))) != "") then
                                                                          <GIVEN_NAMES_3>{ data($conDatoCliente/ns2:Column[@name = 'Nombre_3']) }</GIVEN_NAMES_3>
                                                                          else(
                                                                          <GIVEN_NAMES_3/>
                                                                          )
                                                                        }
        							</customerNames>
        						)
        					}
        					</ns4:CUSTOMER_NAMES>,
                                                
                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-DOB))) != "") then
        					<ns4:BIRTH_DATE>{ data($demographic/AZXNDO-DOB) }</ns4:BIRTH_DATE>
                                                else(
                                                <ns4:BIRTH_DATE/>
                                                ),
                                                
                                                if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'estadocivil']))) != "") then
			        		for $MARITAL_STATUS in $conDatoCliente/ns2:Column[@name = 'estadocivil']
			        		return(
			        			<ns4:MARITAL_STATUS>{ local:valorCatalogoAPPToOSB(string($MARITAL_STATUS/text()), 'MASTERDATAHN', '2', $rspGetCatalogEquivalence) }</ns4:MARITAL_STATUS>
			        		)
                                                else(
                                                <ns4:MARITAL_STATUS/>
                                                ),       		
			        		
                                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-SSAN-FLAG))) != "") then
			        		for $LEGAL_DOCUMENT_TYPE in $demographic/AZXNDO-SSAN-FLAG
			        		return(
			        			<ns4:LEGAL_DOCUMENT_TYPE>{ local:valorCatalogoAPPToOSB(string($LEGAL_DOCUMENT_TYPE/text()), 'VISION+HN', '4', $rspGetCatalogEquivalence) }</ns4:LEGAL_DOCUMENT_TYPE>
			        		)
                                                else(
                                                <ns4:LEGAL_DOCUMENT_TYPE/>
                                                ),
							if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'numero_id']))) != "") then				
							<ns4:LEGAL_DOCUMENT_NUMBER>{ data($conDatoCliente/ns2:Column[@name = 'numero_id']) }</ns4:LEGAL_DOCUMENT_NUMBER>
                                                        else(
                                                        <ns4:LEGAL_DOCUMENT_NUMBER/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'ff_nbr']))) != "") then
							<ns4:FREQUENT_TRAVELERS_NUMBER>{ data($conDatoCliente/ns2:Column[@name = 'ff_nbr']) }</ns4:FREQUENT_TRAVELERS_NUMBER>
                                                        else(
                                                        <ns4:FREQUENT_TRAVELERS_NUMBER/>
                                                        ),
							
                                                        if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'bus_id']))) != "") then
							for $TRAVELERS_STATUS in $conDatoCliente/ns2:Column[@name = 'bus_id']
							return(
								<ns4:TRAVELERS_STATUS>{ local:valorCatalogoAPPToOSB(string($TRAVELERS_STATUS/text()), 'MASTERDATAHN', '5', $rspGetCatalogEquivalence) }</ns4:TRAVELERS_STATUS>
							)
                                                        else(
                                                        <ns4:TRAVELERS_STATUS/>
                                                        ),				
							
                                                        if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'email']))) != "") then
							<ns4:MAIN_EMAIL>{ data($conDatoCliente/ns2:Column[@name = 'email']) }</ns4:MAIN_EMAIL>
                                                        else(
                                                        <ns4:MAIN_EMAIL/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-EMAIL))) != "") then
							<ns4:ALTERNATE_EMAIL>{ data($demographic/AZXNDO-EMAIL) }</ns4:ALTERNATE_EMAIL>
                                                        else(
                                                        <ns4:ALTERNATE_EMAIL/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-NBR-OF-DEPENDENTS))) != "") then
							<ns4:NO_OF_DEPENDANTS>{ data($demographic/AZXNDO-NBR-OF-DEPENDENTS) }</ns4:NO_OF_DEPENDANTS>
                                                        else(
                                                        <ns4:NO_OF_DEPENDANTS/>
                                                        ),
							
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-14))) != "") then
							for $EDUCATION_LEVEL in $demographic/AZXNDO-USER-14
							return(
								<ns4:EDUCATION_LEVEL>{ local:valorCatalogoAPPToOSB(string($EDUCATION_LEVEL/text()), 'VISION+HN', '10', $rspGetCatalogEquivalence) }</ns4:EDUCATION_LEVEL>
							)
                                                        else(
                                                        <ns4:EDUCATION_LEVEL/>
                                                        ),
							
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-GENDER-CODE))) != "") then
							for $GENDER in $demographic/AZXNDO-GENDER-CODE
							return(
								<ns4:GENDER>{ local:valorCatalogoAPPToOSB(string($GENDER/text()), 'VISION+HN', '1', $rspGetCatalogEquivalence) }</ns4:GENDER>				
							)
                                                        else(
                                                        <ns4:GENDER/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-POSITION))) != "") then
							<ns4:PROFESSION>{ data($demographic/AZXNDO-POSITION) }</ns4:PROFESSION>
                                                        else(
                                                        <ns4:PROFESSION/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-DEMO-2))) != "") then
							<ns4:NATIONALITY>{ data($demographic/AZXNDO-USER-DEMO-2) }</ns4:NATIONALITY>
                                                        else(
                                                        <ns4:NATIONALITY/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-3))) != "") then
							<ns4:POSITION>{ data($demographic/AZXNDO-USER-3) }</ns4:POSITION>
                                                        else(
                                                        <ns4:POSITION/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-8))) != "") then
							<ns4:PEP_INDICATOR>{ data($demographic/AZXNDO-USER-8) }</ns4:PEP_INDICATOR>
                                                        else(
                                                        <ns4:PEP_INDICATOR/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-DL-NBR))) != "") then
							<ns4:LEGAL_DOCUMENT_COUNTRY_2>{ data($demographic/AZXNDO-DL-NBR) }</ns4:LEGAL_DOCUMENT_COUNTRY_2>
                                                        else(
                                                        <ns4:LEGAL_DOCUMENT_COUNTRY_2/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-1))) != "") then
							<ns4:EMPLOYMENT_YEARS>{ data($demographic/AZXNDO-USER-1) }</ns4:EMPLOYMENT_YEARS>
                                                        else(
                                                        <ns4:EMPLOYMENT_YEARS/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-2))) != "") then
							<ns4:EMPLOYMENT_MONTHS>{ data($demographic/AZXNDO-USER-2) }</ns4:EMPLOYMENT_MONTHS>
                                                        else(
                                                        <ns4:EMPLOYMENT_MONTHS/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-6))) != "") then
							<ns4:CLIENT_SEGMENT>{ data($demographic/AZXNDO-USER-6) }</ns4:CLIENT_SEGMENT>
                                                        else(
                                                        <ns4:CLIENT_SEGMENT/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-7))) != "") then
							<ns4:VIP_INDICATOR>{ data($demographic/AZXNDO-USER-7) }</ns4:VIP_INDICATOR>
                                                        else(
                                                        <ns4:VIP_INDICATOR/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-9))) != "") then
							<ns4:CONSUMPTION_SCORE>{ data($demographic/AZXNDO-USER-9) }</ns4:CONSUMPTION_SCORE>
                                                        else(
                                                        <ns4:CONSUMPTION_SCORE/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-15))) != "") then
							<ns4:MAIN_INCOME>{ data($demographic/AZXNDO-USER-15) }</ns4:MAIN_INCOME>
                                                        else(
                                                        <ns4:MAIN_INCOME/>
                                                        ),
                                                        
                                                         if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-DEMO-1))) != "") then
							<ns4:SECONDARY_INCOME>{ data($demographic/AZXNDO-USER-DEMO-1) }</ns4:SECONDARY_INCOME>
                                                        else(
                                                        <ns4:SECONDARY_INCOME/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-10))) != "") then
							<ns4:EXPIRATION_DATE>{ (data($demographic/AZXNDO-USER-10)) }</ns4:EXPIRATION_DATE>
                                                        else(
                                                        <ns4:EXPIRATION_DATE/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-11))) != "") then
							<ns4:DATE_ISSUE>{ data($demographic/AZXNDO-USER-11) }</ns4:DATE_ISSUE>
                                                        else(
                                                        <ns4:DATE_ISSUE/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-12))) != "") then
							<ns4:COUNTRY_ISSUANCE_PASSAPORT>{ data($demographic/AZXNDO-USER-12) }</ns4:COUNTRY_ISSUANCE_PASSAPORT>
                                                        else(
                                                        <ns4:COUNTRY_ISSUANCE_PASSAPORT/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-STMT-MSG-2-INDIC))) != "") then
							<ns4:ACCOUNT_STATUS_INDICATOR>{ data($demographic/AZXNDO-STMT-MSG-2-INDIC) }</ns4:ACCOUNT_STATUS_INDICATOR>
                                                        else(
                                                        <ns4:ACCOUNT_STATUS_INDICATOR/>
                                                        ),
                                                        
                                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-DL-CNTRY))) != "") then
							<ns4:COUNTRY_2>{ data($demographic/AZXNDO-DL-CNTRY) }</ns4:COUNTRY_2>
                                                        else(
                                                        <ns4:COUNTRY_2/>
                                                        )
        				)
                    }
            </ns4:PT_CLIENTE_TARJETAS>
        </ns4:InputParameters>
};

local:func($searchCriteria, $rspGetCatalogEquivalence, $rspGetCustomerData, $searchValue, $countryCode, $rspCustomerDemographicInquiryL8V2)