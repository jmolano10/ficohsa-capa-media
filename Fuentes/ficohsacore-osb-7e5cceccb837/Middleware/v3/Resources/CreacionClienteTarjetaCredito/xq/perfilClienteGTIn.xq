(:: pragma bea:global-element-parameter parameter="$creacionClienteTarjetaCredito1" element="ns0:creacionClienteTarjetaCredito" location="../xsd/creacionClienteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaEquivalenciaCatalogo" element="ns2:InputParameters" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos_v2/xsd/consultaEquivalenciasCatalogos_v2_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../v2/BusinessServices/ABKGT/perfilCliente/xsd/perfilCliente_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/CreacionClienteTarjetaCredito/xq/perfilClienteGTIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creacionClienteTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/perfilCliente";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos_v2";

declare function valorCatalogoOSBToAPP($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalenciasCatalogos as element(*)
) as xs:string {
	let $retorno := string($equivalenciasCatalogos/ns2:PT_EQUIVALENCIAS_SALIDA/ns2:PT_EQUIVALENCIAS_SALIDA_ITEM[ns2:CATALOGO_ID = $catalogoId and ns2:VALOR_CATALOGO = $valor][1]/ns2:EQUIVALENCIAS/ns2:EQUIVALENCIAS_ITEM[ns2:APLICACION = $aplicacion]/ns2:VALOR_EQUIVALENCIA/text())
	return
		if($retorno != "") then (
			$retorno
		) else ( 
			$valor
		)
};

declare function xf:perfilClienteGTIn($creacionClienteTarjetaCredito1 as element(ns0:creacionClienteTarjetaCredito),
    $codPais as xs:string,
    $consultaEquivalenciaCatalogo as element(ns2:OutputParameters))
    as element(ns1:InputParameters) {
            <ns1:InputParameters>
            <ns1:PV_TIPO_OPERACION>I</ns1:PV_TIPO_OPERACION>
            <ns1:PN_PAIS>{ data($codPais) }</ns1:PN_PAIS>
            <ns1:RG_CLIENTE>
            	{
            		let $IDENTIFICATION_TYPE := string($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/IDENTIFICATION_TYPE/text())
            		return(
            			<ns1:CODIGO_TIPO_IDENTIFICACION>{ valorCatalogoOSBToAPP($IDENTIFICATION_TYPE, 'ABANKSGT', '4', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_TIPO_IDENTIFICACION>
            		)
            	}          
                <ns1:NUMERO_IDENTIFICACION>{ data($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/IDENTIFICATION_NUMBER) }</ns1:NUMERO_IDENTIFICACION>
                {
            		let $CUSTOMER_TYPE := string($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CUSTOMER_TYPE/text())
            		return(
            			<ns1:CODIGO_TIPO_CLIENTE>{ valorCatalogoOSBToAPP($CUSTOMER_TYPE, 'ABANKSGT', '21', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_TIPO_CLIENTE>
            		)
            	}                 
                <ns1:CODIGO_CATEGORIA>2</ns1:CODIGO_CATEGORIA>
                <ns1:CODIGO_AGENCIA>1</ns1:CODIGO_AGENCIA>
                {
                	let $COUNTRY_ID := string($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/COUNTRY_ID/text())
                	return(
                		<ns1:CODIGO_PAIS>{ valorCatalogoOSBToAPP($COUNTRY_ID, 'ABANKSGT', '9', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_PAIS>
                	)
                }
                {
                	let $ECONOMIC_ACTIVITY_ID := string($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/ECONOMIC_ACTIVITY_ID)
                	return(
                		<ns1:CODIGO_ACTIVIDAD_ECONOMICA>{ valorCatalogoOSBToAPP($ECONOMIC_ACTIVITY_ID, 'ABANKSGT', '22', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_ACTIVIDAD_ECONOMICA>
                	)
                }               
                <ns1:CODIGO_GRUPO_EMPRESARIAL>9500</ns1:CODIGO_GRUPO_EMPRESARIAL>
                <ns1:TIPO_DE_PERSONA>{ data($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/TYPE_OF_PERSON) }</ns1:TIPO_DE_PERSONA>
                <ns1:NOMBRES>{ data($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/NAMES) }</ns1:NOMBRES>
                <ns1:PRIMER_APELLIDO>{ data($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/FIRST_SURNAME) }</ns1:PRIMER_APELLIDO>
                <ns1:SEGUNDO_APELLIDO>{ data($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/SECOND_SURNAME) }</ns1:SEGUNDO_APELLIDO>
                {
                    for $MARRIED_LAST_NAME in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/MARRIED_LAST_NAME
                    return
                        <ns1:APELLIDO_DE_CASADA>{ data($MARRIED_LAST_NAME) }</ns1:APELLIDO_DE_CASADA>
                }
                {
                	let $GENDER := string($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/GENDER/text())
                	return(
                		<ns1:SEXO>{ valorCatalogoOSBToAPP($GENDER, 'ABANKSGT', '1', $consultaEquivalenciaCatalogo) }</ns1:SEXO>
                	)
                }
               
                {
                    for $DATE_OF_BIRTH in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/DATE_OF_BIRTH
                    return
                        <ns1:FECHA_DE_NACIMIENTO>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", fn-bea:date-to-string-with-format("yyyy-MM-dd", data($DATE_OF_BIRTH))) }</ns1:FECHA_DE_NACIMIENTO>
                }
                {
                    for $MARITAL_STATUS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/MARITAL_STATUS
                    return
                        <ns1:ESTADO_CIVIL>{ valorCatalogoOSBToAPP($MARITAL_STATUS, 'ABANKSGT', '2', $consultaEquivalenciaCatalogo) }</ns1:ESTADO_CIVIL>
                }
                {
                    for $SPOUSE_NAME in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/SPOUSE_NAME
                    return
                        <ns1:NOMBRE_CONJUGUE>{ data($SPOUSE_NAME) }</ns1:NOMBRE_CONJUGUE>
                }
                <ns1:CODIGO_OFICIAL>SALESFORCE</ns1:CODIGO_OFICIAL>
                <ns1:CODIGO_EMPRESA>1</ns1:CODIGO_EMPRESA>
                {
                    for $CODE_OCUPACION in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CODE_OCUPACION
                    return
                        <ns1:CODIGO_OCUPACION>{ valorCatalogoOSBToAPP($CODE_OCUPACION, 'ABANKSGT', '23', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_OCUPACION>
                }
                <ns1:CODIGO_ACTIVIDAD_BANCO>33</ns1:CODIGO_ACTIVIDAD_BANCO>
                {
                    for $EDUCATION_LEVEL in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/EDUCATION_LEVEL
                    return
                        <ns1:NIVEL_EDUCATIVO>{ valorCatalogoOSBToAPP($EDUCATION_LEVEL, 'ABANKSGT', '10', $consultaEquivalenciaCatalogo) }</ns1:NIVEL_EDUCATIVO>
                }
                {
                    for $CHILDREN_NUMBERS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CHILDREN_NUMBERS
                    return
                        <ns1:CANTIDAD_HIJOS>{ data($CHILDREN_NUMBERS) }</ns1:CANTIDAD_HIJOS>
                }
                {
                    for $PLACE_OF_BIRTH in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PLACE_OF_BIRTH
                    return
                        <ns1:LUGAR_DE_NACIMIENTO>{ data($PLACE_OF_BIRTH) }</ns1:LUGAR_DE_NACIMIENTO>
                }
                {
                    for $PROFESSION_CODE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PROFESSION_CODE
                    return
                        <ns1:CODIGO_PROFESION>{ valorCatalogoOSBToAPP(string($PROFESSION_CODE/text()), 'ABANKSGT', '3', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_PROFESION>
                }
                <ns1:CODIGO_MONEDA_LEGAL>2</ns1:CODIGO_MONEDA_LEGAL>
                <ns1:CODIGO_TIPO_IDENTIFICACION_R>20</ns1:CODIGO_TIPO_IDENTIFICACION_R>
                <ns1:CODIGO_TIPO_PODER_R>5</ns1:CODIGO_TIPO_PODER_R>
                {
                    for $SEGMENT_CODE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/SEGMENT_CODE
                    return
                        <ns1:CODIGO_SEGMENTO>{ data($SEGMENT_CODE) }</ns1:CODIGO_SEGMENTO>
                }
                <ns1:CODIGO_PAIS_LEGAL>1</ns1:CODIGO_PAIS_LEGAL>
                <ns1:CAPITAL_SOCIAL>1</ns1:CAPITAL_SOCIAL>
                {
                    for $IS_WORK in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/IS_WORK
                    return
                        <ns1:TRABAJA>{ data($IS_WORK) }</ns1:TRABAJA>
                }
                <ns1:CODIGO_DESTINO>1899</ns1:CODIGO_DESTINO>
                <ns1:CODIGO_RESIDENCIA>1</ns1:CODIGO_RESIDENCIA>
                <ns1:CODIGO_SECTOR>1</ns1:CODIGO_SECTOR>
                {
                    for $COMPANY_TYPE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/COMPANY_TYPE
                    return
                        <ns1:TIPO_DE_EMPRESA>{ valorCatalogoOSBToAPP($COMPANY_TYPE, 'ABANKSGT', '24', $consultaEquivalenciaCatalogo) }</ns1:TIPO_DE_EMPRESA>
                }
                {
                    for $CLIENT_RISK in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CLIENT_RISK
                    return
                        <ns1:RIESGO_CLIENTE>{ data($CLIENT_RISK) }</ns1:RIESGO_CLIENTE>
                }
                {
                    for $EXPIRATION_DATE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/EXPIRATION_DATE
                    return
                        <ns1:FECHA_VENC_ID>{ data($EXPIRATION_DATE) }</ns1:FECHA_VENC_ID>
                }
                <ns1:CODIGO_SEGMENTACION_CARTERA>1</ns1:CODIGO_SEGMENTACION_CARTERA>
                <ns1:TIPO_COMERCIANTE>1</ns1:TIPO_COMERCIANTE>
                {
                    for $IS_EMPLOYEE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/IS_EMPLOYEE
                    return
                        <ns1:EMPLEADO>{ data($IS_EMPLOYEE) }</ns1:EMPLEADO>
                }
                {
                    for $PEPS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEPS
                    return
                        <ns1:PEPS>{ data($PEPS) }</ns1:PEPS>
                }
                {
                	for $NIT_NUMBER in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/NIT_NUMBER
                    return
                       	<ns1:NUMERO_DE_NIT>{ data($NIT_NUMBER) }</ns1:NUMERO_DE_NIT>
                } 
                {
                	for $CPE_TYPE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CPE_TYPE
                    return
                       	<ns1:TIPO_CPE>{ data($CPE_TYPE) }</ns1:TIPO_CPE>
                }             
                {
                	for $CUSTOMER_CPE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CUSTOMER_CPE
                    return
                       	<ns1:CLIENTES_CPE>{ data($CUSTOMER_CPE) }</ns1:CLIENTES_CPE>
                }               
                {
                    for $CPE_INSTITUTION in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CPE_INSTITUTION
                    return
                        <ns1:CPE_INSTITUTION>{ data($CPE_INSTITUTION) }</ns1:CPE_INSTITUTION>
                }
                {
                    for $CPE_PRODUCT_SERVICE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CPE_PRODUCT_SERVICE
                    return
                        <ns1:CPE_PRODUCT_SERVICE>{ data($CPE_PRODUCT_SERVICE) }</ns1:CPE_PRODUCT_SERVICE>
                }
                {
                    for $CPE_PRODUCT_SERVICE_CATEGORY in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CPE_PRODUCT_SERVICE_CATEGORY
                    return
                        <ns1:CPE_PRODUCT_SERVICE_CATEGORY>{ data($CPE_PRODUCT_SERVICE_CATEGORY) }</ns1:CPE_PRODUCT_SERVICE_CATEGORY>
                }
                {
                    for $CPE_PRODUCT_ASOC in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CPE_PRODUCT_ASOC
                    return
                        <ns1:CPE_PRODUCT_ASOC>{ data($CPE_PRODUCT_ASOC) }</ns1:CPE_PRODUCT_ASOC>
                }
                {
                    for $CPE_OTHER_PRODUCTS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CPE_OTHER_PRODUCTS
                    return
                        <ns1:CPE_OTHER_PRODUCTS>{ data($CPE_OTHER_PRODUCTS) }</ns1:CPE_OTHER_PRODUCTS>
                }
                {
                    for $CPE_GUATECOMPRAS_STATUS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/CPE_GUATECOMPRAS_STATUS
                    return
                        <ns1:CPE_GUATECOMPRAS_STATUS>{ data($CPE_GUATECOMPRAS_STATUS) }</ns1:CPE_GUATECOMPRAS_STATUS>
                }
                {
                    for $PEP_HERITAGE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_HERITAGE
                    return
                        <ns1:PEP_HERITAGE>{ data($PEP_HERITAGE) }</ns1:PEP_HERITAGE>
                }
                {
                    for $PEP_OWN_BUSINESS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_OWN_BUSINESS
                    return
                        <ns1:PEP_OWN_BUSINESS>{ data($PEP_OWN_BUSINESS) }</ns1:PEP_OWN_BUSINESS>
                }
                {
                    for $PEP_OTHERS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_OTHERS
                    return
                        <ns1:PEP_OTHERS>{ data($PEP_OTHERS) }</ns1:PEP_OTHERS>
                }
                {
                    for $PEP_BANK_LENDING in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_BANK_LENDING
                    return
                        <ns1:PEP_BANK_LENDING>{ data($PEP_BANK_LENDING) }</ns1:PEP_BANK_LENDING>
                }
                {
                    for $PEP_CURRENT_WORK in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_CURRENT_WORK
                    return
                        <ns1:PEP_CURRENT_WORK>{ data($PEP_CURRENT_WORK) }</ns1:PEP_CURRENT_WORK>
                }
                {
                    for $PEP_OLD_WORK in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_OLD_WORK
                    return
                        <ns1:PEP_OLD_WORK>{ data($PEP_OLD_WORK) }</ns1:PEP_OLD_WORK>
                }
                {
                    for $PEP_RELATIONSHIP_TYPE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_RELATIONSHIP_TYPE
                    return
                        <ns1:PEP_RELATIONSHIP_TYPE>{ valorCatalogoOSBToAPP(data($PEP_RELATIONSHIP_TYPE), 'ABANKSGT', '28', $consultaEquivalenciaCatalogo) }</ns1:PEP_RELATIONSHIP_TYPE>
                }
                {
                    for $PEP_NAME in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_NAME
                    return
                        <ns1:PEP_NAME>{ data($PEP_NAME) }</ns1:PEP_NAME>
                }
                {
                    for $PEP_WORK in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_WORK
                    return
                        <ns1:PEP_WORK>{ data($PEP_WORK) }</ns1:PEP_WORK>
                }
                {
                    for $PEP_POSITION in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PEP_POSITION
                    return
                        <ns1:PEP_POSITION>{ data($PEP_POSITION) }</ns1:PEP_POSITION>
                }
                {
                    for $PORE_CLIENT in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PORE_CLIENT
                    return
                        <ns1:PORE_CLIENT>{ data($PORE_CLIENT) }</ns1:PORE_CLIENT>
                }
                {
                    for $PORES_ACTIVITY in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/PORES_ACTIVITY
                    return
                        <ns1:PORES_ACTIVIDAD>{ data($PORES_ACTIVITY) }</ns1:PORES_ACTIVIDAD>
                }
                <ns1:EXPIRATION_ID>{ data($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INFO/EXPIRATION_ID) }</ns1:EXPIRATION_ID>
               
                <ns1:PAIS_EMISION>{ valorCatalogoOSBToAPP(data($creacionClienteTarjetaCredito1/COUNTRY_OF_ISSUE_DOCUMENT), 'ABANKSGT', '9', $consultaEquivalenciaCatalogo) }</ns1:PAIS_EMISION>
                
                {
		            for $MUNICIPALITY_OF_ISSUE_DOCUMENT in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/MUNICIPALITY_OF_ISSUE_DOCUMENT
		            return
		                <ns1:MUNICIPIO_EMISION>{ valorCatalogoOSBToAPP($MUNICIPALITY_OF_ISSUE_DOCUMENT, 'ABANKSGT', '7', $consultaEquivalenciaCatalogo) }</ns1:MUNICIPIO_EMISION>
		        }
		        {
		            for $DEPARMENT_OF_ISSUE_DOCUMENT in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/DEPARMENT_OF_ISSUE_DOCUMENT
		            return
		                <ns1:DEPARTAMENTO_EMISION>{ valorCatalogoOSBToAPP($DEPARMENT_OF_ISSUE_DOCUMENT, 'ABANKSGT', '8', $consultaEquivalenciaCatalogo) }</ns1:DEPARTAMENTO_EMISION>
		        }
		        {
		            for $NIT_TYPE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/NIT_TYPE
		            return
		                <ns1:TIPO_NIT>{ valorCatalogoOSBToAPP($NIT_TYPE, 'ABANKSGT', '4', $consultaEquivalenciaCatalogo) }</ns1:TIPO_NIT>
		        }
		        {
		            for $OTHER_NATIONALITY in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/OTHER_NATIONALITY
		            return
		                <ns1:CODIGO_PAIS2>{ valorCatalogoOSBToAPP($OTHER_NATIONALITY, 'ABANKSGT', '9', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_PAIS2>
		        }
		        {
		            for $IS_RESIDENT_EEUU in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/IS_RESIDENT_EEUU
		            return
		                <ns1:RESIDE_EEUU>{ data($IS_RESIDENT_EEUU) }</ns1:RESIDE_EEUU>
		        }
		        {
		            for $IMMIGRATION in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/IMMIGRATION
		            return
		                <ns1:MIGRATORIO>{ data($IMMIGRATION) }</ns1:MIGRATORIO>
		        }
		        {
		            for $INMMIGRATION_STATUS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/INMMIGRATION_STATUS
		            return
		                <ns1:CONDICION_MIGRATORIO>{ data($INMMIGRATION_STATUS) }</ns1:CONDICION_MIGRATORIO>
		        }
		        {
		            for $EEUU_PHONE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/EEUU_PHONE
		            return
		                <ns1:TELEFONO_EEUU>{ data($EEUU_PHONE) }</ns1:TELEFONO_EEUU>
		        }
		        {
		            for $RATE_RISK in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/RATE_RISK
		            return
		            	<ns1:TIPO_RIESGO>{ valorCatalogoOSBToAPP($RATE_RISK, 'ABANKSGT', '29', $consultaEquivalenciaCatalogo) }</ns1:TIPO_RIESGO>
		        }
            </ns1:RG_CLIENTE>
            <ns1:TR_DIRECCION>
            	{
            		for $CUSTOMER_ADDRESS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS
            		return(
            			<ns1:TR_DIRECCION_ITEM>
            				{
		                        for $ADDRESS_CODE in $CUSTOMER_ADDRESS/ADDRESS_CODE
		                        return
		                            <ns1:CODIGO_DIRECCION>{ valorCatalogoOSBToAPP(string($ADDRESS_CODE/text()), 'ABANKSGT', '25', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_DIRECCION>
		                    }
		                    {
		                        for $COUNTRY_CODE in $CUSTOMER_ADDRESS/COUNTRY_CODE
		                        return
		                            <ns1:CODIGO_PAIS>{ valorCatalogoOSBToAPP($COUNTRY_CODE, 'ABANKSGT', '9', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_PAIS>
		                    }
		                    {
		                        for $DEPARMENT_CODE in $CUSTOMER_ADDRESS/DEPARMENT_CODE
		                        return
		                            <ns1:CODIGO_DEPARTAMENTO>{ valorCatalogoOSBToAPP(string($DEPARMENT_CODE/text()), 'ABANKSGT', '8', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_DEPARTAMENTO>
		                    }
		                    {
		                        for $MUNICIPALITY_CODE in $CUSTOMER_ADDRESS/MUNICIPALITY_CODE
		                        return
		                            <ns1:CODIGO_MUNICIPIO>{ valorCatalogoOSBToAPP(string($MUNICIPALITY_CODE/text()), 'ABANKSGT', '7', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_MUNICIPIO>
		                    }
		                    {
		                        for $NOMENCLATURE in $CUSTOMER_ADDRESS/NOMENCLATURE
		                        return
		                            <ns1:NOMENCLATURA>{ data($NOMENCLATURE) }</ns1:NOMENCLATURA>
		                    }
		                    {
		                        for $ZONE in $CUSTOMER_ADDRESS/ZONE
		                        return
		                            <ns1:ZONA>{ data($ZONE) }</ns1:ZONA>
		                    }
		                    {
		                        for $PHONES in $CUSTOMER_ADDRESS/PHONES
		                        return
		                            <ns1:TELEFONOS>{ data($PHONES) }</ns1:TELEFONOS>
		                    }
		                    {
		                        for $FAX in $CUSTOMER_ADDRESS/FAX
		                        return
		                            <ns1:FAX>{ data($FAX) }</ns1:FAX>
		                    }
		                    {
		                    	let $ADDRESS_TYPE_CODE := string($CUSTOMER_ADDRESS/ADDRESS_TYPE_CODE/text())
		                    	return(
		                    	<ns1:CODIGO_TIPO_DIRECCION>{ valorCatalogoOSBToAPP($ADDRESS_TYPE_CODE, 'ABANKSGT', '25', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_TIPO_DIRECCION>
		                    	)
		                    }
		                    {
		                        for $SECTOR_CODE in $CUSTOMER_ADDRESS/SECTOR_CODE
		                        return
		                            <ns1:CODIGO_SECTOR>{ valorCatalogoOSBToAPP(string($SECTOR_CODE/text()), 'ABANKSGT', '14', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_SECTOR>
		                    }
		                    {
		                        for $COLONY in $CUSTOMER_ADDRESS/COLONY
		                        return
		                            <ns1:COLONIA>{ data($COLONY) }</ns1:COLONIA>
		                    }
		                    {
		                        for $POSTAL_CODE in $CUSTOMER_ADDRESS/POSTAL_CODE
		                        return
		                            <ns1:CODIGO_POSTAL>{ data($POSTAL_CODE) }</ns1:CODIGO_POSTAL>
		                    }
		                    <ns1:STATUS>A</ns1:STATUS>
		                    {
		                        for $EMAIL in $CUSTOMER_ADDRESS/EMAIL
		                        return
		                            <ns1:EMAIL>{ data($EMAIL) }</ns1:EMAIL>
		                    }
		                    {
		                        for $PHONE_MOBILE in $CUSTOMER_ADDRESS/PHONE_MOBILE
		                        return
		                            <ns1:CELULAR>{ data($PHONE_MOBILE) }</ns1:CELULAR>
		                    }
		                    {
		                        for $HOUSE_NUMBER in $CUSTOMER_ADDRESS/HOUSE_NUMBER
		                        return
		                            <ns1:NUMERO_CASA>{ data($HOUSE_NUMBER) }</ns1:NUMERO_CASA>
		                    }
		                    {
		                        for $REFERENCE in $CUSTOMER_ADDRESS/REFERENCE
		                        return
		                            <ns1:REFERENCIA>{ data($REFERENCE) }</ns1:REFERENCIA>
		                    }
		                    {
		                        for $EXT in $CUSTOMER_ADDRESS/EXT
		                        return
		                            <ns1:EXTENCION>{ data($EXT) }</ns1:EXTENCION>
		                    }
            			</ns1:TR_DIRECCION_ITEM>
            		)
            	} 
            </ns1:TR_DIRECCION>
            <ns1:TR_EMPLEOS>
            	{
            		for $CUSTOMER_TYPE_OF_EMPLOYMENT in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_TYPE_OF_EMPLOYMENTS/ns0:CUSTOMER_TYPE_OF_EMPLOYMENT
            		return(
            			<ns1:TR_EMPLEOS_ITEM>
            				 {
		                        for $EMPLOYMENT_SEQUENCE in $CUSTOMER_TYPE_OF_EMPLOYMENT/EMPLOYMENT_SEQUENCE
		                        return
		                            <ns1:SECUENCIA_EMPLEO>{ data($EMPLOYMENT_SEQUENCE) }</ns1:SECUENCIA_EMPLEO>
		                    }
		                    {
		                        for $POSITION in $CUSTOMER_TYPE_OF_EMPLOYMENT/POSITION
		                        return
		                            <ns1:CARGO>{ valorCatalogoOSBToAPP(data($POSITION), 'ABANKSGT', '11', $consultaEquivalenciaCatalogo) }</ns1:CARGO>
		                    }
		                    {
		                        for $COMPANY_NAME in $CUSTOMER_TYPE_OF_EMPLOYMENT/COMPANY_NAME
		                        return
		                            <ns1:NOMBRE_EMPRESA>{ data($COMPANY_NAME) }</ns1:NOMBRE_EMPRESA>
		                    }
		                    {
		                        for $FECHA_ENTRADA in $CUSTOMER_TYPE_OF_EMPLOYMENT/ENTRY_DATE
		                        return
		                            <ns1:FECHA_ENTRADA>{ fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", fn-bea:date-to-string-with-format("yyyy-MM-dd", data($FECHA_ENTRADA))) }</ns1:FECHA_ENTRADA>
		                    }
		                    <ns1:FECHA_SALIDA>{fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", "2000-01-01")}</ns1:FECHA_SALIDA>
		                    <ns1:CODIGO_MONEDA>0</ns1:CODIGO_MONEDA>
		                    <ns1:VALOR_INGRESO>0</ns1:VALOR_INGRESO>
		                    <ns1:FECHA_VERIFICACION>{fn-bea:dateTime-from-string-with-format("yyyy-MM-dd", "2000-01-01")}</ns1:FECHA_VERIFICACION>
		                    {
		                        for $SALARY_RANGE_CODE in $CUSTOMER_TYPE_OF_EMPLOYMENT/SALARY_RANGE_CODE
		                        return
		                            <ns1:CODIGO_RANGO_SUELDO>{ data($SALARY_RANGE_CODE) }</ns1:CODIGO_RANGO_SUELDO>
                    		}
                    		{
                   				for $COMPANY_TYPE_EMPLOYMENT in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_TYPE_OF_EMPLOYMENTS/ns0:CUSTOMER_TYPE_OF_EMPLOYMENT/COMPANY_TYPE_EMPLOYMENT
                    		     return
                        			<ns1:PRIVADA_PUBLICA>{ data($COMPANY_TYPE_EMPLOYMENT) }</ns1:PRIVADA_PUBLICA>
                			}
                		    {
		           				for $INCOME_CURRENCY in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/INCOME_CURRENCY
		            			return
		                			<ns1:MONEDA_INGRESOS>{ data($INCOME_CURRENCY) }</ns1:MONEDA_INGRESOS>
		                    }
		                    {
		           				for $INCOME_RANGE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/INCOME_RANGE
		            			return
		                			<ns1:RANGO_INGRESOS>{ data($INCOME_RANGE) }</ns1:RANGO_INGRESOS>
		                    }
		                    {
		           				for $EXPENSE_CURRENCY in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/EXPENSE_CURRENCY
		            			return
		                			<ns1:MONEDA_EGRESOS>{ data($EXPENSE_CURRENCY) }</ns1:MONEDA_EGRESOS>
		                    }
		                    {
		           				for $EXPENSE_RANGE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/EXPENSE_RANGE
		            			return
		                			<ns1:RANGO_EGRESOS>{ data($EXPENSE_RANGE) }</ns1:RANGO_EGRESOS>
		                    }
		                    {
		           				for $ECONOMIC_SECTOR in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_ADDRESSES/ns0:CUSTOMER_ADDRESS/ECONOMIC_SECTOR
		            			return
		                			<ns1:SECTOR_ECONOMICO_TRAB>{ data($ECONOMIC_SECTOR) }</ns1:SECTOR_ECONOMICO_TRAB>
		                    }
                    		
            			</ns1:TR_EMPLEOS_ITEM>
            		)
            	}                
            </ns1:TR_EMPLEOS>
            <ns1:TR_REF_PERSONAL>
            	{
            		for $CUSTOMER_PERSONAL_REFERENCE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_PERSONAL_REFERENCES/ns0:CUSTOMER_PERSONAL_REFERENCE
            		return(
            			<ns1:TR_REF_PERSONAL_ITEM>
	            			<ns1:CODIGO_REFERENCIA_PERSONAL>{ data($CUSTOMER_PERSONAL_REFERENCE/PERSONAL_REFERENCE_CODE) }</ns1:CODIGO_REFERENCIA_PERSONAL>
		                    {
		                        for $NAME in $CUSTOMER_PERSONAL_REFERENCE/NAME
		                        return
		                            <ns1:NOMBRE>{ data($NAME) }</ns1:NOMBRE>
		                    }
		                    {
		                        for $REFE_TYPE in $CUSTOMER_PERSONAL_REFERENCE/REFE_TYPE
		                        return
		                            <ns1:TIPO_REFERENCIA>{ data($REFE_TYPE) }</ns1:TIPO_REFERENCIA>
		                    }
		                    <ns1:TELEFONO>{ data($CUSTOMER_PERSONAL_REFERENCE/PHONE) }</ns1:TELEFONO>
		                    {
		                        for $FIRST_SURNAME in $CUSTOMER_PERSONAL_REFERENCE/FIRST_SURNAME
		                        return
		                            <ns1:PRIMER_APELLIDO>{ data($FIRST_SURNAME) }</ns1:PRIMER_APELLIDO>
		                    }
		                    {
		                        for $SECOND_SURNAME in $CUSTOMER_PERSONAL_REFERENCE/SECOND_SURNAME
		                        return
		                            <ns1:SEGUNDO_APELLIDO>{ data($SECOND_SURNAME) }</ns1:SEGUNDO_APELLIDO>
		                    }
		                    <ns1:STATUS>V</ns1:STATUS>           			
            			</ns1:TR_REF_PERSONAL_ITEM>
            		)
            	}
            </ns1:TR_REF_PERSONAL>
            <ns1:RG_INT_CLIENTE_CEP>
                <ns1:NOMBRE_INSTITUCION>{ data($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INST_CEP/INSTITUTION_NAME) }</ns1:NOMBRE_INSTITUCION>
                <ns1:TIPO_BIEN_INSTITUCION>{ data($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INST_CEP/TYPE_OF_GOOD_INSTITUTION) }</ns1:TIPO_BIEN_INSTITUCION>
                <ns1:CODIGO_CATEGORIA>{ data($creacionClienteTarjetaCredito1/ns0:CUSTOMER_INST_CEP/CATEGORY_CODE) }</ns1:CODIGO_CATEGORIA>
            </ns1:RG_INT_CLIENTE_CEP>
            <ns1:RG_CLIENTE_PEP>
                {
                    for $RELATIONSHIP_CODE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_PEP/RELATIONSHIP_CODE
                    return
                        <ns1:CODIGO_PARENTESCO>{ valorCatalogoOSBToAPP(data($RELATIONSHIP_CODE), 'ABANKSGT', '28', $consultaEquivalenciaCatalogo) }</ns1:CODIGO_PARENTESCO>
                }
                {
                    for $NAME in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_PEP/NAME
                    return
                        <ns1:NOMBRE>{ data($NAME) }</ns1:NOMBRE>
                }
                {
                    for $COMPANY in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_PEP/COMPANY
                    return
                        <ns1:EMPRESA>{ data($COMPANY) }</ns1:EMPRESA>
                }
                {
                    for $POSITION in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_PEP/POSITION
                    return
                        <ns1:CARGO>{ data($POSITION) }</ns1:CARGO>
                }
            </ns1:RG_CLIENTE_PEP>
            <ns1:RG_CLIENTE_PORE>
           		{
                    for $ACTIVITY_CODE in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_PORE/ACTIVITY_CODE
                    return
                        <ns1:CODIGO_ACTIVIDAD>{ data($ACTIVITY_CODE) }</ns1:CODIGO_ACTIVIDAD>
                }               
                {
                    for $STATUS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_PORE/STATUS
                    return
                        <ns1:ESTADO>{ data($STATUS) }</ns1:ESTADO>
                }
            </ns1:RG_CLIENTE_PORE>
            <ns1:RG_CLIENTE_CEP>
                {
                    for $NATIONALITY_CEP in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_CEP/NATIONALITY_CEP
                    return
                        <ns1:NACIONALIDAD>{ valorCatalogoOSBToAPP($NATIONALITY_CEP, 'ABANKSGT', '26', $consultaEquivalenciaCatalogo) }</ns1:NACIONALIDAD>
                } 
            	{
                    for $ASSOCIATED_PRODUCT in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_CEP/ASSOCIATED_PRODUCT
                    return
                        <ns1:PRODUCTO_ASOCIADO>{ data($ASSOCIATED_PRODUCT) }</ns1:PRODUCTO_ASOCIADO>
                }
                {
                    for $OTHER_PRODUCTS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_CEP/OTHER_PRODUCTS
                    return
                        <ns1:OTROS_PRODUCTOS>{ data($OTHER_PRODUCTS) }</ns1:OTROS_PRODUCTOS>
                }
                {
                    for $STATUS_GUATECOMPRAS in $creacionClienteTarjetaCredito1/ns0:CUSTOMER_CEP/STATUS_GUATECOMPRAS
                    return
                        <ns1:ESTATUS_GUATECOMPRAS>{ data($STATUS_GUATECOMPRAS) }</ns1:ESTATUS_GUATECOMPRAS>
                }       
            </ns1:RG_CLIENTE_CEP>
        </ns1:InputParameters>
};

declare variable $creacionClienteTarjetaCredito1 as element(ns0:creacionClienteTarjetaCredito) external;
declare variable $codPais as xs:string external;
declare variable $consultaEquivalenciaCatalogo as element(ns2:OutputParameters) external;

xf:perfilClienteGTIn($creacionClienteTarjetaCredito1,
    $codPais,
    $consultaEquivalenciaCatalogo)