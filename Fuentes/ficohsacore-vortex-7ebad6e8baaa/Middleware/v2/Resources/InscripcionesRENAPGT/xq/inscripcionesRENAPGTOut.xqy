xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/RENAP/consultaDataRenap/xsd/consultaDataRenap_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaInformacionCUIResponse" element="ns0:consultaInformacionCUIResponse" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaInformacionHUELLAResponse" element="ns0:consultaInformacionHUELLAResponse" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:inscripcionesRENAPResponse" location="../../InscripcionesRENAP/xsd/inscripcionesRENAPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDataRenap";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/inscripcionesRENAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/InscripcionesRENAPGT/xq/inscripcionesRENAPGTOut/";

declare function xf:inscripcionesRENAPGTOut($outputParameters as element(ns2:OutputParameters)?,
    $consultaInformacionCUIResponse as element(ns0:consultaInformacionCUIResponse)?,
    $consultaInformacionHUELLAResponse as element(ns0:consultaInformacionHUELLAResponse)?,
    $errorCode as xs:string,
    $validationMessage as xs:string)
    as element(ns1:inscripcionesRENAPResponse) {
        <ns1:inscripcionesRENAPResponse>
	        {
			    if(fn:upper-case(data($outputParameters/ns2:PV_CODIGO_ESTADO)) = "SUCCESS") then(
					
				    <FIRST_NAME>{ data($outputParameters/ns2:PV_PRIMER_NOMBRE) }</FIRST_NAME>,
				    <SECOND_NAME>{ data($outputParameters/ns2:PV_SEGUNDO_NOMBRE) }</SECOND_NAME>,
					<LAST_NAME>{ data($outputParameters/ns2:PV_PRIMER_APELLIDO) }</LAST_NAME>,
					<SECOND_LAST_NAME>{ data($outputParameters/ns2:PV_SEGUNDO_APELLIDO) }</SECOND_LAST_NAME>,
					<BIRTH_DATE>{ data($outputParameters/ns2:PD_FECHA_NACIMIENTO) }</BIRTH_DATE>,
				    <DEATH_DATE>{ data($outputParameters/ns2:PD_FECHA_DEFUNCION) }</DEATH_DATE>,
					<GENDER>{ data($outputParameters/ns2:PV_GENERO) }</GENDER>,        
				    <CIVIL_STATUS>{ data($outputParameters/ns2:PV_ESTADO_CIVIL) }</CIVIL_STATUS>,
				    <NATIONALITY>{ data($outputParameters/ns2:PV_NACIONALIDAD) }</NATIONALITY>,    
					<COUNTRY_OF_BIRTH>{ data($outputParameters/ns2:PV_PAIS_NACIMIENTO) }</COUNTRY_OF_BIRTH>,    
					<PHOTOGRAPHY>{ data($outputParameters/ns2:PCL_FOTOGRAFIA) }</PHOTOGRAPHY>,    
					<OCCUPATION>{ data($outputParameters/ns2:PV_OCUPACION) }</OCCUPATION>,    
					<MUNICIPALITY_OF_BIRTH>{ data($outputParameters/ns2:PV_MUNI_NACIMIENTO) }</MUNICIPALITY_OF_BIRTH>,    
					<THIRD_NAME>{ data($outputParameters/ns2:PV_TERCER_NOMBRE) }</THIRD_NAME>,    
					<LEGAL_ID_ORDER>{ data($outputParameters/ns2:PV_ORDEN_CEDULA) }</LEGAL_ID_ORDER>,    
					<DEPARTMENT_OF_BIRTH>{ data($outputParameters/ns2:PV_DEPTO_NACIMIENTO) }</DEPARTMENT_OF_BIRTH>,        
					<LEGAL_ID_REGISTRATION>{ data($outputParameters/ns2:PV_REGISTRO_CEDULA) }</LEGAL_ID_REGISTRATION>,
				    <LAST_NAME_MARRIED>{ data($outputParameters/ns2:PV_APELLIDO_CASADA) }</LAST_NAME_MARRIED>,
					<EXPIRATION_DATE>{ data($outputParameters/ns2:PD_FECHA_VENCIMIENTO) }</EXPIRATION_DATE>,
					<CORRELATIVE_DPI>{ data($outputParameters/ns2:PV_CORRELATIVO_DPI) }</CORRELATIVE_DPI>,
					<NEIGHBORHOOD>{ data($outputParameters/ns2:PV_VECINDAD) }</NEIGHBORHOOD>,    
					<STATUS_CODE>{ data($outputParameters/ns2:PV_CODIGO_ESTADO) }</STATUS_CODE>,    
					<MESSAGE_STATUS>{ data($outputParameters/ns2:PV_MENSAJE_ESTADO) }</MESSAGE_STATUS>    
	            
	            )else if(not(fn:empty($consultaInformacionCUIResponse))) then(
	            
	                <FIRST_NAME>{ data($consultaInformacionCUIResponse/FIRST_NAME) }</FIRST_NAME>,    
		            <SECOND_NAME>{ data($consultaInformacionCUIResponse/SECOND_NAME) }</SECOND_NAME>,
	                <LAST_NAME>{ data($consultaInformacionCUIResponse/LAST_NAME) }</LAST_NAME>,
	                <SECOND_LAST_NAME>{ data($consultaInformacionCUIResponse/SECOND_LAST_NAME) }</SECOND_LAST_NAME>,
	            	<BIRTH_DATE>{ data($consultaInformacionCUIResponse/BIRTH_DATE) }</BIRTH_DATE>,
	                <DEATH_DATE>{ data($consultaInformacionCUIResponse/DEATH_DATE) }</DEATH_DATE>,
	                <GENDER>{ data($consultaInformacionCUIResponse/GENDER) }</GENDER>,
	                <CIVIL_STATUS>{ data($consultaInformacionCUIResponse/CIVIL_STATUS) }</CIVIL_STATUS>,
	            	<NATIONALITY>{ data($consultaInformacionCUIResponse/NATIONALITY) }</NATIONALITY>,
	            	<COUNTRY_OF_BIRTH>{ data($consultaInformacionCUIResponse/COUNTRY_OF_BIRTH) }</COUNTRY_OF_BIRTH>,
	            	<PHOTOGRAPHY>{ data($consultaInformacionCUIResponse/PHOTOGRAPHY) }</PHOTOGRAPHY>,
	            	<OCCUPATION>{ data($consultaInformacionCUIResponse/OCCUPATION) }</OCCUPATION>,
	            	<MUNICIPALITY_OF_BIRTH>{ data($consultaInformacionCUIResponse/MUNICIPALITY_OF_BIRTH) }</MUNICIPALITY_OF_BIRTH>,
	            	<THIRD_NAME>{ data($consultaInformacionCUIResponse/THIRD_NAME) }</THIRD_NAME>,
	            	<LEGAL_ID_ORDER>{ data($consultaInformacionCUIResponse/LEGAL_ID_ORDER) }</LEGAL_ID_ORDER>,
	            	<DEPARTMENT_OF_BIRTH>{ data($consultaInformacionCUIResponse/DEPARTMENT_OF_BIRTH) }</DEPARTMENT_OF_BIRTH>,
	            	<LEGAL_ID_REGISTRATION>{ data($consultaInformacionCUIResponse/LEGAL_ID_REGISTRATION) }</LEGAL_ID_REGISTRATION>,
	            	<LAST_NAME_MARRIED>{ data($consultaInformacionCUIResponse/LAST_NAME_MARRIED) }</LAST_NAME_MARRIED>,
	            	<EXPIRATION_DATE>{ data($consultaInformacionCUIResponse/EXPIRATION_DATE) }</EXPIRATION_DATE>,
	            	<CORRELATIVE_DPI>{ data($consultaInformacionCUIResponse/CORRELATIVE_DPI) }</CORRELATIVE_DPI>,
	            	<NEIGHBORHOOD>{ data($consultaInformacionCUIResponse/NEIGHBORHOOD) }</NEIGHBORHOOD>,
		            <STATUS_CODE>{ $errorCode }</STATUS_CODE>,
		            <MESSAGE_STATUS>{ $validationMessage }</MESSAGE_STATUS>
	            
	            )else(
			            	
	                <FIRST_NAME>{ data($consultaInformacionHUELLAResponse/FIRST_NAME) }</FIRST_NAME>,
	                <SECOND_NAME>{ data($consultaInformacionHUELLAResponse/SECOND_NAME) }</SECOND_NAME>,    
	            	<LAST_NAME>{ data($consultaInformacionHUELLAResponse/LAST_NAME) }</LAST_NAME>,
	            	<SECOND_LAST_NAME>{ data($consultaInformacionHUELLAResponse/SECOND_LAST_NAME) }</SECOND_LAST_NAME>,
	            	<BIRTH_DATE>{ data($consultaInformacionHUELLAResponse/BIRTH_DATE) }</BIRTH_DATE>,
					<DEATH_DATE>{ data($consultaInformacionHUELLAResponse/DEATH_DATE) }</DEATH_DATE>,
					<GENDER>{ data($consultaInformacionHUELLAResponse/GENDER) }</GENDER>,
					<CIVIL_STATUS>{ data($consultaInformacionHUELLAResponse/CIVIL_STATUS) }</CIVIL_STATUS>,
	                <NATIONALITY>{ data($consultaInformacionHUELLAResponse/NATIONALITY) }</NATIONALITY>,
	                <COUNTRY_OF_BIRTH>{ data($consultaInformacionHUELLAResponse/COUNTRY_OF_BIRTH) }</COUNTRY_OF_BIRTH>,
	                <PHOTOGRAPHY>{ data($consultaInformacionHUELLAResponse/PHOTOGRAPHY) }</PHOTOGRAPHY>,
	                <OCCUPATION>{ data($consultaInformacionHUELLAResponse/OCCUPATION) }</OCCUPATION>,
	                <MUNICIPALITY_OF_BIRTH>{ data($consultaInformacionHUELLAResponse/MUNICIPALITY_OF_BIRTH) }</MUNICIPALITY_OF_BIRTH>,
	            	<THIRD_NAME>{ data($consultaInformacionHUELLAResponse/THIRD_NAME) }</THIRD_NAME>,
	            	<LEGAL_ID_ORDER>{ data($consultaInformacionHUELLAResponse/LEGAL_ID_ORDER) }</LEGAL_ID_ORDER>,
	            	<DEPARTMENT_OF_BIRTH>{ data($consultaInformacionHUELLAResponse/DEPARTMENT_OF_BIRTH) }</DEPARTMENT_OF_BIRTH>,
	            	<LEGAL_ID_REGISTRATION>{ data($consultaInformacionHUELLAResponse/LEGAL_ID_REGISTRATION) }</LEGAL_ID_REGISTRATION>,
	            	<LAST_NAME_MARRIED>{ data($consultaInformacionHUELLAResponse/LAST_NAME_MARRIED) }</LAST_NAME_MARRIED>,
	            	<EXPIRATION_DATE>{ data($consultaInformacionHUELLAResponse/EXPIRATION_DATE) }</EXPIRATION_DATE>,
	            	<CORRELATIVE_DPI>{ data($consultaInformacionHUELLAResponse/CORRELATIVE_DPI) }</CORRELATIVE_DPI>,
	            	<NEIGHBORHOOD>{ data($consultaInformacionHUELLAResponse/NEIGHBORHOOD) }</NEIGHBORHOOD>,
		            <STATUS_CODE>{ $errorCode }</STATUS_CODE>,
		            <MESSAGE_STATUS>{ $validationMessage }</MESSAGE_STATUS>
	            
	            )
	        }    
        </ns1:inscripcionesRENAPResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters)? external;
declare variable $consultaInformacionCUIResponse as element(ns0:consultaInformacionCUIResponse)? external;
declare variable $consultaInformacionHUELLAResponse as element(ns0:consultaInformacionHUELLAResponse)? external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:inscripcionesRENAPGTOut($outputParameters,
    $consultaInformacionCUIResponse,
    $consultaInformacionHUELLAResponse,
    $errorCode,
    $validationMessage)