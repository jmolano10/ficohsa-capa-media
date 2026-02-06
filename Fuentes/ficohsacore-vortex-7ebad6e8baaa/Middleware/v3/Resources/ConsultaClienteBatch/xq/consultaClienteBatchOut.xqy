xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ConsultaClienteBatch/xsd/ConsultaClienteBatch_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaClienteResponse" location="../../ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaClienteBatch";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaClienteBatch/xq/consultaClienteBatchOut/";

declare function xf:consultaClienteBatchOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaClienteResponse) {
    if (fn:upper-case($outputParameters/ns1:PV_CODIGOMENSAJE) = "SUCCESS") then (
        <ns0:consultaClienteResponse>
            {
                for $PV_CUSTOMER_ID in $outputParameters/ns1:PV_CUSTOMER_ID
                return
                    <ns0:CUSTOMER_ID>{ data($PV_CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            }
            {
                for $PV_MNEMONIC in $outputParameters/ns1:PV_MNEMONIC
                return
                    <ns0:MNEMONIC>{ data($PV_MNEMONIC) }</ns0:MNEMONIC>
            }
            <ns0:IDENTIFICATION_INFO>
                <ns0:LEGAL_IDENTIFICATION_ITEM>
                    <ns0:LEGAL_DOCUMENT_NAME>{ data($outputParameters/ns1:PV_LEGAL_DOC_NAME)}</ns0:LEGAL_DOCUMENT_NAME>
                    <ns0:LEGAL_ID>{ data($outputParameters/ns1:PV_LEGAL_ID) }</ns0:LEGAL_ID>
                </ns0:LEGAL_IDENTIFICATION_ITEM>
            </ns0:IDENTIFICATION_INFO>
            {
                for $PV_NOMBRES in $outputParameters/ns1:PV_NOMBRES
                return
                    <ns0:GIVEN_NAMES>{ data($PV_NOMBRES) }</ns0:GIVEN_NAMES>
            }
            {
                for $PV_APELLIDOS in $outputParameters/ns1:PV_APELLIDOS
                return
                    <ns0:FAMILY_NAME>{ data($PV_APELLIDOS) }</ns0:FAMILY_NAME>
            }
            {
                for $PV_RAZONSOCIAL in $outputParameters/ns1:PV_RAZONSOCIAL
                return
                    <ns0:FULL_NAME>{ data($PV_RAZONSOCIAL) }</ns0:FULL_NAME>
            }
            {
                for $PV_RAZONSOCIAL in $outputParameters/ns1:PV_RAZONSOCIAL
                return
                    <ns0:NAME_OF_BUSINESS>{ data($PV_RAZONSOCIAL) }</ns0:NAME_OF_BUSINESS>
            }
            {
                for $PV_NOMBRECOMERCIAL in $outputParameters/ns1:PV_NOMBRECOMERCIAL
                return
                    <ns0:COMMERCIAL_NAME>{ data($PV_NOMBRECOMERCIAL) }</ns0:COMMERCIAL_NAME>
            }
            {
                for $PV_NOMBRECENTRALRIESGOS in $outputParameters/ns1:PV_NOMBRECENTRALRIESGOS
                return
                    <ns0:LEGAL_HOLDER_NAME>{ data($PV_NOMBRECENTRALRIESGOS) }</ns0:LEGAL_HOLDER_NAME>
            }
            {
                for $PV_NOMBRECORTO in $outputParameters/ns1:PV_NOMBRECORTO
                return
                    <ns0:SHORT_NAME>{ data($PV_NOMBRECORTO) }</ns0:SHORT_NAME>
            }
            {
                for $PD_FECHANACIMIENTO in $outputParameters/ns1:PD_FECHANACIMIENTO
                return
                    <ns0:DATE_OF_BIRTH>{ data($PD_FECHANACIMIENTO) }</ns0:DATE_OF_BIRTH>
            }
            {
                for $PV_GENERO in $outputParameters/ns1:PV_GENERO
                return
                    <ns0:GENDER>{ data($PV_GENERO) }</ns0:GENDER>
            }
            {
                for $PV_NACIONALIDAD in $outputParameters/ns1:PV_NACIONALIDAD
                return
                    <ns0:NATIONALITY>{ data($PV_NACIONALIDAD) }</ns0:NATIONALITY>
            }
            {
                for $PV_RESIDENCIA in $outputParameters/ns1:PV_RESIDENCIA
                return
                    <ns0:RESIDENCE>{ data($PV_RESIDENCIA) }</ns0:RESIDENCE>
            }
            {
                for $PN_SECTOR in $outputParameters/ns1:PN_SECTOR
                return
                    <ns0:SECTOR>{ data($PN_SECTOR) }</ns0:SECTOR>
            }
            {
                for $PV_DESCRIPCIONSECTOR in $outputParameters/ns1:PV_DESCRIPCIONSECTOR
                return
                    <ns0:SECTOR_DESCRIPTION>{ data($PV_DESCRIPCIONSECTOR) }</ns0:SECTOR_DESCRIPTION>
            }
            {
                for $PV_INDUSTRIA in $outputParameters/ns1:PV_INDUSTRIA
                return
                    <ns0:INDUSTRY>{ data($PV_INDUSTRIA) }</ns0:INDUSTRY>
            }
            {
                for $PV_INDUSTRIA_DESCRIPCION in $outputParameters/ns1:PV_INDUSTRIA_DESCRIPCION
                return
                    <ns0:INDUSTRY_DESCRIPTION>{ data($PV_INDUSTRIA_DESCRIPCION) }</ns0:INDUSTRY_DESCRIPTION>
            }
            {
                for $PV_TIPOGENERADOR in $outputParameters/ns1:PV_TIPOGENERADOR
                return
                    <ns0:FGN_CCY_GEN_TYP>{ data($PV_TIPOGENERADOR) }</ns0:FGN_CCY_GEN_TYP>
            }
            {
                for $PV_CODIGOSEGMENTACION in $outputParameters/ns1:PV_CODIGOSEGMENTACION
                return
                    <ns0:TARGET>{ data($PV_CODIGOSEGMENTACION) }</ns0:TARGET>
            }
            {
                for $PV_DESCRIPCIONSEGMENTACION in $outputParameters/ns1:PV_DESCRIPCIONSEGMENTACION
                return
                    <ns0:TARGET_DESCRIPTION>{ data($PV_DESCRIPCIONSEGMENTACION) }</ns0:TARGET_DESCRIPTION>
            }
            {
                for $PV_ESTADOCIVIL in $outputParameters/ns1:PV_ESTADOCIVIL
                return
                    <ns0:MARITAL_STATUS>{ data($PV_ESTADOCIVIL) }</ns0:MARITAL_STATUS>
            }
            {
                for $PN_TIPOCLIENTE in $outputParameters/ns1:PN_TIPOCLIENTE
                return
                    <ns0:CUSTOMER_TYPE>{ data($PN_TIPOCLIENTE) }</ns0:CUSTOMER_TYPE>
            }
            {
                for $PV_STATUSCLIENTE in $outputParameters/ns1:PV_STATUSCLIENTE
                return
                    <ns0:CUSTOMER_STATUS>{ data($PV_STATUSCLIENTE) }</ns0:CUSTOMER_STATUS>
            }
            {
                for $PV_IDIOMACLIENTE in $outputParameters/ns1:PV_IDIOMACLIENTE
                return
                    <ns0:LANGUAGE>{ data($PV_IDIOMACLIENTE) }</ns0:LANGUAGE>
            }
            {
                for $PV_OCUPACION in $outputParameters/ns1:PV_OCUPACION
                return
                    <ns0:OCCUPATION>{ data($PV_OCUPACION) }</ns0:OCCUPATION>
            }
            {
                for $PN_ESTADOTRABAJO in $outputParameters/ns1:PN_ESTADOTRABAJO
                return
                    <ns0:EMPLOYMENT_STATUS>{ data($PN_ESTADOTRABAJO) }</ns0:EMPLOYMENT_STATUS>
            }
            {
                for $PV_NOMBREEMPLEADOR in $outputParameters/ns1:PV_NOMBREEMPLEADOR
                return
                    <ns0:EMPLOYERS_NAME>{ data($PV_NOMBREEMPLEADOR) }</ns0:EMPLOYERS_NAME>
            }
            {
                for $PV_APELLIDOCASADA in $outputParameters/ns1:PV_APELLIDOCASADA
                return
                    <ns0:MARRIED_LAST_NAME>{ data($PV_APELLIDOCASADA) }</ns0:MARRIED_LAST_NAME>
            }
            {
                for $PV_NOMBREREPLEGAL in $outputParameters/ns1:PV_NOMBREREPLEGAL
                return
                    <ns0:LEGAL_REP_NAME>{ data($PV_NOMBREREPLEGAL) }</ns0:LEGAL_REP_NAME>
            }
            {
                for $PV_IDREPLEGAL in $outputParameters/ns1:PV_IDREPLEGAL
                return
                    <ns0:LEGAL_REP_ID>{ data($PV_IDREPLEGAL) }</ns0:LEGAL_REP_ID>
            }
            {
                for $PV_TIPOCOMPANIA in $outputParameters/ns1:PV_TIPOCOMPANIA
                return
                    <ns0:TYPE_OF_COMPANY>{ data($PV_TIPOCOMPANIA) }</ns0:TYPE_OF_COMPANY>
            }
            {
                for $PN_PROFESION in $outputParameters/ns1:PN_PROFESION
                return
                    <ns0:PROFESSION>{ data($PN_PROFESION) }</ns0:PROFESSION>
            }
            {
                for $PV_NUMEROACTA in $outputParameters/ns1:PV_NUMEROACTA
                return
                    <ns0:NUMBER_OF_DEED>{ data($PV_NUMEROACTA) }</ns0:NUMBER_OF_DEED>
            }
            {
                for $PV_TELCASAREPLEGAL in $outputParameters/ns1:PV_TELCASAREPLEGAL
                return
                    <ns0:LEGAL_REP_HOME_PHONE>{ data($PV_TELCASAREPLEGAL) }</ns0:LEGAL_REP_HOME_PHONE>
            }
            {
                for $PV_TIPOPERSONA in $outputParameters/ns1:PV_TIPOPERSONA
                return
                    <ns0:TYPE_OF_PERSON>{ data($PV_TIPOPERSONA) }</ns0:TYPE_OF_PERSON>
            }
            {
                for $PV_USUARIOINGRESO in $outputParameters/ns1:PV_USUARIOINGRESO
                return
                    <ns0:INPUT_USER>{ data($PV_USUARIOINGRESO) }</ns0:INPUT_USER>
            }
            {
                for $PV_FECHA_ULTIMA_MOD in $outputParameters/ns1:PV_FECHA_ULTIMA_MOD
                return
                    <ns0:DATE_TIME>{ data($PV_FECHA_ULTIMA_MOD) }</ns0:DATE_TIME>
            }
            {
                for $PV_CODIGO_OFICIAL in $outputParameters/ns1:PV_CODIGO_OFICIAL
                return
                    <ns0:ACCOUNT_OFFICER>{ data($PV_CODIGO_OFICIAL) }</ns0:ACCOUNT_OFFICER>
            }
            <ns0:BRANCH_CODE>{ fn:string($outputParameters/ns1:PV_CODIGO_AGENCIA) }</ns0:BRANCH_CODE>
            <ns0:NO_OF_DEPENDENTS>{ fn:string($outputParameters/ns1:PV_NUMERO_DEPENDIENTES) }</ns0:NO_OF_DEPENDENTS>
            {
                for $PV_NIVEL_EDUCACION in $outputParameters/ns1:PV_NIVEL_EDUCACION
                return
                    <ns0:EDUCATION_LEVEL>{ data($PV_NIVEL_EDUCACION) }</ns0:EDUCATION_LEVEL>
            }
            {
                for $PV_NOMBRE_CONYUGUE in $outputParameters/ns1:PV_NOMBRE_CONYUGUE
                return
                    <ns0:SPOUSE_NAME>{ data($PV_NOMBRE_CONYUGUE) }</ns0:SPOUSE_NAME>
            }
            {
                for $PV_FECHAINGRESO in $outputParameters/ns1:PV_FECHAINGRESO
                return
                    <ns0:CUSTOMER_SINCE>{ data($PV_FECHAINGRESO) }</ns0:CUSTOMER_SINCE>
            }
            <ns0:ECONOMIC_GROUP_ID>{ fn:string($outputParameters/ns1:PN_CODIGO_GRUPO_ECO) }</ns0:ECONOMIC_GROUP_ID>
            {
                for $PV_NOMBRE_GRUPO_ECO in $outputParameters/ns1:PV_NOMBRE_GRUPO_ECO
                return
                    <ns0:ECONOMIC_GROUP_NAME>{ data($PV_NOMBRE_GRUPO_ECO) }</ns0:ECONOMIC_GROUP_NAME>
            }
            <ns0:PHONE_INFO>
                <ns0:PHONE_NUMBER_ITEM>
                    <ns0:PHONE_NUMBER>{ data($outputParameters/ns1:PV_TELEFONO) }</ns0:PHONE_NUMBER>
                </ns0:PHONE_NUMBER_ITEM>
                <ns0:PHONE_NUMBER_ITEM>
                    <ns0:PHONE_NUMBER>{ data($outputParameters/ns1:PV_CELULAR) }</ns0:PHONE_NUMBER>
                </ns0:PHONE_NUMBER_ITEM>
            </ns0:PHONE_INFO>
            <ns0:ADDRESS_INFO>
            {
            	let $ptTipoDireccion := $outputParameters/ns1:PT_TIPO_DIRECCION/ns1:PT_TIPO_DIRECCION_ITEM
            	let $isMainAddress := $outputParameters/ns1:PT_DIRECCION_PRINCIPAL/ns1:PT_DIRECCION_PRINCIPAL_ITEM
            	let $ptDireccionCompleta := $outputParameters/ns1:PT_DIRECCION_COMPLETA/ns1:PT_DIRECCION_COMPLETA_ITEM
            	let $ptPais := $outputParameters/ns1:PT_PAIS/ns1:PT_PAIS_ITEM
            	let $ptDepartamento := $outputParameters/ns1:PT_DEPARTAMENTO/ns1:PT_PAIS_ITEM
            	let $ptCiudad := $outputParameters/ns1:PT_CIUDAD/ns1:PT_PAIS_ITEM
            	
            	for $i in (1 to count($ptTipoDireccion))
				return
	            <ns0:ADDRESS_ITEM>
	                <ns0:ADDRESS_TYPE>{ data($ptTipoDireccion[$i]) }</ns0:ADDRESS_TYPE>
	                <ns0:COUNTRY_CODE>{ data($ptPais[$i]) }</ns0:COUNTRY_CODE>
	                <ns0:DEPARTMENT_CODE>{ data($ptDepartamento[$i]) }</ns0:DEPARTMENT_CODE>
	                <ns0:MUNICIPALITY_CODE>{ data($ptCiudad[$i]) }</ns0:MUNICIPALITY_CODE>
	                <ns0:ADDRESS_LINE_1>{ data($ptDireccionCompleta[$i]) }</ns0:ADDRESS_LINE_1>
	                <ns0:IS_MAIN_ADDRESS>{ data($isMainAddress[$i]) }</ns0:IS_MAIN_ADDRESS>
	            </ns0:ADDRESS_ITEM>
            }
            </ns0:ADDRESS_INFO>
            <ns0:EMAIL_INFO>
                <ns0:EMAIL_ITEM>
                    <ns0:EMAIL_ADDRESS>{ data($outputParameters/ns1:PV_EMAIL) }</ns0:EMAIL_ADDRESS>
                </ns0:EMAIL_ITEM>
            </ns0:EMAIL_INFO>
            <ns1:SECTORIZATION_INFO>
            {
            	let $ptTipoSectorizacion := $outputParameters/ns1:PT_TIPO_SECTORIZACION/ns1:PT_TIPO_SECTORIZACION_ITEM
            	let $ptCodigoSectorizacion := $outputParameters/ns1:PT_CODIGO_SECTORIZACION/ns1:PT_TIPO_SECTORIZACION_ITEM
            	
            	for $i in (1 to count($ptTipoSectorizacion))
				return
				<ns0:SECTORIZATION_ITEM>
					<ns0:SECTORIZATION_TYPE>{ data($ptTipoSectorizacion[$i]) }</ns0:SECTORIZATION_TYPE>
					<ns0:SECTORIZATION_CODE>{ data($ptCodigoSectorizacion[$i]) }</ns0:SECTORIZATION_CODE>
				</ns0:SECTORIZATION_ITEM>
            }
            </ns1:SECTORIZATION_INFO>
        </ns0:consultaClienteResponse>
        ) else (
        <ns0:consultaClienteResponse/>
        )
        
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaClienteBatchOut($outputParameters)