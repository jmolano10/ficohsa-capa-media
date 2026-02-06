xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$salesforceMarcaViajeroTC" element="ns0:salesforceMarcaViajeroTC" location="../xsd/salesforceMarcaViajeroTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../../Business_Resources/general/Resources/ObtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consulta" location="../../../BusinessServices/External/SalesforceHNMarcaViajeroTC/wsdl/SalesforceHNMarcaViajeroTC.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/salesforceMarcaViajeroTCTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/MarcaViajero";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SalesforceMarcaViajeroTC/xq/consultaHNIn/";

declare function xf:consultaHNIn($salesforceMarcaViajeroTC as element(ns0:salesforceMarcaViajeroTC),
    $outputParameters1 as element(ns2:OutputParameters),
    $countryCodeBank as xs:string,
    $companyName as xs:string)
    as element(ns1:Consulta) {
        <ns1:Consulta>
            <ns1:Begin_Date>{ data($salesforceMarcaViajeroTC/BEGIN_DATE) }</ns1:Begin_Date>
            <ns1:End_Date>{ data($salesforceMarcaViajeroTC/END_DATE) }</ns1:End_Date>
            <ns1:Account>{ data($salesforceMarcaViajeroTC/ACCOUNT_NUMBER) }</ns1:Account>
            <ns1:Card_Number>{ data($salesforceMarcaViajeroTC/CREDIT_CARD_NUMBER) }</ns1:Card_Number>
            <ns1:Emails>{ data($salesforceMarcaViajeroTC/EMAILS) }</ns1:Emails>
            <ns1:Type>ALL</ns1:Type>
            {
                for $COUNTRY_INFO in $salesforceMarcaViajeroTC/COUNTRIES/COUNTRY_INFO
                return
                    <ns1:Country>
                        <ns1:Country_Code>{ data($COUNTRY_INFO/COUNTRY_CODE) }</ns1:Country_Code>
                        {
                            for $COUNTRY_NAME in $COUNTRY_INFO/COUNTRY_NAME
                            return
                                <ns1:Country_Name>{ data($COUNTRY_NAME) }</ns1:Country_Name>
                        }
                    </ns1:Country>
            }
            <ns1:Destino>{ data($salesforceMarcaViajeroTC/DESTINATION) }</ns1:Destino>
            <ns1:CodigoPaisOrigen>{ data($outputParameters1/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME=$countryCodeBank]/ns2:VALUE) }</ns1:CodigoPaisOrigen>
            <ns1:EmpresaDelGrupo>{ data($outputParameters1/ns2:CONFIGURACIONES/ns2:CONFIGURACIONES_ITEM[ns2:NAME=$companyName]/ns2:VALUE) }</ns1:EmpresaDelGrupo>
        </ns1:Consulta>
};

declare variable $salesforceMarcaViajeroTC as element(ns0:salesforceMarcaViajeroTC) external;
declare variable $outputParameters1 as element(ns2:OutputParameters) external;
declare variable $countryCodeBank as xs:string external;
declare variable $companyName as xs:string external;

xf:consultaHNIn($salesforceMarcaViajeroTC,
    $outputParameters1,
    $countryCodeBank,
    $companyName)