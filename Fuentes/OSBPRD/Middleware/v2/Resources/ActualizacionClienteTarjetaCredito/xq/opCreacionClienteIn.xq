(:: pragma bea:global-element-parameter parameter="$actualizacionClienteTarjetaCredito" element="ns1:actualizacionClienteTarjetaCredito" location="../xsd/actualizacionClienteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$ptEquivalencias" type="ns3:OutputParameters/ns3:PT_EQUIVALENCIAS" location="../../../BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CTS/clientesCredito/xsd/clientesCredito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/clientesCredito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizacionClienteTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/actualizacionClienteTarjetaCredito/xq/opCreacionClienteIn/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";

declare function valorCatalogoOSBToAPP($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns3:EQUIVALENCIA[ns3:CATALOGO_ID = $catalogoId and 
															  ns3:APLICACION_DESC = $aplicacion and 
															  ns3:VALOR_DESC = $valor]/ns3:EQUIVALENCIA_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:opCreacionClienteIn($actualizacionClienteTarjetaCredito as element(ns1:actualizacionClienteTarjetaCredito),
    $ptEquivalencias as element(),
    $sourceCode as xs:string,
    $emisorCode as xs:string,
    $applicationType as xs:string,
    $applicantType as xs:string,
    $prodLogo1 as xs:string,
    $rework as xs:string,
    $country as xs:string)
    as element(ns0:InputParameters) {
        let $countryOfBirth := valorCatalogoOSBToAPP(string($actualizacionClienteTarjetaCredito/COUNTRY_OF_BIRTH/text()), 'COBIS', '9', $ptEquivalencias)
        let $countryOfResidence := valorCatalogoOSBToAPP(string($actualizacionClienteTarjetaCredito/COUNTRY_OF_RESIDENCE/text()), 'COBIS', '9', $ptEquivalencias)
        return
            <ns0:InputParameters>
			    {
                   if(data($actualizacionClienteTarjetaCredito/PEP_CLIENT) != "" )then (

                     <ns0:i_usuario>{ data($actualizacionClienteTarjetaCredito/PEP_CLIENT) }</ns0:i_usuario>

                   )else(<ns0:i_usuario xsi:nil="true" />)
                }		
                <ns0:i_ssn xsi:nil="true" />				
                <ns0:i_reproceso>{ $rework }</ns0:i_reproceso>	
                <ns0:i_fechaproceso xsi:nil="true" />				
                <ns0:i_pais_envia>{ $country }</ns0:i_pais_envia>
                <ns0:i_emisor>{ $emisorCode }</ns0:i_emisor>
                <ns0:i_solicitud>{ $sourceCode }</ns0:i_solicitud>
			    {
                   if(data($actualizacionClienteTarjetaCredito/FIRST_NAME) != "" )then (

                     <ns0:i_p_nombre>{ fn:replace(data($actualizacionClienteTarjetaCredito/FIRST_NAME),"#","Ñ") }</ns0:i_p_nombre>

                   )else(<ns0:i_p_nombre xsi:nil="true" />)
                }				                
                {
                   if(data($actualizacionClienteTarjetaCredito/SECOND_NAME) != "" )then (

                     <ns0:i_s_nombre>{ fn:replace(data($actualizacionClienteTarjetaCredito/SECOND_NAME),"#","Ñ") }</ns0:i_s_nombre>

                   )else(<ns0:i_s_nombre xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/FIRST_SURNAME) != "" )then (

                     <ns0:i_p_apellido>{ fn:replace(data($actualizacionClienteTarjetaCredito/FIRST_SURNAME),"#","Ñ") }</ns0:i_p_apellido>

                   )else(<ns0:i_p_apellido xsi:nil="true" />)
                }				                
                {
                   if(data($actualizacionClienteTarjetaCredito/SECOND_SURNAME) != "" )then (

                     <ns0:i_s_apellido>{ fn:replace(data($actualizacionClienteTarjetaCredito/SECOND_SURNAME),"#","Ñ") }</ns0:i_s_apellido>

                   )else(<ns0:i_s_apellido xsi:nil="true" />)
                }
				<ns0:i_c_apellido xsi:nil="true" />
			    {
                   if(data($actualizacionClienteTarjetaCredito/GENDER) != "" )then (

                     <ns0:i_sexo>{ valorCatalogoOSBToAPP(string($actualizacionClienteTarjetaCredito/GENDER/text()), 'COBIS', '1', $ptEquivalencias) }</ns0:i_sexo>

                   )else(<ns0:i_sexo xsi:nil="true" />)
                }				    
			    {
                   if(data($actualizacionClienteTarjetaCredito/BIRTH_DATE) != "" )then (

                   <ns0:i_fecha_nac>
                    {
                        let $bornDate  := ($actualizacionClienteTarjetaCredito/BIRTH_DATE)  
                        return
                            (fn-bea:fail-over(fn-bea:dateTime-from-string-with-format('yyyyMMdd', fn-bea:date-to-string-with-format('yyyyMMdd', data($bornDate))),data($bornDate)))
                    }
				   </ns0:i_fecha_nac>

                   )else(<ns0:i_fecha_nac xsi:nil="true" />)
                }		
			    {
                   if(data($actualizacionClienteTarjetaCredito/MARITAL_STATUS) != "" )then (

                     <ns0:i_estado_civil>{ valorCatalogoOSBToAPP(string($actualizacionClienteTarjetaCredito/MARITAL_STATUS/text()), 'COBIS', '2', $ptEquivalencias) }</ns0:i_estado_civil>

                   )else(<ns0:i_estado_civil xsi:nil="true" />)
                }	
			    {
                   if(data($actualizacionClienteTarjetaCredito/COUNTRY_OF_BIRTH) != "" )then (

                     <ns0:i_pais_nac>{ $countryOfBirth }</ns0:i_pais_nac>

                   )else(<ns0:i_pais_nac xsi:nil="true" />)
                }	
			    {
                   if(data($actualizacionClienteTarjetaCredito/COUNTRY_OF_RESIDENCE) != "" )then (

                     <ns0:i_pais_res>{ $countryOfResidence }</ns0:i_pais_res>

                   )else(<ns0:i_pais_res xsi:nil="true" />)
                }			
			    {
                   if(data($actualizacionClienteTarjetaCredito/LEGAL_ID_TYPE) != "" )then (

                     <ns0:i_tipo_doc1>{ valorCatalogoOSBToAPP(string($actualizacionClienteTarjetaCredito/LEGAL_ID_TYPE/text()), 'COBIS', '4', $ptEquivalencias) }</ns0:i_tipo_doc1>

                   )else(<ns0:i_tipo_doc1 xsi:nil="true" />)
                }				                
			    {
                   if(data($actualizacionClienteTarjetaCredito/LEGAL_ID) != "" )then (

                     <ns0:i_doc1>{ data($actualizacionClienteTarjetaCredito/LEGAL_ID) }</ns0:i_doc1>

                   )else(<ns0:i_doc1 xsi:nil="true" />)
                }	
				<ns0:i_tipo_doc2 xsi:nil="true" />
                <ns0:i_doc2 xsi:nil="true" />				
			    {
                   if(data($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_1) != "" )then (

                     <ns0:i_dir_casa_1>{ fn:replace(data($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_1),"#","Ñ") }</ns0:i_dir_casa_1>

                   )else(<ns0:i_dir_casa_1 xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_2) != "" )then (

                     <ns0:i_dir_casa_2>{ fn:replace(data($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_2),"#","Ñ") }</ns0:i_dir_casa_2>

                   )else(<ns0:i_dir_casa_2 xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_3) != "" )then (

                     <ns0:i_dir_casa_3>{ fn:replace(data($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_3),"#","Ñ") }</ns0:i_dir_casa_3>

                   )else(<ns0:i_dir_casa_3 xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_4) != "" )then (

                     <ns0:i_dir_casa_4>{ fn:replace(data($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_4),"#","Ñ") }</ns0:i_dir_casa_4>

                   )else(<ns0:i_dir_casa_4 xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_1) != "" )then (

                     <ns0:i_dir_trab_1>{ fn:replace(data($actualizacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_1),"#","Ñ") }</ns0:i_dir_trab_1>

                   )else(<ns0:i_dir_trab_1 xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_2) != "" )then (

                     <ns0:i_dir_trab_2>{ fn:replace(data($actualizacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_2),"#","Ñ") }</ns0:i_dir_trab_2>

                   )else(<ns0:i_dir_trab_2 xsi:nil="true" />)
                }
                {
                   if(data($actualizacionClienteTarjetaCredito/WORK_ADDRESS_3) != "" )then (

                     <ns0:i_dir_trab_3>{ fn:replace(data($actualizacionClienteTarjetaCredito/WORK_ADDRESS_3),"#","Ñ") }</ns0:i_dir_trab_3>

                   )else(<ns0:i_dir_trab_3 xsi:nil="true" />)
                } 		
                {
                   if(data($actualizacionClienteTarjetaCredito/WORK_ADDRESS_4) != "" )then (

                     <ns0:i_dir_trab_4>{ fn:replace(data($actualizacionClienteTarjetaCredito/WORK_ADDRESS_4),"#","Ñ") }</ns0:i_dir_trab_4>

                   )else(<ns0:i_dir_trab_4 xsi:nil="true" />)
                }				
                <ns0:i_codpais_tel_casa>000</ns0:i_codpais_tel_casa>
                <ns0:i_codarea_tel_casa>000</ns0:i_codarea_tel_casa>
               {
                   if(data($actualizacionClienteTarjetaCredito/HOME_PHONE_NUMBER) != "" )then (

                     <ns0:i_tel_casa>{ data($actualizacionClienteTarjetaCredito/HOME_PHONE_NUMBER) }</ns0:i_tel_casa>

                   )else(<ns0:i_tel_casa xsi:nil="true" />)
                }                
                <ns0:i_ext_tel_casa>0</ns0:i_ext_tel_casa>
                <ns0:i_codpais_tel_trab>0</ns0:i_codpais_tel_trab>
                <ns0:i_codarea_tel_trab>0</ns0:i_codarea_tel_trab>
                {
                   if(data($actualizacionClienteTarjetaCredito/WORK_PHONE_NUMBER) != "" )then (

                     <ns0:i_tel_trab>{ data($actualizacionClienteTarjetaCredito/WORK_PHONE_NUMBER) }</ns0:i_tel_trab>

                   )else(<ns0:i_tel_trab xsi:nil="true" />)
                }  
                {
                   if(data($actualizacionClienteTarjetaCredito/WORK_EXTENSION) != "" )then (

                     <ns0:i_ext_tel_trab>{ xs:integer(data($actualizacionClienteTarjetaCredito/WORK_EXTENSION)) }</ns0:i_ext_tel_trab>

                   )else(<ns0:i_ext_tel_trab xsi:nil="true" />)
                }    
			    {
                   if(data($actualizacionClienteTarjetaCredito/EMAIL) != "" )then (

                     <ns0:i_email>{ data($actualizacionClienteTarjetaCredito/EMAIL) }</ns0:i_email>

                   )else(<ns0:i_email xsi:nil="true" />)
                }		
			    {
                   if(data($applicationType) != "" )then (

                     <ns0:i_tipo_aplicacion>{ data($applicationType) }</ns0:i_tipo_aplicacion>

                   )else(<ns0:i_tipo_aplicacion xsi:nil="true" />)
                }
			    {
                   if(data($applicantType) != "" )then (

                     <ns0:i_tipo_aplicante>{ data($applicantType) }</ns0:i_tipo_aplicante>

                   )else(<ns0:i_tipo_aplicante xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/WORKPLACE) != "" )then (

                     <ns0:i_nombre_corp>{ data($actualizacionClienteTarjetaCredito/WORKPLACE) }</ns0:i_nombre_corp>

                   )else(<ns0:i_nombre_corp xsi:nil="true" />)
                }	
                <ns0:i_localidad_corp xsi:nil="true" />
                <ns0:i_fecha_ini_corp xsi:nil="true" />
                <ns0:i_branch xsi:nil="true" />
                <ns0:i_destino_prestamo xsi:nil="true" />
                <ns0:i_flag_seguro xsi:nil="true" />
                <ns0:i_campo_adc_tr xsi:nil="true" />
                <ns0:i_intrs_desem xsi:nil="true" />
                <ns0:i_appid_acis xsi:nil="true" />
                <ns0:i_moneda1 xsi:nil="true" />				
			    {
                   if(data($prodLogo1) != "" )then (

                     <ns0:i_prod_logo1>{ data($prodLogo1) }</ns0:i_prod_logo1>

                   )else(<ns0:i_prod_logo1 xsi:nil="true" />)
                }
				<ns0:i_limite_credito1 xsi:nil="true" />
                <ns0:i_moneda2 xsi:nil="true" />
                <ns0:i_prod_logo2 xsi:nil="true" />
                <ns0:i_limite_credito2 xsi:nil="true" />
                <ns0:i_moneda3 xsi:nil="true" />
                <ns0:i_prod_logo3 xsi:nil="true" />
                <ns0:i_limite_credito3 xsi:nil="true" />
                <ns0:i_moneda4 xsi:nil="true" />
                <ns0:i_prod_logo4 xsi:nil="true" />
                <ns0:i_limite_credito4 xsi:nil="true" />
                <ns0:i_moneda5 xsi:nil="true" />
                <ns0:i_prod_logo5 xsi:nil="true" />
                <ns0:i_limite_credito5 xsi:nil="true" />
			    {
                   if(data($actualizacionClienteTarjetaCredito/CITY) != "" )then (

                     <ns0:i_ciudad>{ valorCatalogoOSBToAPP(string($actualizacionClienteTarjetaCredito/CITY/text()), 'COBIS', '7', $ptEquivalencias) }</ns0:i_ciudad>

                   )else(<ns0:i_ciudad xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/SF_FLOW) != "" )then (

                     <ns0:i_eb_nob>{ data($actualizacionClienteTarjetaCredito/SF_FLOW) }</ns0:i_eb_nob>

                   )else(<ns0:i_eb_nob xsi:nil="true" />)
                }   
				<ns0:i_forma_pago xsi:nil="true" />
                <ns0:i_cuenta_bco xsi:nil="true" />
                <ns0:i_cuota xsi:nil="true" />
                <ns0:i_plazo xsi:nil="true" />
                <ns0:i_debito_cuenta xsi:nil="true" />
                <ns0:i_credito_seg_endoso xsi:nil="true" />
                <ns0:i_bal_prod1 xsi:nil="true" />
                <ns0:i_bal_prod2 xsi:nil="true" />
                <ns0:i_bal_prod3 xsi:nil="true" />
                <ns0:i_bal_prod4 xsi:nil="true" />
                <ns0:i_bal_prod5 xsi:nil="true" />
                <ns0:i_bal_prod6 xsi:nil="true" />
                <ns0:i_bal_prod7 xsi:nil="true" />
                <ns0:i_bal_prod8 xsi:nil="true" />
                <ns0:i_bal_mon1 xsi:nil="true" />
                <ns0:i_bal_mon2 xsi:nil="true" />
                <ns0:i_bal_mon3 xsi:nil="true" />
                <ns0:i_bal_mon4 xsi:nil="true" />
                <ns0:i_bal_mon5 xsi:nil="true" />
                <ns0:i_bal_mon6 xsi:nil="true" />
                <ns0:i_bal_mon7 xsi:nil="true" />
                <ns0:i_bal_mon8 xsi:nil="true" />
                <ns0:i_bal_tipo1 xsi:nil="true" />
                <ns0:i_bal_tipo2 xsi:nil="true" />
                <ns0:i_bal_tipo3 xsi:nil="true" />
                <ns0:i_bal_tipo4 xsi:nil="true" />
                <ns0:i_bal_tipo5 xsi:nil="true" />
                <ns0:i_bal_tipo6 xsi:nil="true" />
                <ns0:i_bal_tipo7 xsi:nil="true" />
                <ns0:i_bal_tipo8 xsi:nil="true" />
                <ns0:i_bal_cta_nombre1 xsi:nil="true" />
                <ns0:i_bal_cta_nombre2 xsi:nil="true" />
                <ns0:i_bal_cta_nombre3 xsi:nil="true" />
                <ns0:i_bal_cta_nombre4 xsi:nil="true" />
                <ns0:i_bal_cta_nombre5 xsi:nil="true" />
                <ns0:i_bal_cta_nombre6 xsi:nil="true" />
                <ns0:i_bal_cta_nombre7 xsi:nil="true" />
                <ns0:i_bal_cta_nombre8 xsi:nil="true" />
                <ns0:i_bal_cta_num1 xsi:nil="true" />
                <ns0:i_bal_cta_num2 xsi:nil="true" />
                <ns0:i_bal_cta_num3 xsi:nil="true" />
                <ns0:i_bal_cta_num4 xsi:nil="true" />
                <ns0:i_bal_cta_num5 xsi:nil="true" />
                <ns0:i_bal_cta_num6 xsi:nil="true" />
                <ns0:i_bal_cta_num7 xsi:nil="true" />
                <ns0:i_bal_cta_num8 xsi:nil="true" />
			    {
                   if(data($actualizacionClienteTarjetaCredito/RESIDENCE_TYPE) != "" )then (

                     <ns0:i_nombre_ben1>{ data($actualizacionClienteTarjetaCredito/RESIDENCE_TYPE) }</ns0:i_nombre_ben1>

                   )else(<ns0:i_nombre_ben1 xsi:nil="true" />)
                }   
				<ns0:i_nombre_ben2 xsi:nil="true" />
                <ns0:i_nombre_ben3 xsi:nil="true" />
                <ns0:i_cobertura_ben1 xsi:nil="true" />
                <ns0:i_cobertura_ben2 xsi:nil="true" />
                <ns0:i_cobertura_ben3 xsi:nil="true" />
                <ns0:i_capacida_deuda xsi:nil="true" />
                <ns0:i_mis xsi:nil="true" />
                <ns0:i_ejecutivo xsi:nil="true" />
                <ns0:i_staff_ind xsi:nil="true" />
                <ns0:i_reason_fa xsi:nil="true" />
                <ns0:i_bal_pmt1 xsi:nil="true" />
                <ns0:i_bal_pmt2 xsi:nil="true" />
                <ns0:i_bal_pmt3 xsi:nil="true" />
                <ns0:i_bal_pmt4 xsi:nil="true" />
                <ns0:i_bal_pmt5 xsi:nil="true" />
			    {
                   if(data($actualizacionClienteTarjetaCredito/OPERATION_TYPE) != "" )then (

                     <ns0:i_operacion>{ data($actualizacionClienteTarjetaCredito/OPERATION_TYPE) }</ns0:i_operacion>

                   )else(<ns0:i_operacion xsi:nil="true" />)
                }				                              
                {
                   if(data($actualizacionClienteTarjetaCredito/ALTERNATE_CLIENT_EMAIL) != "" )then (

                     <ns0:i_email_alterno>{ data($actualizacionClienteTarjetaCredito/ALTERNATE_CLIENT_EMAIL) }</ns0:i_email_alterno>            

                   )else(<ns0:i_email_alterno xsi:nil="true" />)
                }    
			    {
                   if(data($actualizacionClienteTarjetaCredito/SALARY_RANGE) != "" )then (

                     <ns0:i_rango_salario>{ data($actualizacionClienteTarjetaCredito/SALARY_RANGE) }</ns0:i_rango_salario>

                   )else(<ns0:i_rango_salario xsi:nil="true" />)
                }	
			    {
                   if(data($actualizacionClienteTarjetaCredito/WORK_ECONOMIC_ACTIVITY) != "" )then (

                     <ns0:i_giro_empresa>{ data($actualizacionClienteTarjetaCredito/WORK_ECONOMIC_ACTIVITY) }</ns0:i_giro_empresa>

                   )else(<ns0:i_giro_empresa xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/WORK_STATE) != "" )then (

                     <ns0:i_dpto_empresa>{ data($actualizacionClienteTarjetaCredito/WORK_STATE) }</ns0:i_dpto_empresa>

                   )else(<ns0:i_dpto_empresa xsi:nil="true" />)
                }		
			    {
                   if(data($actualizacionClienteTarjetaCredito/CLIENT_ECONOMIC_ACTIVITY) != "" )then (

                     <ns0:i_cte_act_econom>{ data($actualizacionClienteTarjetaCredito/CLIENT_ECONOMIC_ACTIVITY) }</ns0:i_cte_act_econom>

                   )else(<ns0:i_cte_act_econom xsi:nil="true" />)
                }				
                {
                   if(data($actualizacionClienteTarjetaCredito/EDUCATION_LEVEL) != "" )then (

                     <ns0:i_grado_estudio>{ data($actualizacionClienteTarjetaCredito/EDUCATION_LEVEL) }</ns0:i_grado_estudio>            

                   )else(<ns0:i_grado_estudio xsi:nil="true" />)
                }        
			    {
                   if(data($actualizacionClienteTarjetaCredito/CITY_OF_BIRTH) != "" )then (

                     <ns0:i_ciudad_nac>{ data($actualizacionClienteTarjetaCredito/CITY_OF_BIRTH) }</ns0:i_ciudad_nac>

                   )else(<ns0:i_ciudad_nac xsi:nil="true" />)
                }				
                {
                   if(data($actualizacionClienteTarjetaCredito/MONTHLY_INCOME) != "" )then (

                     <ns0:i_sueldo_declarado>{ data($actualizacionClienteTarjetaCredito/MONTHLY_INCOME) }</ns0:i_sueldo_declarado>            

                   )else(<ns0:i_sueldo_declarado xsi:nil="true" />)
                }   
			    {
                   if(data($actualizacionClienteTarjetaCredito/NATURE_OF_BUSINESS) != "" )then (

                     <ns0:i_naturaleza_neg>{ data($actualizacionClienteTarjetaCredito/NATURE_OF_BUSINESS) }</ns0:i_naturaleza_neg>

                   )else(<ns0:i_naturaleza_neg xsi:nil="true" />)
                }				            
                {
                   if(data($actualizacionClienteTarjetaCredito/ISSUE_DATE_CLIENT_ID) != "" )then (

                     <ns0:i_fecha_emision_id1>{ data($actualizacionClienteTarjetaCredito/ISSUE_DATE_CLIENT_ID) }</ns0:i_fecha_emision_id1>            

                   )else(<ns0:i_fecha_emision_id1 xsi:nil="true" />)
                }      			
                {
                   if(data($actualizacionClienteTarjetaCredito/EXPIRATION_DATE_CLIENT_ID) != "" )then (

                     <ns0:i_fecha_expira_id1>{ data($actualizacionClienteTarjetaCredito/EXPIRATION_DATE_CLIENT_ID) }</ns0:i_fecha_expira_id1>

                   )else(<ns0:i_fecha_expira_id1 xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_TYPE1) != "" )then (

                     <ns0:i_personalReferenceType1>{ data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_TYPE1) }</ns0:i_personalReferenceType1>

                   )else(<ns0:i_personalReferenceType1 xsi:nil="true" />)
                }		
			    {
                   if(data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_NAME1) != "" )then (

                     <ns0:i_personalReferenceName1>{ data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_NAME1) }</ns0:i_personalReferenceName1>

                   )else(<ns0:i_personalReferenceName1 xsi:nil="true" />)
                }				             
                {
                   if(data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_PHONE1) != "" )then (

                     <ns0:i_personalReferencePhone1>{ data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_PHONE1) }</ns0:i_personalReferencePhone1>

                   )else(<ns0:i_personalReferencePhone1 xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_TYPE2) != "" )then (

                     <ns0:i_personalReferenceType2>{ data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_TYPE2) }</ns0:i_personalReferenceType2>

                   )else(<ns0:i_personalReferenceType2 xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_NAME2) != "" )then (

                     <ns0:i_personalReferenceName2>{ data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_NAME2) }</ns0:i_personalReferenceName2>

                   )else(<ns0:i_personalReferenceName2 xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_PHONE2) != "" )then (

                     <ns0:i_personalReferencePhone2>{ data($actualizacionClienteTarjetaCredito/PERSONAL_REFERENCE_PHONE2) }</ns0:i_personalReferencePhone2>

                   )else(<ns0:i_personalReferencePhone2 xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/NAMES_SPOUSE) != "" )then (

                     <ns0:i_spouseNames>{ data($actualizacionClienteTarjetaCredito/NAMES_SPOUSE) }</ns0:i_spouseNames>

                   )else(<ns0:i_spouseNames xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/SURNAMES_SPOUSE) != "" )then (

                     <ns0:i_spouseSurnames>{ data($actualizacionClienteTarjetaCredito/SURNAMES_SPOUSE) }</ns0:i_spouseSurnames>

                   )else(<ns0:i_spouseSurnames xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/EMAIL_SPOUSE) != "" )then (

                     <ns0:i_spouseEmail>{ data($actualizacionClienteTarjetaCredito/EMAIL_SPOUSE) }</ns0:i_spouseEmail>

                   )else(<ns0:i_spouseEmail xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/DATE_OF_BIRTH_SPOUSE) != "" )then (

                     <ns0:i_spouseDateOfBirth>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-ddHH:mm:ss", concat(data($actualizacionClienteTarjetaCredito/DATE_OF_BIRTH_SPOUSE),xs:time("00:00:00")))}</ns0:i_spouseDateOfBirth>

                   )else(<ns0:i_spouseDateOfBirth xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/SPOUSE_ID_TYPE) != "" )then (

                     <ns0:i_spouseIDType>{ valorCatalogoOSBToAPP(string($actualizacionClienteTarjetaCredito/SPOUSE_ID_TYPE/text()), 'COBIS', '4', $ptEquivalencias) }</ns0:i_spouseIDType>

                   )else(<ns0:i_spouseIDType xsi:nil="true" />)
                }                 
                {
                   if(data($actualizacionClienteTarjetaCredito/SPOUSE_ID) != "" )then (

                     <ns0:i_spouseID>{ data($actualizacionClienteTarjetaCredito/SPOUSE_ID) }</ns0:i_spouseID>

                   )else(<ns0:i_spouseID xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/SPOUSE_PHONE) != "" )then (

                     <ns0:i_spousePhone>{ data($actualizacionClienteTarjetaCredito/SPOUSE_PHONE) }</ns0:i_spousePhone>

                   )else(<ns0:i_spousePhone xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/LOGIN_APP) != "" )then (

                     <ns0:i_login>{ data($actualizacionClienteTarjetaCredito/LOGIN_APP) }</ns0:i_login>

                   )else(<ns0:i_login xsi:nil="true" />)
                }  
                {
                   if(data($actualizacionClienteTarjetaCredito/USER_NAME) != "" )then (

                     <ns0:i_userName>{ data($actualizacionClienteTarjetaCredito/USER_NAME) }</ns0:i_userName>

                   )else(<ns0:i_userName xsi:nil="true" />)
                } 				
                {
                   if(data($actualizacionClienteTarjetaCredito/ID_CREDIT_REQUEST) != "" )then (

                     <ns0:i_idCreditRequest>{ data($actualizacionClienteTarjetaCredito/ID_CREDIT_REQUEST) }</ns0:i_idCreditRequest>

                   )else(<ns0:i_idCreditRequest xsi:nil="true" />)
                }  
                {
                   if(data($actualizacionClienteTarjetaCredito/ID_SALEFORCE_REQUEST) != "" )then (

                     <ns0:i_idSaleForceRequest>{ data($actualizacionClienteTarjetaCredito/ID_SALEFORCE_REQUEST) }</ns0:i_idSaleForceRequest>

                   )else(<ns0:i_idSaleForceRequest xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/SELLER_CODE) != "" )then (

                     <ns0:i_sellerCode>{ data($actualizacionClienteTarjetaCredito/SELLER_CODE) }</ns0:i_sellerCode>

                   )else(<ns0:i_sellerCode xsi:nil="true" />)
                }                
                {
                   if(data($actualizacionClienteTarjetaCredito/SUPERVISOR_CODE) != "" )then (

                     <ns0:i_supervisorCode>{ data($actualizacionClienteTarjetaCredito/SUPERVISOR_CODE) }</ns0:i_supervisorCode>

                   )else(<ns0:i_supervisorCode xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/WORK_MUNICIPALITY) != "" )then (

                     <ns0:i_jobMunicipality>{ data($actualizacionClienteTarjetaCredito/WORK_MUNICIPALITY) }</ns0:i_jobMunicipality>

                   )else(<ns0:i_jobMunicipality xsi:nil="true" />)
                }		
			    {
                   if(data($actualizacionClienteTarjetaCredito/HOME_MUNICIPALITY) != "" )then (

                     <ns0:i_homeMunicipality>{ data($actualizacionClienteTarjetaCredito/HOME_MUNICIPALITY) }</ns0:i_homeMunicipality>

                   )else(<ns0:i_homeMunicipality xsi:nil="true" />)
                }			
			    {
                   if(data($actualizacionClienteTarjetaCredito/HOME_STATE) != "" )then (

                     <ns0:i_homeState>{ data($actualizacionClienteTarjetaCredito/HOME_STATE) }</ns0:i_homeState>

                   )else(<ns0:i_homeState xsi:nil="true" />)
                }				
                {
                   if(data($actualizacionClienteTarjetaCredito/PROFESSION) != "" )then (

                     <ns0:i_professionCode>{ data($actualizacionClienteTarjetaCredito/PROFESSION) }</ns0:i_professionCode>

                   )else(<ns0:i_professionCode xsi:nil="true" />)
                }                
			    {
                   if(data($actualizacionClienteTarjetaCredito/WORK_TITLE) != "" )then (

                     <ns0:i_titleEmployment>{ data($actualizacionClienteTarjetaCredito/WORK_TITLE) }</ns0:i_titleEmployment>

                   )else(<ns0:i_titleEmployment xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/MOBILE_PHONE) != "" )then (

                     <ns0:i_mobilePhone>{ data($actualizacionClienteTarjetaCredito/MOBILE_PHONE) }</ns0:i_mobilePhone>

                   )else(<ns0:i_mobilePhone xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/CHANNEL) != "" )then (

                     <ns0:i_canal>{ data($actualizacionClienteTarjetaCredito/CHANNEL) }</ns0:i_canal>

                   )else(<ns0:i_canal xsi:nil="true" />)
                }		
			    {
                   if(data($actualizacionClienteTarjetaCredito/OFFICE) != "" )then (

                     <ns0:i_oficina>{ data($actualizacionClienteTarjetaCredito/OFFICE) }</ns0:i_oficina>

                   )else(<ns0:i_oficina xsi:nil="true" />)
                }				
                {
                   if(data($actualizacionClienteTarjetaCredito/OTHER_ANNUAL_INCOME) != "" )then (

                     <ns0:i_otros_ing_anual>{ data($actualizacionClienteTarjetaCredito/OTHER_ANNUAL_INCOME) }</ns0:i_otros_ing_anual>

                   )else(<ns0:i_otros_ing_anual xsi:nil="true" />)
                }   
			    {
                   if(data($actualizacionClienteTarjetaCredito/SOURCE_OTHER_INCOME) != "" )then (

                     <ns0:i_fuente_otros_ing>{ data($actualizacionClienteTarjetaCredito/SOURCE_OTHER_INCOME) }</ns0:i_fuente_otros_ing>

                   )else(<ns0:i_fuente_otros_ing xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/YEARS_OF_RESIDENCE) != "" )then (

                     <ns0:i_anios_residencia>{ data($actualizacionClienteTarjetaCredito/YEARS_OF_RESIDENCE) }</ns0:i_anios_residencia>

                   )else(<ns0:i_anios_residencia xsi:nil="true" />)
                }	
			    {
                   if(data($actualizacionClienteTarjetaCredito/MONTHS_OF_RESIDENCE) != "" )then (

                     <ns0:i_meses_residencia>{ data($actualizacionClienteTarjetaCredito/MONTHS_OF_RESIDENCE) }</ns0:i_meses_residencia>

                   )else(<ns0:i_meses_residencia xsi:nil="true" />)
                }				
                {
                   if(data($actualizacionClienteTarjetaCredito/ALTERNATE_TELEPHONE) != "" )then (

                     <ns0:i_tel_alterno>{ data($actualizacionClienteTarjetaCredito/ALTERNATE_TELEPHONE) }</ns0:i_tel_alterno>

                   )else(<ns0:i_tel_alterno xsi:nil="true" />)
                }                         
			    {
                   if(data($actualizacionClienteTarjetaCredito/POSITION_OCCUPATION) != "" )then (

                     <ns0:i_cargo_ocupacion>{ data($actualizacionClienteTarjetaCredito/POSITION_OCCUPATION) }</ns0:i_cargo_ocupacion>

                   )else(<ns0:i_cargo_ocupacion xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/JOB_CODE) != "" )then (

                     <ns0:i_cod_cargo>{ data($actualizacionClienteTarjetaCredito/JOB_CODE) }</ns0:i_cod_cargo>

                   )else(<ns0:i_cod_cargo xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/SENIORITY_EMPLOYEE_YEARS) != "" )then (

                     <ns0:i_antiguedad_emp_anio>{ data($actualizacionClienteTarjetaCredito/SENIORITY_EMPLOYEE_YEARS) }</ns0:i_antiguedad_emp_anio>

                   )else(<ns0:i_antiguedad_emp_anio xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/SENIORITY_EMPLOYEE_MONTHS) != "" )then (

                     <ns0:i_antiguedad_emp_mes>{ data($actualizacionClienteTarjetaCredito/SENIORITY_EMPLOYEE_MONTHS) }</ns0:i_antiguedad_emp_mes>

                   )else(<ns0:i_antiguedad_emp_mes xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/IS_PEP) != "" )then (

                     <ns0:i_es_pep>{ data($actualizacionClienteTarjetaCredito/IS_PEP) }</ns0:i_es_pep>

                   )else(<ns0:i_es_pep xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/DEPARTMENT_WORK) != "" )then (

                     <ns0:i_departamento_trab>{ data($actualizacionClienteTarjetaCredito/DEPARTMENT_WORK) }</ns0:i_departamento_trab>

                   )else(<ns0:i_departamento_trab xsi:nil="true" />)
                }				
			    {
                   if(data($actualizacionClienteTarjetaCredito/COUNTRY_WORK) != "" )then (

                     <ns0:i_pais_trabajo>{ data($actualizacionClienteTarjetaCredito/COUNTRY_WORK) }</ns0:i_pais_trabajo>

                   )else(<ns0:i_pais_trabajo xsi:nil="true" />)
                }			
			    {
                   if(data($actualizacionClienteTarjetaCredito/ALTERNATE_ADDRESS) != "" )then (

                     <ns0:i_dir_alterna>{ data($actualizacionClienteTarjetaCredito/ALTERNATE_ADDRESS) }</ns0:i_dir_alterna>

                   )else(<ns0:i_dir_alterna xsi:nil="true" />)
                }
			    {
                   if(data($actualizacionClienteTarjetaCredito/COMMENTS) != "" )then (

                     <ns0:i_comentarios>{ data($actualizacionClienteTarjetaCredito/COMMENTS) }</ns0:i_comentarios>

                   )else(<ns0:i_comentarios xsi:nil="true" />)
                }				
            </ns0:InputParameters>
};

declare variable $actualizacionClienteTarjetaCredito as element(ns1:actualizacionClienteTarjetaCredito) external;
declare variable $ptEquivalencias as element() external;
declare variable $sourceCode as xs:string external;
declare variable $emisorCode as xs:string external;
declare variable $applicationType as xs:string external;
declare variable $applicantType as xs:string external;
declare variable $prodLogo1 as xs:string external;
declare variable $rework as xs:string external;
declare variable $country as xs:string external;

xf:opCreacionClienteIn($actualizacionClienteTarjetaCredito,
    $ptEquivalencias,
    $sourceCode,
    $emisorCode,
    $applicationType,
    $applicantType,
    $prodLogo1,
    $rework,
    $country)