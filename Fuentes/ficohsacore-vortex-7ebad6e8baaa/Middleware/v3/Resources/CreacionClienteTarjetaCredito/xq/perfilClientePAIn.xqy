xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creacionClienteTarjetaCredito1" element="ns1:creacionClienteTarjetaCredito" location="../xsd/creacionClienteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v2/BusinessServices/ABKPA/perfilCliente/xsd/perfilCliente_sp.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$ptEquivalencias" type="ns2:TEQUIVALENCIA_CATALOGO" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creacionClienteTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/perfilCliente";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/CreacionClienteTarjetaCredito/xq/perfilClientePAIn/";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";

declare function valorCatalogoOSBToAPP($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns2:EQUIVALENCIA[ns2:CATALOGO_ID = $catalogoId and 
															  ns2:APLICACION_DESC = $aplicacion and 
															  ns2:VALOR_DESC = $valor]/ns2:EQUIVALENCIA_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:perfilClientePAIn($creacionClienteTarjetaCredito1 as element(ns1:creacionClienteTarjetaCredito),
    $codPais as xs:string,
    $ptEquivalencias as element())
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TIPO_OPERACION>I</ns0:PV_TIPO_OPERACION>
            <ns0:PN_PAIS>{ data($codPais) }</ns0:PN_PAIS>
            <ns0:RG_CLIENTE>
            	{
            		let $IDENTIFICATION_TYPE := string($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/IDENTIFICATION_TYPE/text())
            		return(
            			<ns0:CODIGO_TIPO_IDENTIFICACION>{ valorCatalogoOSBToAPP($IDENTIFICATION_TYPE, 'ABANKSPA', '4', $ptEquivalencias) }</ns0:CODIGO_TIPO_IDENTIFICACION>
            		)
            	}          
                <ns0:NUMERO_IDENTIFICACION>{ data($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/IDENTIFICATION_NUMBER) }</ns0:NUMERO_IDENTIFICACION>
                {
            		let $CUSTOMER_TYPE := string($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CUSTOMER_TYPE/text())
            		return(
            			<ns0:CODIGO_TIPO_CLIENTE>{ valorCatalogoOSBToAPP($CUSTOMER_TYPE, 'ABANKSPA', '21', $ptEquivalencias) }</ns0:CODIGO_TIPO_CLIENTE>
            		)
            	}                 
                <ns0:CODIGO_CATEGORIA>2</ns0:CODIGO_CATEGORIA>
                <ns0:CODIGO_AGENCIA>1</ns0:CODIGO_AGENCIA>
                {
                	let $COUNTRY_ID := string($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/COUNTRY_ID/text())
                	return(
                		<ns0:CODIGO_PAIS>{ valorCatalogoOSBToAPP($COUNTRY_ID, 'ABANKSPA', '9', $ptEquivalencias) }</ns0:CODIGO_PAIS>
                	)
                }
                {
                	let $ECONOMIC_ACTIVITY_ID := string($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/ECONOMIC_ACTIVITY_ID)
                	return(
                		<ns0:CODIGO_ACTIVIDAD_ECONOMICA>{ valorCatalogoOSBToAPP($ECONOMIC_ACTIVITY_ID, 'ABANKSPA', '22', $ptEquivalencias) }</ns0:CODIGO_ACTIVIDAD_ECONOMICA>
                	)
                }               
                <ns0:CODIGO_GRUPO_EMPRESARIAL>9500</ns0:CODIGO_GRUPO_EMPRESARIAL>
                <ns0:TIPO_DE_PERSONA>{ data($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/TYPE_OF_PERSON) }</ns0:TIPO_DE_PERSONA>
                <ns0:NOMBRES>{ data($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/NAMES) }</ns0:NOMBRES>
                <ns0:PRIMER_APELLIDO>{ data($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/FIRST_SURNAME) }</ns0:PRIMER_APELLIDO>
                <ns0:SEGUNDO_APELLIDO>{ data($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/SECOND_SURNAME) }</ns0:SEGUNDO_APELLIDO>
                {
                    for $MARRIED_LAST_NAME in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/MARRIED_LAST_NAME
                    return
                        <ns0:APELLIDO_DE_CASADA>{ data($MARRIED_LAST_NAME) }</ns0:APELLIDO_DE_CASADA>
                }
                {
                	let $GENDER := string($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/GENDER/text())
                	return(
                		<ns0:SEXO>{ valorCatalogoOSBToAPP($GENDER, 'ABANKSPA', '1', $ptEquivalencias) }</ns0:SEXO>
                	)
                }
               
                {
                    for $DATE_OF_BIRTH in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/DATE_OF_BIRTH
                    return
                        <ns0:FECHA_DE_NACIMIENTO>{ data($DATE_OF_BIRTH) }</ns0:FECHA_DE_NACIMIENTO>
                }
                {
                    for $MARITAL_STATUS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/MARITAL_STATUS
                    return
                        <ns0:ESTADO_CIVIL>{ valorCatalogoOSBToAPP($MARITAL_STATUS, 'ABANKSPA', '2', $ptEquivalencias) }</ns0:ESTADO_CIVIL>
                }
                {
                    for $SPOUSE_NAME in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/SPOUSE_NAME
                    return
                        <ns0:NOMBRE_CONJUGUE>{ data($SPOUSE_NAME) }</ns0:NOMBRE_CONJUGUE>
                }
                <ns0:CODIGO_OFICIAL>SALESFORCE</ns0:CODIGO_OFICIAL>
                <ns0:CODIGO_EMPRESA>1</ns0:CODIGO_EMPRESA>
                {
                    for $CODE_OCUPACION in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CODE_OCUPACION
                    return
                        <ns0:CODIGO_OCUPACION>{ valorCatalogoOSBToAPP($CODE_OCUPACION, 'ABANKSPA', '23', $ptEquivalencias) }</ns0:CODIGO_OCUPACION>
                }
                <ns0:CODIGO_ACTIVIDAD_BANCO>33</ns0:CODIGO_ACTIVIDAD_BANCO>
                {
                    for $EDUCATION_LEVEL in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/EDUCATION_LEVEL
                    return
                        <ns0:NIVEL_EDUCATIVO>{ valorCatalogoOSBToAPP($EDUCATION_LEVEL, 'ABANKSPA', '10', $ptEquivalencias) }</ns0:NIVEL_EDUCATIVO>
                }
                {
                    for $CHILDREN_NUMBERS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CHILDREN_NUMBERS
                    return
                        <ns0:CANTIDAD_HIJOS>{ data($CHILDREN_NUMBERS) }</ns0:CANTIDAD_HIJOS>
                }
                {
                    for $PLACE_OF_BIRTH in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PLACE_OF_BIRTH
                    return
                        <ns0:LUGAR_DE_NACIMIENTO>{ data($PLACE_OF_BIRTH) }</ns0:LUGAR_DE_NACIMIENTO>
                }
                {
                    for $PROFESSION_CODE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PROFESSION_CODE
                    return
                        <ns0:CODIGO_PROFESION>{ valorCatalogoOSBToAPP(string($PROFESSION_CODE/text()), 'ABANKSPA', '3', $ptEquivalencias) }</ns0:CODIGO_PROFESION>
                }
                <ns0:CODIGO_MONEDA_LEGAL>2</ns0:CODIGO_MONEDA_LEGAL>
                <ns0:CODIGO_TIPO_IDENTIFICACION_R>20</ns0:CODIGO_TIPO_IDENTIFICACION_R>
                <ns0:CODIGO_TIPO_PODER_R>5</ns0:CODIGO_TIPO_PODER_R>
                {
                    for $SEGMENT_CODE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/SEGMENT_CODE
                    return
                        <ns0:CODIGO_SEGMENTO>{ data($SEGMENT_CODE) }</ns0:CODIGO_SEGMENTO>
                }
                <ns0:CODIGO_PAIS_LEGAL>1</ns0:CODIGO_PAIS_LEGAL>
                <ns0:CAPITAL_SOCIAL>1</ns0:CAPITAL_SOCIAL>
                {
                    for $IS_WORK in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/IS_WORK
                    return
                        <ns0:TRABAJA>{ data($IS_WORK) }</ns0:TRABAJA>
                }
                <ns0:CODIGO_DESTINO>1899</ns0:CODIGO_DESTINO>
                <ns0:CODIGO_RESIDENCIA>1</ns0:CODIGO_RESIDENCIA>
                <ns0:CODIGO_SECTOR>1</ns0:CODIGO_SECTOR>
                {
                    for $COMPANY_TYPE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/COMPANY_TYPE
                    return
                        <ns0:TIPO_DE_EMPRESA>{ valorCatalogoOSBToAPP($COMPANY_TYPE, 'ABANKSPA', '24', $ptEquivalencias) }</ns0:TIPO_DE_EMPRESA>
                }
                {
                    for $CLIENT_RISK in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CLIENT_RISK
                    return
                        <ns0:RIESGO_CLIENTE>{ data($CLIENT_RISK) }</ns0:RIESGO_CLIENTE>
                }
                {
                    for $EXPIRATION_DATE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/EXPIRATION_DATE
                    return
                        <ns0:FECHA_VENC_ID>{ data($EXPIRATION_DATE) }</ns0:FECHA_VENC_ID>
                }
                <ns0:CODIGO_SEGMENTACION_CARTERA>1</ns0:CODIGO_SEGMENTACION_CARTERA>
                <ns0:TIPO_COMERCIANTE>1</ns0:TIPO_COMERCIANTE>
                {
                    for $IS_EMPLOYEE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/IS_EMPLOYEE
                    return
                        <ns0:EMPLEADO>{ data($IS_EMPLOYEE) }</ns0:EMPLEADO>
                }
                {
                    for $PEPS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEPS
                    return
                        <ns0:PEPS>{ data($PEPS) }</ns0:PEPS>
                }
                {
                	for $NIT_NUMBER in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/NIT_NUMBER
                    return
                       	<ns0:NUMERO_DE_NIT>{ data($NIT_NUMBER) }</ns0:NUMERO_DE_NIT>
                } 
                {
                	for $CPE_TYPE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CPE_TYPE
                    return
                       	<ns0:TIPO_CPE>{ data($CPE_TYPE) }</ns0:TIPO_CPE>
                }             
                {
                	for $CUSTOMER_CPE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CUSTOMER_CPE
                    return
                       	<ns0:CLIENTES_CPE>{ data($CUSTOMER_CPE) }</ns0:CLIENTES_CPE>
                }               
                {
                    for $CPE_INSTITUTION in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CPE_INSTITUTION
                    return
                        <ns0:CPE_INSTITUTION>{ data($CPE_INSTITUTION) }</ns0:CPE_INSTITUTION>
                }
                {
                    for $CPE_PRODUCT_SERVICE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CPE_PRODUCT_SERVICE
                    return
                        <ns0:CPE_PRODUCT_SERVICE>{ data($CPE_PRODUCT_SERVICE) }</ns0:CPE_PRODUCT_SERVICE>
                }
                {
                    for $CPE_PRODUCT_SERVICE_CATEGORY in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CPE_PRODUCT_SERVICE_CATEGORY
                    return
                        <ns0:CPE_PRODUCT_SERVICE_CATEGORY>{ data($CPE_PRODUCT_SERVICE_CATEGORY) }</ns0:CPE_PRODUCT_SERVICE_CATEGORY>
                }
                {
                    for $CPE_PRODUCT_ASOC in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CPE_PRODUCT_ASOC
                    return
                        <ns0:CPE_PRODUCT_ASOC>{ data($CPE_PRODUCT_ASOC) }</ns0:CPE_PRODUCT_ASOC>
                }
                {
                    for $CPE_OTHER_PRODUCTS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CPE_OTHER_PRODUCTS
                    return
                        <ns0:CPE_OTHER_PRODUCTS>{ data($CPE_OTHER_PRODUCTS) }</ns0:CPE_OTHER_PRODUCTS>
                }
                {
                    for $CPE_GUATECOMPRAS_STATUS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/CPE_GUATECOMPRAS_STATUS
                    return
                        <ns0:CPE_GUATECOMPRAS_STATUS>{ data($CPE_GUATECOMPRAS_STATUS) }</ns0:CPE_GUATECOMPRAS_STATUS>
                }
                {
                    for $PEP_HERITAGE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_HERITAGE
                    return
                        <ns0:PEP_HERITAGE>{ data($PEP_HERITAGE) }</ns0:PEP_HERITAGE>
                }
                {
                    for $PEP_OWN_BUSINESS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_OWN_BUSINESS
                    return
                        <ns0:PEP_OWN_BUSINESS>{ data($PEP_OWN_BUSINESS) }</ns0:PEP_OWN_BUSINESS>
                }
                {
                    for $PEP_OTHERS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_OTHERS
                    return
                        <ns0:PEP_OTHERS>{ data($PEP_OTHERS) }</ns0:PEP_OTHERS>
                }
                {
                    for $PEP_BANK_LENDING in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_BANK_LENDING
                    return
                        <ns0:PEP_BANK_LENDING>{ data($PEP_BANK_LENDING) }</ns0:PEP_BANK_LENDING>
                }
                {
                    for $PEP_CURRENT_WORK in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_CURRENT_WORK
                    return
                        <ns0:PEP_CURRENT_WORK>{ data($PEP_CURRENT_WORK) }</ns0:PEP_CURRENT_WORK>
                }
                {
                    for $PEP_OLD_WORK in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_OLD_WORK
                    return
                        <ns0:PEP_OLD_WORK>{ data($PEP_OLD_WORK) }</ns0:PEP_OLD_WORK>
                }
                {
                    for $PEP_RELATIONSHIP_TYPE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_RELATIONSHIP_TYPE
                    return
                        <ns0:PEP_RELATIONSHIP_TYPE>{ data($PEP_RELATIONSHIP_TYPE) }</ns0:PEP_RELATIONSHIP_TYPE>
                }
                {
                    for $PEP_NAME in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_NAME
                    return
                        <ns0:PEP_NAME>{ data($PEP_NAME) }</ns0:PEP_NAME>
                }
                {
                    for $PEP_WORK in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_WORK
                    return
                        <ns0:PEP_WORK>{ data($PEP_WORK) }</ns0:PEP_WORK>
                }
                {
                    for $PEP_POSITION in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PEP_POSITION
                    return
                        <ns0:PEP_POSITION>{ data($PEP_POSITION) }</ns0:PEP_POSITION>
                }
                {
                    for $PORE_CLIENT in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PORE_CLIENT
                    return
                        <ns0:PORE_CLIENT>{ data($PORE_CLIENT) }</ns0:PORE_CLIENT>
                }
                {
                    for $PORES_ACTIVITY in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/PORES_ACTIVITY
                    return
                        <ns0:PORES_ACTIVIDAD>{ data($PORES_ACTIVITY) }</ns0:PORES_ACTIVIDAD>
                }
                <ns0:EXPIRATION_ID>{ data($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INFO/EXPIRATION_ID) }</ns0:EXPIRATION_ID>
            </ns0:RG_CLIENTE>
            <ns0:TR_DIRECCION>
            	{
            		for $CUSTOMER_ADDRESS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_ADDRESSES/ns1:CUSTOMER_ADDRESS
            		return(
            			<ns0:TR_DIRECCION_ITEM>
            				{
		                        for $ADDRESS_CODE in $CUSTOMER_ADDRESS/ADDRESS_CODE
		                        return
		                            <ns0:CODIGO_DIRECCION>{ valorCatalogoOSBToAPP(string($ADDRESS_CODE/text()), 'ABANKSPA', '25', $ptEquivalencias) }</ns0:CODIGO_DIRECCION>
		                    }
		                    {
		                        for $COUNTRY_CODE in $CUSTOMER_ADDRESS/COUNTRY_CODE
		                        return
		                            <ns0:CODIGO_PAIS>{ valorCatalogoOSBToAPP($COUNTRY_CODE, 'ABANKSPA', '9', $ptEquivalencias) }</ns0:CODIGO_PAIS>
		                    }
		                    {
		                        for $DEPARMENT_CODE in $CUSTOMER_ADDRESS/DEPARMENT_CODE
		                        return
		                            <ns0:CODIGO_DEPARTAMENTO>{ valorCatalogoOSBToAPP(string($DEPARMENT_CODE/text()), 'ABANKSPA', '8', $ptEquivalencias) }</ns0:CODIGO_DEPARTAMENTO>
		                    }
		                    {
		                        for $MUNICIPALITY_CODE in $CUSTOMER_ADDRESS/MUNICIPALITY_CODE
		                        return
		                            <ns0:CODIGO_MUNICIPIO>{ valorCatalogoOSBToAPP(string($MUNICIPALITY_CODE/text()), 'ABANKSPA', '7', $ptEquivalencias) }</ns0:CODIGO_MUNICIPIO>
		                    }
		                    {
		                        for $NOMENCLATURE in $CUSTOMER_ADDRESS/NOMENCLATURE
		                        return
		                            <ns0:NOMENCLATURA>{ data($NOMENCLATURE) }</ns0:NOMENCLATURA>
		                    }
		                    {
		                        for $ZONE in $CUSTOMER_ADDRESS/ZONE
		                        return
		                            <ns0:ZONA>{ data($ZONE) }</ns0:ZONA>
		                    }
		                    {
		                        for $PHONES in $CUSTOMER_ADDRESS/PHONES
		                        return
		                            <ns0:TELEFONOS>{ data($PHONES) }</ns0:TELEFONOS>
		                    }
		                    {
		                        for $FAX in $CUSTOMER_ADDRESS/FAX
		                        return
		                            <ns0:FAX>{ data($FAX) }</ns0:FAX>
		                    }
		                    {
		                    	let $ADDRESS_TYPE_CODE := string($CUSTOMER_ADDRESS/ADDRESS_TYPE_CODE/text())
		                    	return(
		                    	<ns0:CODIGO_TIPO_DIRECCION>{ valorCatalogoOSBToAPP($ADDRESS_TYPE_CODE, 'ABANKSPA', '25', $ptEquivalencias) }</ns0:CODIGO_TIPO_DIRECCION>
		                    	)
		                    }
		                    {
		                        for $SECTOR_CODE in $CUSTOMER_ADDRESS/SECTOR_CODE
		                        return
		                            <ns0:CODIGO_SECTOR>{ valorCatalogoOSBToAPP(string($SECTOR_CODE/text()), 'ABANKSPA', '14', $ptEquivalencias) }</ns0:CODIGO_SECTOR>
		                    }
		                    {
		                        for $COLONY in $CUSTOMER_ADDRESS/COLONY
		                        return
		                            <ns0:COLONIA>{ data($COLONY) }</ns0:COLONIA>
		                    }
		                    {
		                        for $POSTAL_CODE in $CUSTOMER_ADDRESS/POSTAL_CODE
		                        return
		                            <ns0:CODIGO_POSTAL>{ data($POSTAL_CODE) }</ns0:CODIGO_POSTAL>
		                    }
		                    <ns0:STATUS>A</ns0:STATUS>
		                    {
		                        for $EMAIL in $CUSTOMER_ADDRESS/EMAIL
		                        return
		                            <ns0:EMAIL>{ data($EMAIL) }</ns0:EMAIL>
		                    }
		                    {
		                        for $PHONE_MOBILE in $CUSTOMER_ADDRESS/PHONE_MOBILE
		                        return
		                            <ns0:CELULAR>{ data($PHONE_MOBILE) }</ns0:CELULAR>
		                    }
		                    {
		                        for $HOUSE_NUMBER in $CUSTOMER_ADDRESS/HOUSE_NUMBER
		                        return
		                            <ns0:NUMERO_CASA>{ data($HOUSE_NUMBER) }</ns0:NUMERO_CASA>
		                    }
		                    {
		                        for $REFERENCE in $CUSTOMER_ADDRESS/REFERENCE
		                        return
		                            <ns0:REFERENCIA>{ data($REFERENCE) }</ns0:REFERENCIA>
		                    }
		                    {
		                        for $EXT in $CUSTOMER_ADDRESS/EXT
		                        return
		                            <ns0:EXTENCION>{ data($EXT) }</ns0:EXTENCION>
		                    }
            			</ns0:TR_DIRECCION_ITEM>
            		)
            	} 
            </ns0:TR_DIRECCION>
            <ns0:TR_EMPLEOS>
            	{
            		for $CUSTOMER_TYPE_OF_EMPLOYMENT in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_TYPE_OF_EMPLOYMENTS/ns1:CUSTOMER_TYPE_OF_EMPLOYMENT
            		return(
            			<ns0:TR_EMPLEOS_ITEM>
            				 {
		                        for $EMPLOYMENT_SEQUENCE in $CUSTOMER_TYPE_OF_EMPLOYMENT/EMPLOYMENT_SEQUENCE
		                        return
		                            <ns0:SECUENCIA_EMPLEO>{ data($EMPLOYMENT_SEQUENCE) }</ns0:SECUENCIA_EMPLEO>
		                    }
		                    {
		                        for $POSITION in $CUSTOMER_TYPE_OF_EMPLOYMENT/POSITION
		                        return
		                            <ns0:CARGO>{ data($POSITION) }</ns0:CARGO>
		                    }
		                    {
		                        for $COMPANY_NAME in $CUSTOMER_TYPE_OF_EMPLOYMENT/COMPANY_NAME
		                        return
		                            <ns0:NOMBRE_EMPRESA>{ data($COMPANY_NAME) }</ns0:NOMBRE_EMPRESA>
		                    }
		                    {
		                        for $FECHA_ENTRADA in $CUSTOMER_TYPE_OF_EMPLOYMENT/ENTRY_DATE
		                        return
		                            <ns0:FECHA_ENTRADA>{ data($FECHA_ENTRADA) }</ns0:FECHA_ENTRADA>
		                    }
		                    <ns0:FECHA_SALIDA>2000-01-01</ns0:FECHA_SALIDA>
		                    <ns0:CODIGO_MONEDA>0</ns0:CODIGO_MONEDA>
		                    <ns0:VALOR_INGRESO>0</ns0:VALOR_INGRESO>
		                    <ns0:FECHA_VERIFICACION>2000-01-01</ns0:FECHA_VERIFICACION>
		                    {
		                        for $SALARY_RANGE_CODE in $CUSTOMER_TYPE_OF_EMPLOYMENT/SALARY_RANGE_CODE
		                        return
		                            <ns0:CODIGO_RANGO_SUELDO>{ data($SALARY_RANGE_CODE) }</ns0:CODIGO_RANGO_SUELDO>
                    		}
            			</ns0:TR_EMPLEOS_ITEM>
            		)
            	}                
            </ns0:TR_EMPLEOS>
            <ns0:TR_REF_PERSONAL>
            	{
            		for $CUSTOMER_PERSONAL_REFERENCE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_PERSONAL_REFERENCES/ns1:CUSTOMER_PERSONAL_REFERENCE
            		return(
            			<ns0:TR_REF_PERSONAL_ITEM>
	            			<ns0:CODIGO_REFERENCIA_PERSONAL>{ data($CUSTOMER_PERSONAL_REFERENCE/PERSONAL_REFERENCE_CODE) }</ns0:CODIGO_REFERENCIA_PERSONAL>
		                    {
		                        for $NAME in $CUSTOMER_PERSONAL_REFERENCE/NAME
		                        return
		                            <ns0:NOMBRE>{ data($NAME) }</ns0:NOMBRE>
		                    }
		                    {
		                        for $REFE_TYPE in $CUSTOMER_PERSONAL_REFERENCE/REFE_TYPE
		                        return
		                            <ns0:TIPO_REFERENCIA>{ data($REFE_TYPE) }</ns0:TIPO_REFERENCIA>
		                    }
		                    <ns0:TELEFONO>{ data($CUSTOMER_PERSONAL_REFERENCE/PHONE) }</ns0:TELEFONO>
		                    {
		                        for $FIRST_SURNAME in $CUSTOMER_PERSONAL_REFERENCE/FIRST_SURNAME
		                        return
		                            <ns0:PRIMER_APELLIDO>{ data($FIRST_SURNAME) }</ns0:PRIMER_APELLIDO>
		                    }
		                    {
		                        for $SECOND_SURNAME in $CUSTOMER_PERSONAL_REFERENCE/SECOND_SURNAME
		                        return
		                            <ns0:SEGUNDO_APELLIDO>{ data($SECOND_SURNAME) }</ns0:SEGUNDO_APELLIDO>
		                    }
		                    <ns0:STATUS>V</ns0:STATUS>           			
            			</ns0:TR_REF_PERSONAL_ITEM>
            		)
            	}
            </ns0:TR_REF_PERSONAL>
            <ns0:RG_INT_CLIENTE_CEP>
                <ns0:NOMBRE_INSTITUCION>{ data($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INST_CEP/INSTITUTION_NAME) }</ns0:NOMBRE_INSTITUCION>
                <ns0:TIPO_BIEN_INSTITUCION>{ data($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INST_CEP/TYPE_OF_GOOD_INSTITUTION) }</ns0:TIPO_BIEN_INSTITUCION>
                <ns0:CODIGO_CATEGORIA>{ data($creacionClienteTarjetaCredito1/ns1:CUSTOMER_INST_CEP/CATEGORY_CODE) }</ns0:CODIGO_CATEGORIA>
            </ns0:RG_INT_CLIENTE_CEP>
            <ns0:RG_CLIENTE_PEP>
                {
                    for $RELATIONSHIP_CODE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_PEP/RELATIONSHIP_CODE
                    return
                        <ns0:CODIGO_PARENTESCO>{ data($RELATIONSHIP_CODE) }</ns0:CODIGO_PARENTESCO>
                }
                {
                    for $NAME in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_PEP/NAME
                    return
                        <ns0:NOMBRE>{ data($NAME) }</ns0:NOMBRE>
                }
                {
                    for $COMPANY in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_PEP/COMPANY
                    return
                        <ns0:EMPRESA>{ data($COMPANY) }</ns0:EMPRESA>
                }
                {
                    for $POSITION in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_PEP/POSITION
                    return
                        <ns0:CARGO>{ data($POSITION) }</ns0:CARGO>
                }
            </ns0:RG_CLIENTE_PEP>
            <ns0:RG_CLIENTE_PORE>
           		{
                    for $ACTIVITY_CODE in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_PORE/ACTIVITY_CODE
                    return
                        <ns0:CODIGO_ACTIVIDAD>{ data($ACTIVITY_CODE) }</ns0:CODIGO_ACTIVIDAD>
                }               
                {
                    for $STATUS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_PORE/STATUS
                    return
                        <ns0:ESTADO>{ data($STATUS) }</ns0:ESTADO>
                }
            </ns0:RG_CLIENTE_PORE>
            <ns0:RG_CLIENTE_CEP>
            	{
                    for $ASSOCIATED_PRODUCT in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_CEP/ASSOCIATED_PRODUCT
                    return
                        <ns0:PRODUCTO_ASOCIADO>{ data($ASSOCIATED_PRODUCT) }</ns0:PRODUCTO_ASOCIADO>
                }
                {
                    for $OTHER_PRODUCTS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_CEP/OTHER_PRODUCTS
                    return
                        <ns0:OTROS_PRODUCTOS>{ data($OTHER_PRODUCTS) }</ns0:OTROS_PRODUCTOS>
                }
                {
                    for $STATUS_GUATECOMPRAS in $creacionClienteTarjetaCredito1/ns1:CUSTOMER_CEP/STATUS_GUATECOMPRAS
                    return
                        <ns0:ESTATUS_GUATECOMPRAS>{ data($STATUS_GUATECOMPRAS) }</ns0:ESTATUS_GUATECOMPRAS>
                }       
            </ns0:RG_CLIENTE_CEP>
        </ns0:InputParameters>
};

declare variable $creacionClienteTarjetaCredito1 as element(ns1:creacionClienteTarjetaCredito) external;
declare variable $codPais as xs:string external;
declare variable $ptEquivalencias as element() external;

xf:perfilClientePAIn($creacionClienteTarjetaCredito1,
    $codPais,
    $ptEquivalencias)