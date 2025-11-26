(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterData/conDatoCliente/xsd/conDatoCliente_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$customerDemographicInquiryResponse" element="ns2:CustomerDemographicInquiryResponse" location="../../../BusinessServices/VisionPlus/vmx/wsdl/VMX.wsdl" ::)
(:: pragma bea:local-element-parameter parameter="$ptEquivalencias" type="ns4:OutputParameters/ns4:PT_EQUIVALENCIAS" location="../../../BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteTarjetasResponse" location="../xsd/consultaClienteTarjetasTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCliente";
declare namespace ns2 = "http://www.procesa.com/fdcs";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClienteTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteTarjetas/xq/consultaClienteTarjetasOut/";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";

declare function valorCatalogoAPPToOSB($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns4:EQUIVALENCIA[ns4:CATALOGO_ID = $catalogoId and 
															  ns4:APLICACION_DESC = $aplicacion and 
															  ns4:EQUIVALENCIA_DESC = $valor]/ns4:VALOR_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:consultaClienteTarjetasOut($outputParameters as element(ns0:OutputParameters),
    $customerDemographicInquiryResponse as element(ns2:CustomerDemographicInquiryResponse),
    $ptEquivalencias as element())
    as element(ns1:consultaClienteTarjetasResponse) {
    <ns1:consultaClienteTarjetasResponse>
    {
        let $row := $outputParameters/ns0:RowSet/ns0:Row
        let $demographic := $customerDemographicInquiryResponse/DemographicArray/DemographicElement[1]
        return
        (
            <CUSTOMER_ID>{ data($row/ns0:Column[@name='numcliente']) }</CUSTOMER_ID>,
            <CUSTOMER_NAMES> 
                {
                for $NAMES_1 in $row/ns0:Column[@name='nombre_1']
                return 
                    <GIVEN_NAMES_1>{ fn-bea:trim(xs:string(data($NAMES_1))) }</GIVEN_NAMES_1>
                }
                {
                for $NAMES_2 in $row/ns0:Column[@name='nombre_2']
                return 
                    <GIVEN_NAMES_2>{ fn-bea:trim(xs:string(data($NAMES_2))) }</GIVEN_NAMES_2>
                }
                {
                for $NAMES_3 in $row/ns0:Column[@name='Nombre_3']
                return 
                    <GIVEN_NAMES_3>{ fn-bea:trim(xs:string(data($NAMES_3))) }</GIVEN_NAMES_3>
                }                 
            </CUSTOMER_NAMES>, 
            for $BIRTH_DATE in $demographic/ARXNDO-DOB
            return
                <BIRTH_DATE>{ fn-bea:trim(xs:string(data($BIRTH_DATE ))) }</BIRTH_DATE>,

            for $MARITAL_STATUS in $row/ns0:Column[@name='estadocivil']
            return
                <MARITAL_STATUS>
                { 
                	valorCatalogoAPPToOSB(string($MARITAL_STATUS/text()), 'MASTERDATA+', '2', $ptEquivalencias)
                }
                </MARITAL_STATUS>,

            for $LEGAL_DOCUMENT_TYPE in $demographic/ARXNDO-SSAN-FLAG
            return
                <LEGAL_DOCUMENT_TYPE>
                { 
                	valorCatalogoAPPToOSB(string($LEGAL_DOCUMENT_TYPE/text()), 'VISION+', '4', $ptEquivalencias) 
                }
                </LEGAL_DOCUMENT_TYPE>,

            for $LEGAL_DOCUMENT_NUMBER in $row/ns0:Column[@name='numero_id']
            return
                <LEGAL_DOCUMENT_NUMBER>{ fn-bea:trim(xs:string(data($LEGAL_DOCUMENT_NUMBER))) }</LEGAL_DOCUMENT_NUMBER>,

            for $FREQUENT_TRAVELERS_NUMBER in $row/ns0:Column[@name='ff_nbr']
            return
                <FREQUENT_TRAVELERS_NUMBER>{ fn-bea:trim(xs:string(data($FREQUENT_TRAVELERS_NUMBER))) }</FREQUENT_TRAVELERS_NUMBER>,

            for $TRAVELERS_STATUS in $row/ns0:Column[@name='bus_id']
            return
                <TRAVELERS_STATUS>
                { 
                	valorCatalogoAPPToOSB(string($TRAVELERS_STATUS/text()), 'MASTERDATA+', '5', $ptEquivalencias) 
                }
                </TRAVELERS_STATUS>,

            for $ALTERNATE_EMAIL in $row/ns0:Column[@name='email']
            return
                <MAIN_EMAIL>{ fn-bea:trim(xs:string(data($ALTERNATE_EMAIL))) }</MAIN_EMAIL>,

            for $ALTERNATE_EMAIL in $demographic/ARXNDO-EMAIL
            return
                <ALTERNATE_EMAIL>{ fn-bea:trim(xs:string(data($ALTERNATE_EMAIL))) }</ALTERNATE_EMAIL>,

            for $NO_OF_DEPENDANTS in $demographic/ARXNDO-NBR-OF-DEPENDENTS
            return
                <NO_OF_DEPENDANTS>{ fn-bea:trim(xs:string(data($NO_OF_DEPENDANTS))) }</NO_OF_DEPENDANTS>,

            for $ARXNDO-USER-14 in $demographic/ARXNDO-USER-14
            return
                <EDUCATION_LEVEL>
                { 
                	valorCatalogoAPPToOSB(string($ARXNDO-USER-14/text()), 'VISION+', '10', $ptEquivalencias) 
                }
                </EDUCATION_LEVEL>,

            for $ARXNDO-GENDER-CODE in $demographic/ARXNDO-GENDER-CODE
            return
                <GENDER>
                { 
                	valorCatalogoAPPToOSB(string($ARXNDO-GENDER-CODE/text()), 'VISION+', '1', $ptEquivalencias) 
                }
                </GENDER>,

            for $ARXNDO-EMPLOYER in $demographic/ARXNDO-EMPLOYER
            return
                <EMPLOYERS_NAME>{ fn-bea:trim(xs:string(data($ARXNDO-EMPLOYER))) }</EMPLOYERS_NAME>,
            <ADDRESS_INFO>
            { 
                    <ADDRESS_TYPE>01</ADDRESS_TYPE>,

                for $ARXNDO-ADDR-1 in $demographic/ARXNDO-ADDR-1
                return
                    <ADDRESS_LINE_1>{ fn-bea:trim(xs:string(data($ARXNDO-ADDR-1))) }</ADDRESS_LINE_1>,

                for $ARXNDO-ADDR-2 in $demographic/ARXNDO-ADDR-2
                return
                    <ADDRESS_LINE_2>{ fn-bea:trim(xs:string(data($ARXNDO-ADDR-2))) }</ADDRESS_LINE_2>,

                for $ARXNDO-ADDR-3 in $demographic/ARXNDO-ADDR-3
                return
                    <ADDRESS_LINE_3>{ fn-bea:trim(xs:string(data($ARXNDO-ADDR-3))) }</ADDRESS_LINE_3>,

                for $ARXNDO-ADDR-4 in $demographic/ARXNDO-ADDR-4
                return
                    <ADDRESS_LINE_4>{ fn-bea:trim(xs:string(data($ARXNDO-ADDR-4))) }</ADDRESS_LINE_4>,

                for $ARXNDO-PSTL-CD in $demographic/ARXNDO-PSTL-CD
                return
                    <CITY>
                    {
                     valorCatalogoAPPToOSB(string($ARXNDO-PSTL-CD/text()), 'VISION+', '7', $ptEquivalencias) 
                    }
                    </CITY>,

                for $ARXNDO-CITY-STATE in $demographic/ARXNDO-CITY-STATE
                return
                    <STATE>
                    { 
                    	valorCatalogoAPPToOSB(string($ARXNDO-CITY-STATE/text()), 'VISION+', '8', $ptEquivalencias) 
                    }
                    </STATE>,

                for $ARXNDO-CNTRY-CD in $demographic/ARXNDO-CNTRY-CD
                return
                    <COUNTRY>
                    {
                     	valorCatalogoAPPToOSB(string($ARXNDO-CNTRY-CD/text()), 'VISION+', '9', $ptEquivalencias)
                    }
                    </COUNTRY>,

                for $ARXNDO-MOBILE-PHONE in $demographic/ARXNDO-MOBILE-PHONE
                return
                    <MOBILE_NUMBER>{ fn-bea:trim(xs:string(data($ARXNDO-MOBILE-PHONE))) }</MOBILE_NUMBER>,

                for $ARXNDO-HOME-PHONE in $demographic/ARXNDO-HOME-PHONE
                return
                    <PHONE_NUMBER>{ fn-bea:trim(xs:string(data($ARXNDO-HOME-PHONE))) }</PHONE_NUMBER>
            }
            </ADDRESS_INFO>,
            <ADDRESS_INFO>
            { 
                    <ADDRESS_TYPE>02</ADDRESS_TYPE>,

                for $DIRRECION_1 in $row/ns0:Column[@name='direccion_dos_1']
                return
                    <ADDRESS_LINE_1>{ fn-bea:trim(xs:string(data($DIRRECION_1))) }</ADDRESS_LINE_1>,

                for $DIRRECION_2 in $row/ns0:Column[@name='direccion_dos_2']
                return
                    <ADDRESS_LINE_2>{ fn-bea:trim(xs:string(data($DIRRECION_2))) }</ADDRESS_LINE_2>,

                for $DIRRECION_3 in $row/ns0:Column[@name='direccion_dos_3']
                return
                    <ADDRESS_LINE_3>{fn-bea:trim(xs:string( data($DIRRECION_3))) }</ADDRESS_LINE_3>,

                for $CITY in $row/ns0:Column[@name='cod_postal_dos']
                return
                    <CITY>
                    {
                    	valorCatalogoAPPToOSB(string($CITY/text()), 'MASTERDATA', '7', $ptEquivalencias) 
                    }
                    </CITY>,

                for $STATE in $row/ns0:Column[@name='ciudad_dos']
                return
                    <STATE>
                    { 
                    	valorCatalogoAPPToOSB(string($STATE/text()), 'MASTERDATA', '8', $ptEquivalencias) 
                    }
                    </STATE>,

                for $PAIS in $row/ns0:Column[@name='pais_dos']
                return
                    <COUNTRY>
                    { 
                    	valorCatalogoAPPToOSB(string($PAIS/text()), 'MASTERDATA', '9', $ptEquivalencias) 
                    }
                    </COUNTRY>,

                for $ARXNDO-EMP-PHONE in $demographic/ARXNDO-EMP-PHONE
                return
                    <PHONE_NUMBER>{ fn-bea:trim(xs:string(data($ARXNDO-EMP-PHONE))) }</PHONE_NUMBER>,
                    
                for $ARXNDO-EMP-PHONE-EXTN in $demographic/ARXNDO-EMP-PHONE-EXTN
                return
                	<PHONE_EXT>{ fn-bea:trim(xs:string(data($ARXNDO-EMP-PHONE-EXTN))) }</PHONE_EXT>
            }
            </ADDRESS_INFO>,
            <ADDRESS_INFO>
            { 
                    <ADDRESS_TYPE>03</ADDRESS_TYPE>,

                for $DIRRECION_1 in $row/ns0:Column[@name='direccion_tres_1']
                return
                    <ADDRESS_LINE_1>{ fn-bea:trim(xs:string(data($DIRRECION_1))) }</ADDRESS_LINE_1>,

                for $DIRRECION_2 in $row/ns0:Column[@name='direccion_tres_2']
                return
                    <ADDRESS_LINE_2>{ fn-bea:trim(xs:string(data($DIRRECION_2))) }</ADDRESS_LINE_2>,

                for $DIRRECION_3 in $row/ns0:Column[@name='direccion_tres_3']
                return
                    <ADDRESS_LINE_3>{ fn-bea:trim(xs:string(data($DIRRECION_3))) }</ADDRESS_LINE_3>,

                for $CITY in $row/ns0:Column[@name='cod_postal_tres']
                return
                    <CITY>
                    { 
                    	valorCatalogoAPPToOSB(string($CITY/text()), 'MASTERDATA', '7', $ptEquivalencias) 
                    }
                    </CITY>,

                for $COD_POSTAL in $row/ns0:Column[@name='ciudad_tres']
                return
                    <STATE>
                    { 
                    	valorCatalogoAPPToOSB(string($COD_POSTAL/text()), 'MASTERDATA', '8', $ptEquivalencias) 
                    }
                    </STATE>,

                for $PAIS in $row/ns0:Column[@name='pais_tres']
                return
                    <COUNTRY>
                    { 
                    	valorCatalogoAPPToOSB(string($PAIS/text()), 'MASTERDATA', '9', $ptEquivalencias)
                    }
                    </COUNTRY>,
                for $ARXNDO-FAX-PHONE in $demographic/ARXNDO-FAX-PHONE
                return
                	<PHONE_NUMBER>{ fn-bea:trim(xs:string(data($ARXNDO-FAX-PHONE))) }</PHONE_NUMBER>
            }
            </ADDRESS_INFO>,
            <PROFESSION>{ data($demographic/ARXNDO-POSITION) }</PROFESSION>,
            <NATIONALITY>{ data($demographic/ARXNDO-USER-DEMO-2) }</NATIONALITY>,
            <POSITION>{ data($demographic/ARXNDO-USER-3) }</POSITION>,
             
         	for $MAIN_INCOME in $demographic/ARXNDO-USER-15
	        return	
	        	if (fn-bea:trim(string($MAIN_INCOME/text())) != '') then ( 
					<MAIN_INCOME>{ fn-bea:trim(string($MAIN_INCOME/text())) }</MAIN_INCOME>	
				) else(),
			for $SECONDARY_INCOME in $demographic/ARXNDO-USER-DEMO-1
    		return
			if(fn-bea:trim(string($SECONDARY_INCOME/text())) != '') then (
 				<SECONDARY_INCOME>{ fn-bea:trim(string($SECONDARY_INCOME/text())) }</SECONDARY_INCOME>
			)else(),
			<CLIENT_SEGMENT>{ data($demographic/ARXNDO-USER-6) }</CLIENT_SEGMENT>,
			<VIP_INDICATOR>{ data($demographic/ARXNDO-USER-7) }</VIP_INDICATOR>,
		  	<CONSUMPTION_SCORE>{ data($demographic/ARXNDO-USER-9) }</CONSUMPTION_SCORE>,
		    <LEGAL_DOCUMENT_NUMBER_2>{ data($demographic/ARXNDO-DL-NBR) }</LEGAL_DOCUMENT_NUMBER_2>,
            <LEGAL_DOCUMENT_COUNTRY_2>{ data($demographic/ARXNDO-DL-CNTRY) }</LEGAL_DOCUMENT_COUNTRY_2>,
            <EMPLOYMENT_YEARS>{ data($demographic/ARXNDO-USER-1) }</EMPLOYMENT_YEARS>,
            <EMPLOYMENT_MONTHS>{ data($demographic/ARXNDO-USER-2) }</EMPLOYMENT_MONTHS>,
            for $PEP_INDICATO in $demographic/ARXNDO-USER-8
	        return	
	        	if (fn-bea:trim(string($PEP_INDICATO/text())) != '') then ( 
					 <PEP_INDICATOR>{ $PEP_INDICATO}</PEP_INDICATOR>	
				)else()
           
        )
    }
    </ns1:consultaClienteTarjetasResponse>
};
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $customerDemographicInquiryResponse as element(ns2:CustomerDemographicInquiryResponse) external;
declare variable $ptEquivalencias as element() external;

xf:consultaClienteTarjetasOut($outputParameters,
    $customerDemographicInquiryResponse,
    $ptEquivalencias)