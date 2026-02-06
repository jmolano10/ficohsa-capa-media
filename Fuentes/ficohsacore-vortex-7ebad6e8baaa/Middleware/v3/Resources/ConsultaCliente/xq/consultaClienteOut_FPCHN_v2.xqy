xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaClienteRequest1" element="ns4:consultaClienteRequest" location="../xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParametersTelefono" element="ns3:OutputParameters" location="../../../../v2/BusinessServices/FPC/consultaTelefonoPersona/xsd/consultaTelefonoPersonaFPC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParametersDireccion" element="ns0:OutputParameters" location="../../../../v2/BusinessServices/FPC/consultaDireccionPersona/xsd/consultaDireccionPersonaFPC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParametersEmail" element="ns2:OutputParameters" location="../../../../v2/BusinessServices/FPC/consultaEmailPersona/xsd/consultaEmailPersonaFPC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParametersTrabajo" element="ns1:OutputParameters" location="../../../../v2/BusinessServices/FPC/consultaTrabajoPersona/xsd/consultaTrabajoPersonaFPC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParametersInfoPersona" element="ns5:OutputParameters" location="../../../../v2/BusinessServices/FPC/consultaInformacionPersona/xsd/consultaInformacionPersonaFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns4:consultaClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEmailPersonaFPC";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTrabajoPersonaFPC";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTelefonoPersonaFPC";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDireccionPersonaFPC";
declare namespace ns5 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteOut_FPCHN_v2/";

declare function local:format-date-from-FPC($textdate as xs:string) as xs:string
{
	fn:concat(fn:substring($textdate,1,4),fn:substring($textdate,6,2),fn:substring($textdate,9,2),fn:substring($textdate,12,2),fn:substring($textdate,15,2),fn:substring($textdate,18,2))
};
declare function local:decode-values($target as xs:string, $fieldname as xs:string, $fieldvalue as xs:string) as xs:string
{	
	let $e := element{fn:concat($target,'_',$fieldname,'_',$fieldvalue)}{}
	return
		typeswitch($e)
			case element(FPCHN_YESNO_S) return 'YES'
			case element(FPCHN_YESNO_N) return 'NO'		
			case element(FPCHN_PHONELOCATION_C) return 'HOME'
			case element(FPCHN_PHONELOCATION_T) return 'WORK'
			case element(FPCHN_PHONELOCATION_O) return 'OTHER'
			case element(FPCHN_PHONETYPE_B) return 'BEEPER'
			case element(FPCHN_PHONETYPE_C) return 'MOBILE'
			case element(FPCHN_PHONETYPE_D) return 'LANDLINE'
			case element(FPCHN_PHONETYPE_F) return 'FAX'
			case element(FPCHN_PHONETYPE_R) return 'PBX'
			case element(FPCHN_PHONETYPE_T) return 'TELEFAX'
			case element(FPCHN_PHONETYPE_O) return 'OTHER'	
			case element(FPCHN_ADDRESSTYPE_C) return 'HOME'		
			case element(FPCHN_ADDRESSTYPE_T) return 'WORK'
			case element(FPCHN_ADDRESSTYPE_R) return 'MAILBOX'
			case element(FPCHN_ADDRESSTYPE_O) return 'OTHER'	
			case element(FPCHN_INCOMETYPE_S) return 'SALARY'
			case element(FPCHN_INCOMETYPE_I) return 'FREELANCE'
			case element(FPCHN_INCOMETYPE_H) return 'FEE'
			case element(FPCHN_INCOMETYPE_O) return 'OTHER'								
		default return '' 		
		 
};

declare function xf:consultaClienteOut_FPCHN($consultaClienteRequest1 as element(ns4:consultaClienteRequest),
    $outputParametersTelefono as element(ns3:OutputParameters),
    $outputParametersDireccion as element(ns0:OutputParameters),
    $outputParametersEmail as element(ns2:OutputParameters),
    $outputParametersTrabajo as element(ns1:OutputParameters),
    $outputParametersInfoPersona as element(ns5:OutputParameters))
    as element(ns4:consultaClienteResponse) {
        <ns4:consultaClienteResponse>
            {
            if ($consultaClienteRequest1/ns4:CUSTOMER_ID_TYPE/text() = ('CODE','CUSTOMER_ID')) then
            	<ns4:CUSTOMER_ID>{ data($consultaClienteRequest1/ns4:CUSTOMER_ID_VALUE) }</ns4:CUSTOMER_ID>
            else if ($consultaClienteRequest1/ns4:CUSTOMER_ID_TYPE/text() = 'ACCOUNT_NUMBER') then
            	<ns4:CUSTOMER_ID>{data ($outputParametersInfoPersona/ns5:PC_COD_PERSONA_SYSDE)}</ns4:CUSTOMER_ID>
            else
            	<ns4:CUSTOMER_ID/>
            }            
            {
                for $PT_IDENTIFICACIONES in $outputParametersInfoPersona/ns5:PT_IDENTIFICACIONES
                return
                    <ns4:IDENTIFICATION_INFO>
                        {
                            for $PT_IDENTIFICACIONES_ITEM in $PT_IDENTIFICACIONES/ns5:PT_IDENTIFICACIONES_ITEM
                            return
                                <ns4:LEGAL_IDENTIFICATION_ITEM>
                                    <ns4:LEGAL_DOCUMENT_NAME>{ data($PT_IDENTIFICACIONES_ITEM/ns5:COD_TIPO_ID) }</ns4:LEGAL_DOCUMENT_NAME>
                                    <ns4:LEGAL_ID>{ data($PT_IDENTIFICACIONES_ITEM/ns5:NUM_ID) }</ns4:LEGAL_ID>
                                    <ns4:EXPIRATION_DATE>{ local:format-date-from-FPC(data($PT_IDENTIFICACIONES_ITEM/ns5:FEC_VENCIMIENTO)) }</ns4:EXPIRATION_DATE>
                                </ns4:LEGAL_IDENTIFICATION_ITEM>
                        }
                    </ns4:IDENTIFICATION_INFO>
            }
            <ns4:FULL_NAME>{data($outputParametersInfoPersona/ns5:PC_NOMBRE_COMPLETO)}</ns4:FULL_NAME>
            <ns4:DATE_OF_BIRTH>{local:format-date-from-FPC(data($outputParametersInfoPersona/ns5:PD_FEC_NACIMIENTO))}</ns4:DATE_OF_BIRTH>
			{
            if ($outputParametersTelefono/ns3:PN_CODIGO_ERROR/text() = '0') then						
            <ns4:PHONE_INFO>
                {
                    for $PT_TELEFONOS_ITEM in $outputParametersTelefono/ns3:PT_TELEFONOS/ns3:PT_TELEFONOS_ITEM
                    return
                        <ns4:PHONE_NUMBER_ITEM>
                            <ns4:PHONE_LOCATION>{ local:decode-values('FPCHN','PHONELOCATION',data($PT_TELEFONOS_ITEM/ns3:TEL_UBICACION)) }</ns4:PHONE_LOCATION>
                            <ns4:PHONE_TYPE>{ local:decode-values('FPCHN','PHONETYPE',data($PT_TELEFONOS_ITEM/ns3:TIP_TELEFONO)) }</ns4:PHONE_TYPE>
                            <ns4:PHONE_AREA_CODE>{ data($PT_TELEFONOS_ITEM/ns3:COD_AREA) }</ns4:PHONE_AREA_CODE>
                            <ns4:PHONE_NUMBER>{ data($PT_TELEFONOS_ITEM/ns3:NUM_TELEFONO) }</ns4:PHONE_NUMBER>
                            <ns4:IS_DEFAULT>{ local:decode-values('FPCHN','YESNO',data($PT_TELEFONOS_ITEM/ns3:ES_DEFAULT)) }</ns4:IS_DEFAULT>
                        </ns4:PHONE_NUMBER_ITEM>
                }
            </ns4:PHONE_INFO>
            else
            	<ns4:PHONE_INFO/>
            }

			{
			if ($outputParametersDireccion/ns0:PN_CODIGO_ERROR/text() = '0') then			
            <ns4:ADDRESS_INFO>
                {
                    for $PT_DIRECCIONES_ITEM in $outputParametersDireccion/ns0:PT_DIRECCIONES/ns0:PT_DIRECCIONES_ITEM
                    return
                        <ns4:ADDRESS_ITEM>
                            <ns4:ADDRESS_CODE>{ data($PT_DIRECCIONES_ITEM/ns0:COD_DIRECCION) }</ns4:ADDRESS_CODE>
                            <ns4:ADDRESS_TYPE>{ local:decode-values('FPCHN','ADDRESSTYPE',data($PT_DIRECCIONES_ITEM/ns0:TIP_DIRECCION)) }</ns4:ADDRESS_TYPE>
                            <ns4:POBOX>{ data($PT_DIRECCIONES_ITEM/ns0:APARTADO_POSTAL) }</ns4:POBOX>
                            <ns4:ZIPCODE>{ data($PT_DIRECCIONES_ITEM/ns0:COD_POSTAL) }</ns4:ZIPCODE>
                            <ns4:COUNTRY_CODE>{ data($PT_DIRECCIONES_ITEM/ns0:COD_PAIS) }</ns4:COUNTRY_CODE>
                            <ns4:DEPARTMENT_CODE>{ data($PT_DIRECCIONES_ITEM/ns0:COD_PROVINCIA) }</ns4:DEPARTMENT_CODE>
                            <ns4:MUNICIPALITY_CODE>{ data($PT_DIRECCIONES_ITEM/ns0:COD_CANTON) }</ns4:MUNICIPALITY_CODE>
                            <ns4:CITY_CODE>{ data($PT_DIRECCIONES_ITEM/ns0:COD_DISTRITO) }</ns4:CITY_CODE>
                            <ns4:DISTRICT_CODE>{ data($PT_DIRECCIONES_ITEM/ns0:COD_PUEBLO) }</ns4:DISTRICT_CODE>
                            <ns4:ADDRESS_LINE_1>{ data($PT_DIRECCIONES_ITEM/ns0:DES_DOMICILIO) }</ns4:ADDRESS_LINE_1>
                            <ns4:ADDRESS_LINE_2>{ data($PT_DIRECCIONES_ITEM/ns0:DES_EDIFICIO) }</ns4:ADDRESS_LINE_2>
                            <ns4:ADDRESS_LINE_3>{ data($PT_DIRECCIONES_ITEM/ns0:DES_PISO) }</ns4:ADDRESS_LINE_3>
                            <ns4:ADDRESS_LINE_4>{ data($PT_DIRECCIONES_ITEM/ns0:DES_APTO) }</ns4:ADDRESS_LINE_4>
                            <ns4:ADDRESS_LINE_5>{ data($PT_DIRECCIONES_ITEM/ns0:DETALLE) }</ns4:ADDRESS_LINE_5>
                            <ns4:IS_MAIN_ADDRESS>{ local:decode-values('FPCHN','YESNO',data($PT_DIRECCIONES_ITEM/ns0:ES_DEFAULT)) }</ns4:IS_MAIN_ADDRESS>
                        </ns4:ADDRESS_ITEM>
                }
            </ns4:ADDRESS_INFO>
            else
            	<ns4:ADDRES_INFO/>
            }


			{
            if ($outputParametersEmail/ns2:PN_CODIGO_ERROR/text() = '0') then			
            <ns4:EMAIL_INFO>
                {
                    for $PT_EMAILS_ITEM in $outputParametersEmail/ns2:PT_EMAILS/ns2:PT_EMAILS_ITEM
                    return
                        <ns4:EMAIL_ITEM>
                            <ns4:EMAIL_CODE>{ data($PT_EMAILS_ITEM/ns2:COD_EMAIL) }</ns4:EMAIL_CODE>
                            <ns4:EMAIL_ADDRESS>{ fn:concat(data($PT_EMAILS_ITEM/ns2:EMAIL_USUARIO),'@',data($PT_EMAILS_ITEM/ns2:EMAIL_SERVIDOR)) }</ns4:EMAIL_ADDRESS>
                            <ns4:IS_DEFAULT>{ local:decode-values('FPCHN','YESNO',data($PT_EMAILS_ITEM/ns2:ES_DEFAULT)) }</ns4:IS_DEFAULT>
                        </ns4:EMAIL_ITEM>
                }
            </ns4:EMAIL_INFO>
            else
            	<ns4:EMAIL_INFO/>
            }
            
            {
            if ($outputParametersTrabajo/ns1:PN_CODIGO_ERROR/text() = '0') then
            <ns4:JOB_INFO>
                {                	
                    for $PT_INFO_LABORAL_ITEM in $outputParametersTrabajo/ns1:PT_INFO_LABORAL/ns1:PT_INFO_LABORAL_ITEM
                    return
                        <ns4:JOB_ITEM>
                            <ns4:EMPLOYER_CODE>{ data($PT_INFO_LABORAL_ITEM/ns1:COD_PATRONAL) }</ns4:EMPLOYER_CODE>
                            <ns4:EMPLOYER_NAME>{ data($PT_INFO_LABORAL_ITEM/ns1:NOM_PATRONAL) }</ns4:EMPLOYER_NAME>
                            <ns4:JOB_CODE>{ data($PT_INFO_LABORAL_ITEM/ns1:COD_CARGO) }</ns4:JOB_CODE>
                            <ns4:JOB_DESCRIPTION>{ data($PT_INFO_LABORAL_ITEM/ns1:PUESTO) }</ns4:JOB_DESCRIPTION>
                            <ns4:INCOME_TYPE>{ local:decode-values('FPCHN','INCOMETYPE',data($PT_INFO_LABORAL_ITEM/ns1:TIP_INGRESO)) }</ns4:INCOME_TYPE>
                            <ns4:SALARY_CURRENCY/>
                            <ns4:SALARY_AMOUNT>{data($PT_INFO_LABORAL_ITEM/ns1:MON_DEVENGADO)}</ns4:SALARY_AMOUNT>
                            <ns4:START_DATE>{local:format-date-from-FPC(data($PT_INFO_LABORAL_ITEM/ns1:FEC_INGRESO))}</ns4:START_DATE>
                            <ns4:END_DATE>{local:format-date-from-FPC(data($PT_INFO_LABORAL_ITEM/ns1:FEC_SALIDA))}</ns4:END_DATE>
                            <ns4:IS_CURRENT_JOB>{ local:decode-values('FPCHN','YESNO',data($PT_INFO_LABORAL_ITEM/ns1:EMPLEO_ACTUAL)) }</ns4:IS_CURRENT_JOB>
                        </ns4:JOB_ITEM>                 
                }
            </ns4:JOB_INFO>
            else
            	<ns4:JOB_INFO/>
            }            
        </ns4:consultaClienteResponse>
};

declare variable $consultaClienteRequest1 as element(ns4:consultaClienteRequest) external;
declare variable $outputParametersTelefono as element(ns3:OutputParameters) external;
declare variable $outputParametersDireccion as element(ns0:OutputParameters) external;
declare variable $outputParametersEmail as element(ns2:OutputParameters) external;
declare variable $outputParametersTrabajo as element(ns1:OutputParameters) external;
declare variable $outputParametersInfoPersona as element(ns5:OutputParameters) external;

xf:consultaClienteOut_FPCHN($consultaClienteRequest1,
    $outputParametersTelefono,
    $outputParametersDireccion,
    $outputParametersEmail,
    $outputParametersTrabajo,
    $outputParametersInfoPersona)