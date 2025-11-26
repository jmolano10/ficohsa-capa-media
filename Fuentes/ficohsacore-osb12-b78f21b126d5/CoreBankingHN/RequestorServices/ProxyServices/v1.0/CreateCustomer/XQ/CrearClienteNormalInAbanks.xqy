xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateCustomerAbanks_BS_";
(:: import schema at "../../../../../../LegacyCoreBankingHN/ProviderServices/XSD/CreateCustomerAbanks/v1.0/CreateCustomerAbanks_BS_sp_v2.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $cdCliente as xs:string external  ; 
declare variable $crearCliente as element() (:: schema-element(ns1:createCustomerRequest) ::) external;
declare variable $user as xs:string external  ; 

declare function xq:CrearClienteNormalInAbanks($cdCliente as xs:string, $crearCliente as element() (:: schema-element(ns1:createCustomerRequest) ::), $user as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_CD_CLIENTE>{fn:data($cdCliente)}</ns2:PV_CD_CLIENTE>
        <ns2:PV_CD_TIPO_ID>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IdList[ns1:DocumentName='Cedula']/ns1:DocumentName)}</ns2:PV_CD_TIPO_ID>
        <ns2:PV_NRO_ID>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IdList[ns1:DocumentName='Cedula']/ns1:LegalId)}</ns2:PV_NRO_ID>
        {
            if ($crearCliente/ns1:GeneralInfo/com:BranchId)
            then <ns2:PV_CD_AGENCIA>{fn:data($crearCliente/ns1:GeneralInfo/com:BranchId)}</ns2:PV_CD_AGENCIA>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:BirthCountry)
            then <ns2:PV_CD_PAIS>{fn:data($crearCliente/ns1:CustomerInfo/ns1:BirthCountry)}</ns2:PV_CD_PAIS>
            else ()
        }
        <ns2:PV_TIPO_PERSONA></ns2:PV_TIPO_PERSONA>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:GivenNames)
            then <ns2:PV_NOMBRES>{fn:data($crearCliente/ns1:CustomerInfo/ns1:GivenNames)}</ns2:PV_NOMBRES>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:FamilyNames)
            then <ns2:PV_APELLIDOS>{fn:data($crearCliente/ns1:CustomerInfo/ns1:FamilyNames)}</ns2:PV_APELLIDOS>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:MarriedName)
            then <ns2:PV_APELLIDO_CASADA>{fn:data($crearCliente/ns1:CustomerInfo/ns1:MarriedName)}</ns2:PV_APELLIDO_CASADA>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:Gender)
            then <ns2:PV_SEXO>{fn:data($crearCliente/ns1:CustomerInfo/ns1:Gender)}</ns2:PV_SEXO>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:BirthDate)
            then <ns2:PV_FECHA_NACIMIENTO>{fn:data($crearCliente/ns1:CustomerInfo/ns1:BirthDate)}</ns2:PV_FECHA_NACIMIENTO>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:MaritalStatus)
            then <ns2:PV_ESTADO_CIVIL>{fn:data($crearCliente/ns1:CustomerInfo/ns1:MaritalStatus)}</ns2:PV_ESTADO_CIVIL>
            else ()
        }
        <ns2:PV_RAZON_SOCIAL></ns2:PV_RAZON_SOCIAL>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:LegalRepresentative/ns1:LastName)
            then <ns2:PV_RPTE_LEGAL>{fn:data($crearCliente/ns1:CustomerInfo/ns1:LegalRepresentative/ns1:LastName)}</ns2:PV_RPTE_LEGAL>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:LegalRepresentative/ns1:LegalId)
            then <ns2:PV_NRO_ID_R>{fn:data($crearCliente/ns1:CustomerInfo/ns1:LegalRepresentative/ns1:LegalId)}</ns2:PV_NRO_ID_R>
            else ()
        }
        <ns2:PV_TIPO_EMPRESA></ns2:PV_TIPO_EMPRESA>
        <ns2:PV_NOMBRE_COMERCIAL></ns2:PV_NOMBRE_COMERCIAL>
        {
            if ($crearCliente/ns1:GeneralInfo/com:ApplicationUser)
            then <ns2:PV_ADICIONADO_POR>{fn:data($user)}</ns2:PV_ADICIONADO_POR>
            else ()
        }
        <ns2:PV_FECHA_ADICION></ns2:PV_FECHA_ADICION>
        <ns2:PV_NRO_ESCRITURA></ns2:PV_NRO_ESCRITURA>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:AccountOfficer)
            then <ns2:PV_CD_OFICIAL>{fn:data($crearCliente/ns1:CustomerInfo/ns1:AccountOfficer)}</ns2:PV_CD_OFICIAL>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:ReferenceList/ns1:GivenNames)
            then <ns2:PV_NOMBRE_C_RIESGOS>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type='Personal']/ns1:GivenNames)}</ns2:PV_NOMBRE_C_RIESGOS>
            else ()
        }
        <ns2:PV_TEL_CASA_RLEGAL></ns2:PV_TEL_CASA_RLEGAL>
        <ns2:PV_STATUS>ACTIVE</ns2:PV_STATUS>
        <ns2:PV_CD_DIRECCION>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList[ns1:IsMain='Yes']/ns1:Type)}</ns2:PV_CD_DIRECCION>
        <ns2:PV_LINEA_DIR_2></ns2:PV_LINEA_DIR_2>
        <ns2:PV_TELEFONOS>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type)='LANDLINE']/ns1:Number[1])}</ns2:PV_TELEFONOS>
        <ns2:PV_FAX></ns2:PV_FAX>
        <ns2:PV_CD_SECTORIZACION></ns2:PV_CD_SECTORIZACION>
        <ns2:PV_CANT_DEPENDIENTES></ns2:PV_CANT_DEPENDIENTES>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:EducationLevel)
            then <ns2:PV_NIVEL_EDUCATIVO>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:EducationLevel)}</ns2:PV_NIVEL_EDUCATIVO>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:SpouseName)
            then <ns2:PV_NOMBRE_CONYUGUE>{ concat(fn:string($crearCliente/ns1:CustomerInfo/ns1:SpouseName/text()),' ',fn:string($crearCliente/ns1:CustomerInfo/ns1:MarriedName/text()))}</ns2:PV_NOMBRE_CONYUGUE>
            else ()
        }
        <ns2:PV_CELULAR>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Type)='SMS']/ns1:Number[1])}</ns2:PV_CELULAR>
        <ns2:PV_EMAIL>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ContactInfo/ns1:EmailList[ns1:IsMain='Yes']/ns1:Email)}</ns2:PV_EMAIL>
        <ns2:PV_EXTENSION></ns2:PV_EXTENSION>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyName)
            then <ns2:PV_NOMBRE_EMPRESA>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyName)}</ns2:PV_NOMBRE_EMPRESA>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:StartDate)
            then <ns2:PV_FECHA_ENTRADA>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:StartDate)}</ns2:PV_FECHA_ENTRADA>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:Occupation)
            then <ns2:PV_OCUPACION>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:Occupation)}</ns2:PV_OCUPACION>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeCurrency)
            then <ns2:PV_MONEDA_INGRESO>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeCurrency)}</ns2:PV_MONEDA_INGRESO>
            else ()
        }
        <ns2:PV_RANGO_SUELDO>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeRange)}</ns2:PV_RANGO_SUELDO>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:LegalRepresentative/ns1:LegalId)
            then <ns2:PV_COD_TIPO_IDENTIFICACION_R>{fn:data($crearCliente/ns1:CustomerInfo/ns1:LegalRepresentative/ns1:LegalId)}</ns2:PV_COD_TIPO_IDENTIFICACION_R>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyType)
            then <ns2:PV_TIPO_DE_EMPRESA>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyType)}</ns2:PV_TIPO_DE_EMPRESA>
            else ()
        }
        <ns2:PV_CODIGO_PROFESION>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:ProfessionCode)}</ns2:PV_CODIGO_PROFESION>
        <ns2:PV_OBJETIVO_SOCIAL></ns2:PV_OBJETIVO_SOCIAL>
        <ns2:PV_CAPITAL_SOCIAL></ns2:PV_CAPITAL_SOCIAL>
        <ns2:PV_CODIGO_TIPO_PERSONA_BCH></ns2:PV_CODIGO_TIPO_PERSONA_BCH>
        <ns2:PV_CODIGO_TIPO_PODER_R></ns2:PV_CODIGO_TIPO_PODER_R>
        <ns2:PV_NRO_INSCRIPCION></ns2:PV_NRO_INSCRIPCION>
        <ns2:PV_TOMO_INSCRIPCION></ns2:PV_TOMO_INSCRIPCION>
        <ns2:PV_FECHA_ACTA></ns2:PV_FECHA_ACTA>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyName!='')
            then <ns2:PV_TRABAJA>S</ns2:PV_TRABAJA>
            else
            <ns2:PV_TRABAJA>N</ns2:PV_TRABAJA>
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:SalesVolume)
            then <ns2:PV_VOLUMEN_VENTAS>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:SalesVolume)}</ns2:PV_VOLUMEN_VENTAS>
            else ()
        }
        <ns2:PV_EMAIL_RLEGAL></ns2:PV_EMAIL_RLEGAL>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:BirthPlace)
            then <ns2:PV_LUGAR_DE_NACIMIENTO>{fn:data($crearCliente/ns1:CustomerInfo/ns1:BirthPlace)}</ns2:PV_LUGAR_DE_NACIMIENTO>
            else ()
        }
        <ns2:PV_VEHICULO_PROPIO></ns2:PV_VEHICULO_PROPIO>
        <ns2:PV_DEMANDA></ns2:PV_DEMANDA>
        <ns2:PV_TIPO_ACCIONES></ns2:PV_TIPO_ACCIONES>
        <ns2:PV_CONSEJO_ADMON></ns2:PV_CONSEJO_ADMON>
        <ns2:PV_FACULTADES_REPRESENTANTE></ns2:PV_FACULTADES_REPRESENTANTE>
        <ns2:PV_TELEFONO_EMPRESA_RLEGAL></ns2:PV_TELEFONO_EMPRESA_RLEGAL>
        <ns2:PV_CELULAR_RLEGAL></ns2:PV_CELULAR_RLEGAL>
        <ns2:PV_CODIGO_TIPO_GENERADOR></ns2:PV_CODIGO_TIPO_GENERADOR>
        <ns2:PV_RTN>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IdList[fn:upper-case(ns1:DocumentName)='RTN']/ns1:LegalId)}</ns2:PV_RTN>
        <ns2:PV_CODIGO_TIPO_DIRECCION>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList[1]/ns1:Type)}</ns2:PV_CODIGO_TIPO_DIRECCION>
        <ns2:PV_CASA_COMERCIAL></ns2:PV_CASA_COMERCIAL>
        <ns2:PV_CONTACTO_REF_COM></ns2:PV_CONTACTO_REF_COM>
        <ns2:PV_TELEFONOS_REF_COM></ns2:PV_TELEFONOS_REF_COM>
        <ns2:PV_NOMBRE_CONTACTO1></ns2:PV_NOMBRE_CONTACTO1>
        <ns2:PV_NOMBRE_CONTACTO2></ns2:PV_NOMBRE_CONTACTO2>
        <ns2:PV_NOMBRE_CONTACTO3></ns2:PV_NOMBRE_CONTACTO3>
        <ns2:PV_TELEFONO_CASA_CONTACTO></ns2:PV_TELEFONO_CASA_CONTACTO>
        <ns2:PV_TELEFONO_MOVIL_CONTACTO></ns2:PV_TELEFONO_MOVIL_CONTACTO>
        <ns2:PV_CARGO>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList[1]/ns1:JobTitle)}</ns2:PV_CARGO>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeCurrency)
            then <ns2:PV_CODIGO_MONEDA>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeCurrency)}</ns2:PV_CODIGO_MONEDA>
            else ()
        }
        <ns2:PV_PRIVADA_PUBLICA></ns2:PV_PRIVADA_PUBLICA>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeSource)
            then <ns2:PV_FUENTE_INGRESOS>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeSource)}</ns2:PV_FUENTE_INGRESOS>
            else ()
        }
        <ns2:PV_NOMBRE_DEPENDIENTE></ns2:PV_NOMBRE_DEPENDIENTE>
        <ns2:PV_COD_PARENTEZCO_DEPENDIENTE></ns2:PV_COD_PARENTEZCO_DEPENDIENTE>
        <ns2:PV_COD_PROFESION_DEPENDIENTE></ns2:PV_COD_PROFESION_DEPENDIENTE>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:GivenNames)
            then <ns2:PV_NOMBRE_REF_PER>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:GivenNames)}</ns2:PV_NOMBRE_REF_PER>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:FamilyNames)
            then <ns2:PV_PRIMER_APELLIDO_REF_PER>{
            if(contains(fn:data($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:FamilyNames), ' '))then(
              fn:substring-before(fn:data($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:FamilyNames), ' ')
            )else(
              fn:data($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:FamilyNames)
            )}</ns2:PV_PRIMER_APELLIDO_REF_PER>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:FamilyNames)
            then <ns2:PV_SEGUNDO_APELLIDO_REF_PER>{fn:substring-after(fn:data($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:FamilyNames), ' ')}</ns2:PV_SEGUNDO_APELLIDO_REF_PER>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:MarriedName)
            then <ns2:PV_APELLIDO_DE_CASADA_REF_PER>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:MarriedName)}</ns2:PV_APELLIDO_DE_CASADA_REF_PER>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:PhoneNumber)
            then <ns2:PV_TELEFONO_REF_COM>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:PhoneNumber)}</ns2:PV_TELEFONO_REF_COM>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:Relationship)
            then <ns2:PV_CODIGO_REFERENCIA_PERSONAL>{fn:data($crearCliente/ns1:CustomerInfo/ns1:ReferenceList[ns1:Type = 'Personal']/ns1:Relationship)}</ns2:PV_CODIGO_REFERENCIA_PERSONAL>
            else ()
        }
        <ns2:PV_CODIGO_TIPO_IDENT_SOCIOS></ns2:PV_CODIGO_TIPO_IDENT_SOCIOS>
        <ns2:PV_NUM_IDENTIFICACION_SOCIOS></ns2:PV_NUM_IDENTIFICACION_SOCIOS>
        <ns2:PV_NOMBRES_SOCIOS></ns2:PV_NOMBRES_SOCIOS>
        <ns2:PV_APELLIDOS_SOCIOS></ns2:PV_APELLIDOS_SOCIOS>
        <ns2:PV_APELLIDO_DE_CASADA_SOCIOS></ns2:PV_APELLIDO_DE_CASADA_SOCIOS>
        <ns2:PV_PORCENTAJE_PARTICIPACION></ns2:PV_PORCENTAJE_PARTICIPACION>
        <ns2:PV_DIRECCION_PRINCIPAL></ns2:PV_DIRECCION_PRINCIPAL>
        <ns2:PV_NO_PROM_PROVEEDORES></ns2:PV_NO_PROM_PROVEEDORES>
        <ns2:PV_RECOLECCION_VALORES></ns2:PV_RECOLECCION_VALORES>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:Segment)
            then <ns2:PV_SEGMENTACION_TARGET>{fn:data($crearCliente/ns1:CustomerInfo/ns1:Segment)}</ns2:PV_SEGMENTACION_TARGET>
            else ()
        }
        <ns2:PV_PAIS_CONSTITUCION></ns2:PV_PAIS_CONSTITUCION>
        <ns2:PV_MONEDA_CONSTITUCION></ns2:PV_MONEDA_CONSTITUCION>
        <ns2:PV_FECHA_INSCRIPCION_COSNT></ns2:PV_FECHA_INSCRIPCION_COSNT>
        <ns2:PV_FACULTADES_CONSTITUCION></ns2:PV_FACULTADES_CONSTITUCION>
        <ns2:PT_DIRECCIONES>
            {
                for $AddressList in $crearCliente/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList
                return 
                <ns2:PT_DIRECCIONES_ITEM>
                    {
                        if ($AddressList/ns1:DistrictCode)
                        then <ns2:PV_COLONIA>{fn:data($AddressList/ns1:DistrictCode)}</ns2:PV_COLONIA>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:Avenue)
                        then <ns2:PV_AVENIDA>{fn:data($AddressList/ns1:Avenue)}</ns2:PV_AVENIDA>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:Street)
                        then <ns2:PV_CALLE>{fn:data($AddressList/ns1:Street)}</ns2:PV_CALLE>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:Block)
                        then <ns2:PV_BLOQUE>{fn:data($AddressList/ns1:Block)}</ns2:PV_BLOQUE>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:HouseNumber)
                        then <ns2:PV_NUMERO_CASA>{fn:data($AddressList/ns1:HouseNumber)}</ns2:PV_NUMERO_CASA>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:References)
                        then <ns2:PV_REFERENCIAS>{fn:data($AddressList/ns1:References)}</ns2:PV_REFERENCIAS>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:CityCode)
                        then <ns2:PV_CODIGO_MUNICIPIO>{fn:data($AddressList/ns1:CityCode)}</ns2:PV_CODIGO_MUNICIPIO>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:StateCode)
                        then <ns2:PV_CODIGO_DEPARTAMENTO>{fn:data($AddressList/ns1:StateCode)}</ns2:PV_CODIGO_DEPARTAMENTO>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:References)
                        then <ns2:PV_LINEA_DIR_1>{fn:data($AddressList/ns1:References)}</ns2:PV_LINEA_DIR_1>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:CityCode)
                        then <ns2:PV_CD_MUNICIPIO>{fn:data($AddressList/ns1:CityCode)}</ns2:PV_CD_MUNICIPIO>
                        else ()
                    }
                    {
                        if ($AddressList/ns1:StateCode)
                        then <ns2:PV_CD_DEPARTAMENTO>{fn:data($AddressList/ns1:StateCode)}</ns2:PV_CD_DEPARTAMENTO>
                        else ()
                    }
                    <ns2:PN_CODIGO_TIPO_DIRECCION>{fn:data($AddressList/ns1:Type)}</ns2:PN_CODIGO_TIPO_DIRECCION></ns2:PT_DIRECCIONES_ITEM>
            }
        </ns2:PT_DIRECCIONES>
        <ns2:PV_NOMBRE_PERSO_CONTAC></ns2:PV_NOMBRE_PERSO_CONTAC>
        <ns2:PV_TEL_CASA_PERSO_CONTAC></ns2:PV_TEL_CASA_PERSO_CONTAC>
        <ns2:PV_CEL_PERSO_CONTAC></ns2:PV_CEL_PERSO_CONTAC>
        <ns2:PV_EMAIL_PERSO_CONTAC></ns2:PV_EMAIL_PERSO_CONTAC>
        <ns2:PV_CARGO_PERSO_CONTAC></ns2:PV_CARGO_PERSO_CONTAC>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:MerchantType)
            then <ns2:PV_TIPO_COMERCIANTE>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:MerchantType)}</ns2:PV_TIPO_COMERCIANTE>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:Nationality)
            then <ns2:PV_NACIONALIDAD>{fn:data($crearCliente/ns1:CustomerInfo/ns1:Nationality)}</ns2:PV_NACIONALIDAD>
            else ()
        }
        <ns2:PV_TIPOS_SECTORIZACION></ns2:PV_TIPOS_SECTORIZACION>
        <ns2:PV_NOMBRE_CLIENTE_MAIN></ns2:PV_NOMBRE_CLIENTE_MAIN>
        <ns2:PV_CLIENTE_UBICACION_GEO></ns2:PV_CLIENTE_UBICACION_GEO>
        <ns2:PV_CLIENTE_PRODUCTOS_MAIN></ns2:PV_CLIENTE_PRODUCTOS_MAIN>
        <ns2:PV_CLIENTE_TELEFONO_MAIN></ns2:PV_CLIENTE_TELEFONO_MAIN>
        <ns2:PV_NOMBRE_PROVEEDOR></ns2:PV_NOMBRE_PROVEEDOR>
        <ns2:PV_PROVEEDOR_UBICACION_GEO></ns2:PV_PROVEEDOR_UBICACION_GEO>
        <ns2:PV_PROVEEDOR_PRODUCTOS_MAIN></ns2:PV_PROVEEDOR_PRODUCTOS_MAIN>
        <ns2:PV_PROVEEDOR_TELEFONO_MAIN></ns2:PV_PROVEEDOR_TELEFONO_MAIN>
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:Industry)
            then <ns2:PV_INDUSTRIA>{fn:data($crearCliente/ns1:CustomerInfo/ns1:Industry)}</ns2:PV_INDUSTRIA>
            else ()
        }
        {
            if ($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyName)
            then <ns2:PV_NOMBRE_EMPRESA_TRABAJO>{fn:data($crearCliente/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyName)}</ns2:PV_NOMBRE_EMPRESA_TRABAJO>
            else ()
        }
        <ns2:PV_NUMERO_IDENTIFICACION_REP></ns2:PV_NUMERO_IDENTIFICACION_REP>
        <ns2:PV_DIR_MAIN_ELECTRONICA></ns2:PV_DIR_MAIN_ELECTRONICA>
        <ns2:PV_NUMERO_DE_EMPLEADOS></ns2:PV_NUMERO_DE_EMPLEADOS>
        <ns2:PV_OBSERVACIONES_APER></ns2:PV_OBSERVACIONES_APER>
        <ns2:PV_RESIDENCIA_STATUS></ns2:PV_RESIDENCIA_STATUS>
        <ns2:PV_CUSTOMERTYPE>{fn:data($crearCliente/ns1:Type)}</ns2:PV_CUSTOMERTYPE>
    </ns2:InputParameters>
};

xq:CrearClienteNormalInAbanks($cdCliente, $crearCliente, $user)