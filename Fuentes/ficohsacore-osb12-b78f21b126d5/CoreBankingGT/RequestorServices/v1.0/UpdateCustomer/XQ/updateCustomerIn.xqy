xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogsEquivalence";
(:: import schema at "../../../../../CoreBankingHN/ProviderServices/XSD/GetCatalogsEquivalence/GetCatalogsEquivalence_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/UpdateCustomer_BS";
(:: import schema at "../../../../ProviderServices/XSD/UpdateCustomer/UpdateCustomer_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $updateCustomerRequest as element() (:: schema-element(ns1:updateCustomerRequest) ::) external;
declare variable $getCatalogsEquivalenceResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;

declare function local:CatalogValueOSBToAPP($value as xs:string,
	$application as xs:string,
	$catalogId as xs:string,
	$catalogEquivalencies as element(*)
) as xs:string {
	let $responseCatalog := $catalogEquivalencies/ns2:PT_EQUIVALENCIAS_SALIDA/ns2:PT_EQUIVALENCIAS_SALIDA_ITEM[ns2:CATALOGO_ID = $catalogId and 
                                                     ns2:EQUIVALENCIAS/ns2:EQUIVALENCIAS_ITEM/ns2:APLICACION = $application and 
                                                              ns2:VALOR_CATALOGO = $value]
															  
	let $return := fn:string($responseCatalog[1]/ns2:EQUIVALENCIAS/ns2:EQUIVALENCIAS_ITEM/ns2:VALOR_EQUIVALENCIA/text())
	return
		if($return != '') then (
			$return
		) else (
			$value
		)
};

declare function xq:updateCustomerIn($updateCustomerRequest as element() (:: schema-element(ns1:updateCustomerRequest) ::), 
                                     $getCatalogsEquivalenceResponse as element() (:: schema-element(ns2:OutputParameters) ::)) 
                                     as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        {
            for $customerId in $updateCustomerRequest/ns1:CustomerId
            return
            <ns3:PN_CODIGO_CLIENTE>{fn:data($customerId)}</ns3:PN_CODIGO_CLIENTE>
        }
        {
            for $idList in $updateCustomerRequest/ns1:CustomerInfo/ns1:IdList[ns1:DocumentName = 'DOCTO PERSONAL DE ID (DPI)']
            return
            <ns3:PV_NUMERO_IDENTIFICACION>{fn:data($idList/ns1:LegalId)}</ns3:PV_NUMERO_IDENTIFICACION>
        }        
        {
            for $idList in $updateCustomerRequest/ns1:CustomerInfo/ns1:IdList[ns1:DocumentName = 'NUMERO DE ID TRIBUTA (NIT)']
            return
            <ns3:PV_NIT>{fn:data($idList/ns1:LegalId)}</ns3:PV_NIT>
        }
        {
            if (exists($updateCustomerRequest/ns1:ContactInfo/ns1:AddressList) or exists ($updateCustomerRequest/ns1:ContactInfo/ns1:EmailList) or exists($updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList))
            then (
                <ns3:PT_DIRECCIONES>
                {
                    if (exists($updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1']) or exists ($updateCustomerRequest/ns1:ContactInfo/ns1:EmailList[fn:upper-case(ns1:Type) = '1']) or exists($updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Location) = '1'])  or exists($updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Ismain) = 'YES']))
                        then (
                            <ns3:PT_DIRECCIONES_ITEM>
                                <ns3:PN_CODIGO_DIRECCION>{ '1' }</ns3:PN_CODIGO_DIRECCION>
                            {
                                for $addressReferences in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1'][1]/ns1:References
                                return
                                <ns3:PV_REFERENCIA>{fn:data($addressReferences)}</ns3:PV_REFERENCIA>
                            }
                            {
                                if (exists($updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Ismain) = 'YES'][1]))
                                    then (
                                        for $phoneList in $updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Ismain) = 'YES'][1]
                                        return
                                        (
                                            if (fn:upper-case(fn:data($phoneList/ns1:Type))='MOBILE') then (
                                                <ns3:PV_CELULAR>{fn:data($phoneList/ns1:Number)}</ns3:PV_CELULAR>
                                            ) else ()
                                        )
                                        
                                ) else (
                                    for $phoneList in $updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Location) = '1'][1]
                                    return
                                    (
                                        if (fn:upper-case(fn:data($phoneList/ns1:Type))='MOBILE') then (
                                            <ns3:PV_CELULAR>{fn:data($phoneList/ns1:Number)}</ns3:PV_CELULAR>
                                        ) else ()
                                    )
                                )
                            }
                            {
                                for $email in $updateCustomerRequest/ns1:ContactInfo/ns1:EmailList[fn:upper-case(ns1:Type) = '1'][1]/ns1:Email
                                return
                                <ns3:PV_EMAIL>{fn:data($email)}</ns3:PV_EMAIL>
                            }
                            {
                                for $addressCountryCode in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1'][1]/ns1:CountryCode
                                return
                                <ns3:PN_CODIGO_PAIS_UPD>{ local:CatalogValueOSBToAPP(fn:upper-case(fn:data($addressCountryCode)), 'ABANKSGT', '9', $getCatalogsEquivalenceResponse) }</ns3:PN_CODIGO_PAIS_UPD>
                            }
                            {
                                for $addressStateCode in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1'][1]/ns1:StateCode
                                return
                                <ns3:PN_CODIGO_DEPTO_UPD>{ local:CatalogValueOSBToAPP(fn:upper-case(fn:data($addressStateCode)), 'ABANKSGT', '8', $getCatalogsEquivalenceResponse) }</ns3:PN_CODIGO_DEPTO_UPD>
                            }
                            {
                                for $addressCityCode in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1'][1]/ns1:CityCode
                                return
                                <ns3:PN_CODIGO_MUNICIPIO_UPD>{ local:CatalogValueOSBToAPP(fn:upper-case(fn:data($addressCityCode)), 'ABANKSGT', '7', $getCatalogsEquivalenceResponse) }</ns3:PN_CODIGO_MUNICIPIO_UPD>
                            }
                            {
                                for $addressHouseNumber in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1'][1]/ns1:HouseNumber
                                return
                                <ns3:PV_NUMERO_CASA>{fn:data($addressHouseNumber)}</ns3:PV_NUMERO_CASA>
                            }
                            {
                                for $addressAvenue in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1'][1]/ns1:Avenue
                                return
                                <ns3:PV_AVENIDA1_UPD>{fn:data($addressAvenue)}</ns3:PV_AVENIDA1_UPD>
                            }
                            {
                                for $addressStreet in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1'][1]/ns1:Street
                                return
                                <ns3:PV_CALLE_UPD>{fn:data($addressStreet)}</ns3:PV_CALLE_UPD>
                            }
                            {
                                for $addressZone in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1'][1]/ns1:Zone
                                return
                                <ns3:PN_ZONA_UPD>{fn:data($addressZone)}</ns3:PN_ZONA_UPD>
                            }
                            {
                                for $addressNeighborhood in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '1'][1]/ns1:Neighborhood
                                return
                                <ns3:PV_BARRIO_UPD>{fn:data($addressNeighborhood)}</ns3:PV_BARRIO_UPD>
                            }
                            </ns3:PT_DIRECCIONES_ITEM>
                    ) else ()
                }
                {
                    if (exists($updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2']) or exists ($updateCustomerRequest/ns1:ContactInfo/ns1:EmailList[fn:upper-case(ns1:Type) = '2']) or exists($updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Location) = '2']))
                        then (
                            <ns3:PT_DIRECCIONES_ITEM>
                                <ns3:PN_CODIGO_DIRECCION>{ '2' }</ns3:PN_CODIGO_DIRECCION>
                            {
                                for $addressReferences in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2'][1]/ns1:References
                                return
                                <ns3:PV_REFERENCIA>{fn:data($addressReferences)}</ns3:PV_REFERENCIA>
                            }
                            {
                                for $phoneList in $updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Location) = '2'][1]
                                return
                                (
                                    if (fn:upper-case(fn:data($phoneList/ns1:Type))='MOBILE') then (
                                        <ns3:PV_CELULAR>{fn:data($phoneList/ns1:Number)}</ns3:PV_CELULAR>
                                    ) else ()
                                )
                            }
                            {
                                for $email in $updateCustomerRequest/ns1:ContactInfo/ns1:EmailList[fn:upper-case(ns1:Type) = '2'][1]/ns1:Email
                                return
                                <ns3:PV_EMAIL>{fn:data($email)}</ns3:PV_EMAIL>
                            }
                            {
                                for $addressCountryCode in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2'][1]/ns1:CountryCode
                                return
                                <ns3:PN_CODIGO_PAIS_UPD>{ local:CatalogValueOSBToAPP(fn:upper-case(fn:data($addressCountryCode)), 'ABANKSGT', '9', $getCatalogsEquivalenceResponse) }</ns3:PN_CODIGO_PAIS_UPD>
                            }
                            {
                                for $addressStateCode in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2'][1]/ns1:StateCode
                                return
                                <ns3:PN_CODIGO_DEPTO_UPD>{ local:CatalogValueOSBToAPP(fn:upper-case(fn:data($addressStateCode)), 'ABANKSGT', '8', $getCatalogsEquivalenceResponse) }</ns3:PN_CODIGO_DEPTO_UPD>
                            }
                            {
                                for $addressCityCode in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2'][1]/ns1:CityCode
                                return
                                <ns3:PN_CODIGO_MUNICIPIO_UPD>{ local:CatalogValueOSBToAPP(fn:upper-case(fn:data($addressCityCode)), 'ABANKSGT', '7', $getCatalogsEquivalenceResponse) }</ns3:PN_CODIGO_MUNICIPIO_UPD>
                            }
                            {
                                for $addressHouseNumber in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2'][1]/ns1:HouseNumber
                                return
                                <ns3:PV_NUMERO_CASA>{fn:data($addressHouseNumber)}</ns3:PV_NUMERO_CASA>
                            }
                            {
                                for $addressAvenue in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2'][1]/ns1:Avenue
                                return
                                <ns3:PV_AVENIDA1_UPD>{fn:data($addressAvenue)}</ns3:PV_AVENIDA1_UPD>
                            }
                            {
                                for $addressStreet in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2'][1]/ns1:Street
                                return
                                <ns3:PV_CALLE_UPD>{fn:data($addressStreet)}</ns3:PV_CALLE_UPD>
                            }
                            {
                                for $addressZone in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2'][1]/ns1:Zone
                                return
                                <ns3:PN_ZONA_UPD>{fn:data($addressZone)}</ns3:PN_ZONA_UPD>
                            }
                            {
                                for $addressNeighborhood in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '2'][1]/ns1:Neighborhood
                                return
                                <ns3:PV_BARRIO_UPD>{fn:data($addressNeighborhood)}</ns3:PV_BARRIO_UPD>
                            }
                            </ns3:PT_DIRECCIONES_ITEM>
                    ) else ()
                }
                {
                    if (exists($updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3']) or exists ($updateCustomerRequest/ns1:ContactInfo/ns1:EmailList[fn:upper-case(ns1:Type) = '3']) or exists($updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Location) = '3']))
                        then (
                            <ns3:PT_DIRECCIONES_ITEM>
                                <ns3:PN_CODIGO_DIRECCION>{ '3' }</ns3:PN_CODIGO_DIRECCION>
                            {
                                for $addressReferences in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3'][1]/ns1:References
                                return
                                <ns3:PV_REFERENCIA>{fn:data($addressReferences)}</ns3:PV_REFERENCIA>
                            }
                            {
                                for $phoneList in $updateCustomerRequest/ns1:ContactInfo/ns1:PhoneList[fn:upper-case(ns1:Location) = '3'][1]
                                return
                                (
                                    if (fn:upper-case(fn:data($phoneList/ns1:Type))='MOBILE') then (
                                        <ns3:PV_CELULAR>{fn:data($phoneList/ns1:Number)}</ns3:PV_CELULAR>
                                    ) else ()
                                )
                            }
                            {
                                for $email in $updateCustomerRequest/ns1:ContactInfo/ns1:EmailList[fn:upper-case(ns1:Type) = '3'][1]/ns1:Email
                                return
                                <ns3:PV_EMAIL>{fn:data($email)}</ns3:PV_EMAIL>
                            }
                            {
                                for $addressCountryCode in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3'][1]/ns1:CountryCode
                                return
                                <ns3:PN_CODIGO_PAIS_UPD>{ local:CatalogValueOSBToAPP(fn:upper-case(fn:data($addressCountryCode)), 'ABANKSGT', '9', $getCatalogsEquivalenceResponse) }</ns3:PN_CODIGO_PAIS_UPD>
                            }
                            {
                                for $addressStateCode in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3'][1]/ns1:StateCode
                                return
                                <ns3:PN_CODIGO_DEPTO_UPD>{ local:CatalogValueOSBToAPP(fn:upper-case(fn:data($addressStateCode)), 'ABANKSGT', '8', $getCatalogsEquivalenceResponse) }</ns3:PN_CODIGO_DEPTO_UPD>
                            }
                            {
                                for $addressCityCode in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3'][1]/ns1:CityCode
                                return
                                <ns3:PN_CODIGO_MUNICIPIO_UPD>{ local:CatalogValueOSBToAPP(fn:upper-case(fn:data($addressCityCode)), 'ABANKSGT', '7', $getCatalogsEquivalenceResponse) }</ns3:PN_CODIGO_MUNICIPIO_UPD>
                            }
                            {
                                for $addressHouseNumber in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3'][1]/ns1:HouseNumber
                                return
                                <ns3:PV_NUMERO_CASA>{fn:data($addressHouseNumber)}</ns3:PV_NUMERO_CASA>
                            }
                            {
                                for $addressAvenue in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3'][1]/ns1:Avenue
                                return
                                <ns3:PV_AVENIDA1_UPD>{fn:data($addressAvenue)}</ns3:PV_AVENIDA1_UPD>
                            }
                            {
                                for $addressStreet in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3'][1]/ns1:Street
                                return
                                <ns3:PV_CALLE_UPD>{fn:data($addressStreet)}</ns3:PV_CALLE_UPD>
                            }
                            {
                                for $addressZone in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3'][1]/ns1:Zone
                                return
                                <ns3:PN_ZONA_UPD>{fn:data($addressZone)}</ns3:PN_ZONA_UPD>
                            }
                            {
                                for $addressNeighborhood in $updateCustomerRequest/ns1:ContactInfo/ns1:AddressList[fn:upper-case(ns1:Type) = '3'][1]/ns1:Neighborhood
                                return
                                <ns3:PV_BARRIO_UPD>{fn:data($addressNeighborhood)}</ns3:PV_BARRIO_UPD>
                            }
                            </ns3:PT_DIRECCIONES_ITEM>
                    ) else ()
                }
                </ns3:PT_DIRECCIONES>
            ) else ()
        }
        {
            let $MaritalStatus := fn:upper-case(fn:data($updateCustomerRequest/ns1:CustomerInfo/ns1:MaritalStatus))
            return
            <ns3:PV_ESTADO_CIVIL>{ local:CatalogValueOSBToAPP($MaritalStatus, 'ABANKSGT', '2', $getCatalogsEquivalenceResponse) }</ns3:PV_ESTADO_CIVIL>

        }
        {
            for $companyName in $updateCustomerRequest/ns1:IncomeSourceList/ns1:CompanyName
            return
            <ns3:PV_NOMBRE_EMPRESA>{fn:data($companyName)}</ns3:PV_NOMBRE_EMPRESA>
        }
        {
            for $isEmployed in $updateCustomerRequest/ns1:IncomeSourceList/ns1:CurrentlyEmployed
            return (
                if (fn:upper-case(fn:data($isEmployed))='YES')
                then <ns3:PV_TRABAJA>S</ns3:PV_TRABAJA>
                else if (fn:upper-case(fn:data($isEmployed))='NO')
                then  <ns3:PV_TRABAJA>N</ns3:PV_TRABAJA>
                else ()
            )
        }
        {
            let $ProfessionCode := fn:data($updateCustomerRequest/ns1:IncomeSourceList/ns1:ProfessionCode)
            return         
            <ns3:PN_CODIGO_PROFESION>{fn:data($updateCustomerRequest/ns1:IncomeSourceList/ns1:ProfessionCode)}</ns3:PN_CODIGO_PROFESION>
        }
        <ns3:PV_CARGO>{fn:data($updateCustomerRequest/ns1:IncomeSourceList/ns1:JobTitle)}</ns3:PV_CARGO>
        <ns3:PN_INGRESOS>{fn:data($updateCustomerRequest/ns1:IncomeSourceList/ns1:IncomeRange)}</ns3:PN_INGRESOS>        
    </ns3:InputParameters>
};  

xq:updateCustomerIn($updateCustomerRequest, $getCatalogsEquivalenceResponse)