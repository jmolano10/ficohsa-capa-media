(:: pragma bea:global-element-parameter parameter="$confirmacionSolicitudTarjetaCredito1" element="ns1:confirmacionSolicitudTarjetaCredito" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CreditCardRequestResult" location="../../../BusinessServices/SALESFORCE/recepEvalCreditos/wsdl/WS_NIC_Recepcion_Eval_Creditos.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_NIC_Recepcion_Eval_Creditos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmacionSolicitudTarjetaCredito/xq/creditCardRequestResultIn/";

declare function xf:creditCardRequestResultIn($confirmacionSolicitudTarjetaCredito1 as element(ns1:confirmacionSolicitudTarjetaCredito))
    as element(ns0:CreditCardRequestResult) {
        <ns0:CreditCardRequestResult>
            <ns0:idProspecto>{ data($confirmacionSolicitudTarjetaCredito1/REQUEST_ID) }</ns0:idProspecto>
            <ns0:idCreditRequest>{ data($confirmacionSolicitudTarjetaCredito1/CREDIT_REQUEST_ID) }</ns0:idCreditRequest>
            <ns0:requestStatus>{ data($confirmacionSolicitudTarjetaCredito1/REQUEST_STATUS) }</ns0:requestStatus>
            <ns0:requestSubStatus>{ data($confirmacionSolicitudTarjetaCredito1/REQUEST_SUB_STATUS) }</ns0:requestSubStatus>
            {
                let $UNIQUE_CLIENT_INFO := $confirmacionSolicitudTarjetaCredito1/UNIQUE_CLIENT_INFO
                return
                    <ns0:uniqueClient>
                        { 
                           if($UNIQUE_CLIENT_INFO/ACCESS_FUNDS_PEP/text()) then(
                           <ns0:Acceso_Fondos_PEP>{ data($UNIQUE_CLIENT_INFO/ACCESS_FUNDS_PEP) }</ns0:Acceso_Fondos_PEP>
                           )else() 
                        }                        
                        <ns0:Actividad_Economica>{ data($UNIQUE_CLIENT_INFO/ECONOMIC_ACTIVITY) }</ns0:Actividad_Economica>
                        <ns0:Actividad_Economica_Cliente>{ data($UNIQUE_CLIENT_INFO/CLIENT_ECONOMIC_ACTIVITY) }</ns0:Actividad_Economica_Cliente>
						<ns0:Apellidos_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_SURNAMES) }</ns0:Apellidos_Conyuge>
						<ns0:bus_id_status_viajero_frecuente>{ data($UNIQUE_CLIENT_INFO/FREQUENT_TRAVELER_STATUS) }</ns0:bus_id_status_viajero_frecuente>
                        <ns0:Cargo>{ data($UNIQUE_CLIENT_INFO/OCCUPATION) }</ns0:Cargo>
                        <ns0:Ciudad_dos>{ data($UNIQUE_CLIENT_INFO/WORKING_CITY) }</ns0:Ciudad_dos>
                        <ns0:Ciudad_Nacimiento>{ data($UNIQUE_CLIENT_INFO/CITY_BORN) }</ns0:Ciudad_Nacimiento>
                        <ns0:ciudad_tres>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_CITY) }</ns0:ciudad_tres>
						<ns0:Cliente_VIP>{ data($UNIQUE_CLIENT_INFO/CUSTOMER_VIP) }</ns0:Cliente_VIP>
                        <ns0:Codigo_Postal_Tres>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_ZIP_CODE) }</ns0:Codigo_Postal_Tres>
                        {
                          if($UNIQUE_CLIENT_INFO/SPOUSE_CURRENTLY_WORKING/text()) then(
                           <ns0:Conyuge_Labora_Actualmente>{ data($UNIQUE_CLIENT_INFO/SPOUSE_CURRENTLY_WORKING) }</ns0:Conyuge_Labora_Actualmente>
                          )else()
                        }                        
                        <ns0:Coodigo_Postal_Dos>{ data($UNIQUE_CLIENT_INFO/WORK_ZIP_CODE) }</ns0:Coodigo_Postal_Dos>
                        <ns0:Coodigo_Postal_uno>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ZIP_CODE) }</ns0:Coodigo_Postal_uno>
                        <ns0:Correo_Electronico>{ data($UNIQUE_CLIENT_INFO/EMAIL) }</ns0:Correo_Electronico>
                        <ns0:Correo_Electronico_Alterno>{ data($UNIQUE_CLIENT_INFO/SECONDARY_EMAIL) }</ns0:Correo_Electronico_Alterno>
						<ns0:Correo_Electronico_Conyugue>{ data($UNIQUE_CLIENT_INFO/EMAIL_SPOUSE_CURRENTLY_WORKING) }</ns0:Correo_Electronico_Conyugue>
                        <ns0:Correo_Trabajo_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_WORKING_CURRENTLY_EMAIL) }</ns0:Correo_Trabajo_Conyuge>
						<ns0:Direccion_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_ADDRESS) }</ns0:Direccion_Conyuge>
                        <ns0:Direccion_Dos_1>{ data($UNIQUE_CLIENT_INFO/WORK_ADDRESS_1) }</ns0:Direccion_Dos_1>
                        <ns0:Direccion_Dos_2>{ data($UNIQUE_CLIENT_INFO/WORK_ADDRESS_2) }</ns0:Direccion_Dos_2>
                        <ns0:Direccion_Dos_3>{ data($UNIQUE_CLIENT_INFO/WORK_ADDRESS_3) }</ns0:Direccion_Dos_3>
                        <ns0:Direccion_Dos_4>{ data($UNIQUE_CLIENT_INFO/WORK_ADDRESS_4) }</ns0:Direccion_Dos_4>
						<ns0:Direccion_Trabajo_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_WORK_ADDRESS) }</ns0:Direccion_Trabajo_Conyuge>
                        <ns0:Direccion_Tres_1>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_ADDRESS_1) }</ns0:Direccion_Tres_1>
                        <ns0:Direccion_Tres_2>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_ADDRESS_2) }</ns0:Direccion_Tres_2>
                        <ns0:Direccion_Tres_3>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_ADDRESS_3) }</ns0:Direccion_Tres_3>
                        <ns0:Direccion_uno_1>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ADDRESS_1) }</ns0:Direccion_uno_1>
						<ns0:Direccion_uno_2>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ADDRESS_2) }</ns0:Direccion_uno_2>                        
						<ns0:Direccion_uno_3>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ADDRESS_3) }</ns0:Direccion_uno_3>
                        <ns0:Direccion_uno_4>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ADDRESS_4) }</ns0:Direccion_uno_4>
                        {
                          if($UNIQUE_CLIENT_INFO/IS_PEP/text()) then(
                           <ns0:Es_PEP>{ data($UNIQUE_CLIENT_INFO/IS_PEP) }</ns0:Es_PEP>
                          )else()
                        }                        
                        <ns0:Estado_Civil_Catalogo>{ data($UNIQUE_CLIENT_INFO/CIVIL_STATUS) }</ns0:Estado_Civil_Catalogo>
						<ns0:Explicacion_PEP>{ data($UNIQUE_CLIENT_INFO/EXPLANATION_PEP) }</ns0:Explicacion_PEP>
                        {
                          if($UNIQUE_CLIENT_INFO/ISSUE_DATE_ID/text()) then(
                            <ns0:Fecha_Emision_Id>{ data($UNIQUE_CLIENT_INFO/ISSUE_DATE_ID) }</ns0:Fecha_Emision_Id>
                          )else()                               
                        }
                        {
                          if($UNIQUE_CLIENT_INFO/ISSUE_DATE_ID_2/text()) then(
                            <ns0:Fecha_Emision_Id_2>{ data($UNIQUE_CLIENT_INFO/ISSUE_DATE_ID_2) }</ns0:Fecha_Emision_Id_2>
                          )else()                               
                        }
                        {
                          if($UNIQUE_CLIENT_INFO/END_DATE_CHARGE_PEP/text()) then(
                            <ns0:Fecha_Fin_Cargo_PEP>{ data($UNIQUE_CLIENT_INFO/END_DATE_CHARGE_PEP) }</ns0:Fecha_Fin_Cargo_PEP>
                          )else()                               
                        }
                        {
                          if($UNIQUE_CLIENT_INFO/START_DATE_PEP_CHARGE/text()) then(
                            <ns0:Fecha_Inicio_Cargo_PEP>{ data($UNIQUE_CLIENT_INFO/START_DATE_PEP_CHARGE) }</ns0:Fecha_Inicio_Cargo_PEP>
                          )else()                               
                        }
                        {
                          if($UNIQUE_CLIENT_INFO/SPOUSE_BIRTHNAME/text()) then(
                            <ns0:fecha_nac_conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_BIRTHNAME) }</ns0:fecha_nac_conyuge>
                          )else()                               
                        }
                        {
                          if($UNIQUE_CLIENT_INFO/BIRTHDATE/text()) then(
                            <ns0:Fecha_Nacimiento>{ data($UNIQUE_CLIENT_INFO/BIRTHDATE) }</ns0:Fecha_Nacimiento>
                          )else()                               
                        }
                                                {
                          if($UNIQUE_CLIENT_INFO/EXPIRY_DATE_ID/text()) then(
                            <ns0:Fecha_Vencimiento_Id>{ data($UNIQUE_CLIENT_INFO/EXPIRY_DATE_ID) }</ns0:Fecha_Vencimiento_Id>
                          )else()                               
                        }
						<ns0:ff_nbr_viajero_frecuente>{ data($UNIQUE_CLIENT_INFO/FREQUENT_TRAVELER_NUMBER) }</ns0:ff_nbr_viajero_frecuente>
						<ns0:Fuente_Otros_Ingresos>{ data($UNIQUE_CLIENT_INFO/SOURCE_OTHER_REVENUE) }</ns0:Fuente_Otros_Ingresos>
                        <ns0:Genero_Catalogo>{ data($UNIQUE_CLIENT_INFO/GENDER) }</ns0:Genero_Catalogo>
                        <ns0:Identificacion>{ data($UNIQUE_CLIENT_INFO/LEGAL_ID) }</ns0:Identificacion>
						<ns0:Identificacion_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_ID) }</ns0:Identificacion_Conyuge>
						<ns0:Identificacion_dos>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_LEGAL_ID) }</ns0:Identificacion_dos>
                        {
                          if($UNIQUE_CLIENT_INFO/MONTHLY_INCOME/text()) then(
                          <ns0:Ingresos_Mensuales>{ xs:decimal($UNIQUE_CLIENT_INFO/MONTHLY_INCOME) }</ns0:Ingresos_Mensuales>
                          )else()
                        }
                        <ns0:Institucion_PEP>{ data($UNIQUE_CLIENT_INFO/INSTITUTION_PEP) }</ns0:Institucion_PEP>
                        <ns0:Lugar_de_Empleo>{ data($UNIQUE_CLIENT_INFO/WORKPLACE) }</ns0:Lugar_de_Empleo>
                        <ns0:Lugar_de_Nacimiento>{ data($UNIQUE_CLIENT_INFO/PLACE_BIRTH) }</ns0:Lugar_de_Nacimiento>
						<ns0:Municipio>{ data($UNIQUE_CLIENT_INFO/MUNICIPALITY) }</ns0:Municipio>
						<ns0:Municipio_Trabajo>{ data($UNIQUE_CLIENT_INFO/MUNICIPALITY_JOB) }</ns0:Municipio_Trabajo>
                        <ns0:Naturaleza_del_Negocio>{ data($UNIQUE_CLIENT_INFO/BUSINESS_OF_NATURE) }</ns0:Naturaleza_del_Negocio>
						<ns0:Nivel_Educacion>{ data($UNIQUE_CLIENT_INFO/LEVEL_OF_EDUCATION) }</ns0:Nivel_Educacion>
						<ns0:No_Llamar>{ data($UNIQUE_CLIENT_INFO/NO_CALL) }</ns0:No_Llamar>
						<ns0:Nombre_Cargo_Publico_PEP>{ data($UNIQUE_CLIENT_INFO/PUBLIC_POSITION_NAME_PEP) }</ns0:Nombre_Cargo_Publico_PEP>
                        <ns0:Nombre_Centro_Trabajo_Conyuge>{ data($UNIQUE_CLIENT_INFO/NAME_WORK_SPOUSE) }</ns0:Nombre_Centro_Trabajo_Conyuge>
						<ns0:Nombre_Persona_PEP>{ data($UNIQUE_CLIENT_INFO/PERSON_NAME_PEP) }</ns0:Nombre_Persona_PEP>
						<ns0:Nombres_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_NAMES) }</ns0:Nombres_Conyuge>
                        <ns0:Numero_Cliente_unico>{ data($UNIQUE_CLIENT_INFO/CUSTOMER_NUMBER) }</ns0:Numero_Cliente_unico>
                        <ns0:numero_id>{ data($UNIQUE_CLIENT_INFO/CUSTOMER_NUMBER) }</ns0:numero_id>
                        {
                          if($UNIQUE_CLIENT_INFO/NUMBER_OF_DEPENDENT_PERSONS/text()) then(
                           <ns0:Numero_Personas_Dependientes>{ xs:int($UNIQUE_CLIENT_INFO/NUMBER_OF_DEPENDENT_PERSONS) }</ns0:Numero_Personas_Dependientes>
                          )else()
                        }  
                        <ns0:Ocupacion_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_OCCUPATION) }</ns0:Ocupacion_Conyuge>
                        <ns0:ORG_Nic>{ data($UNIQUE_CLIENT_INFO/ORG) }</ns0:ORG_Nic>
                        {
                          if($UNIQUE_CLIENT_INFO/OTHER_INCOME/text()) then(
                           <ns0:Otros_Ingresos>{ xs:decimal($UNIQUE_CLIENT_INFO/OTHER_INCOME) }</ns0:Otros_Ingresos>
                          )else()
                        }
                        <ns0:Pais_Cargo_PEP>{ data($UNIQUE_CLIENT_INFO/COUNTRY_CHARGE_PEP) }</ns0:Pais_Cargo_PEP>
                        <ns0:Pais_Dos>{ data($UNIQUE_CLIENT_INFO/WORK_COUNTRY) }</ns0:Pais_Dos>
                        <ns0:Pais_Emision>{ data($UNIQUE_CLIENT_INFO/LEGAL_ID_COUNTRY_EMISSION) }</ns0:Pais_Emision>
						<ns0:Pais_Emisor_Id>{ data($UNIQUE_CLIENT_INFO/COUNTRY_EMISOR_ID) }</ns0:Pais_Emisor_Id>
                        <ns0:Pais_Nacionalidad>{ data($UNIQUE_CLIENT_INFO/NATIONALITY_COUNTRY) }</ns0:Pais_Nacionalidad>
						<ns0:Pais_Trabajo>{ data($UNIQUE_CLIENT_INFO/COUNTRY_JOB) }</ns0:Pais_Trabajo>
						<ns0:Pais_Tres>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_COUNTRY) }</ns0:Pais_Tres>
                        <ns0:Pais_Uno>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_COUNTRY) }</ns0:Pais_Uno>
                        <ns0:Primer_Apellido>{ data($UNIQUE_CLIENT_INFO/FIRST_LAST_NAME) }</ns0:Primer_Apellido>
                        <ns0:Primer_Nombre>{ data($UNIQUE_CLIENT_INFO/FIRST_NAME) }</ns0:Primer_Nombre>
                        <ns0:Profesion>{ data($UNIQUE_CLIENT_INFO/PROFESSION) }</ns0:Profesion>
                        <ns0:Profesion_Conyuge>{ data($UNIQUE_CLIENT_INFO/PROFESSION_SPOUSE) }</ns0:Profesion_Conyuge>
						<ns0:Rango_Ingresos>{ data($UNIQUE_CLIENT_INFO/INCOME_RANGE) }</ns0:Rango_Ingresos>
                        <ns0:Ref_Personal_Nombre_1>{ data($UNIQUE_CLIENT_INFO/PERSONAL_REFERENCE_NAME_1) }</ns0:Ref_Personal_Nombre_1>
                        <ns0:Ref_Personal_Nombre_2>{ data($UNIQUE_CLIENT_INFO/PERSONAL_REFERENCE_NAME_2) }</ns0:Ref_Personal_Nombre_2>
						<ns0:Ref_Personal_Nombre_3>{ data($UNIQUE_CLIENT_INFO/PERSONAL_REFERENCE_NAME_3) }</ns0:Ref_Personal_Nombre_3>
                        <ns0:Ref_Personal_Telefono_1>{ data($UNIQUE_CLIENT_INFO/PHONE_REFERENCE_1) }</ns0:Ref_Personal_Telefono_1>
                        <ns0:Ref_Personal_Telefono_2>{ data($UNIQUE_CLIENT_INFO/PHONE_REFERENCE_2) }</ns0:Ref_Personal_Telefono_2>
						<ns0:Ref_Personal_Telefono_3>{ data($UNIQUE_CLIENT_INFO/PERSONAL_REFERENCE_PHONE_3) }</ns0:Ref_Personal_Telefono_3>
                        <ns0:Ref_Personal_Tipo_1>{ data($UNIQUE_CLIENT_INFO/RELATIONSHIP_TYPE_REFERENCE_1) }</ns0:Ref_Personal_Tipo_1>
                        <ns0:Ref_Personal_Tipo_2>{ data($UNIQUE_CLIENT_INFO/RELATIONSHIP_TYPE_REFERENCE_2) }</ns0:Ref_Personal_Tipo_2>
						<ns0:Ref_Personal_Tipo_3>{ data($UNIQUE_CLIENT_INFO/PERSONAL_REFERENCE_TYPE_3) }</ns0:Ref_Personal_Tipo_3>
						<ns0:Relacion_con_Institucion_Financiera_1>{ data($UNIQUE_CLIENT_INFO/RELATIONSHIP_WITH_FINANCIAL_INSTITUTION_1) }</ns0:Relacion_con_Institucion_Financiera_1>
						<ns0:Relacion_con_Institucion_Financiera_2>{ data($UNIQUE_CLIENT_INFO/RELATIONSHIP_WITH_FINANCIAL_INSTITUTION_2) }</ns0:Relacion_con_Institucion_Financiera_2>
						<ns0:Relacion_con_Institucion_Financiera_3>{ data($UNIQUE_CLIENT_INFO/RELATIONSHIP_WITH_FINANCIAL_INSTITUTION_3) }</ns0:Relacion_con_Institucion_Financiera_3>
						<ns0:Relacion_Familiar_PEP>{ data($UNIQUE_CLIENT_INFO/FAMILY_RELATIONSHIP_PEP) }</ns0:Relacion_Familiar_PEP>
						<ns0:Relacion_Titular_PEP>{ data($UNIQUE_CLIENT_INFO/RELATIONSHIP_OWNER_PEP) }</ns0:Relacion_Titular_PEP>
                        {
                          if($UNIQUE_CLIENT_INFO/MONTHLY_WAGE_PEP/text()) then(
                            <ns0:Salario_Mensual_PEP>{ xs:decimal($UNIQUE_CLIENT_INFO/MONTHLY_WAGE_PEP) }</ns0:Salario_Mensual_PEP>
                          )else()
                        }                        
                        <ns0:Segundo_Apellido>{ data($UNIQUE_CLIENT_INFO/SECOND_SURNAME) }</ns0:Segundo_Apellido>
						<ns0:Segundo_Apellido_Conyuge>{ data($UNIQUE_CLIENT_INFO/SECOND_SURNAME_SPOUSE) }</ns0:Segundo_Apellido_Conyuge>
						<ns0:Segundo_Nombre>{ data($UNIQUE_CLIENT_INFO/MIDDLE_NAME) }</ns0:Segundo_Nombre>
						<ns0:Sitio_Web_Trabajo_Conyuge>{ data($UNIQUE_CLIENT_INFO/WORK_WEBSITE_SPOUSE_JOB_SITE) }</ns0:Sitio_Web_Trabajo_Conyuge>
                        {
                           if($UNIQUE_CLIENT_INFO/MONTHLY_SALARY_SPOUSE/text()) then(
                             <ns0:Sueldo_Mensual_Conyuge>{ xs:decimal($UNIQUE_CLIENT_INFO/MONTHLY_SALARY_SPOUSE) }</ns0:Sueldo_Mensual_Conyuge>
                           )else()
                        }
                        <ns0:Telefono_Alterno>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_PHONE) }</ns0:Telefono_Alterno>
                        <ns0:Telefono_Casa>{ data($UNIQUE_CLIENT_INFO/HOME_PHONE_NUMBER) }</ns0:Telefono_Casa>
                        <ns0:Telefono_Celular>{ data($UNIQUE_CLIENT_INFO/CELL_PHONE_NUMBER) }</ns0:Telefono_Celular>
						<ns0:Telefono_Celular_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_CELLULAR_PHONE) }</ns0:Telefono_Celular_Conyuge>
                        <ns0:Telefono_de_Trabajo>{ data($UNIQUE_CLIENT_INFO/WORK_PHONE_NUMBER) }</ns0:Telefono_de_Trabajo>
						<ns0:Telefono_Domicilio_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_HOME_PHONE) }</ns0:Telefono_Domicilio_Conyuge>
						<ns0:Telefono_Trabajo_Conyuge>{ data($UNIQUE_CLIENT_INFO/WORK_PHONE_SPOUSE) }</ns0:Telefono_Trabajo_Conyuge>
						<ns0:Telefono_Trabajo_Extension>{ data($UNIQUE_CLIENT_INFO/WORK_PHONE_EXTENSSION) }</ns0:Telefono_Trabajo_Extension>
						<ns0:Tercer_Nombre>{ data($UNIQUE_CLIENT_INFO/THIRD_NAME) }</ns0:Tercer_Nombre>
                        <ns0:Tiempo_de_Residir_Anios>{ data($UNIQUE_CLIENT_INFO/RESIDENCIE_CURRENT_YEARS) }</ns0:Tiempo_de_Residir_Anios>
                        <ns0:Tiempo_de_Residir_Meses>{ data($UNIQUE_CLIENT_INFO/RESIDENCIE_CURRENT_MONTH) }</ns0:Tiempo_de_Residir_Meses>
                        <ns0:Tiempo_de_Trabajar_Anios>{ data($UNIQUE_CLIENT_INFO/YEARS_CURRENT_JOB) }</ns0:Tiempo_de_Trabajar_Anios>
                        <ns0:Tiempo_de_Trabajar_Meses>{ data($UNIQUE_CLIENT_INFO/MONTHS_CURRENT_JOB) }</ns0:Tiempo_de_Trabajar_Meses>
                        <ns0:Tipo_de_identificacion>{ data($UNIQUE_CLIENT_INFO/LEGAL_ID_TYPE) }</ns0:Tipo_de_identificacion>
						<ns0:Tipo_de_identificacion_2>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_LEGAL_ID_TYPE) }</ns0:Tipo_de_identificacion_2>
                        <ns0:Tipo_de_Residencia>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_TYPE) }</ns0:Tipo_de_Residencia>
						<ns0:Tipo_Identificacion_Conyuge>{ data($UNIQUE_CLIENT_INFO/SPOUSE_IDENTIFICATION_TYPE) }</ns0:Tipo_Identificacion_Conyuge>
						<ns0:Tipo_Relacion_Cuenta_1>{ data($UNIQUE_CLIENT_INFO/ACCOUNT_RELATIONSHIP_TYPE) }</ns0:Tipo_Relacion_Cuenta_1>
						<ns0:Tipo_Relacion_Cuenta_2>{ data($UNIQUE_CLIENT_INFO/ACCOUNT_RELATIONSHIP_TYPE_2) }</ns0:Tipo_Relacion_Cuenta_2>
						<ns0:Tipo_Relacion_Cuenta_3>{ data($UNIQUE_CLIENT_INFO/ACCOUNT_RELATIONSHIP_TYPE_3) }</ns0:Tipo_Relacion_Cuenta_3>
                    </ns0:uniqueClient>
            }
            {
                let $ACCOUNT_NUMBER_INFO := $confirmacionSolicitudTarjetaCredito1/ACCOUNT_NUMBER_INFO
                return
                    <ns0:cuentaNuevaTC>
					    <ns0:Beneficio_Cash_Back>{ data($ACCOUNT_NUMBER_INFO/BENEFICIARY_CASH_BACK) }</ns0:Beneficio_Cash_Back>
                        {
                            for $ACCOUNT_CYCLE in $ACCOUNT_NUMBER_INFO/ACCOUNT_CYCLE
                            return
                                <ns0:ciclo>{ data($ACCOUNT_CYCLE) }</ns0:ciclo>
                        }
                        <ns0:core_donde_sale_esta_cuenta>{ data($ACCOUNT_NUMBER_INFO/ORIGIN_CORE) }</ns0:core_donde_sale_esta_cuenta>
                        {
                            for $LMS_ACCOUNT in $ACCOUNT_NUMBER_INFO/LMS_ACCOUNT
                            return
                                <ns0:CuentaLms>{ data($LMS_ACCOUNT) }</ns0:CuentaLms>
                        }
                        <ns0:Direccion_Utilizar_Bill_To>{ data($ACCOUNT_NUMBER_INFO/INVOICE_ADDRESS_TYPE) }</ns0:Direccion_Utilizar_Bill_To>
                        <ns0:Envio_Estado_de_Cta_Statement_Flag>{ data($ACCOUNT_NUMBER_INFO/BILL_SHIPPING_TYPE) }</ns0:Envio_Estado_de_Cta_Statement_Flag>
                        <ns0:FechaHora_Aprobacion>{ data($ACCOUNT_NUMBER_INFO/APPROVAL_DATE_TIME) }</ns0:FechaHora_Aprobacion>
                        <ns0:ingresoNetoClientAlMomentoAnalisisCrediticio>{ data($ACCOUNT_NUMBER_INFO/NET_INCOME_CLIENT) }</ns0:ingresoNetoClientAlMomentoAnalisisCrediticio>
                        <ns0:LegalId>{ data($ACCOUNT_NUMBER_INFO/LEGAL_ID) }</ns0:LegalId>
                        <ns0:Moneda>{ data($ACCOUNT_NUMBER_INFO/CURRENCY) }</ns0:Moneda>
						<ns0:Numero_Certificado_Deposito_Garantia>{ data($ACCOUNT_NUMBER_INFO/GUARANTEE_DEPOSIT_CERTIFICATE_NUMBER) }</ns0:Numero_Certificado_Deposito_Garantia>
                        <ns0:NumeroDeCuenta>{ data($ACCOUNT_NUMBER_INFO/ACCOUNT_NUMBER) }</ns0:NumeroDeCuenta>
                        <ns0:ORG>{ data($ACCOUNT_NUMBER_INFO/ORG) }</ns0:ORG>
                        {
                            for $LOGO_PRODUCT in $ACCOUNT_NUMBER_INFO/LOGO_PRODUCT
                            return
                                <ns0:producto_logo>{ data($LOGO_PRODUCT) }</ns0:producto_logo>
                        }
                        {
                            for $SETTLEMENT_MODEL in $ACCOUNT_NUMBER_INFO/SETTLEMENT_MODEL
                            return
                                <ns0:settlement_model>{ data($SETTLEMENT_MODEL) }</ns0:settlement_model>
                        }
                    </ns0:cuentaNuevaTC>
            }
            {
                let $CREDIT_CARD_INFO := $confirmacionSolicitudTarjetaCredito1/CREDIT_CARD_INFO
                return
                    <ns0:tarjetaNueva>
                        <ns0:Estatus>{ data($CREDIT_CARD_INFO/STATUS) }</ns0:Estatus>
                        {
                            for $LEGAL_ID in $CREDIT_CARD_INFO/LEGAL_ID
                            return
                                <ns0:Identificacion_Tarjetahabiente>{ data($LEGAL_ID) }</ns0:Identificacion_Tarjetahabiente>
                        }
                        {
                            for $ANNUAL_PURCHASE_LIMIT in $CREDIT_CARD_INFO/ANNUAL_PURCHASE_LIMIT
                            return
                                <ns0:Limite_de_compra_anual_RTL_YTD_AMT>{ data($ANNUAL_PURCHASE_LIMIT) }</ns0:Limite_de_compra_anual_RTL_YTD_AMT>
                        }
                        {
                            for $DAILY_PURCHASE_LIMIT in $CREDIT_CARD_INFO/DAILY_PURCHASE_LIMIT
                            return
                                <ns0:Limite_de_compra_diaria_RTL_DLY_AMT>{ data($DAILY_PURCHASE_LIMIT) }</ns0:Limite_de_compra_diaria_RTL_DLY_AMT>
                        }
                        {
                            for $MONTHLY_PURCHASE_LIMIT in $CREDIT_CARD_INFO/MONTHLY_PURCHASE_LIMIT
                            return
                                <ns0:Limite_de_compra_mensual_RTL_MTD_AMT>{ data($MONTHLY_PURCHASE_LIMIT) }</ns0:Limite_de_compra_mensual_RTL_MTD_AMT>
                        }
                        {
                            for $ANNUAL_WITHDRAWAL_LIMIT in $CREDIT_CARD_INFO/ANNUAL_WITHDRAWAL_LIMIT
                            return
                                <ns0:Limite_de_retiro_anual_CSH_YTD_AMT>{ data($ANNUAL_WITHDRAWAL_LIMIT) }</ns0:Limite_de_retiro_anual_CSH_YTD_AMT>
                        }
                        {
                            for $DAILY_WITHDRAWAL_LIMIT in $CREDIT_CARD_INFO/DAILY_WITHDRAWAL_LIMIT
                            return
                                <ns0:Limite_de_retiro_diario_CSH_DLY_AMT>{ data($DAILY_WITHDRAWAL_LIMIT) }</ns0:Limite_de_retiro_diario_CSH_DLY_AMT>
                        }
                        {
                            for $MONTHLY_WITHDRAWAL_LIMIT in $CREDIT_CARD_INFO/MONTHLY_WITHDRAWAL_LIMIT
                            return
                                <ns0:Limite_de_retiro_mensual_CSH_MTD_AMT>{ data($MONTHLY_WITHDRAWAL_LIMIT) }</ns0:Limite_de_retiro_mensual_CSH_MTD_AMT>
                        }
                        <ns0:nombre_en_tarjeta>{ data($CREDIT_CARD_INFO/CREDIT_CARD_NAME) }</ns0:nombre_en_tarjeta>
                        <ns0:numero_enmascarado>{ data($CREDIT_CARD_INFO/MASKED_CREDIT_CARD_NUMBER) }</ns0:numero_enmascarado>
                        <ns0:numtarjetaencriptado>{ data($CREDIT_CARD_INFO/ENCRYPTIONED_CREDIT_CARD_NUMBER) }</ns0:numtarjetaencriptado>
                    </ns0:tarjetaNueva>
            }
        </ns0:CreditCardRequestResult>
};

declare variable $confirmacionSolicitudTarjetaCredito1 as element(ns1:confirmacionSolicitudTarjetaCredito) external;

xf:creditCardRequestResultIn($confirmacionSolicitudTarjetaCredito1)