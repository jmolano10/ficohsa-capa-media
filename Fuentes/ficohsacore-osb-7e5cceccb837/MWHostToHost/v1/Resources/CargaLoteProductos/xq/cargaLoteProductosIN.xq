(:: pragma bea:global-element-parameter parameter="$cargaLoteProductosRequest" element="ns0:cargaLoteProductosRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/cargaLoteProductos/xsd/cargaLoteProductos_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cargaLoteProductos";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/CargaLoteProductos/xq/cargaLoteProductosIN/";

declare function xf:cargaLoteProductosIN($cargaLoteProductosRequest as element(ns0:cargaLoteProductosRequest),
    $username as xs:string,
    $nameOfBusiness as xs:string,
    $colonyCode as xs:string,
    $addStreet as xs:string,
    $block as xs:string,
    $houseNumber as xs:string,
    $phone as xs:string,
    $reference as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($cargaLoteProductosRequest/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_CODIGOGRUPOPLANILLA>{ data($cargaLoteProductosRequest/PAYROLL_GROUP_ID) }</ns1:PV_CODIGOGRUPOPLANILLA>
            <ns1:PV_USUARIO>{ $username }</ns1:PV_USUARIO>
            <ns1:PN_NUMEROCLIENTES>{ fn:count($cargaLoteProductosRequest/CUSTOMERS/CUSTOMER/CUSTOMER_ID_TYPE) }</ns1:PN_NUMEROCLIENTES>
            <ns1:PV_NOMBREEMPRESA>{ $nameOfBusiness }</ns1:PV_NOMBREEMPRESA>
            <ns1:PV_DIRECCIONEMPRESA>{ $colonyCode }</ns1:PV_DIRECCIONEMPRESA>
            <ns1:PV_CALLEEMPRESA>{ $addStreet }</ns1:PV_CALLEEMPRESA>
            <ns1:PV_BLOQUEEMPRESA>{ $block }</ns1:PV_BLOQUEEMPRESA>
            <ns1:PV_CASAEMPRESA>{ $houseNumber }</ns1:PV_CASAEMPRESA>
            <ns1:PV_TELEFONO_EMPRESA>{ $phone }</ns1:PV_TELEFONO_EMPRESA>
            <ns1:PV_REFERENCIAEMPRESA>{ $reference }</ns1:PV_REFERENCIAEMPRESA>
            <ns1:PT_TIPOIDENTIFICACION>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR20_ITEM>{ data($customer/CUSTOMER_ID_TYPE) }</ns1:PT_TVARCHAR20_ITEM>
                }
            </ns1:PT_TIPOIDENTIFICACION>
            <ns1:PT_NUMEROIDENTIFICACION>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR13_ITEM>{ data($customer/LEGAL_ID) }</ns1:PT_TVARCHAR13_ITEM>
                }
            </ns1:PT_NUMEROIDENTIFICACION>
            <ns1:PT_FECHAEMISION>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TDATE_ITEM>{ data($customer/LEGAL_ID_EMISSION_DATE) }</ns1:PT_TDATE_ITEM>
                }
            </ns1:PT_FECHAEMISION>
            <ns1:PT_NOMBRECLIENTE>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR40_ITEM>{ data($customer/GIVEN_NAMES) }</ns1:PT_TVARCHAR40_ITEM>
                }
            </ns1:PT_NOMBRECLIENTE>
            <ns1:PT_APELLIDOSCLIENTE>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR40_ITEM>{ data($customer/FAMILY_NAME) }</ns1:PT_TVARCHAR40_ITEM>
                }
            </ns1:PT_APELLIDOSCLIENTE>
            <ns1:PT_FECHANACIMIENTO>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TDATE_ITEM>{ data($customer/DATE_OF_BIRTH) }</ns1:PT_TDATE_ITEM>
                }
            </ns1:PT_FECHANACIMIENTO>
            <ns1:PT_GENERO>
                {
                    for $customer  in ($cargaLoteProductosRequest/CUSTOMERS/CUSTOMER)  
                    return
                        (<ns1:PT_TNUMBER_ITEM>{ data($customer/GENDER) }</ns1:PT_TNUMBER_ITEM>)
                }
            </ns1:PT_GENERO>
            <ns1:PT_ESTADOCIVIL>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR20_ITEM>{ data($customer/MARITAL_STATUS) }</ns1:PT_TVARCHAR20_ITEM>
                }
            </ns1:PT_ESTADOCIVIL>
            <ns1:PT_DIRECCIONHOGAR>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR60_ITEM>{ data($customer/HOME_ADDRESS) }</ns1:PT_TVARCHAR60_ITEM>
                }
            </ns1:PT_DIRECCIONHOGAR>
            <ns1:PT_CELULAR>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR11_ITEM>{ data($customer/CELLULAR) }</ns1:PT_TVARCHAR11_ITEM>
                }
            </ns1:PT_CELULAR>
            <ns1:PT_TELEFONO>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR11_ITEM>{ data($customer/PHONE_NUMBER) }</ns1:PT_TVARCHAR11_ITEM>
                }
            </ns1:PT_TELEFONO>
            <ns1:PT_REFERENCIATELEFONO>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR20_ITEM>{ data($customer/PHONE_REFERENCE) }</ns1:PT_TVARCHAR20_ITEM>
                }
            </ns1:PT_REFERENCIATELEFONO>
            <ns1:PT_NIVELEDUCATIVO>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR20_ITEM>{ data($customer/EDUCATION_LEVEL) }</ns1:PT_TVARCHAR20_ITEM>
                }
            </ns1:PT_NIVELEDUCATIVO>
            <ns1:PT_PROFESION>
                {
                    for $customer  in ($cargaLoteProductosRequest/CUSTOMERS/CUSTOMER)  
                    return
                        (<ns1:PT_TNUMBER_ITEM>{ data($customer/PROFESSION) }</ns1:PT_TNUMBER_ITEM>)
                }
            </ns1:PT_PROFESION>
            <ns1:PT_FECHAINGRESOEMPRESA>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TDATE_ITEM>{ data($customer/START_DAY_JOB) }</ns1:PT_TDATE_ITEM>
                }
            </ns1:PT_FECHAINGRESOEMPRESA>
            <ns1:PT_CARGO>
                {
                    for $customer  in ($cargaLoteProductosRequest/CUSTOMERS/CUSTOMER)  
                    return
                        (<ns1:PT_TNUMBER_ITEM>{ data($customer/JOB_TITTLE) }</ns1:PT_TNUMBER_ITEM>)
                }
            </ns1:PT_CARGO>
            <ns1:PT_MONEDAINGRESO>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR3_ITEM>{ data($customer/INCOME_CURRENCY) }</ns1:PT_TVARCHAR3_ITEM>
                }
            </ns1:PT_MONEDAINGRESO>
            <ns1:PT_MONTOINGRESO>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR20_ITEM>{ data($customer/INCOME_AMOUNT) }</ns1:PT_TVARCHAR20_ITEM>
                }
            </ns1:PT_MONTOINGRESO>
            <ns1:PT_NOMBRECONYUGUE>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR40_ITEM>{ data($customer/MARRIED_NAME) }</ns1:PT_TVARCHAR40_ITEM>
                }
            </ns1:PT_NOMBRECONYUGUE>
            <ns1:PT_APELLIDOSCONYUGUE>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR40_ITEM>{ data($customer/MARRIED_LASTNAME) }</ns1:PT_TVARCHAR40_ITEM>
                }
            </ns1:PT_APELLIDOSCONYUGUE>
            <ns1:PT_NOMBREREFERENCIA>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR40_ITEM>{ data($customer/REFERENCE_NAME) }</ns1:PT_TVARCHAR40_ITEM>
                }
            </ns1:PT_NOMBREREFERENCIA>
            <ns1:PT_APELLIDOSREFERENCIA>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR40_ITEM>{ data($customer/REFERENCE_LASTNAME) }</ns1:PT_TVARCHAR40_ITEM>
                }
            </ns1:PT_APELLIDOSREFERENCIA>
            <ns1:PT_TELEFONOREFERENCIA>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR11_ITEM>{ data($customer/REFERENCE_PHONE) }</ns1:PT_TVARCHAR11_ITEM>
                }
            </ns1:PT_TELEFONOREFERENCIA>
            <ns1:PT_PARENTESCOREFERENCIA>
                {
                    for $customer  in ($cargaLoteProductosRequest/CUSTOMERS/CUSTOMER)  
                    return
                        (<ns1:PT_TNUMBER_ITEM>{ data($customer/REFERENCE_RELATIONSHIP) }</ns1:PT_TNUMBER_ITEM>)
                }
            </ns1:PT_PARENTESCOREFERENCIA>
            <ns1:PT_NOMBREBENEFICIARIO>
                {
                    for $customer in $cargaLoteProductosRequest/CUSTOMERS/CUSTOMER
                    return
                        <ns1:PT_TVARCHAR50_ITEM>{ data($customer/BENEFICIARY_NAME) }</ns1:PT_TVARCHAR50_ITEM>
                }
            </ns1:PT_NOMBREBENEFICIARIO>
            <ns1:PT_PARENTESCOBENEFICIARIO>
                {
                    for $customer  in ($cargaLoteProductosRequest/CUSTOMERS/CUSTOMER)  
                    return
                        (<ns1:PT_TNUMBER_ITEM>{ data($customer/BENEFICIARY_RELATIONSHIP) }</ns1:PT_TNUMBER_ITEM>)
                }
            </ns1:PT_PARENTESCOBENEFICIARIO>
        </ns1:InputParameters>
};

declare variable $cargaLoteProductosRequest as element(ns0:cargaLoteProductosRequest) external;
declare variable $username as xs:string external;
declare variable $nameOfBusiness as xs:string external;
declare variable $colonyCode as xs:string external;
declare variable $addStreet as xs:string external;
declare variable $block as xs:string external;
declare variable $houseNumber as xs:string external;
declare variable $phone as xs:string external;
declare variable $reference as xs:string external;

xf:cargaLoteProductosIN($cargaLoteProductosRequest,
    $username,
    $nameOfBusiness,
    $colonyCode,
    $addStreet,
    $block,
    $houseNumber,
    $phone,
    $reference)
