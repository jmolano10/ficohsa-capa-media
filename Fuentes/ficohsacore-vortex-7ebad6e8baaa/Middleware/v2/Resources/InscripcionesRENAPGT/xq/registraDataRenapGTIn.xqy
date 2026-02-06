xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaInformacionCUIResponse" element="ns0:consultaInformacionCUIResponse" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaInformacionHUELLAResponse" element="ns0:consultaInformacionHUELLAResponse" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/RENAP/registraDataRenap/xsd/registraDataRenap_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$inscripcionesRENAP" element="ns2:inscripcionesRENAP" location="../../InscripcionesRENAP/xsd/inscripcionesRENAPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraDataRenap";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/inscripcionesRENAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/InscripcionesRENAPGT/xq/registraDataRenapGTIn/";

declare function xf:registraDataRenapGTIn($consultaInformacionCUIResponse as element(ns0:consultaInformacionCUIResponse)?,
    $consultaInformacionHUELLAResponse as element(ns0:consultaInformacionHUELLAResponse)?,
    $inscripcionesRENAP as element(ns2:inscripcionesRENAP))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	{
            	if(not(fn:empty($consultaInformacionCUIResponse))) then(
            	
                    <ns1:PV_REFERENCIA>{ data($consultaInformacionCUIResponse/REFERENCE) }</ns1:PV_REFERENCIA>,
                    <ns1:PV_HIT>
                    	{ 
                    		if(fn:upper-case(data($consultaInformacionCUIResponse/HIT)) = "TRUE") then(
                    			"T"
                    		)else("F")
                    	}
                    </ns1:PV_HIT>,
                    <ns1:PV_USUARIO>{ data($inscripcionesRENAP/USER_CODE) }</ns1:PV_USUARIO>,
		            <ns1:PV_NOMBRE_USUARIO>{ data($inscripcionesRENAP/USER_NAME) }</ns1:PV_NOMBRE_USUARIO>,
		            <ns1:PV_CUI>{ data($inscripcionesRENAP/CUI) }</ns1:PV_CUI>,
		            <ns1:PCL_HUELLA>{ data($inscripcionesRENAP/FOOTPRINT) }</ns1:PCL_HUELLA>,
		            <ns1:PV_CODIGO_DEDO>{ data($inscripcionesRENAP/FINGER_CODE) }</ns1:PV_CODIGO_DEDO>,
		            <ns1:PCL_FMD>{ data($inscripcionesRENAP/FMD) }</ns1:PCL_FMD>,
		            <ns1:PV_TIPO_CONSULTA>{ data($inscripcionesRENAP/QUERY_TYPE) }</ns1:PV_TIPO_CONSULTA>,
		            <ns1:PV_ORIGEN_CONSULTA>{ data($inscripcionesRENAP/ORIGIN_INQUIRY) }</ns1:PV_ORIGEN_CONSULTA>,
                    <ns1:PV_TIPO_CONSULTA>{ data($consultaInformacionCUIResponse/QUERY_TIME) }</ns1:PV_TIPO_CONSULTA>,
                    <ns1:PV_PRIMER_NOMBRE>{ data($consultaInformacionCUIResponse/FIRST_NAME) }</ns1:PV_PRIMER_NOMBRE>,
                    <ns1:PV_SEGUNDO_NOMBRE>{ data($consultaInformacionCUIResponse/SECOND_NAME) }</ns1:PV_SEGUNDO_NOMBRE>,
                    <ns1:PV_PRIMER_APELLIDO>{ data($consultaInformacionCUIResponse/LAST_NAME) }</ns1:PV_PRIMER_APELLIDO>,
                    <ns1:PV_SEGUNDO_APELLIDO>{ data($consultaInformacionCUIResponse/SECOND_LAST_NAME) }</ns1:PV_SEGUNDO_APELLIDO>,
		             <ns1:PD_FECHA_NACIMIENTO>
		            	{ 
		            		if(data($consultaInformacionCUIResponse/BIRTH_DATE) != "") then(
		            			xs:date(
		            				fn:concat(
		            					fn:substring(data($consultaInformacionCUIResponse/BIRTH_DATE), 7, 10), "-",
		            					fn:substring(data($consultaInformacionCUIResponse/BIRTH_DATE), 4, 2), "-",
		            					fn:substring(data($consultaInformacionCUIResponse/BIRTH_DATE), 1, 2)
		            				)
		            			)
		            		)else() 
		            	}
		            </ns1:PD_FECHA_NACIMIENTO>,
		            <ns1:PD_FECHA_DEFUNCION>
		            	{ 
		            		if(data($consultaInformacionCUIResponse/DEATH_DATE) != "") then(
		            			xs:date(
		            				fn:concat(
		            					fn:substring(data($consultaInformacionCUIResponse/DEATH_DATE), 7, 10), "-",
		            					fn:substring(data($consultaInformacionCUIResponse/DEATH_DATE), 4, 2), "-",
		            					fn:substring(data($consultaInformacionCUIResponse/DEATH_DATE), 1, 2)
		            				)
		            			)
		            		)else()
		            	}
		            </ns1:PD_FECHA_DEFUNCION>,
		            <ns1:PV_GENERO>{ data($consultaInformacionCUIResponse/GENDER) }</ns1:PV_GENERO>,
		            <ns1:PV_ESTADO_CIVIL>{ data($consultaInformacionCUIResponse/CIVIL_STATUS) }</ns1:PV_ESTADO_CIVIL>,
		            <ns1:PV_NACIONALIDAD>{ data($consultaInformacionCUIResponse/NATIONALITY) }</ns1:PV_NACIONALIDAD>,
		            <ns1:PV_PAIS_NACIMIENTO>{ data($consultaInformacionCUIResponse/COUNTRY_OF_BIRTH) }</ns1:PV_PAIS_NACIMIENTO>,
		            <ns1:PCL_FOTOGRAFIA>{ data($consultaInformacionCUIResponse/PHOTOGRAPHY) }</ns1:PCL_FOTOGRAFIA>,
		            <ns1:PV_OCUPACION>{ data($consultaInformacionCUIResponse/OCCUPATION) }</ns1:PV_OCUPACION>,
	                <ns1:PV_MUNI_NACIMIENTO>{ data($consultaInformacionCUIResponse/MUNICIPALITY_OF_BIRTH) }</ns1:PV_MUNI_NACIMIENTO>,
	                <ns1:PV_TERCER_NOMBRE>{ data($consultaInformacionCUIResponse/THIRD_NAME) }</ns1:PV_TERCER_NOMBRE>,
	                <ns1:PV_ORDEN_CEDULA>{ data($consultaInformacionCUIResponse/LEGAL_ID_ORDER) }</ns1:PV_ORDEN_CEDULA>,
	                <ns1:PV_DEPTO_NACIMIENTO>{ data($consultaInformacionCUIResponse/DEPARTMENT_OF_BIRTH) }</ns1:PV_DEPTO_NACIMIENTO>,    
	                <ns1:PV_REGISTRO_CEDULA>{ data($consultaInformacionCUIResponse/LEGAL_ID_REGISTRATION) }</ns1:PV_REGISTRO_CEDULA>,
	                <ns1:PV_APELLIDO_CASADA>{ data($consultaInformacionCUIResponse/LAST_NAME_MARRIED) }</ns1:PV_APELLIDO_CASADA>,
	            	<ns1:PD_FECHA_VENCIMIENTO>
	            		{ 
	            			if(data($consultaInformacionCUIResponse/EXPIRATION_DATE) != "") then(
		            			xs:date(
		            				fn:concat(
		            					fn:substring(data($consultaInformacionCUIResponse/EXPIRATION_DATE), 7, 10), "-",
		            					fn:substring(data($consultaInformacionCUIResponse/EXPIRATION_DATE), 4, 2), "-",
		            					fn:substring(data($consultaInformacionCUIResponse/EXPIRATION_DATE), 1, 2)
		            				)
		            			)
		            		)else() 
	            		}
	            	</ns1:PD_FECHA_VENCIMIENTO>,
	            	<ns1:PV_VECINDAD>{ data($consultaInformacionCUIResponse/NEIGHBORHOOD) }</ns1:PV_VECINDAD>,
	            	<ns1:PV_CORRELATIVO_DPI> { data($consultaInformacionCUIResponse/CORRELATIVE_DPI) }</ns1:PV_CORRELATIVO_DPI>
            	)else(
            		
	                <ns1:PV_REFERENCIA>{ data($consultaInformacionHUELLAResponse/REFERENCE) }</ns1:PV_REFERENCIA>,    
	                <ns1:PV_HIT>
	                	{ 
                    		if(fn:upper-case(data($consultaInformacionHUELLAResponse/HIT)) = "TRUE") then(
                    			"T"
                    		)else("F")
	                	}
	                </ns1:PV_HIT>,
	                <ns1:PV_USUARIO>{ data($inscripcionesRENAP/USER_CODE) }</ns1:PV_USUARIO>,
		            <ns1:PV_NOMBRE_USUARIO>{ data($inscripcionesRENAP/USER_NAME) }</ns1:PV_NOMBRE_USUARIO>,
		            <ns1:PV_CUI>{ data($inscripcionesRENAP/CUI) }</ns1:PV_CUI>,
		            <ns1:PCL_HUELLA>{ data($inscripcionesRENAP/FOOTPRINT) }</ns1:PCL_HUELLA>,
		            <ns1:PV_CODIGO_DEDO>{ data($inscripcionesRENAP/FINGER_CODE) }</ns1:PV_CODIGO_DEDO>,
		            <ns1:PCL_FMD>{ data($inscripcionesRENAP/FMD) }</ns1:PCL_FMD>,
		            <ns1:PV_TIPO_CONSULTA>{ data($inscripcionesRENAP/QUERY_TYPE) }</ns1:PV_TIPO_CONSULTA>,
		            <ns1:PV_ORIGEN_CONSULTA>{ data($inscripcionesRENAP/ORIGIN_INQUIRY) }</ns1:PV_ORIGEN_CONSULTA>,
	                <ns1:PV_PRIMER_NOMBRE>{ data($consultaInformacionHUELLAResponse/FIRST_NAME) }</ns1:PV_PRIMER_NOMBRE>,
	                <ns1:PV_SEGUNDO_NOMBRE>{ data($consultaInformacionHUELLAResponse/SECOND_NAME) }</ns1:PV_SEGUNDO_NOMBRE>,
	                <ns1:PV_PRIMER_APELLIDO>{ data($consultaInformacionHUELLAResponse/LAST_NAME) }</ns1:PV_PRIMER_APELLIDO>,
	                <ns1:PV_SEGUNDO_APELLIDO>{ data($consultaInformacionHUELLAResponse/SECOND_LAST_NAME) }</ns1:PV_SEGUNDO_APELLIDO>,
		            <ns1:PD_FECHA_NACIMIENTO>
		            	{ 
		            		if(data($consultaInformacionHUELLAResponse/BIRTH_DATE) != "") then(
		            			xs:date(
		            				fn:concat(
		            					fn:substring(data($consultaInformacionHUELLAResponse/BIRTH_DATE), 7, 10), "-",
		            					fn:substring(data($consultaInformacionHUELLAResponse/BIRTH_DATE), 4, 2), "-",
		            					fn:substring(data($consultaInformacionHUELLAResponse/BIRTH_DATE), 1, 2)
		            				)
		            			)
		            		)else() 
		            	}
		            </ns1:PD_FECHA_NACIMIENTO>,
		             <ns1:PD_FECHA_DEFUNCION>
		            	{ 
		            		if(data($consultaInformacionHUELLAResponse/DEATH_DATE) != "") then(
		            			xs:date(
		            				fn:concat(
		            					fn:substring(data($consultaInformacionHUELLAResponse/DEATH_DATE), 7, 10), "-",
		            					fn:substring(data($consultaInformacionHUELLAResponse/DEATH_DATE), 4, 2), "-",
		            					fn:substring(data($consultaInformacionHUELLAResponse/DEATH_DATE), 1, 2)
		            				)
		            			)
		            		)else()
		            	}
		            </ns1:PD_FECHA_DEFUNCION>,
	            	<ns1:PV_GENERO>{ data($consultaInformacionHUELLAResponse/GENDER) }</ns1:PV_GENERO>,
	            	<ns1:PV_ESTADO_CIVIL>{ data($consultaInformacionHUELLAResponse/CIVIL_STATUS) }</ns1:PV_ESTADO_CIVIL>,
	            	<ns1:PV_NACIONALIDAD>{ data($consultaInformacionHUELLAResponse/NATIONALITY) }</ns1:PV_NACIONALIDAD>,
	                <ns1:PV_PAIS_NACIMIENTO>{ data($consultaInformacionHUELLAResponse/COUNTRY_OF_BIRTH) }</ns1:PV_PAIS_NACIMIENTO>,
					<ns1:PCL_FOTOGRAFIA>{ data($consultaInformacionHUELLAResponse/PHOTOGRAPHY) }</ns1:PCL_FOTOGRAFIA>,
					<ns1:PV_OCUPACION>{ data($consultaInformacionHUELLAResponse/OCCUPATION) }</ns1:PV_OCUPACION>,
					<ns1:PV_MUNI_NACIMIENTO>{ data($consultaInformacionHUELLAResponse/MUNICIPALITY_OF_BIRTH) }</ns1:PV_MUNI_NACIMIENTO>,
	            	<ns1:PV_TERCER_NOMBRE>{ data($consultaInformacionHUELLAResponse/THIRD_NAME) }</ns1:PV_TERCER_NOMBRE>,
	            	<ns1:PV_ORDEN_CEDULA>{ data($consultaInformacionHUELLAResponse/LEGAL_ID_ORDER) }</ns1:PV_ORDEN_CEDULA>,
	            	<ns1:PV_DEPTO_NACIMIENTO>{ data($consultaInformacionHUELLAResponse/DEPARTMENT_OF_BIRTH) }</ns1:PV_DEPTO_NACIMIENTO>,
	            	<ns1:PV_REGISTRO_CEDULA>{ data($consultaInformacionHUELLAResponse/LEGAL_ID_REGISTRATION) }</ns1:PV_REGISTRO_CEDULA>,
	            	<ns1:PV_APELLIDO_CASADA>{ data($consultaInformacionHUELLAResponse/LAST_NAME_MARRIED) }</ns1:PV_APELLIDO_CASADA>,
	            	<ns1:PD_FECHA_VENCIMIENTO>
	            		{ 
		            		if(data($consultaInformacionHUELLAResponse/PD_FECHA_VENCIMIENTO) != "") then(
		            			xs:date(
		            				fn:concat(
		            					fn:substring(data($consultaInformacionHUELLAResponse/PD_FECHA_VENCIMIENTO), 7, 10), "-",
		            					fn:substring(data($consultaInformacionHUELLAResponse/PD_FECHA_VENCIMIENTO), 4, 2), "-",
		            					fn:substring(data($consultaInformacionHUELLAResponse/PD_FECHA_VENCIMIENTO), 1, 2)
		            				)
		            			)
		            		)else()
	            		}
	            	</ns1:PD_FECHA_VENCIMIENTO>,
	            	<ns1:PV_VECINDAD>{ data($consultaInformacionHUELLAResponse/NEIGHBORHOOD) }</ns1:PV_VECINDAD>,
	            	<ns1:PV_CORRELATIVO_DPI> { data($consultaInformacionHUELLAResponse/CORRELATIVE_DPI) }</ns1:PV_CORRELATIVO_DPI>
		        )
	        }
        </ns1:InputParameters>
};

declare variable $consultaInformacionCUIResponse as element(ns0:consultaInformacionCUIResponse)? external;
declare variable $consultaInformacionHUELLAResponse as element(ns0:consultaInformacionHUELLAResponse)? external; 
declare variable $inscripcionesRENAP as element(ns2:inscripcionesRENAP) external;

xf:registraDataRenapGTIn($consultaInformacionCUIResponse,
    $consultaInformacionHUELLAResponse,
    $inscripcionesRENAP)