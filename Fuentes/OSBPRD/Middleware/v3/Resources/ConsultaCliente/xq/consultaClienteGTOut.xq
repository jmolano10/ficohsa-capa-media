(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaCliente/xsd/consultaCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/abanksGT/consultaCliente/xq/consultaClienteOut2/";

declare function xf:consultaClienteOut2($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaClienteResponse) {
    
    if (fn:upper-case($outputParameters1/ns0:PV_CODIGOMENSAJE) = "SUCCESS") then (
        <ns1:consultaClienteResponse>
            {
                for $PV_CUSTOMER_ID in $outputParameters1/ns0:PV_CUSTOMER_ID
                return
                    <ns1:CUSTOMER_ID>{ data($PV_CUSTOMER_ID) }</ns1:CUSTOMER_ID>
            }
            {
                for $PV_MNEMONIC in $outputParameters1/ns0:PV_MNEMONIC
                return
                    <ns1:MNEMONIC>{ data($PV_MNEMONIC) }</ns1:MNEMONIC>
            }
            <ns1:IDENTIFICATION_INFO>
                <ns1:LEGAL_IDENTIFICATION_ITEM>
                    <ns1:LEGAL_DOCUMENT_NAME>{ data($outputParameters1/ns0:PV_LEGAL_DOC_NAME)}</ns1:LEGAL_DOCUMENT_NAME>
                    <ns1:LEGAL_ID>{ data($outputParameters1/ns0:PV_LEGAL_ID) }</ns1:LEGAL_ID>
                </ns1:LEGAL_IDENTIFICATION_ITEM>
            </ns1:IDENTIFICATION_INFO>
            {
                for $PV_NOMBRES in $outputParameters1/ns0:PV_NOMBRES
                return
                    <ns1:GIVEN_NAMES>{ data($PV_NOMBRES) }</ns1:GIVEN_NAMES>
            }
            {
                for $PV_APELLIDOS in $outputParameters1/ns0:PV_APELLIDOS
                return
                    <ns1:FAMILY_NAME>{ data($PV_APELLIDOS) }</ns1:FAMILY_NAME>
            }
            {
                for $PV_RAZONSOCIAL in $outputParameters1/ns0:PV_RAZONSOCIAL
                return
                    <ns1:FULL_NAME>{ data($PV_RAZONSOCIAL) }</ns1:FULL_NAME>
            }
            {
                for $PV_RAZONSOCIAL in $outputParameters1/ns0:PV_RAZONSOCIAL
                return
                    <ns1:NAME_OF_BUSINESS>{ data($PV_RAZONSOCIAL) }</ns1:NAME_OF_BUSINESS>
            }
            {
                for $PV_NOMBRECOMERCIAL in $outputParameters1/ns0:PV_NOMBRECOMERCIAL
                return
                    <ns1:COMMERCIAL_NAME>{ data($PV_NOMBRECOMERCIAL) }</ns1:COMMERCIAL_NAME>
            }
            {
                for $PV_NOMBRECENTRALRIESGOS in $outputParameters1/ns0:PV_NOMBRECENTRALRIESGOS
                return
                    <ns1:LEGAL_HOLDER_NAME>{ data($PV_NOMBRECENTRALRIESGOS) }</ns1:LEGAL_HOLDER_NAME>
            }
            {
                for $PV_NOMBRECORTO in $outputParameters1/ns0:PV_NOMBRECORTO
                return
                    <ns1:SHORT_NAME>{ data($PV_NOMBRECORTO) }</ns1:SHORT_NAME>
            }
            {
                for $PD_FECHANACIMIENTO in $outputParameters1/ns0:PD_FECHANACIMIENTO
                return
                    <ns1:DATE_OF_BIRTH>{ data($PD_FECHANACIMIENTO) }</ns1:DATE_OF_BIRTH>
            }
            {
                for $PV_GENERO in $outputParameters1/ns0:PV_GENERO
                return
                    <ns1:GENDER>{ data($PV_GENERO) }</ns1:GENDER>
            }
            {
                for $PV_NACIONALIDAD in $outputParameters1/ns0:PV_NACIONALIDAD
                return
                    <ns1:NATIONALITY>{ data($PV_NACIONALIDAD) }</ns1:NATIONALITY>
            }
            {
                for $PV_RESIDENCIA in $outputParameters1/ns0:PV_RESIDENCIA
                return
                    <ns1:RESIDENCE>{ data($PV_RESIDENCIA) }</ns1:RESIDENCE>
            }
            {
                for $PN_SECTOR in $outputParameters1/ns0:PN_SECTOR
                return
                    <ns1:SECTOR>{ data($PN_SECTOR) }</ns1:SECTOR>
            }
            {
                for $PV_DESCRIPCIONSECTOR in $outputParameters1/ns0:PV_DESCRIPCIONSECTOR
                return
                    <ns1:SECTOR_DESCRIPTION>{ data($PV_DESCRIPCIONSECTOR) }</ns1:SECTOR_DESCRIPTION>
            }
            {
                for $PV_INDUSTRIA in $outputParameters1/ns0:PV_INDUSTRIA
                return
                    <ns1:INDUSTRY>{ data($PV_INDUSTRIA) }</ns1:INDUSTRY>
            }
            {
                for $PV_INDUSTRIA_DESCRIPCION in $outputParameters1/ns0:PV_INDUSTRIA_DESCRIPCION
                return
                    <ns1:INDUSTRY_DESCRIPTION>{ data($PV_INDUSTRIA_DESCRIPCION) }</ns1:INDUSTRY_DESCRIPTION>
            }
            {
                for $PV_TIPOGENERADOR in $outputParameters1/ns0:PV_TIPOGENERADOR
                return
                    <ns1:FGN_CCY_GEN_TYP>{ data($PV_TIPOGENERADOR) }</ns1:FGN_CCY_GEN_TYP>
            }
            {
                for $PV_CODIGOSEGMENTACION in $outputParameters1/ns0:PV_CODIGOSEGMENTACION
                return
                    <ns1:TARGET>{ data($PV_CODIGOSEGMENTACION) }</ns1:TARGET>
            }
            {
                for $PV_DESCRIPCIONSEGMENTACION in $outputParameters1/ns0:PV_DESCRIPCIONSEGMENTACION
                return
                    <ns1:TARGET_DESCRIPTION>{ data($PV_DESCRIPCIONSEGMENTACION) }</ns1:TARGET_DESCRIPTION>
            }
            {
                for $PV_ESTADOCIVIL in $outputParameters1/ns0:PV_ESTADOCIVIL
                return
                    <ns1:MARITAL_STATUS>{ data($PV_ESTADOCIVIL) }</ns1:MARITAL_STATUS>
            }
            {
                for $PN_TIPOCLIENTE in $outputParameters1/ns0:PN_TIPOCLIENTE
                return
                    <ns1:CUSTOMER_TYPE>{ data($PN_TIPOCLIENTE) }</ns1:CUSTOMER_TYPE>
            }
            {
                for $PV_STATUSCLIENTE in $outputParameters1/ns0:PV_STATUSCLIENTE
                return
                    <ns1:CUSTOMER_STATUS>{ data($PV_STATUSCLIENTE) }</ns1:CUSTOMER_STATUS>
            }
            {
                for $PV_IDIOMACLIENTE in $outputParameters1/ns0:PV_IDIOMACLIENTE
                return
                    <ns1:LANGUAGE>{ data($PV_IDIOMACLIENTE) }</ns1:LANGUAGE>
            }
            {
                for $PV_OCUPACION in $outputParameters1/ns0:PV_OCUPACION
                return
                    <ns1:OCCUPATION>{ data($PV_OCUPACION) }</ns1:OCCUPATION>
            }
            {
                for $PN_ESTADOTRABAJO in $outputParameters1/ns0:PN_ESTADOTRABAJO
                return
                    <ns1:EMPLOYMENT_STATUS>{ data($PN_ESTADOTRABAJO) }</ns1:EMPLOYMENT_STATUS>
            }
            {
                for $PV_NOMBREEMPLEADOR in $outputParameters1/ns0:PV_NOMBREEMPLEADOR
                return
                    <ns1:EMPLOYERS_NAME>{ data($PV_NOMBREEMPLEADOR) }</ns1:EMPLOYERS_NAME>
            }                       
            {
                for $PV_APELLIDOCASADA in $outputParameters1/ns0:PV_APELLIDOCASADA
                return
                    <ns1:MARRIED_LAST_NAME>{ data($PV_APELLIDOCASADA) }</ns1:MARRIED_LAST_NAME>
            }
            {
                for $PV_NOMBREREPLEGAL in $outputParameters1/ns0:PV_NOMBREREPLEGAL
                return
                    <ns1:LEGAL_REP_NAME>{ data($PV_NOMBREREPLEGAL) }</ns1:LEGAL_REP_NAME>
            }
            {
                for $PV_IDREPLEGAL in $outputParameters1/ns0:PV_IDREPLEGAL
                return
                    <ns1:LEGAL_REP_ID>{ data($PV_IDREPLEGAL) }</ns1:LEGAL_REP_ID>
            }
            {
                for $PV_TIPOCOMPANIA in $outputParameters1/ns0:PV_TIPOCOMPANIA
                return
                    <ns1:TYPE_OF_COMPANY>{ data($PV_TIPOCOMPANIA) }</ns1:TYPE_OF_COMPANY>
            }
            {
                for $PN_PROFESION in $outputParameters1/ns0:PN_PROFESION
                return
                    <ns1:PROFESSION>{ data($PN_PROFESION) }</ns1:PROFESSION>
            }
            {
                for $PV_NUMEROACTA in $outputParameters1/ns0:PV_NUMEROACTA
                return
                    <ns1:NUMBER_OF_DEED>{ data($PV_NUMEROACTA) }</ns1:NUMBER_OF_DEED>
            }
            {
                for $PV_TELCASAREPLEGAL in $outputParameters1/ns0:PV_TELCASAREPLEGAL
                return
                    <ns1:LEGAL_REP_HOME_PHONE>{ data($PV_TELCASAREPLEGAL) }</ns1:LEGAL_REP_HOME_PHONE>
            }
            {
                for $PV_TIPOPERSONA in $outputParameters1/ns0:PV_TIPOPERSONA
                return
                    <ns1:TYPE_OF_PERSON>{ data($PV_TIPOPERSONA) }</ns1:TYPE_OF_PERSON>
            }
            {
                for $PV_USUARIOINGRESO in $outputParameters1/ns0:PV_USUARIOINGRESO
                return
                    <ns1:INPUT_USER>{ data($PV_USUARIOINGRESO) }</ns1:INPUT_USER>
            }
            {
                for $PV_FECHA_ULTIMA_MOD in $outputParameters1/ns0:PV_FECHA_ULTIMA_MOD
                return
                    <ns1:DATE_TIME>{ data($PV_FECHA_ULTIMA_MOD) }</ns1:DATE_TIME>
            }
            {
                for $PV_CODIGO_OFICIAL in $outputParameters1/ns0:PV_CODIGO_OFICIAL
                return
                    <ns1:ACCOUNT_OFFICER>{ data($PV_CODIGO_OFICIAL) }</ns1:ACCOUNT_OFFICER>
            }
            <ns1:BRANCH_CODE>{ fn:string($outputParameters1/ns0:PV_CODIGO_AGENCIA) }</ns1:BRANCH_CODE>
            <ns1:NO_OF_DEPENDENTS>{ fn:string($outputParameters1/ns0:PV_NUMERO_DEPENDIENTES) }</ns1:NO_OF_DEPENDENTS>
            {
                for $PV_NIVEL_EDUCACION in $outputParameters1/ns0:PV_NIVEL_EDUCACION
                return
                    <ns1:EDUCATION_LEVEL>{ data($PV_NIVEL_EDUCACION) }</ns1:EDUCATION_LEVEL>
            }
            {
                for $PV_NOMBRE_CONYUGUE in $outputParameters1/ns0:PV_NOMBRE_CONYUGUE
                return
                    <ns1:SPOUSE_NAME>{ data($PV_NOMBRE_CONYUGUE) }</ns1:SPOUSE_NAME>
            }
            {
                for $PV_FECHAINGRESO in $outputParameters1/ns0:PV_FECHAINGRESO
                return
                    <ns1:CUSTOMER_SINCE>{ data($PV_FECHAINGRESO) }</ns1:CUSTOMER_SINCE>
            }
            <ns1:ECONOMIC_GROUP_ID>{ fn:string($outputParameters1/ns0:PN_CODIGO_GRUPO_ECO) }</ns1:ECONOMIC_GROUP_ID>
            {
                for $PV_NOMBRE_GRUPO_ECO in $outputParameters1/ns0:PV_NOMBRE_GRUPO_ECO
                return
                    <ns1:ECONOMIC_GROUP_NAME>{ data($PV_NOMBRE_GRUPO_ECO) }</ns1:ECONOMIC_GROUP_NAME>
            }
            <ns1:PHONE_INFO>
                <ns1:PHONE_NUMBER_ITEM>
                    <ns1:PHONE_NUMBER>{ data($outputParameters1/ns0:PV_TELEFONO) }</ns1:PHONE_NUMBER>
                </ns1:PHONE_NUMBER_ITEM>
                <ns1:PHONE_NUMBER_ITEM>
                    <ns1:PHONE_NUMBER>{ data($outputParameters1/ns0:PV_CELULAR) }</ns1:PHONE_NUMBER>
                </ns1:PHONE_NUMBER_ITEM>
            </ns1:PHONE_INFO>
            <ns1:ADDRESS_INFO>
            {
            	let $ptTipoDireccion := $outputParameters1/ns0:PT_TIPO_DIRECCION/ns0:PT_TIPO_DIRECCION_ITEM
            	let $isMainAddress := $outputParameters1/ns0:PT_DIRECCION_PRINCIPAL/ns0:PT_DIRECCION_PRINCIPAL_ITEM
            	let $ptDireccionCompleta := $outputParameters1/ns0:PT_DIRECCION_COMPLETA/ns0:PT_DIRECCION_COMPLETA_ITEM
            	let $ptPais := $outputParameters1/ns0:PT_PAIS/ns0:PT_PAIS_ITEM
            	let $ptDepartamento := $outputParameters1/ns0:PT_DEPARTAMENTO/ns0:PT_PAIS_ITEM
            	let $ptCiudad := $outputParameters1/ns0:PT_CIUDAD/ns0:PT_PAIS_ITEM
            	let $zone := $outputParameters1/ns0:PT_ZONE/ns0:PT_PAIS_ITEM[1]
            	
            	for $i in (1 to count($ptTipoDireccion))
				return
	            <ns1:ADDRESS_ITEM>
	                <ns1:ADDRESS_TYPE>{ data($ptTipoDireccion[$i]) }</ns1:ADDRESS_TYPE>
	                <ns1:COUNTRY_CODE>{ data($ptPais[$i]) }</ns1:COUNTRY_CODE>
	                <ns1:DEPARTMENT_CODE>{ data($ptDepartamento[$i]) }</ns1:DEPARTMENT_CODE>
	                <ns1:MUNICIPALITY_CODE>{ data($ptCiudad[$i]) }</ns1:MUNICIPALITY_CODE>
	                <ns1:ADDRESS_LINE_1>{ data($ptDireccionCompleta[$i]) }</ns1:ADDRESS_LINE_1>
	                <ns1:ZONE>{ data($zone) }</ns1:ZONE>
	                
	            </ns1:ADDRESS_ITEM>
            }
            </ns1:ADDRESS_INFO>
            <ns1:EMAIL_INFO>
                <ns1:EMAIL_ITEM>
                    <ns1:EMAIL_ADDRESS>{ data($outputParameters1/ns0:PV_EMAIL) }</ns1:EMAIL_ADDRESS>
                </ns1:EMAIL_ITEM>
            </ns1:EMAIL_INFO>
              <ns1:JOB_INFO>
                <ns1:JOB_ITEM>
                    <ns1:JOB_DESCRIPTION>{ data($outputParameters1/ns0:PV_PUESTO_TRABAJO) }</ns1:JOB_DESCRIPTION>
                </ns1:JOB_ITEM>
            </ns1:JOB_INFO>
            <ns1:SECTORIZATION_INFO>
            {
            	let $ptTipoSectorizacion := $outputParameters1/ns0:PT_TIPO_SECTORIZACION/ns0:PT_TIPO_SECTORIZACION_ITEM
            	let $ptCodigoSectorizacion := $outputParameters1/ns0:PT_CODIGO_SECTORIZACION/ns0:PT_TIPO_SECTORIZACION_ITEM
            	
            	for $i in (1 to count($ptTipoSectorizacion))
				return
				<ns1:SECTORIZATION_ITEM>
					<ns1:SECTORIZATION_TYPE>{ data($ptTipoSectorizacion[$i]) }</ns1:SECTORIZATION_TYPE>
					<ns1:SECTORIZATION_CODE>{ data($ptCodigoSectorizacion[$i]) }</ns1:SECTORIZATION_CODE>
				</ns1:SECTORIZATION_ITEM>
            }
            </ns1:SECTORIZATION_INFO>
            <ns1:OPERATION_DEPARTMENTS_INFO>
            	<ns1:OPERATION_DEPARTMENTS_ITEM>
           			<ns1:OPERATION_DEPARTMENT>{ data($outputParameters1/ns0:PV_DEPARTAMENTO_EMPRESA) }</ns1:OPERATION_DEPARTMENT>
            	</ns1:OPERATION_DEPARTMENTS_ITEM>
            </ns1:OPERATION_DEPARTMENTS_INFO>
             
             <ns1:TOTAL_INCOME>{ data($outputParameters1/ns0:PV_MONTO_APROX_INGRESOS) }</ns1:TOTAL_INCOME>
             <ns1:ECONOMICGROUP>{ data($outputParameters1/ns0:PV_ACTIVIDAD_EC_EMPRESA) }</ns1:ECONOMICGROUP>
             <ns1:IS_STATE_CONTRACTOR>{ data($outputParameters1/ns0:PV_CLIENTE_CPE) }</ns1:IS_STATE_CONTRACTOR>
            {
               for $otherIncomeDetails in $outputParameters1/ns0:PT_INGRESOS/ns0:OTHER_INCOME_DETAILS/ns0:OTHER_INCOME_DETAILS_ITEM
               return
                 <ns1:OTHER_INCOME_DETAILS>
                   	  <ns1:INCOME>{ string($otherIncomeDetails/ns0:MONEDA_INGRESO/text()) }</ns1:INCOME>
                 	  <ns1:AMOUNT>{ string($otherIncomeDetails/ns0:MONTO_INGRESO/text()) }</ns1:AMOUNT>
                      <ns1:DEPARTMENT>{ string($otherIncomeDetails/ns0:DEPARTAMENTO_INGRESO/text()) }</ns1:DEPARTMENT>
                 	  <ns1:INCOME_CODE>{ string($otherIncomeDetails/ns0:CODIGO_INGRESO/text()) }</ns1:INCOME_CODE>
                      <ns1:INCOME_TYPE_CODE>{ string($otherIncomeDetails/ns0:CODIGO_TIPO_INGRESO/text()) }</ns1:INCOME_TYPE_CODE>
           		 </ns1:OTHER_INCOME_DETAILS>
           }
                 <ns1:PEP_DETAILS>
                        <ns1:IS_DIRECT>{ data($outputParameters1/ns0:PV_CLIENTE_PEP) }</ns1:IS_DIRECT>
                        <ns1:IS_INDIRECT>{ data($outputParameters1/ns0:PV_CLIENTE_CERCANO_PEP) }</ns1:IS_INDIRECT>
                        <ns1:IS_RELATED>{ data($outputParameters1/ns0:PV_CLIENTE_PARENTESCO_PEP) }</ns1:IS_RELATED>
                 </ns1:PEP_DETAILS>
                
               <ns1:OWN_BUSINESS_DETAILS>
             {
                       let $businessItem := $outputParameters1/ns0:PT_OWNBUSINESSDETAIL
                        return(
                        
                           if(string($businessItem/ns0:NOMBRE_NEG_PROPIO/text())  != '') then (
                      		<ns1:BUSINESS_ITEM>
                      		       <ns1:NAME>{ fn:substring(name($businessItem/ns0:NOMBRE_NEG_PROPIO),6) }</ns1:NAME>
                      		       <ns1:VALUE>{ string($businessItem/ns0:NOMBRE_NEG_PROPIO/text()) }</ns1:VALUE>
                      		</ns1:BUSINESS_ITEM>
                      		)else(),
                      		if(string($businessItem/ns0:ACTIVIDAD_EC_NEG_PROPIO/text())  != '') then (
                      		<ns1:BUSINESS_ITEM>
                      		       <ns1:NAME>{ fn:substring(name($businessItem/ns0:ACTIVIDAD_EC_NEG_PROPIO),6) }</ns1:NAME>
                      		       <ns1:VALUE>{ string($businessItem/ns0:ACTIVIDAD_EC_NEG_PROPIO/text()) }</ns1:VALUE>
                      		</ns1:BUSINESS_ITEM>
                      		)else(),
                      		if(string($businessItem/ns0:FECHA_INICIO_OPERACIONES/text())  != '') then (
                      		<ns1:BUSINESS_ITEM>
                      		       <ns1:NAME>{ fn:substring(name($businessItem/ns0:FECHA_INICIO_OPERACIONES),6) }</ns1:NAME>
                      		       <ns1:VALUE>{ string($businessItem/ns0:FECHA_INICIO_OPERACIONES/text()) }</ns1:VALUE>
                      		</ns1:BUSINESS_ITEM>
                      		)else(),
                      		if(string($businessItem/ns0:TIPO_NEGOCIO/text())  != '') then (
                      		<ns1:BUSINESS_ITEM>
                      		       <ns1:NAME>{ fn:substring(name($businessItem/ns0:TIPO_NEGOCIO),6) }</ns1:NAME>
                      		       <ns1:VALUE>{ string($businessItem/ns0:TIPO_NEGOCIO/text()) }</ns1:VALUE>
                      		</ns1:BUSINESS_ITEM>
                      		)else(),
                      		if(string($businessItem/ns0:DIRECCION_NEG_PROPIO/text())  != '') then (
                      		<ns1:BUSINESS_ITEM>
                      		       <ns1:NAME>{ fn:substring(name($businessItem/ns0:DIRECCION_NEG_PROPIO),6) }</ns1:NAME>
                      		       <ns1:VALUE>{ string($businessItem/ns0:DIRECCION_NEG_PROPIO/text()) }</ns1:VALUE>
                      		</ns1:BUSINESS_ITEM>
                      		)else(),
                      		if(string($businessItem/ns0:DEPTO_NEGOCIO_PROPIO/text())  != '') then (
                      		<ns1:BUSINESS_ITEM>
                      		       <ns1:NAME>{ fn:substring(name($businessItem/ns0:DEPTO_NEGOCIO_PROPIO),6) }</ns1:NAME>
                      		       <ns1:VALUE>{ string($businessItem/ns0:DEPTO_NEGOCIO_PROPIO/text()) }</ns1:VALUE>
                      		</ns1:BUSINESS_ITEM>
                      		)else(),
                      		if(string($businessItem/ns0:MONTO_ING_NEG_PROPIO/text())  != '') then (
                      		<ns1:BUSINESS_ITEM>
                      		       <ns1:NAME>{ fn:substring(name($businessItem/ns0:MONTO_ING_NEG_PROPIO),6) }</ns1:NAME>
                      		       <ns1:VALUE>{ string($businessItem/ns0:MONTO_ING_NEG_PROPIO/text()) }</ns1:VALUE>
                      		</ns1:BUSINESS_ITEM>
                      		)else()
                      		)
                    }
                  </ns1:OWN_BUSINESS_DETAILS>
                {
                for $PV_VALOR_INGRESOS in $outputParameters1/ns0:PV_VALOR_INGRESOS
                return
                    <ns1:INCOME_VALUE>{ data($PV_VALOR_INGRESOS) }</ns1:INCOME_VALUE>
                }
                {
                for $PV_VALOR_EGRESOS in $outputParameters1/ns0:PV_VALOR_EGRESOS
                return
                    <ns1:EXPENSES_VALUE>{ data($PV_VALOR_EGRESOS) }</ns1:EXPENSES_VALUE>
                }
                {
                for $PV_PROPOSITO_RELACION_NEGOCIO in $outputParameters1/ns0:PV_PROPOSITO_RELACION_NEGOCIO
                return
                    <ns1:BUSINESS_RELT_PURPOSE>{ data($PV_PROPOSITO_RELACION_NEGOCIO) }</ns1:BUSINESS_RELT_PURPOSE>
                }
                {
                for $PV_CALIDAD_EN_QUE_ACTUA in $outputParameters1/ns0:PV_CALIDAD_EN_QUE_ACTUA
                return
                    <ns1:QUALITY_CUSTOMER_BEHAVIOR>{ data($PV_CALIDAD_EN_QUE_ACTUA) }</ns1:QUALITY_CUSTOMER_BEHAVIOR>
                }
        </ns1:consultaClienteResponse>
        ) else (
        <ns1:consultaClienteResponse/>
        )
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaClienteOut2($outputParameters1)