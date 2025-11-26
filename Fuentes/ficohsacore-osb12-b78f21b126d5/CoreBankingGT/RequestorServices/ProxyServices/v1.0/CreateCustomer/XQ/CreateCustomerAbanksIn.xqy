xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateCustomerAbanks";
(:: import schema at "../../../../../ProviderServices/XSD/CreateCustomerAbanks/CreateCustomerAbanks_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogsEquivalence";
(:: import schema at "../../../../../../CoreBankingHN/ProviderServices/XSD/GetCatalogsEquivalence/GetCatalogsEquivalence_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare variable $CreateCustomerAbanksRequest as element() (:: schema-element(ns1:createCustomerRequest) ::) external;
declare variable $GetCatalogsEquivalenceResponse as element() (:: schema-element(ns3:OutputParameters) ::) external;

declare function local:CatalogValueOSBToAPP($value as xs:string,
	$application as xs:string,
	$catalogId as xs:string,
	$catalogEquivalencies as element(*)
) as xs:string {
	let $return := string($catalogEquivalencies/ns3:PT_EQUIVALENCIAS_SALIDA/ns3:PT_EQUIVALENCIAS_SALIDA_ITEM[ns3:CATALOGO_ID = $catalogId and ns3:VALOR_CATALOGO = $value][1]/ns3:EQUIVALENCIAS/ns3:EQUIVALENCIAS_ITEM[ns3:APLICACION = $application]/ns3:VALOR_EQUIVALENCIA/text())
	return
		if($return != "") then (
			$return
		) else ( 
			$value
		)
};

declare function local:func($CreateCustomerAbanksRequest as element() (:: schema-element(ns1:createCustomerRequest) ::),
                            $GetCatalogsEquivalenceResponse as element() (:: schema-element(ns3:OutputParameters) ::)) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {      
            if (data($CreateCustomerAbanksRequest/ns1:ProcessType)='8.2') then(
		<PN_PROCESS_TYPE>8</PN_PROCESS_TYPE>
            )else (
		<PN_PROCESS_TYPE>{fn:data($CreateCustomerAbanksRequest/ns1:ProcessType)}</PN_PROCESS_TYPE>
            )
        }
        {
            for $Migrate in $CreateCustomerAbanksRequest/ns1:Migrate
            return
            <ns2:PN_CODIGO_CLIENTE>{fn:data($Migrate)}</ns2:PN_CODIGO_CLIENTE>
        }
        {
            for $Segment in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:Segment
            return
            <ns2:PN_SEGMENTO>{fn:data($Segment)}</ns2:PN_SEGMENTO>
        }
        {
            let $OpeningCountry := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "OpeningCountry"]/ns1:Value)
            return
            <ns2:PN_PAIS>{ local:CatalogValueOSBToAPP($OpeningCountry, 'ABANKSGT', '9', $GetCatalogsEquivalenceResponse) }</ns2:PN_PAIS>
        }
        {
            let $CountyOfIssuance := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IdList/ns1:CountryOfIssuance)
            return
            <ns2:PN_PAIS_EMISION>{ local:CatalogValueOSBToAPP($CountyOfIssuance, 'ABANKSGT', '9', $GetCatalogsEquivalenceResponse) }</ns2:PN_PAIS_EMISION>
        }
        {
            let $CityOfIssuance := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IdList/ns1:CityOfIssuance)
            return
            <ns2:PN_MUNICIPIO_EMISION>{ local:CatalogValueOSBToAPP($CityOfIssuance, 'ABANKSGT', '7', $GetCatalogsEquivalenceResponse) }</ns2:PN_MUNICIPIO_EMISION>
        }
        {
            let $StateOfIssuance := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IdList/ns1:StateOfIssuance)
            return
            <ns2:PN_DEPTO_EMISION>{ local:CatalogValueOSBToAPP($StateOfIssuance, 'ABANKSGT', '8', $GetCatalogsEquivalenceResponse) }</ns2:PN_DEPTO_EMISION>
        }
        {
            let $Nombres := fn:concat(fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FirstName), ' ', fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:SecondName))
            return
            <ns2:PV_NOMBRES>{ $Nombres }</ns2:PV_NOMBRES>
        }
        {
            for $FirstLastName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FirstLastName
            return
            <ns2:PV_PRIMER_APELLIDO>{fn:data($FirstLastName)}</ns2:PV_PRIMER_APELLIDO>
        }
        {
            for $SecondLastName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:SecondLastName
            return
            <ns2:PV_SEGUNDO_APELLIDO>{fn:data($SecondLastName)}</ns2:PV_SEGUNDO_APELLIDO>
        }
        {
            for $MarriedName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:MarriedName
            return
            <ns2:PV_APELLIDO_CASADA>{fn:data($MarriedName)}</ns2:PV_APELLIDO_CASADA>
        }
        {
            for $BirthDate in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:BirthDate
            return
            <ns2:PD_FECHA_NACIMIENTO>{ fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($BirthDate)) }</ns2:PD_FECHA_NACIMIENTO>
        }
        {
            let $BirthCountry := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:BirthCountry)
            return
            <ns2:PN_PAIS_NACIMIENTO>{ local:CatalogValueOSBToAPP($BirthCountry, 'ABANKSGT', '9', $GetCatalogsEquivalenceResponse) }</ns2:PN_PAIS_NACIMIENTO>
        }
        {
            for $BirthPlace in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:BirthPlace
            return
            <ns2:PV_LUGAR_NACIMIENTO>{fn:data($BirthPlace)}</ns2:PV_LUGAR_NACIMIENTO>
        }
        {
            let $BirthCity := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:BirthCity)
            return
            <ns2:PN_MUNICIPIO_NACIMIENTO>{ local:CatalogValueOSBToAPP($BirthCity, 'ABANKSGT', '7', $GetCatalogsEquivalenceResponse) }</ns2:PN_MUNICIPIO_NACIMIENTO>
        }
        {
            let $CountryCode := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList[ns1:Type = "1"]/ns1:CountryCode)
            return
            <ns2:PN_CODIGO_PAIS_2>{ local:CatalogValueOSBToAPP($CountryCode, 'ABANKSGT', '9', $GetCatalogsEquivalenceResponse) }</ns2:PN_CODIGO_PAIS_2>
        }
        {
            for $ImmigrationStatus in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "ImmigrationStatus"]
            return
            <ns2:PV_CONDICION_MIGRATORIA>{fn:data($ImmigrationStatus/ns1:Value)}</ns2:PV_CONDICION_MIGRATORIA>
        }
        {
            let $IsFatcaCustomer := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FatcaInfo/ns1:IsFatcaCustomer)
            let $IsUSResident := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FatcaInfo/ns1:IsUSResident)
            return
            if ($IsFatcaCustomer = "Yes" and $IsUSResident = "Yes") then (
                <ns2:PV_RESIDE_EEUU>S</ns2:PV_RESIDE_EEUU>
            ) else (
                <ns2:PV_RESIDE_EEUU>N</ns2:PV_RESIDE_EEUU>
            )
        }
        {
            for $USAPhoneNumber in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList[ns1:Location = "USA"]
            return
                <ns2:PV_TELEFONO_EEUU>{fn:data($USAPhoneNumber/ns1:Number)}</ns2:PV_TELEFONO_EEUU>
        }
        {
            let $Gender := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:Gender)
            return
                <ns2:PV_SEXO>{ local:CatalogValueOSBToAPP($Gender, 'ABANKSGT', '1', $GetCatalogsEquivalenceResponse) }</ns2:PV_SEXO>
        }
        {
            let $MaritalStatus := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:MaritalStatus)
            return
                <ns2:PV_ESTADO_CIVIL>{ local:CatalogValueOSBToAPP($MaritalStatus, 'ABANKSGT', '2', $GetCatalogsEquivalenceResponse) }</ns2:PV_ESTADO_CIVIL>
        }
        {
            for $NumberOfChildren in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "NumberOfChildren"]
            return
              <ns2:PN_CANTIDAD_HIJOS>{fn:data($NumberOfChildren/ns1:Value)}</ns2:PN_CANTIDAD_HIJOS>
        }
        {
            let $DocumentName := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IdList/ns1:DocumentName)
            return
              <ns2:PN_TIPO_IDENTF>{ local:CatalogValueOSBToAPP($DocumentName, 'ABANKSGT', '4', $GetCatalogsEquivalenceResponse) }</ns2:PN_TIPO_IDENTF>
              
        }
        <ns2:PV_NUMERO_IDENTIFICACION>{fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IdList/ns1:LegalId)}</ns2:PV_NUMERO_IDENTIFICACION>
        {
            for $Activity in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "Activity"]
            return
            <ns2:PN_CODIGO_TIPO_CLIENTE>{fn:data($Activity/ns1:Value)}</ns2:PN_CODIGO_TIPO_CLIENTE>
        }
        {
            for $NIT in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IdList[ns1:DocumentName = "NIT"]
            return
            <ns2:PV_NIT>{fn:data($NIT/ns1:LegalId)}</ns2:PV_NIT>
        }
        {
            if ($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList) then (
              <ns2:PT_DIRECCION>
              {
                  for $address in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:AddressList
                  return (
                      <ns2:PT_DIRECCION_ITEM>
                          <ns2:PV_TYPE>{fn:data($address/ns1:Type)}</ns2:PV_TYPE>
                          <ns2:PN_CODIGO_PAIS>{fn:data($address/ns1:CountryCode)}</ns2:PN_CODIGO_PAIS>
                          <ns2:PN_CODIGO_DEPTO>{fn:data($address/ns1:StateCode)}</ns2:PN_CODIGO_DEPTO>
                          <ns2:PN_CODIGO_MUNICIPIO>{fn:data($address/ns1:CityCode)}</ns2:PN_CODIGO_MUNICIPIO>
                          <ns2:PV_BARRIO>{fn:data($address/ns1:Neighborhood)}</ns2:PV_BARRIO>
                          <ns2:PV_AVENIDA>{fn:data($address/ns1:Avenue)}</ns2:PV_AVENIDA>
                          <ns2:PV_CALLE>{fn:data($address/ns1:Street)}</ns2:PV_CALLE>
                          <ns2:PN_ZONA>{fn:data($address/ns1:Zone)}</ns2:PN_ZONA>
                          <ns2:PV_CASA>{fn:data($address/ns1:HouseNumber)}</ns2:PV_CASA>
                          <ns2:PV_REFERENCIA>{fn:data($address/ns1:References)}</ns2:PV_REFERENCIA>
                          {
                              for $email in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:EmailList[ns1:Type = $address/ns1:Type]
                              return
                              <ns2:PV_EMAIL>{fn:data($email/ns1:Email)}</ns2:PV_EMAIL>
                          }
                          {
                            let $mobileMain := $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList[ns1:Type = "Mobile" and ns1:Ismain = 'Yes']
                            let $mobileSec := $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList[ns1:Type = "Mobile" and ns1:Ismain = 'No']
                            return
                              if(fn:data($address/ns1:Type)= '1')then(
                                <ns2:PV_CELULAR>{fn:data($mobileMain/ns1:Number)}</ns2:PV_CELULAR>
                              )else(
                                <ns2:PV_CELULAR>{fn:data($mobileSec/ns1:Number)}</ns2:PV_CELULAR>
                              )
                          }
                          {
                            let $phoneMain := $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList[ns1:Type = "Landline" and ns1:Ismain = 'Yes']
                            let $phoneSec := $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList[ns1:Type = "Landline" and ns1:Ismain = 'No']
                            return
                              if(fn:data($address/ns1:Type)= '1')then(
                                <ns2:PV_TELEFONOS>{fn:data($phoneMain/ns1:Number)}</ns2:PV_TELEFONOS>
                              )else(
                                <ns2:PV_TELEFONOS>{fn:data($phoneSec/ns1:Number)}</ns2:PV_TELEFONOS>
                              )
                          }
                          {
                            let $faxMain := $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList[ns1:Type = "Fax" and ns1:Ismain = 'Yes']
                            let $faxSec := $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ContactInfo/ns1:PhoneList[ns1:Type = "Fax" and ns1:Ismain = 'No']
                            return
                              if(fn:data($address/ns1:Type)= '1')then(
                                <ns2:PV_FAX>{fn:data($faxMain/ns1:Number)}</ns2:PV_FAX>
                              )else(
                                <ns2:PV_FAX>{fn:data($faxSec/ns1:Number)}</ns2:PV_FAX>
                              )
                          }
                      </ns2:PT_DIRECCION_ITEM>
                  )
              }
              </ns2:PT_DIRECCION>
            ) else ()
        }
        {
            let $IsPepCustomer := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:PepInfo/ns1:IsPepCustomer)
            return
            if ($IsPepCustomer = "Yes") then (
                <ns2:PV_CLIENTE_PEP>S</ns2:PV_CLIENTE_PEP>
            ) else (
                <ns2:PV_CLIENTE_PEP>N</ns2:PV_CLIENTE_PEP>
            )
        }
        {
            for $PepInfo in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:PepInfo
            return
            if ($PepInfo/ns1:IsPepCustomer = "Yes") then (
                <ns2:PV_NOMBRE_PEP>
                { 
                    fn:concat(
                        fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FirstName), 
                        ' ',
                        fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:SecondName), 
                        ' ',
                        fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FirstLastName),
                        ' ',
                        fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:SecondLastName)
                    )
                }
                </ns2:PV_NOMBRE_PEP>,
                <ns2:PV_EMPRESA_PEP>{fn:data($PepInfo/ns1:InstitutionName)}</ns2:PV_EMPRESA_PEP>,
                <ns2:PV_CARGO_PEP>{fn:data($PepInfo/ns1:JobTitle)}</ns2:PV_CARGO_PEP>,
                
                  let $PepCountry := fn:data($PepInfo/ns1:Country)
                  return
                    <ns2:PN_PAIS_PEP>{ local:CatalogValueOSBToAPP($PepCountry, 'ABANKSGT', '9', $GetCatalogsEquivalenceResponse) }</ns2:PN_PAIS_PEP>,
                
                <ns2:PT_ORIGEN_RIQUEZA_PEP>
                    <ns2:PT_ORIGEN_RIQUEZA_PEP_ITEM>
                    {
                        for $WealthOrigin in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "WealthOrigin"]
                        return
                        <ns2:PV_DESCRIPCION>{fn:data($WealthOrigin/ns1:Value)}</ns2:PV_DESCRIPCION>
                    }
                    {
                        for $WealthValue in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "WealthValue"]
                        return
                        <ns2:PV_VALOR>{fn:data($WealthValue/ns1:Value)}</ns2:PV_VALOR>
                    }
                    </ns2:PT_ORIGEN_RIQUEZA_PEP_ITEM>
                </ns2:PT_ORIGEN_RIQUEZA_PEP>,
                for $FamilyMemberInfo in $PepInfo/ns1:FamilyMemberList[ns1:IsPep = "Yes"]
                return
                    <ns2:PT_PARIENTE_PEP>
                        <ns2:PT_PARIENTE_PEP_ITEM>
                            <ns2:PV_PRIMER_NOMBRE>{fn:data($FamilyMemberInfo/ns1:FullName)}</ns2:PV_PRIMER_NOMBRE>
                            <ns2:PV_SEGUNDO_NOMBRE>{fn:data($FamilyMemberInfo/ns1:FullName)}</ns2:PV_SEGUNDO_NOMBRE>
                            <ns2:PV_PRIMER_APELLIDO>{fn:data($FamilyMemberInfo/ns1:FullName)}</ns2:PV_PRIMER_APELLIDO>
                            <ns2:PV_SEGUNDO_APELLIDO>{fn:data($FamilyMemberInfo/ns1:FullName)}</ns2:PV_SEGUNDO_APELLIDO>
                            <ns2:PV_OTRO_NOMBRE>{fn:data($FamilyMemberInfo/ns1:FullName)}</ns2:PV_OTRO_NOMBRE>
                            <ns2:PV_APELLIDO_CASADA></ns2:PV_APELLIDO_CASADA>
                            <ns2:PN_PARENTEZCO></ns2:PN_PARENTEZCO>
                            <ns2:PV_SEXO_PEP></ns2:PV_SEXO_PEP>
                            <ns2:PV_CONDICION_MIGRATORIA></ns2:PV_CONDICION_MIGRATORIA>
                            <ns2:PV_NOMBRE_INSTITUCION></ns2:PV_NOMBRE_INSTITUCION>
                            <ns2:PV_CARGO>{fn:data($FamilyMemberInfo/ns1:JobTitle)}</ns2:PV_CARGO>
                            <ns2:PV_RELACION>{fn:data($FamilyMemberInfo/ns1:Relationship)}</ns2:PV_RELACION>
                            {
                                for $PepAssociatedFirstName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedFirstName"]
                                return
                                <ns2:PV_PRIMER_NOMBRE_AS>{fn:data($PepAssociatedFirstName/ns1:Value)}</ns2:PV_PRIMER_NOMBRE_AS>   
                            }
                            {
                                for $PepAssociatedSecondName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedSecondName"]
                                return
                                <ns2:PV_SEGUNDO_NOMBRE_AS>{fn:data($PepAssociatedSecondName/ns1:Value)}</ns2:PV_SEGUNDO_NOMBRE_AS>
                            }
                            {
                                for $PepAssociatedFirstLastName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedFirstLastName"]
                                return
                                <ns2:PV_PRIMER_APELLIDO_AS>{fn:data($PepAssociatedFirstLastName/ns1:Value)}</ns2:PV_PRIMER_APELLIDO_AS>
                            }
                            {
                                for $PepAssociatedSecondLastName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedSecondLastName"]
                                return
                                <ns2:PV_SEGUNDO_APELLIDO_AS>{fn:data($PepAssociatedSecondLastName/ns1:Value)}</ns2:PV_SEGUNDO_APELLIDO_AS>
                            }
                            {
                                for $PepAssociatedSecondOtherName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedSecondOtherName"]
                                return
                                <ns2:PV_OTRO_NOMBRE_AS>{fn:data($PepAssociatedSecondOtherName/ns1:Value)}</ns2:PV_OTRO_NOMBRE_AS>
                            }
                            {
                                for $PepAssociatedMarriedName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedMarriedName"]
                                return
                                <ns2:PV_APELLIDO_CASADA_AS>{fn:data($PepAssociatedMarriedName/ns1:Value)}</ns2:PV_APELLIDO_CASADA_AS>
                            }
                            <ns2:PN_PARENTEZCO_AS></ns2:PN_PARENTEZCO_AS>
                            {
                                for $PepAssociatedGender in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedGender"]
                                return
                                <ns2:PV_SEXO_PEP_AS>{fn:data($PepAssociatedGender/ns1:Value)}</ns2:PV_SEXO_PEP_AS>
                            }
                            {
                                for $PepAssociatedImmigrationStatus in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedImmigrationStatus"]
                                return
                                <ns2:PV_CONDICION_MIGRATORIA_AS>{fn:data($PepAssociatedImmigrationStatus/ns1:Value)}</ns2:PV_CONDICION_MIGRATORIA_AS>
                            }
                            {
                                for $PepAssociatedInstitutionName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedInstitutionName"]
                                return
                                <ns2:PV_NOMBRE_INSTITUCION_AS>{fn:data($PepAssociatedInstitutionName/ns1:Value)}</ns2:PV_NOMBRE_INSTITUCION_AS>
                            }
                            {
                                for $PepAssociatedJobTitle in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedJobTitle"]
                                return
                                <ns2:PV_CARGO_AS>{fn:data($PepAssociatedJobTitle/ns1:Value)}</ns2:PV_CARGO_AS>
                            }
                            {
                                for $PepAssociatedCountry in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedCountry"]
                                return
                                <ns2:PN_PAIS_AS>{fn:data($PepAssociatedCountry/ns1:Value)}</ns2:PN_PAIS_AS>
                            }
                            {
                                for $PepAssociatedRelationship in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "PepAssociatedRelationship"]
                                return
                                <ns2:PV_RELACION_AS>{fn:data($PepAssociatedRelationship/ns1:Value)}</ns2:PV_RELACION_AS>
                            }
                        </ns2:PT_PARIENTE_PEP_ITEM>
                    </ns2:PT_PARIENTE_PEP>
            ) else ()
        }
        {
            let $GovernmentContractor := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:GovernmentContractor)
            return
            if ($GovernmentContractor = "Yes") then (
                <ns2:PV_CLIENTES_CPE>S</ns2:PV_CLIENTES_CPE>
            ) else (
                <ns2:PV_CLIENTES_CPE>N</ns2:PV_CLIENTES_CPE>
            )
        }
        {
            for $CPEType in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "CPEType"]
            return
            <ns2:PV_TIPO_CPE>{fn:data($CPEType/ns1:Value)}</ns2:PV_TIPO_CPE>
        }
        {
            for $CPEAssociatedProduct in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "CPEAssociatedProduct"]
            return
            <ns2:PN_PRODUCTO_ASOCIADO_CPE>{fn:data($CPEAssociatedProduct/ns1:Value)}</ns2:PN_PRODUCTO_ASOCIADO_CPE>
        }
        {
            for $CPEProduct in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "CPEProduct"]
            return
            <ns2:PN_OTROS_PRODUCTOS_CPE>{fn:data($CPEProduct/ns1:Value)}</ns2:PN_OTROS_PRODUCTOS_CPE>
        }
        {
            for $CPEStatus in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "CPEStatus"]
            return
            <ns2:PN_ESTATUS_GUATECOMPRAS_CPE>{fn:data($CPEStatus/ns1:Value)}</ns2:PN_ESTATUS_GUATECOMPRAS_CPE>
        }
        {
            for $ApnfdCustomer in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ApnfdCustomer
            return
            <ns2:PV_PORE_CLIENT>{fn:data($ApnfdCustomer)}</ns2:PV_PORE_CLIENT>
        }
        {
            for $ApnfdProfession in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ApnfdProfession
            return
            <ns2:PV_PORES_ACTIVIDAD>{fn:data($ApnfdProfession)}</ns2:PV_PORES_ACTIVIDAD>
        }
        {
            let $ProfessionCode := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:ProfessionCode)
            return 
              <ns2:PN_CODIGO_PROFESION>{ local:CatalogValueOSBToAPP($ProfessionCode, 'ABANKSGT', '3', $GetCatalogsEquivalenceResponse) }</ns2:PN_CODIGO_PROFESION>
        }
        {
            for $LineOfBusiness in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:LineOfBusiness
            return
            <ns2:PN_CODIGO_SECTOR_E>{fn:data($LineOfBusiness)}</ns2:PN_CODIGO_SECTOR_E>
        }
        {
            for $CustomerRisk in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "CustomerRisk"]
            return
            <ns2:PV_TIPO_RIESGO>{fn:data($CustomerRisk/ns1:Value)}</ns2:PV_TIPO_RIESGO>
        }
        {
            for $EconomicActivityCode in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "EconomicActivityCode"]
            return
            <ns2:PN_COD_ACTIVIDAD_ECONOMICA>{fn:data($EconomicActivityCode/ns1:Value)}</ns2:PN_COD_ACTIVIDAD_ECONOMICA>
        }
        {
            for $EconomicActivityDesc in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "EconomicActivityDesc"]
            return
            <ns2:PV_DESC_ACTIVIDAD_ECO>{fn:data($EconomicActivityDesc/ns1:Value)}</ns2:PV_DESC_ACTIVIDAD_ECO>
        }
        {
            let $EducationLevel := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:EducationLevel)
            return
                <ns2:PV_NIVEL_EDUCATIVO>{ local:CatalogValueOSBToAPP($EducationLevel, 'ABANKSGT', '10', $GetCatalogsEquivalenceResponse) }</ns2:PV_NIVEL_EDUCATIVO>
        }
        {
            for $Occupation in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:Occupation
            return
            <ns2:PN_CODIGO_OCUPACION>{fn:data($Occupation)}</ns2:PN_CODIGO_OCUPACION>
        }
        {
            for $CompanyType in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyType
            return
            <ns2:PV_TIPO_EMPRESA>{fn:data($CompanyType)}</ns2:PV_TIPO_EMPRESA>
        }
        {
            let $CurrentlyEmployed := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CurrentlyEmployed)
            return
            if ($CurrentlyEmployed = "Yes") then (
                <ns2:PV_TRABAJA>S</ns2:PV_TRABAJA>
            ) else (
                <ns2:PV_TRABAJA>N</ns2:PV_TRABAJA>
            )
        }
        {
            for $CompanyName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:CompanyName
            return
            <ns2:PV_NOMBRE_EMPRESA>{fn:data($CompanyName)}</ns2:PV_NOMBRE_EMPRESA>
        }
        <ns2:PV_CARGO>{fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:JobTitle)}</ns2:PV_CARGO>
        <ns2:PT_INGRESOS>
            <ns2:PT_INGRESOS_ITEM>
                {
                    for $IncomeSource in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeSource
                    return
                    <ns2:PN_COD_TIPO_INGRESO>{fn:data($IncomeSource)}</ns2:PN_COD_TIPO_INGRESO>
                }
                {
                    for $SourceName in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:SourceName
                    return
                    <ns2:PV_DESCRIPCION>{fn:data($SourceName)}</ns2:PV_DESCRIPCION>
                }
                {
                    for $IncomeCurrency in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:IncomeCurrency
                    return
                    <ns2:PV_MONEDA>{fn:data($IncomeCurrency)}</ns2:PV_MONEDA>
                }
                <ns2:PN_MONTO>{fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:Amount)}</ns2:PN_MONTO>
                {
                    for $CountryCode in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:CountryCode
                    return
                    <ns2:PV_PAIS>{fn:data($CountryCode)}</ns2:PV_PAIS>
                }
                {
                    for $StateCode in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:OtherIncomeSourceList/ns1:StateCode
                    return
                    <ns2:PV_DEPARTAMENTO>{fn:data($StateCode)}</ns2:PV_DEPARTAMENTO>
                }
            </ns2:PT_INGRESOS_ITEM>
        </ns2:PT_INGRESOS>
        {
            for $StartDate in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:StartDate
            return
            <ns2:PD_FECHA_INGRESO>{ fn-bea:dateTime-from-string-with-format('yyyy-MM-dd', fn:data($StartDate)) }</ns2:PD_FECHA_INGRESO>
        }
        <ns2:PN_INGRESOS>{fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:IncomeRange)}</ns2:PN_INGRESOS>
        {
            for $Expenses in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:IncomeSourceList/ns1:Expenses
            return
            <ns2:PN_EGRESOS>{fn:data($Expenses)}</ns2:PN_EGRESOS>
        }
        {
            for $FundsTransfer in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "FundsTransfer"]
            return
            <ns2:PV_TRANF_FONDOS>{fn:data($FundsTransfer/ns1:Value)}</ns2:PV_TRANF_FONDOS>
        }
        {
            for $FundsTransferType in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "FundsTransferType"]
            return
            <ns2:PV_LOCA_INTER>{fn:data($FundsTransferType/ns1:Value)}</ns2:PV_LOCA_INTER>
        }
        {
            for $BusinessOwner in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "BusinessOwner"]
            return
            <ns2:PV_NEGOCIO_PROPIO>{fn:data($BusinessOwner/ns1:Value)}</ns2:PV_NEGOCIO_PROPIO>
        }
        {
            for $GeneratorType in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "GeneratorType"]
            return
            <ns2:PV_TIPO_GENERADOR>{fn:data($GeneratorType/ns1:Value)}</ns2:PV_TIPO_GENERADOR>
        }
        {
            if ($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ReferenceList) then (
                <ns2:PT_REFERENCIAS>
                    {
                        for $Reference in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:ReferenceList
                        return (
                            <ns2:PT_REFERENCIAS_ITEM>
                                {
                                    let $Type := fn:data($Reference/ns1:Type)
                                    return
                                    if ($Type = "Personal") then (
                                        <ns2:PV_TYPE>1</ns2:PV_TYPE>
                                    ) else if ($Type = "Commercial") then (
                                        <ns2:PV_TYPE>2</ns2:PV_TYPE>
                                    ) else ()
                                }
                                <ns2:PV_NOMBRES>{fn:data($Reference/ns1:GivenNames)}</ns2:PV_NOMBRES>
                                {
                                    let $FamilyNames := fn:tokenize(fn:data($Reference/ns1:FamilyNames), '\|')
                                    return (
                                        <ns2:PV_PRIMER_APELLIDO>{$FamilyNames[1]}</ns2:PV_PRIMER_APELLIDO>,
                                        <ns2:PV_SEGUNDO_APELLIDO>{$FamilyNames[2]}</ns2:PV_SEGUNDO_APELLIDO>
                                    )
                                }
                                <ns2:PV_APELLIDO_CASADA>{fn:data($Reference/ns1:MarriedName)}</ns2:PV_APELLIDO_CASADA>
                                <ns2:PV_TELEFONO>{fn:data($Reference/ns1:PhoneNumber)}</ns2:PV_TELEFONO>
                                <ns2:PV_CELULAR>{fn:data($Reference/ns1:Cellphone)}</ns2:PV_CELULAR>
                                <ns2:PV_COD_REFERENCIA_PERSONAL>{fn:data($Reference/ns1:Relationship)}</ns2:PV_COD_REFERENCIA_PERSONAL>
                                {
                                    if ($Reference/ns1:Type/text() = "Commercial") then (
                                          <ns2:PV_NOMBRE_EMPRESA>{fn:data($Reference/ns1:CompanyName)}</ns2:PV_NOMBRE_EMPRESA>,
                                          <ns2:PV_CARGO>{fn:data($Reference/ns1:Occupation)}</ns2:PV_CARGO>
                                    ) else ()
                                }
                            </ns2:PT_REFERENCIAS_ITEM>
                        )
                    }
                </ns2:PT_REFERENCIAS>
            ) else ()
        }
        {
            for $HouseOwner in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "HouseOwner"]
            return
            <ns2:PN_POSEE_CASA>{fn:data($HouseOwner/ns1:Value)}</ns2:PN_POSEE_CASA>
        }
        {
            for $CarOwner in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "CarOwner"]
            return
            <ns2:PV_POSEE_CARRO>{fn:data($CarOwner/ns1:Value)}</ns2:PV_POSEE_CARRO>
        }
        {
            let $IsFatcaCustomer := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FatcaInfo/ns1:IsFatcaCustomer)
            return
            if ($IsFatcaCustomer = "Yes") then (
                <ns2:LV_CONTRIBUYENTE_EEUU>S</ns2:LV_CONTRIBUYENTE_EEUU>
            ) else (
                <ns2:LV_CONTRIBUYENTE_EEUU>N</ns2:LV_CONTRIBUYENTE_EEUU>
            )
        }
        {
            for $USFiscallId in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FatcaInfo/ns1:USFiscallId
            return
            <ns2:LV_TIN>{fn:data($USFiscallId)}</ns2:LV_TIN>
        }
        {
            for $FatcaIndicator in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FatcaInfo/ns1:FatcaIndicator
            return
            <ns2:LV_INDICIOS_FATCA>{fn:data($FatcaIndicator)}</ns2:LV_INDICIOS_FATCA>
        }
        <ns2:LV_RECALCITRANTE_FATCA>N</ns2:LV_RECALCITRANTE_FATCA>
        {
            for $ReviewedForValidation in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "ReviewedForValidation"]
            return
            <ns2:LV_REV_VALIDACION>{fn:data($ReviewedForValidation/ns1:Value)}</ns2:LV_REV_VALIDACION>
        }
        {
            for $FatcaDocumented in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FatcaInfo/ns1:FatcaDocumented
            return
            <ns2:LV_DOC_FATCA>{fn:data($FatcaDocumented)}</ns2:LV_DOC_FATCA>
        }
        {
            for $FatcaReports in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FatcaInfo/ns1:FatcaReports
            return
            <ns2:PV_REPT_FATCA>{fn:data($FatcaReports)}</ns2:PV_REPT_FATCA>
        }
        {
            let $IsInmigrant := fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FatcaInfo/ns1:IsInmigrant)
            return
            if ($IsInmigrant = "Yes") then (
                <ns2:PV_RES_EFC_MIGRATORIOS>S</ns2:PV_RES_EFC_MIGRATORIOS>
            ) else (
                <ns2:PV_RES_EFC_MIGRATORIOS>N</ns2:PV_RES_EFC_MIGRATORIOS>
            )
        }
        {
            for $CountryOfResidence in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:FatcaInfo/ns1:CountryOfResidence
            return
            <ns2:PN_PAIS_RES_FISCAL>{fn:data($CountryOfResidence)}</ns2:PN_PAIS_RES_FISCAL>
        }
        {
            for $AdditionalFiscalID in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "AdditionalFiscalID"]
            return
            <ns2:PV_ID_FISCAL_OTRO_PAIS>{fn:data($AdditionalFiscalID/ns1:Value)}</ns2:PV_ID_FISCAL_OTRO_PAIS>
        }
        {
            for $OtherCompanies in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "OtherCompanies"]
            return
            <ns2:PV_OTRAS_SOCIEDADES>{fn:data($OtherCompanies/ns1:Value)}</ns2:PV_OTRAS_SOCIEDADES>
        }
        {
            if ($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AccountOfficer)
            then <ns2:PV_CODIGO_USUARIO>{fn:data($CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AccountOfficer)}</ns2:PV_CODIGO_USUARIO>
            else ()
        }
        {
            for $Sector in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:Sector
            return
            <ns2:PV_TIPO_PERSONA>{fn:data($Sector)}</ns2:PV_TIPO_PERSONA>
        }
        {
            for $CompanyCode in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "CompanyCode"]
            return
            <ns2:PN_CODIGO_EMPRESA>{fn:data($CompanyCode/ns1:Value)}</ns2:PN_CODIGO_EMPRESA>
        }
        {
            for $Agency in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:Agency
            return
            <ns2:PN_CODIGO_AGENCIA>{fn:data($Agency)}</ns2:PN_CODIGO_AGENCIA>
        }
        {
            for $SubApplication in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:SubApplication
            return
            <ns2:PN_CODIGO_SUB_APLIC>{fn:data($SubApplication)}</ns2:PN_CODIGO_SUB_APLIC>
        }
        {
            for $Application in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:Application
            return
            <ns2:PV_CODIGO_APLICACION>{fn:data($Application)}</ns2:PV_CODIGO_APLICACION>
        }
        {
            for $Currency in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:Currency
            return
            <ns2:PV_MONEDA>{fn:data($Currency)}</ns2:PV_MONEDA>
        }
        {
            for $OperationType in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:OperationType
            return
            <ns2:PV_TIPO_OPERACION>{fn:data($OperationType)}</ns2:PV_TIPO_OPERACION>
        }
        {
            for $Passbook in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:Passbook
            return
            <ns2:PV_LIBRETA>{fn:data($Passbook)}</ns2:PV_LIBRETA>
        }
        {
            for $PassbookNumber in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:PassbookNumber
            return
            <ns2:PN_NUM_LIBRETA>{fn:data($PassbookNumber)}</ns2:PN_NUM_LIBRETA>
        }
        {
            for $PayrollGroup in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:PayrollGroup
            return
            <ns2:PV_CODIGO_G_PLANILLA>{fn:data($PayrollGroup)}</ns2:PV_CODIGO_G_PLANILLA>
        }
        {
            for $InitialDeposit in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:InitialDeposit
            return
            <ns2:PN_DEP_INICIAL>{fn:data($InitialDeposit)}</ns2:PN_DEP_INICIAL>
        }
        {
            for $Purpose in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:Purpose
            return
            <ns2:PV_PROPOSITO_CTA>{fn:data($Purpose)}</ns2:PV_PROPOSITO_CTA>
        }
        {
            for $OrigenOfFunds in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:OrigenOfFunds
            return
            <ns2:PV_ORIGEN_FONDOS>{fn:data($OrigenOfFunds)}</ns2:PV_ORIGEN_FONDOS>
        }
        {
            for $MonthlyTxnVolume in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:MonthlyTxnVolume
            return
            <ns2:PV_VOL_TRX_MENSUAL>{fn:data($MonthlyTxnVolume)}</ns2:PV_VOL_TRX_MENSUAL>
        }
        {
            if ($CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:BeneficiaryDetails) then (
                <ns2:TR_BENEFICIARIOS>
                {
                    for $Beneficiary in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:BeneficiaryDetails
                    return(
                        <ns2:TR_BENEFICIARIOS_ITEM>
                            <ns2:PV_NOMBRE_COMPLETO>{fn:data($Beneficiary/ns1:Name)}</ns2:PV_NOMBRE_COMPLETO>
                            <ns2:PV_TIPO_ID>{fn:data($Beneficiary/ns1:DocumentName)}</ns2:PV_TIPO_ID>
                            <ns2:PV_IDENTIDAD>{fn:data($Beneficiary/ns1:LegalId)}</ns2:PV_IDENTIDAD>
                            <ns2:PV_PARENTESCO>{fn:data($Beneficiary/ns1:Relationship)}</ns2:PV_PARENTESCO>
                            <ns2:PV_PORCENTAJE>{fn:data($Beneficiary/ns1:Percentage)}</ns2:PV_PORCENTAJE>
                            <ns2:PV_NACIONALIDAD>{fn:data($Beneficiary/ns1:Nationality)}</ns2:PV_NACIONALIDAD>
                        </ns2:TR_BENEFICIARIOS_ITEM>
                    )
                }
                </ns2:TR_BENEFICIARIOS>
            ) else ()
        }
        {
            if ($CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:SignatoryDetails) then (
                <ns2:TR_FIRMAS>
                {
                    for $Signatory in $CreateCustomerAbanksRequest/ns1:AccountInfo/ns1:SignatoryDetails
                    return(
                        <ns2:TR_FIRMAS_ITEM>
                            <ns2:PN_CANT_FIRMANTES>{fn:data($Signatory/ns1:RegisteredSignatory)}</ns2:PN_CANT_FIRMANTES>
                            <ns2:PN_CANT_FIRMAS_REQ>{fn:data($Signatory/ns1:RequiredSignatory)}</ns2:PN_CANT_FIRMAS_REQ>
                            <ns2:PN_CODIGO_CLIENTE></ns2:PN_CODIGO_CLIENTE>
                            <ns2:PN_TIPO_ID>{fn:data($Signatory/ns1:IdType)}</ns2:PN_TIPO_ID>
                            <ns2:PV_IDENTIDAD>{fn:data($Signatory/ns1:IdNumber)}</ns2:PV_IDENTIDAD>
                            <ns2:PV_NOMBRE_COMPLETO>{fn:data($Signatory/ns1:SignatoryName)}</ns2:PV_NOMBRE_COMPLETO>
                            <ns2:PV_RELACION_TITULAR>{fn:data($Signatory/ns1:Relationship)}</ns2:PV_RELACION_TITULAR>
                            <ns2:PV_CLASE_CLIENTE></ns2:PV_CLASE_CLIENTE>
                            <ns2:PV_TIPO_FIRMA>{fn:data($Signatory/ns1:SignatureType)}</ns2:PV_TIPO_FIRMA>
                            <ns2:PV_NACIONALIDAD>{fn:data($Signatory/ns1:Nationality)}</ns2:PV_NACIONALIDAD>
                        </ns2:TR_FIRMAS_ITEM>
                    )
                }
                </ns2:TR_FIRMAS>
            ) else ()
        }
        {
            for $ElectricityBill in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "ElectricityBill"]
            return
            <ns2:PN_CORRE_RECB_LUZ>{fn:data($ElectricityBill/ns1:Value)}</ns2:PN_CORRE_RECB_LUZ>
        }
        {
            for $EconomicActivity in $CreateCustomerAbanksRequest/ns1:CustomerInfo/ns1:AdditionalInfo[ns1:Name = "EconomicActivity"]
            return
            <ns2:PV_ACT_ECO_RUT>{fn:data($EconomicActivity/ns1:Value)}</ns2:PV_ACT_ECO_RUT>
        }
    </ns2:InputParameters>
};

local:func($CreateCustomerAbanksRequest, $GetCatalogsEquivalenceResponse)