xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns5="http://www.ficohsa.com.hn/middleware.services/getCustomerCreditCardTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/getCustomerCreditCardTypes.xsd" ::)
declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerCC";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerCC/GetCustomerCC_sp.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerData";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerLiabilities/GetCustomerData_sp.xsd" ::)
declare namespace ns4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogEquivalence";
(:: import schema at "../../../../../ProviderServices/XSD/GetCatalogEquivalence/GetCatalogEquivalence_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $CustomerDemographicInquiryL8V2Response as element() (:: schema-element(ns1:CustomerDemographicInquiryL8V2Response) ::) external;
declare variable $GetCustomerDataResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $GetCustomerCCResponse as element() (:: schema-element(ns3:OutputParameters) ::) external;
declare variable $GetCatalogEquivalenceResponse as element() (:: schema-element(ns4:OutputParameters) ::) external;
declare variable $uuid as xs:string external;


declare function local:valorCatalogoAPPToOSB($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns4:PT_EQUIVALENCIAS_ITEM[ns4:CATALOGO_ID = $catalogoId and 
                                                 ns4:APLICACION_DESC = $aplicacion and 
                                                 ns4:EQUIVALENCIA_DESC = $valor]/ns4:VALOR_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function local:func($CustomerDemographicInquiryL8V2Response as element() (:: schema-element(ns1:CustomerDemographicInquiryL8V2Response) ::), 
                            $GetCustomerDataResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $GetCustomerCCResponse as element() (:: schema-element(ns3:OutputParameters) ::), 
                            $GetCatalogEquivalenceResponse as element() (:: schema-element(ns4:OutputParameters) ::), 
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns5:getCustomerCreditCardResponse) ::) {
    <ns5:getCustomerCreditCardResponse>
        <ns5:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns5:StatusInfo>
        {
        	if(not(empty($GetCustomerCCResponse/ns3:PT_CLIENTE_TARJETAS/ns3:ORG))) then (
        		let $clientesTarjetas := $GetCustomerCCResponse/ns3:PT_CLIENTE_TARJETAS
        		return(
        			<Org>{ data($clientesTarjetas/ns3:ORG) }</Org>,
        			<CustomerId>{ data($clientesTarjetas/ns3:CUSTOMER_ID) }</CustomerId>,
        				let $addresInformationResidence := fn-bea:inlinedXML($clientesTarjetas/ns3:RESIDENCE_ADDRESS)
        				return(
        				<addresInformationResidence>
		        			<AddressLine1>{ data($addresInformationResidence/ADDRESS_LINE_1) }</AddressLine1>
		        			<AddressLine2>{ data($addresInformationResidence/ADDRESS_LINE_2) }</AddressLine2>
		        			<AddressLine3>{ data($addresInformationResidence/ADDRESS_LINE_3) }</AddressLine3>
		        			<AddressLine4>{ data($addresInformationResidence/ADDRESS_LINE_4) }</AddressLine4>
		        			<City>{ data($addresInformationResidence/CITY) }</City>
			        		<State>{data($addresInformationResidence/STATE) }</State>
			        		<Country>{data($addresInformationResidence/COUNTRY) }</Country>			        		          			
		        			<MobileNumber>{ data($addresInformationResidence/MOBILE_NUMBER) }</MobileNumber>
		        			<PhoneNumber>{ data($addresInformationResidence/PHONE_NUMBER) }</PhoneNumber>	
		        			<Suburb>{ data($addresInformationResidence/SUBURB) }</Suburb>
		        			<HouseNumber>{ data($addresInformationResidence/HOUSE_NUMBER) }</HouseNumber>
        				</addresInformationResidence>
        				),
        				let $addresInformationWork := fn-bea:inlinedXML($clientesTarjetas/ns3:WORK_ADDRESS)
        				return(
        					<addresInformationWork>
			        			<AddressType>{ data($addresInformationWork/ADDRESS_TYPE) }</AddressType>
			        			<AddressLine1>{ data($addresInformationWork/ADDRESS_LINE_1) }</AddressLine1>
			        			<AddressLine2>{ data($addresInformationWork/ADDRESS_LINE_2) }</AddressLine2>
			        			<AddressLine3>{ data($addresInformationWork/ADDRESS_LINE_3) }</AddressLine3>
				        		<City>{ data($addresInformationWork/CITY) }</City>
				        		<State>{data($addresInformationWork/STATE) }</State>
				        		<Country>{ data($addresInformationWork/COUNTRY) }</Country>				        		      			
			        			<EmployersName>{ data($addresInformationWork/EMPLOYERS_NAME) }</EmployersName>
			        			<PhoneNumber>{ data($addresInformationWork/PHONE_NUMBER) }</PhoneNumber>
			        			<PhoneExt>{ data($addresInformationWork/PHONE_EXT) }</PhoneExt>        			
			        		</addresInformationWork>
			        					
        				),
        				let $addresInformationAltern := fn-bea:inlinedXML($clientesTarjetas/ns3:ALTERN_ADDRESS)
        				return(
        					<addresInformationAltern>
			        			<AlternAdress>{ data($addresInformationAltern/ALTERN_ADDRESS) }</AlternAdress>
			        			<AddressLine1>{ data($addresInformationAltern/ADDRESS_LINE_1) }</AddressLine1>
			        			<AddressLine2>{ data($addresInformationAltern/ADDRESS_LINE_2) }</AddressLine2>
			        			<AddressLine3>{ data($addresInformationAltern/ADDRESS_LINE_3) }</AddressLine3>
			        			<City>{ data($addresInformationAltern/CITY) }</City>
			        			<State>{ data($addresInformationAltern/STATE) }</State>
			        			<Country>{ data($addresInformationAltern/COUNTRY) }</Country>
			        			<PhoneNumber>{ data($addresInformationAltern/PHONE_NUMBER) }</PhoneNumber>
			        		</addresInformationAltern>
        				),
        				let $customerNames := fn-bea:inlinedXML($clientesTarjetas/ns3:CUSTOMER_NAMES)
        				return(
        					<customerNames>
			        			<GivenNames1>{ data($customerNames/GIVEN_NAMES_1) }</GivenNames1>
			        			<GivenNames2>{ data($customerNames/GIVEN_NAMES_2) }</GivenNames2>
			        			<GivenNames3>{ data($customerNames/GIVEN_NAMES_3) }</GivenNames3>
			        		</customerNames>
        				),
        				<BirthDate>{ data($clientesTarjetas/ns3:BIRTH_DATE) }</BirthDate>,
        				<MartialStatus>{ data($clientesTarjetas/ns3:MARITAL_STATUS) }</MartialStatus>,
        				<LegalDocumentType>{ data($clientesTarjetas/ns3:LEGAL_DOCUMENT_TYPE) }</LegalDocumentType>,
        				<LegalDocumentNumber>{ data($clientesTarjetas/ns3:LEGAL_DOCUMENT_NUMBER) }</LegalDocumentNumber>,
        				<FrequentTravelersNumber>{ data($clientesTarjetas/ns3:FREQUENT_TRAVELERS_NUMBER) }</FrequentTravelersNumber>,
        				<TravelersStatus>{ data($clientesTarjetas/ns3:TRAVELERS_STATUS) }</TravelersStatus>,
        				<MainEmail>{ data($clientesTarjetas/ns3:MAIN_EMAIL) }</MainEmail>,
        				<AlternateEmail>{ data($clientesTarjetas/ns3:ALTERNATE_EMAIL) }</AlternateEmail>,
        				<NoOfDependants>{ data($clientesTarjetas/ns3:NO_OF_DEPENDANTS) }</NoOfDependants>,
        				<EducationLevel>{ data($clientesTarjetas/ns3:EDUCATION_LEVEL) }</EducationLevel>,
        				<Gender>{ data($clientesTarjetas/ns3:GENDER) }</Gender>,
        				<Profession>{ data($clientesTarjetas/ns3:PROFESSION) }</Profession>,
        				<Nationality>{ data($clientesTarjetas/ns3:NATIONALITY) }</Nationality>,
        				<Position>{ data($clientesTarjetas/ns3:POSITION) }</Position>,
        				<PepIndicator>{ data($clientesTarjetas/ns3:PEP_INDICATOR) }</PepIndicator>,
        				<LegalDocumentCountry2>{ data($clientesTarjetas/ns3:PEP_INDICATOR) }</LegalDocumentCountry2>,	
						<EmploymentYears>{ data($clientesTarjetas/ns3:EMPLOYMENT_YEARS) }</EmploymentYears>,				
						<EmploymentMonths>{ data($clientesTarjetas/ns3:EMPLOYMENT_MONTHS) }</EmploymentMonths>,
						<ClientSegment>{ data($clientesTarjetas/ns3:CLIENT_SEGMENT) }</ClientSegment>,
						<VipIndicator>{ data($clientesTarjetas/ns3:VIP_INDICATOR) }</VipIndicator>,		
						<ConsumptionScore>{ data($clientesTarjetas/ns3:CONSUMPTION_SCORE) }</ConsumptionScore>,
						<MainIncome>{ data($clientesTarjetas/ns3:MAIN_INCOME) }</MainIncome>,	
						<SecondaryIncome>{ data($clientesTarjetas/ns3:SECONDARY_INCOME) }</SecondaryIncome>,
						<ExpirationDate>{ data($clientesTarjetas/ns3:EXPIRATION_DATE) }</ExpirationDate>,					
						<DateIssue>{ data($clientesTarjetas/ns3:DATE_ISSUE) }</DateIssue>,
						<CountryIssuancePassaport>{ data($clientesTarjetas/ns3:COUNTRY_ISSUANCE_PASSAPORT) }</CountryIssuancePassaport>,	
						<AccountStatusIndicator>{ data($clientesTarjetas/ns3:ACCOUNT_STATUS_INDICATOR) }</AccountStatusIndicator>,
						<Country2>{ data($clientesTarjetas/ns3:COUNTRY_2) }</Country2>
        		)
        	) else (
        	let $conDatoCliente := $GetCustomerDataResponse/ns2:RowSet/ns2:Row[1]
        	let $demographic := $CustomerDemographicInquiryL8V2Response/DemographicArray/DemographicElement[1]
        	return(
        		<Org>{ data($conDatoCliente/ns2:Column[@name = 'org']) }</Org>,
        		<CustomerId>{ data($conDatoCliente/ns2:Column[@name = 'numcliente']) }</CustomerId>,
        		<addresInformationResidence>
                                
        			{
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-1))) != "") then
                                    <AddressLine1>{ data($demographic/AZXNDO-ADDR-1) }</AddressLine1>
                                  else(
                                    <AddressLine1/>)
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2))) != "") then
                                    <AddressLine2>{ data($demographic/AZXNDO-ADDR-2) }</AddressLine2>
                                  else(
                                    <AddressLine2/>)
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3))) != "") then
                                    <AddressLine3>{ data($demographic/AZXNDO-ADDR-3) }</AddressLine3>
                                  else(
                                    <AddressLine3/>)
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-4))) != "") then
                                    <AddressLine4>{ data($demographic/AZXNDO-ADDR-4) }</AddressLine4>
                                  else(
                                    <AddressLine4/>)
                                }

        			{
                                        
	        			if (fn-bea:trim(xs:string(data($demographic/AZXNDO-PSTL-CD))) != "") then
                                      
                                          for $CITY in $demographic/AZXNDO-PSTL-CD
                                          return(
	        				<City>{ local:valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+HN', '7', $GetCatalogEquivalenceResponse) }</City>
                                          )
                                        else(
                                          <City/>
                                        )
       				}
                                
       				{
                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CITY-STATE))) != "") then
                                        
                                          for $STATE in $demographic/AZXNDO-CITY-STATE
                                          return(
	        				<State>{ local:valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+HN', '8', $GetCatalogEquivalenceResponse) }</State>
	        			)
                                        else(
                                          <State/>
                                          )
       				}
                                
       				{
                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CNTRY-CD))) != "") then
                                        
                                          for $COUNTRY in $demographic/AZXNDO-CNTRY-CD
                                          return(
	        				<Country>{ local:valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+HN', '9', $GetCatalogEquivalenceResponse) }</Country>
	        			)
                                        else(
                                          <Country/>
                                        )
       				}
                                
                                {
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-MOBILE-PHONE))) != "") then
                                  <MobileNumber>{ data($demographic/AZXNDO-MOBILE-PHONE) }</MobileNumber>
                                else(
                                  <MobileNumber/>)
                                }
                                
                                {
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-HOME-PHONE))) != "") then
                                  <PhoneNumber>{ data($demographic/AZXNDO-HOME-PHONE) }</PhoneNumber>
                                else(
                                  <PhoneNumer/>
                                )
                                }
                                
        			{
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-HOUSE-NAME))) != "") then
                                  <Suburb>{ data($demographic/AZXNDO-HOUSE-NAME) }</Suburb>
                                else(
                                  <Suburb/>
                                )
                                }
                                
                                {                              
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-HOUSE-NUMBER))) != "") then
                                  <HouseNumber>{ data($demographic/AZXNDO-HOUSE-NUMBER) }</HouseNumber>
                                else(
                                  <HouseNumbmer/>
                                )
                                }
        		</addresInformationResidence>,
        		<addresInformationWork>
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2-INDIC))) != "") then
                                    <AddressType>{ data($demographic/AZXNDO-ADDR-2-INDIC) }</AddressType>
                                  else(
                                    <AddressType/>
                                  )
        			}
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2-LINE-1))) != "") then
                                    <AddressLine1>{ data($demographic/AZXNDO-ADDR-2-LINE-1) }</AddressLine1>
                                  else(
                                    <AddressLine1/>
                                  )
        			}
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2-LINE-2))) != "") then
                                    <AddressLine2>{ data($demographic/$demographic/AZXNDO-ADDR-2-LINE-2) }</AddressLine2>
                                  else(
                                    <AddressLine2/>
                                  )
        			}
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-2-LINE-3))) != "") then
                                    <AddressLine3>{ data($demographic/AZXNDO-ADDR-2-LINE-3) }</AddressLine3>
                                  else(
                                    <AddressLine3/>
                                  )
        			}
        			
        			{
                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-PSTL-CD-2))) != "") then
	        			for $CITY in $demographic/AZXNDO-PSTL-CD-2
	        			return(
	        				<City>{ local:valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+HN', '7', $GetCatalogEquivalenceResponse) }</City>
	        			)
                                        else(
                                        <City/>
                                        )
       				}
                                
       				{
                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CITY-2))) != "") then
	        			for $STATE in $demographic/AZXNDO-CITY-2
	        			return(
	        				<State>{ local:valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+HN', '8', $GetCatalogEquivalenceResponse) }</State>
	        			)
                                        else(
                                          <State/>
                                        )
       				}
                                
       				{       
                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CNTRY-CD-2))) != "") then
	        			for $COUNTRY in $demographic/AZXNDO-CNTRY-CD-2
	        			return(
	        				<Country>{ local:valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+HN', '9', $GetCatalogEquivalenceResponse) }</Country>
	        			)
                                        else(
                                        <Countru/>
                                        )
       				}
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CNTRY-CD-2))) != "") then
                                  <EmployersName>{ data($demographic/AZXNDO-EMPLOYER) }</EmployersName>
                                  else(
                                  <EmployersName/>
                                  )                  
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-EMP-PHONE))) != "") then
                                  <PhoneNumber>{ data($demographic/AZXNDO-EMP-PHONE) }</PhoneNumber>
                                  else(
                                  <PhoneNumber/>
                                  )                  
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-EMP-PHONE-EXTN))) != "") then
                                  <PhoneExt>{ data($demographic/AZXNDO-EMP-PHONE-EXTN) }</PhoneExt>
                                  else(
                                  <PhoneExt/>
                                  )                  
                                }       			
        		</addresInformationWork>,
        		<addresInformationAltern>
                        
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3-INDIC))) != "") then
                                  <AlternAdress>{ data($demographic/AZXNDO-ADDR-3-INDIC) }</AlternAdress>
                                  else(
                                  <AlternAdress/>
                                  )
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3-LINE-1))) != "") then
                                  <AddressLine1>{ data($demographic/AZXNDO-ADDR-3-LINE-1) }</AddressLine1>
                                  else(
                                  <AddressLine1/>
                                  )
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3-LINE-2))) != "") then
                                  <AddressLine2>{ data($demographic/AZXNDO-ADDR-3-LINE-2) }</AddressLine2>
                                  else(
                                  <AddressLine2/>
                                  )
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($demographic/AZXNDO-ADDR-3-LINE-3))) != "") then
                                  <AddressLine3>{ data($demographic/AZXNDO-ADDR-3-LINE-3) }</AddressLine3>
                                  else(
                                  <AddressLine3/>
                                  )
                                }
        			
        			{
	        			if (fn-bea:trim(xs:string(data($demographic/AZXNDO-PSTL-CD-3))) != "") then
                                              for $CITY in $demographic/AZXNDO-PSTL-CD-3
	        			return(
	        				<City>{ local:valorCatalogoAPPToOSB(string($CITY/text()), 'VISION+HN', '7', $GetCatalogEquivalenceResponse) }</City>
	        			)
                                        else(
                                        <City/>
                                        )
       				}
                                
       				{
                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CITY-3))) != "") then
	        			for $STATE in $demographic/AZXNDO-CITY-3
	        			return(
	        				<State>{ local:valorCatalogoAPPToOSB(string($STATE/text()), 'VISION+HN', '8', $GetCatalogEquivalenceResponse) }</State>
	        			)
                                        else(
                                        <State/>)
       				}
                                
       				{       if (fn-bea:trim(xs:string(data($demographic/AZXNDO-CNTRY-CD-3))) != "") then
	        			for $COUNTRY in $demographic/AZXNDO-CNTRY-CD-3
	        			return(
	        				<Country>{ local:valorCatalogoAPPToOSB(string($COUNTRY/text()), 'VISION+HN', '9', $GetCatalogEquivalenceResponse) }</Country>
	        			)
                                        else(
                                        <Country/>
                                        )
       				}
                                
                                {
                                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-FAX-PHONE))) != "") then
                                        <PhoneNumber>{ data($demographic/AZXNDO-FAX-PHONE) }</PhoneNumber>
                                        else(
                                        <PhoneNumber/>
                                        )
                                }	
        		</addresInformationAltern>,
        		<customerNames>
                                {
                                  if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'nombre_1']))) != "") then
                                    <GivenNames1>{ data($conDatoCliente/ns2:Column[@name = 'nombre_1']) }</GivenNames1>
                                  else(
                                    <GivenNames1/>
                                  )        
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'nombre_2']))) != "") then
                                    <GivenNames2>{ data($conDatoCliente/ns2:Column[@name = 'nombre_2']) }</GivenNames2>
                                  else(
                                    <GivenNames2/>
                                  )        
                                }
                                
                                {
                                  if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'nombre_3']))) != "") then
                                    <GivenNames3>{ data($conDatoCliente/ns2:Column[@name = 'nombre_3']) }</GivenNames3>
                                  else(
                                    <GivenNames3/>
                                  )        
                                }
        		</customerNames>,
                        
                          if (fn-bea:trim(xs:string(data($demographic/AZXNDO-DOB))) != "") then
                          <BirthDate>{ data($demographic/AZXNDO-DOB) }</BirthDate>
                          else(
                          <BirthDate/>
                          ),
        		
                        
                        if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'estadocivil']))) != "") then
                        for $MARITAL_STATUS in $conDatoCliente/ns2:Column[@name = 'estadocivil']
        		return(
        			<MaritalStatus>{ local:valorCatalogoAPPToOSB(string($MARITAL_STATUS/text()), 'MASTERDATAHN', '2', $GetCatalogEquivalenceResponse) }</MaritalStatus>
        		)else(
                        <MaritalStatus/>
                        ),       		
        		
                        if (fn-bea:trim(xs:string(data($demographic/AZXNDO-SSAN-FLAG))) != "") then
        		for $LEGAL_DOCUMENT_TYPE in $demographic/AZXNDO-SSAN-FLAG
        		return(
        			<LegalDocumentType>{ local:valorCatalogoAPPToOSB(string($LEGAL_DOCUMENT_TYPE/text()), 'VISION+HN', '4', $GetCatalogEquivalenceResponse) }</LegalDocumentType>
        		)
                        else(
                          <LegalDocumentType/>
                        ),
				if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'numero_id']))) != "") then				
				<LegalDocumentNumber>{ data($conDatoCliente/ns2:Column[@name = 'numero_id']) }</LegalDocumentNumber>
                                else(
                                <LegalDocumentNumber/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'ff_nbr']))) != "") then
				<FrequentTravelersNumber>{ data($conDatoCliente/ns2:Column[@name = 'ff_nbr']) }</FrequentTravelersNumber>
                                else(
                                <FrequentTravelersNumber/>
                                ),
				
                                if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'bus_id']))) != "") then
				for $TRAVELERS_STATUS in $conDatoCliente/ns2:Column[@name = 'bus_id']
				return(
					<TravelersStatus>{ local:valorCatalogoAPPToOSB(string($TRAVELERS_STATUS/text()), 'MASTERDATAHN', '5', $GetCatalogEquivalenceResponse) }</TravelersStatus>
				)
                                else(
                                  <TravelersStatus/>
                                ),				
				
                                if (fn-bea:trim(xs:string(data($conDatoCliente/ns2:Column[@name = 'email']))) != "") then
				<MainEmail>{ data($conDatoCliente/ns2:Column[@name = 'email']) }</MainEmail>
                                else(
                                <MainEmail/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-EMAIL))) != "") then
				<AlternateEmail>{ data($demographic/AZXNDO-EMAIL) }</AlternateEmail>
                                else(
                                <AlternateEmail/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-NBR-OF-DEPENDENTS))) != "") then
				<NoOfDependants>{ data($demographic/AZXNDO-NBR-OF-DEPENDENTS) }</NoOfDependants>
                                else(
                                <NoOfDependants/>
                                ),
				
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-14))) != "") then
				for $EDUCATION_LEVEL in $demographic/AZXNDO-USER-14
				return(
					<EducationLevel>{ local:valorCatalogoAPPToOSB(string($EDUCATION_LEVEL/text()), 'VISION+HN', '10', $GetCatalogEquivalenceResponse) }</EducationLevel>
				)
                                else(
                                <EducationLevel/>
                                ),
				
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-GENDER-CODE))) != "") then
				for $GENDER in $demographic/AZXNDO-GENDER-CODE
				return(
					<Gender>{ local:valorCatalogoAPPToOSB(string($GENDER/text()), 'VISION+HN', '1', $GetCatalogEquivalenceResponse) }</Gender>				
				)
                                else(
                                <Gender/>),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-POSITION))) != "") then
				<Profession>{ data($demographic/AZXNDO-POSITION) }</Profession>
                                else(
                                <Profession/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-DEMO-2))) != "") then
				<Nationality>{ data($demographic/AZXNDO-USER-DEMO-2) }</Nationality>
                                else(
                                <Nationality/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-3))) != "") then
				<Position>{ data($demographic/AZXNDO-USER-3) }</Position>
                                else(
                                <Position/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-8))) != "") then
				<PepIndicator>{ data($demographic/AZXNDO-USER-8) }</PepIndicator>
                                else(
                                <PepIndicator/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-DL-NBR))) != "") then
				<LegalDocumentCountry2>{ data($demographic/AZXNDO-DL-NBR) }</LegalDocumentCountry2>
                                else(
                                <LegalDocumentCountry2/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-1))) != "") then
				<EmploymentYears>{ data($demographic/AZXNDO-USER-1) }</EmploymentYears>
                                else(
                                <EmploymentYears/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-2))) != "") then
				<EmploymentMonths>{ data($demographic/AZXNDO-USER-2) }</EmploymentMonths>
                                else(
                                <EmploymentMonths/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-6))) != "") then
				<ClientSegment>{ data($demographic/AZXNDO-USER-6) }</ClientSegment>
                                else(
                                <ClientSegment/>
                                ),
 
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-7))) != "") then
				<VipIndicator>{ data($demographic/AZXNDO-USER-7) }</VipIndicator>
                                else(
                                <VipIndicator/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-9))) != "") then
				<ConsumptionScore>{ data($demographic/AZXNDO-USER-9) }</ConsumptionScore>
                                else(
                                <ConsumptionScore/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-15))) != "") then
				<MainIncome>{ data($demographic/AZXNDO-USER-15) }</MainIncome>
                                else(
                                <MainIncome/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-DEMO-1))) != "") then
				<SecondaryIncome>{ data($demographic/AZXNDO-USER-DEMO-1) }</SecondaryIncome>
                                else(
                                <SecondaryIncome/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-10))) != "") then
				<ExpirationDate>{ data($demographic/AZXNDO-USER-10) }</ExpirationDate>
                                else(
                                <ExpirationDate/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-11))) != "") then
				<DateIssue>{ data($demographic/AZXNDO-USER-11) }</DateIssue>
                                else(
                                <DateIssue/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-USER-12))) != "") then
				<CountryIssuancePassaport>{ data($demographic/AZXNDO-USER-12) }</CountryIssuancePassaport>
                                else(
                                <CountryIssuancePassaport/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-STMT-MSG-2-INDIC))) != "") then
				<AccountStatusIndicator>{ data($demographic/AZXNDO-STMT-MSG-2-INDIC) }</AccountStatusIndicator>
                                else(
                                <AccountStatusIndicator/>
                                ),
                                
                                if (fn-bea:trim(xs:string(data($demographic/AZXNDO-DL-CNTRY))) != "") then
				<Country2>{ data($demographic/AZXNDO-DL-CNTRY) }</Country2>
                                else(
                                <Country2/>
                                )
        	)
        	)
        } 
    </ns5:getCustomerCreditCardResponse>
};

local:func($CustomerDemographicInquiryL8V2Response, $GetCustomerDataResponse, $GetCustomerCCResponse, $GetCatalogEquivalenceResponse, $uuid)