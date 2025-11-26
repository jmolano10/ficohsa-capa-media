xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCliente";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerDetails/GetCustomerDetails_BS.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getCustomerDetailsOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace cus = "http://www.ficohsa.com.hn/middleware.services/customerInfoCommonTypes";

declare variable $uuid as xs:string external;
declare variable $getCustomerDetailsRSP as element() (:: schema-element(ns2:OutputParameters) ::) external;

declare function ns1:getCustomerDetailsOut($uuid as xs:string, 
                                           $getCustomerDetailsRSP as element() (:: schema-element(ns2:OutputParameters) ::)) as element() (:: schema-element(ns3:getCustomerDetailsResponse) ::) {
    <ns3:getCustomerDetailsResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:BasicInfo>
            <ns3:CustomerId>{fn:data($getCustomerDetailsRSP/ns2:PV_CUSTOMER_ID)}</ns3:CustomerId>
            <ns3:Mnemonic></ns3:Mnemonic>
            <ns3:IdentificationInfo>
                <ns3:LegalDocumentType>{fn:data($getCustomerDetailsRSP/ns2:PV_LEGAL_DOC_NAME)}</ns3:LegalDocumentType>
                <ns3:LegalId>{fn:data($getCustomerDetailsRSP/ns2:PV_LEGAL_ID)}</ns3:LegalId>
            </ns3:IdentificationInfo>
            <ns3:GivenNames>{ data($getCustomerDetailsRSP/ns2:PV_NOMBRES) }</ns3:GivenNames>
            <ns3:FamilyName>{ data($getCustomerDetailsRSP/ns2:PV_APELLIDOS) }</ns3:FamilyName>
            <ns3:FullName>{ data($getCustomerDetailsRSP/ns2:PV_NOMBRECENTRALRIESGOS) }</ns3:FullName>
            <ns3:NameBusiness>{ data($getCustomerDetailsRSP/ns2:PV_RAZONSOCIAL) }</ns3:NameBusiness>
            <ns3:CommercialName>{ data($getCustomerDetailsRSP/ns2:PV_NOMBRECOMERCIAL) }</ns3:CommercialName>
            <ns3:LegalHolderName>{ data($getCustomerDetailsRSP/ns2:PV_NOMBRECENTRALRIESGOS) }</ns3:LegalHolderName>
            <ns3:ShortName>{ data($getCustomerDetailsRSP/ns2:PV_NOMBRECORTO) }</ns3:ShortName>
            <ns3:DateBirth>{ fn:concat(fn:substring(data($getCustomerDetailsRSP/ns2:PD_FECHANACIMIENTO),0,5), '-', fn:substring(data($getCustomerDetailsRSP/ns2:PD_FECHANACIMIENTO),5,2), '-', fn:substring(data($getCustomerDetailsRSP/ns2:PD_FECHANACIMIENTO),7,2)) }</ns3:DateBirth>
            <ns3:Gender>{ data($getCustomerDetailsRSP/ns2:PV_GENERO) }</ns3:Gender>
            <ns3:Nationality>{ data($getCustomerDetailsRSP/ns2:PV_NACIONALIDAD) }</ns3:Nationality>
            <ns3:Residence>{ data($getCustomerDetailsRSP/ns2:PV_RESIDENCIA) }</ns3:Residence>
            <ns3:MaritalStatus>{ data($getCustomerDetailsRSP/ns2:PV_ESTADOCIVIL) }</ns3:MaritalStatus>
            <ns3:MarriedLastName>{ data($getCustomerDetailsRSP/ns2:PV_APELLIDOCASADA) }</ns3:MarriedLastName>
            <ns3:SpouseName>{ data($getCustomerDetailsRSP/ns2:PV_NOMBRE_CONYUGUE) }</ns3:SpouseName>
            <ns3:LegalRepresentativeId>{ data($getCustomerDetailsRSP/ns2:PV_IDREPLEGAL) }</ns3:LegalRepresentativeId>
            <ns3:LegalRepresentativeName>{ data($getCustomerDetailsRSP/ns2:PV_NOMBREREPLEGAL) }</ns3:LegalRepresentativeName>
            <ns3:Sector>{ data($getCustomerDetailsRSP/ns2:PN_SECTOR) }</ns3:Sector>
            <ns3:SectorDescription>{ data($getCustomerDetailsRSP/ns2:PV_DESCRIPCIONSECTOR) }</ns3:SectorDescription>
            <ns3:Industry>{ data($getCustomerDetailsRSP/ns2:PV_INDUSTRIA) }</ns3:Industry>
            <ns3:IndustryDescription>{ data($getCustomerDetailsRSP/ns2:PV_INDUSTRIA_DESCRIPCION) }</ns3:IndustryDescription>
            <ns3:Target>{ data($getCustomerDetailsRSP/ns2:PV_CODIGOSEGMENTACION) }</ns3:Target>
            <ns3:TargetDescription>{ data($getCustomerDetailsRSP/ns2:PV_DESCRIPCIONSEGMENTACION) }</ns3:TargetDescription>
            <ns3:ForeignExchangeGenerator>{ data($getCustomerDetailsRSP/ns2:PV_TIPOGENERADOR) }</ns3:ForeignExchangeGenerator>
            <ns3:AccountOfficer>{ data($getCustomerDetailsRSP/ns2:PV_CODIGO_OFICIAL) }</ns3:AccountOfficer>
            <ns3:BranchCode>{ data($getCustomerDetailsRSP/ns2:PN_CODIGO_AGENCIA) }</ns3:BranchCode>
            <ns3:TypePerson>{ data($getCustomerDetailsRSP/ns2:PV_TIPOPERSONA) }</ns3:TypePerson>
            <ns3:CustomerType>{ data($getCustomerDetailsRSP/ns2:PN_TIPOCLIENTE) }</ns3:CustomerType>
            <ns3:CustomerStatus>{ data($getCustomerDetailsRSP/ns2:PV_STATUSCLIENTE) }</ns3:CustomerStatus>
            <ns3:CustomerSince>{ fn:concat(fn:substring(data($getCustomerDetailsRSP/ns2:PV_FECHAINGRESO),0,5), '-', fn:substring(data($getCustomerDetailsRSP/ns2:PV_FECHAINGRESO),5,2), '-', fn:substring(data($getCustomerDetailsRSP/ns2:PV_FECHAINGRESO),7,2)) }</ns3:CustomerSince>
        </ns3:BasicInfo>
        <ns3:FinancialInfo>
            <ns3:LevelEducation>{ data($getCustomerDetailsRSP/ns2:PV_NIVEL_EDUCACION) }</ns3:LevelEducation>
            {
                if (data($getCustomerDetailsRSP/ns2:PN_ESTADOTRABAJO) = 'S') then
                    <ns3:EmploymentSatus>YES</ns3:EmploymentSatus>
                else if (data($getCustomerDetailsRSP/ns2:PN_ESTADOTRABAJO) = 'N') then
                    <ns3:EmploymentSatus>NO</ns3:EmploymentSatus>
                else
                    <ns3:EmploymentSatus></ns3:EmploymentSatus>
            }
            <ns3:Occupation>{ data($getCustomerDetailsRSP/ns2:PV_OCUPACION) }</ns3:Occupation>
            <ns3:Profession>{ data($getCustomerDetailsRSP/ns2:PN_PROFESION) }</ns3:Profession>
            <ns3:CompanyType>{ data($getCustomerDetailsRSP/ns2:PV_TIPOCOMPANIA) }</ns3:CompanyType>
            <ns3:EmployerName>{ data($getCustomerDetailsRSP/ns2:PV_NOMBREEMPLEADOR) }</ns3:EmployerName>
            <ns3:JobTitleDescription></ns3:JobTitleDescription>
            <ns3:NumberDependents>{ data($getCustomerDetailsRSP/ns2:PN_NUMERO_DEPENDIENTES) }</ns3:NumberDependents>
        </ns3:FinancialInfo>
        {
            for $ADDRESS_TYPE at $i in $getCustomerDetailsRSP/ns2:PT_TIPO_DIRECCION/ns2:PT_TIPO_DIRECCION_ITEM
            return
                <ns3:AddressesInfo>
                    <ns3:AddressCode>{ data($getCustomerDetailsRSP/ns2:PT_TIPO_DIRECCION/ns2:PT_TIPO_DIRECCION_ITEM[$i]) }</ns3:AddressCode>
                    {
                        if (data($getCustomerDetailsRSP/ns2:PT_TIPO_DIRECCION/ns2:PT_TIPO_DIRECCION_ITEM[$i]) = 1) then
                            <ns3:AddressType>HOME</ns3:AddressType>
                        else if (data($getCustomerDetailsRSP/ns2:PT_TIPO_DIRECCION/ns2:PT_TIPO_DIRECCION_ITEM[$i]) = 2) then
                            <ns3:AddressType>WORK</ns3:AddressType>
                        else
                            <ns3:AddressType>OTHER</ns3:AddressType>
                    }
                    {
                        if (data($getCustomerDetailsRSP/ns2:PT_DIRECCION_PRINCIPAL/ns2:PT_DIRECCION_PRINCIPAL_ITEM) = 'S') then
                            <ns3:IsMainAddress>YES</ns3:IsMainAddress>
                        else if (data($getCustomerDetailsRSP/ns2:PT_DIRECCION_PRINCIPAL/ns2:PT_DIRECCION_PRINCIPAL_ITEM) = 'N') then
                            <ns3:IsMainAddress>NO</ns3:IsMainAddress>
                        else
                            <ns3:IsMainAddress>NO</ns3:IsMainAddress>
                    }
                    <ns3:CountryCode>{ data($getCustomerDetailsRSP/ns2:PT_PAIS/ns2:PT_PAIS_ITEM[$i]) }</ns3:CountryCode>
                    <ns3:DepartmentCode>{ data($getCustomerDetailsRSP/ns2:PT_DEPARTAMENTO/ns2:PT_PAIS_ITEM[$i]) }</ns3:DepartmentCode>
                    <ns3:MunicipalityCode>{ data($getCustomerDetailsRSP/ns2:PT_CIUDAD/ns2:PT_PAIS_ITEM[$i]) }</ns3:MunicipalityCode>
                    <ns3:AddressLine1>{ data($getCustomerDetailsRSP/ns2:PT_DIRECCION_COMPLETA/ns2:PT_DIRECCION_COMPLETA_ITEM[$i]) }</ns3:AddressLine1>
                    <ns3:Zone></ns3:Zone>
                </ns3:AddressesInfo>
        }
        <ns3:PhoneInfo>
            <cus:Id>1</cus:Id>
            <cus:Type>LANDLINE</cus:Type>
            <cus:PhoneNumber>{ data($getCustomerDetailsRSP/ns2:PV_TELEFONO) }</cus:PhoneNumber>
        </ns3:PhoneInfo>
        <ns3:PhoneInfo>
            <cus:Id>1</cus:Id>
            <cus:Type>MOBILE</cus:Type>
            <cus:PhoneNumber>{ data($getCustomerDetailsRSP/ns2:PV_CELULAR) }</cus:PhoneNumber>
        </ns3:PhoneInfo>
        <ns3:EmailInfo>
            <ns3:Id>1</ns3:Id>
            <ns3:Email>{ data($getCustomerDetailsRSP/ns2:PV_EMAIL) }</ns3:Email>
            <ns3:IsMainEmail>YES</ns3:IsMainEmail>
        </ns3:EmailInfo>
        {
            for $SECTOR_INFO at $i in $getCustomerDetailsRSP/ns2:PT_TIPO_SECTORIZACION/ns2:PT_TIPO_SECTORIZACION_ITEM
            return
                <ns3:SectorizationInfo>
                    <ns3:Type>{ fn:data($getCustomerDetailsRSP/ns2:PT_TIPO_SECTORIZACION/ns2:PT_TIPO_SECTORIZACION_ITEM[$i]) }</ns3:Type>
                    <ns3:Code>{ fn:data($getCustomerDetailsRSP/ns2:PT_CODIGO_SECTORIZACION/ns2:PT_TIPO_SECTORIZACION_ITEM[$i]) }</ns3:Code>
                </ns3:SectorizationInfo>
        }
        <ns3:AuditInfo>
            <ns3:CreatedBy>{ fn:data($getCustomerDetailsRSP/ns2:PV_USUARIOINGRESO) }</ns3:CreatedBy>
            <ns3:DateTime>{ fn:concat(fn:substring(data($getCustomerDetailsRSP/ns2:PV_FECHA_ULTIMA_MOD),0,5), '-', fn:substring(data($getCustomerDetailsRSP/ns2:PV_FECHA_ULTIMA_MOD),5,2), '-', fn:substring(data($getCustomerDetailsRSP/ns2:PV_FECHA_ULTIMA_MOD),7,2), 'T', fn:substring(data($getCustomerDetailsRSP/ns2:PV_FECHA_ULTIMA_MOD),9,2), ':', fn:substring(data($getCustomerDetailsRSP/ns2:PV_FECHA_ULTIMA_MOD),11,2), ':', fn:substring(data($getCustomerDetailsRSP/ns2:PV_FECHA_ULTIMA_MOD),13,2)) }</ns3:DateTime>
        </ns3:AuditInfo>
    </ns3:getCustomerDetailsResponse>
};

ns1:getCustomerDetailsOut($uuid, $getCustomerDetailsRSP)