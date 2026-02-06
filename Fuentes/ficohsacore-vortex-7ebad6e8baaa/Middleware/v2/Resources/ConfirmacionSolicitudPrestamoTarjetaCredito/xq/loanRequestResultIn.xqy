xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$confirmacionSolicitudPrestamoTarjetaCredito" element="ns1:confirmacionSolicitudPrestamoTarjetaCredito" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:LoanRequestResult" location="../../../BusinessServices/SALESFORCE/recepEvalCreditos/wsdl/WS_NIC_Recepcion_Eval_Creditos.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_NIC_Recepcion_Eval_Creditos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmacionSolicitudPrestamoTarjetaCredito/xq/loanRequestResultIn/";

declare function xf:loanRequestResultIn($confirmacionSolicitudPrestamoTarjetaCredito as element(ns1:confirmacionSolicitudPrestamoTarjetaCredito))
    as element(ns0:LoanRequestResult) {
        <ns0:LoanRequestResult>
            <ns0:idProspecto>{ data($confirmacionSolicitudPrestamoTarjetaCredito/REQUEST_ID) }</ns0:idProspecto>
            <ns0:idCreditRequest>{ data($confirmacionSolicitudPrestamoTarjetaCredito/CREDIT_REQUEST_ID) }</ns0:idCreditRequest>
            <ns0:requestStatus>{ data($confirmacionSolicitudPrestamoTarjetaCredito/REQUEST_STATUS) }</ns0:requestStatus>
            <ns0:requestSubStatus>{ data($confirmacionSolicitudPrestamoTarjetaCredito/REQUEST_SUB_STATUS) }</ns0:requestSubStatus>
            {
                let $UNIQUE_CLIENT_INFO := $confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO
                return
                    <ns0:uniqueClient>
                        <ns0:Actividad_Economica>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/ECONOMIC_ACTIVITY) }</ns0:Actividad_Economica>
                        <ns0:Actividad_Economica_Cliente>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/CLIENT_ECONOMIC_ACTIVITY) }</ns0:Actividad_Economica_Cliente>
                        {
                            for $SPOUSE_SURNAMES in $UNIQUE_CLIENT_INFO/SPOUSE_SURNAMES
                            return
                                <ns0:Apellidos_Conyuge>{ data($SPOUSE_SURNAMES) }</ns0:Apellidos_Conyuge>
                        }
                        {
                            for $FREQUENT_TRAVELER_STATUS in $UNIQUE_CLIENT_INFO/FREQUENT_TRAVELER_STATUS
                            return
                                <ns0:bus_id_status_viajero_frecuente>{ data($FREQUENT_TRAVELER_STATUS) }</ns0:bus_id_status_viajero_frecuente>
                        }
                        <ns0:Cargo>{ data($UNIQUE_CLIENT_INFO/OCCUPATION) }</ns0:Cargo>
                        <ns0:Ciudad_dos>{ data($UNIQUE_CLIENT_INFO/WORKING_CITY) }</ns0:Ciudad_dos>
                        {
                            for $RESIDENCE_CITY in $UNIQUE_CLIENT_INFO/RESIDENCE_CITY
                            return
                                <ns0:ciudad_tres>{ data($RESIDENCE_CITY) }</ns0:ciudad_tres>
                        }
                        {
                            for $ALTERNATE_ZIP_CODE in $UNIQUE_CLIENT_INFO/ALTERNATE_ZIP_CODE
                            return
                                <ns0:Codigo_Postal_Tres>{ data($ALTERNATE_ZIP_CODE) }</ns0:Codigo_Postal_Tres>
                        }
                        <ns0:Coodigo_Postal_Dos>{ data($UNIQUE_CLIENT_INFO/WORK_ZIP_CODE) }</ns0:Coodigo_Postal_Dos>
                        <ns0:Coodigo_Postal_uno>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ZIP_CODE) }</ns0:Coodigo_Postal_uno>
                        <ns0:Correo_Electronico>{ data($UNIQUE_CLIENT_INFO/EMAIL) }</ns0:Correo_Electronico>
						<ns0:Correo_Electronico_Alterno>{ data($UNIQUE_CLIENT_INFO/SECONDARY_EMAIL) }</ns0:Correo_Electronico_Alterno>
                        <ns0:Direccion_Dos_1>{ data($UNIQUE_CLIENT_INFO/WORK_ADDRESS_1) }</ns0:Direccion_Dos_1>
                        <ns0:Direccion_Dos_2>{ data($UNIQUE_CLIENT_INFO/WORK_ADDRESS_2) }</ns0:Direccion_Dos_2>
                        <ns0:Direccion_Dos_3>{ data($UNIQUE_CLIENT_INFO/WORK_ADDRESS_3) }</ns0:Direccion_Dos_3>
						<ns0:Direccion_Dos_4>{ data($UNIQUE_CLIENT_INFO/WORK_ADDRESS_4) }</ns0:Direccion_Dos_4>
                        <ns0:Direccion_Tres_1>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_ADDRESS_1) }</ns0:Direccion_Tres_1>
                        <ns0:Direccion_Tres_2>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_ADDRESS_2) }</ns0:Direccion_Tres_2>
                        <ns0:Direccion_Tres_3>{ data($UNIQUE_CLIENT_INFO/ALTERNATE_ADDRESS_3) }</ns0:Direccion_Tres_3>
                        <ns0:Direccion_uno_1>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ADDRESS_1) }</ns0:Direccion_uno_1>
                        <ns0:Direccion_uno_2>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ADDRESS_2) }</ns0:Direccion_uno_2>
                        <ns0:Direccion_uno_3>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ADDRESS_3) }</ns0:Direccion_uno_3>
						<ns0:Direccion_uno_4>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_ADDRESS_4) }</ns0:Direccion_uno_4>
                        <ns0:Estado_Civil_Catalogo>{ data($UNIQUE_CLIENT_INFO/CIVIL_STATUS) }</ns0:Estado_Civil_Catalogo>
                        {
                            for $SPOUSE_BIRTHNAME in $UNIQUE_CLIENT_INFO/SPOUSE_BIRTHNAME
                            return
                                <ns0:fecha_nac_conyuge>{ data($SPOUSE_BIRTHNAME) }</ns0:fecha_nac_conyuge>
                        }
                        <ns0:Fecha_Nacimiento>{ data($UNIQUE_CLIENT_INFO/BIRTHDATE) }</ns0:Fecha_Nacimiento>
                        {
                            for $FREQUENT_TRAVELER_NUMBER in $UNIQUE_CLIENT_INFO/FREQUENT_TRAVELER_NUMBER
                            return
                                <ns0:ff_nbr_viajero_frecuente>{ data($FREQUENT_TRAVELER_NUMBER) }</ns0:ff_nbr_viajero_frecuente>
                        }
                        <ns0:Genero_Catalogo>{ data($UNIQUE_CLIENT_INFO/GENDER) }</ns0:Genero_Catalogo>
                        <ns0:Identificacion>{ data($UNIQUE_CLIENT_INFO/LEGAL_ID) }</ns0:Identificacion>
                        {
                            for $ALTERNATE_LEGAL_ID in $UNIQUE_CLIENT_INFO/ALTERNATE_LEGAL_ID
                            return
                                <ns0:Identificacion_dos>{ data($ALTERNATE_LEGAL_ID) }</ns0:Identificacion_dos>
                        }
                        <ns0:Lugar_de_Empleo>{ data($UNIQUE_CLIENT_INFO/WORKPLACE) }</ns0:Lugar_de_Empleo>
                        <ns0:Lugar_de_Nacimiento>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/PLACE_BIRTH) }</ns0:Lugar_de_Nacimiento>
                        <ns0:Naturaleza_del_Negocio>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/BUSINESS_OF_NATURE) }</ns0:Naturaleza_del_Negocio>
                        {
                            for $NO_CALL in $UNIQUE_CLIENT_INFO/NO_CALL
                            return
                                <ns0:No_Llamar>{ data($NO_CALL) }</ns0:No_Llamar>
                        }
                        {
                            for $SPOUSE_NAMES in $UNIQUE_CLIENT_INFO/SPOUSE_NAMES
                            return
                                <ns0:Nombres_Conyuge>{ data($SPOUSE_NAMES) }</ns0:Nombres_Conyuge>
                        }
                        <ns0:Numero_Cliente_unico>{ data($UNIQUE_CLIENT_INFO/CUSTOMER_NUMBER) }</ns0:Numero_Cliente_unico>
                        <ns0:numero_id>{ data($UNIQUE_CLIENT_INFO/CUSTOMER_NUMBER) }</ns0:numero_id>
                        <ns0:ORG_Nic>{ data($UNIQUE_CLIENT_INFO/ORG) }</ns0:ORG_Nic>
                        <ns0:Pais_Dos>{ data($UNIQUE_CLIENT_INFO/WORK_COUNTRY) }</ns0:Pais_Dos>
                        <ns0:Pais_Emision>{ data($UNIQUE_CLIENT_INFO/LEGAL_ID_COUNTRY_EMISSION) }</ns0:Pais_Emision>
                        <ns0:Pais_Nacionalidad>{ data($UNIQUE_CLIENT_INFO/NATIONALITY_COUNTRY) }</ns0:Pais_Nacionalidad>
                        {
                            for $ALTERNATE_COUNTRY in $UNIQUE_CLIENT_INFO/ALTERNATE_COUNTRY
                            return
                                <ns0:Pais_Tres>{ data($ALTERNATE_COUNTRY) }</ns0:Pais_Tres>
                        }
                        <ns0:Pais_Uno>{ data($UNIQUE_CLIENT_INFO/RESIDENCE_COUNTRY) }</ns0:Pais_Uno>
                        <ns0:Primer_Apellido>{ data($UNIQUE_CLIENT_INFO/FIRST_LAST_NAME) }</ns0:Primer_Apellido>
                        <ns0:Primer_Nombre>{ data($UNIQUE_CLIENT_INFO/FIRST_NAME) }</ns0:Primer_Nombre>
                        <ns0:Profesion>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/PROFESSION) }</ns0:Profesion>
                        <ns0:Ref_Personal_Nombre_1>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/PERSONAL_REFERENCE_NAME_1) }</ns0:Ref_Personal_Nombre_1>
                        <ns0:Ref_Personal_Nombre_2>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/PERSONAL_REFERENCE_NAME_2) }</ns0:Ref_Personal_Nombre_2>
                        <ns0:Ref_Personal_Telefono_1>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/PHONE_REFERENCE_1) }</ns0:Ref_Personal_Telefono_1>
                        <ns0:Ref_Personal_Telefono_2>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/PHONE_REFERENCE_2) }</ns0:Ref_Personal_Telefono_2>
                        <ns0:Ref_Personal_Tipo_1>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/RELATIONSHIP_TYPE_REFERENCE_1) }</ns0:Ref_Personal_Tipo_1>
                        <ns0:Ref_Personal_Tipo_2>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/RELATIONSHIP_TYPE_REFERENCE_2) }</ns0:Ref_Personal_Tipo_2>
                        <ns0:Segundo_Apellido>{ data($UNIQUE_CLIENT_INFO/SECOND_SURNAME) }</ns0:Segundo_Apellido>
                        {
                            for $MIDDLE_NAME in $UNIQUE_CLIENT_INFO/MIDDLE_NAME
                            return
                                <ns0:Segundo_Nombre>{ data($MIDDLE_NAME) }</ns0:Segundo_Nombre>
                        }
                        <ns0:Telefono_Casa>{ data($UNIQUE_CLIENT_INFO/HOME_PHONE_NUMBER) }</ns0:Telefono_Casa>
                        <ns0:Telefono_Celular>{ data($UNIQUE_CLIENT_INFO/CELL_PHONE_NUMBER) }</ns0:Telefono_Celular>
                        <ns0:Telefono_de_Trabajo>{ data($UNIQUE_CLIENT_INFO/WORK_PHONE_NUMBER) }</ns0:Telefono_de_Trabajo>
                        {
                            for $WORK_PHONE_EXTENSSION in $UNIQUE_CLIENT_INFO/WORK_PHONE_EXTENSSION
                            return
                                <ns0:Telefono_Trabajo_Extension>{ data($WORK_PHONE_EXTENSSION) }</ns0:Telefono_Trabajo_Extension>
                        }
                        <ns0:Tiempo_de_Residir_Anios>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/RESIDENCIE_CURRENT_YEARS) }</ns0:Tiempo_de_Residir_Anios>
                        <ns0:Tiempo_de_Residir_Meses>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/RESIDENCIE_CURRENT_MONTH) }</ns0:Tiempo_de_Residir_Meses>
                        <ns0:Tiempo_de_Trabajar_Anios>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/YEARS_CURRENT_JOB) }</ns0:Tiempo_de_Trabajar_Anios>
                        <ns0:Tiempo_de_Trabajar_Meses>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/MONTHS_CURRENT_JOB) }</ns0:Tiempo_de_Trabajar_Meses>
                        <ns0:Tipo_de_identificacion>{ data($UNIQUE_CLIENT_INFO/LEGAL_ID_TYPE) }</ns0:Tipo_de_identificacion>
                        {
                            for $ALTERNATE_LEGAL_ID_TYPE in $UNIQUE_CLIENT_INFO/ALTERNATE_LEGAL_ID_TYPE
                            return
                                <ns0:Tipo_de_identificacion_2>{ data($ALTERNATE_LEGAL_ID_TYPE) }</ns0:Tipo_de_identificacion_2>
                        }
                        <ns0:Tipo_de_Residencia>{ data($confirmacionSolicitudPrestamoTarjetaCredito/UNIQUE_CLIENT_INFO/RESIDENCE_TYPE) }</ns0:Tipo_de_Residencia>
                    </ns0:uniqueClient>
            }
            {
                let $LOAN_INFO := $confirmacionSolicitudPrestamoTarjetaCredito/LOAN_INFO
                return
                    <ns0:cuentaNuevaLoan>
                        <ns0:cuotaPrestamo>{ data($LOAN_INFO/NEXT_PAYMENT_ID) }</ns0:cuotaPrestamo>
                        <ns0:montoAprobadoPrestamo>{ data($LOAN_INFO/INITIAL_AMOUNT_APPROVED) }</ns0:montoAprobadoPrestamo>
                        <ns0:montoDeComision>{ data($LOAN_INFO/COMMISSION_AMOUNT) }</ns0:montoDeComision>
                        <ns0:montoSolicitadoPrestamo>{ data($LOAN_INFO/INITIAL_AMOUNT_REQUESTED) }</ns0:montoSolicitadoPrestamo>
                        <ns0:numeroDeCuenta>{ data($LOAN_INFO/ACCOUNT_NUMBER) }</ns0:numeroDeCuenta>
                        <ns0:plazoMeses>{ data($LOAN_INFO/TERM_MONTH) }</ns0:plazoMeses>
                        <ns0:tasaDeComision>{ data($LOAN_INFO/COMMISSION_RATE) }</ns0:tasaDeComision>
                        <ns0:tasaDeInteres>{ data($LOAN_INFO/INTEREST_RATE) }</ns0:tasaDeInteres>
                    </ns0:cuentaNuevaLoan>
            }
        </ns0:LoanRequestResult>
};

declare variable $confirmacionSolicitudPrestamoTarjetaCredito as element(ns1:confirmacionSolicitudPrestamoTarjetaCredito) external;

xf:loanRequestResultIn($confirmacionSolicitudPrestamoTarjetaCredito)