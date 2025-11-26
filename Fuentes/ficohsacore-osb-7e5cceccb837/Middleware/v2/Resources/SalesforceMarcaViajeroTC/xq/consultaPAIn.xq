(:: pragma bea:global-element-parameter parameter="$salesforceMarcaViajeroTC" element="ns0:salesforceMarcaViajeroTC" location="../xsd/salesforceMarcaViajeroTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consulta" location="../../../BusinessServices/External/SalesforcePAMarcaViajeroTC/wsdl/SalesforcePAMarcaViajeroTC.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/salesforceMarcaViajeroTCTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/MarcaViajero";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SalesforceMarcaViajeroTC/xq/consultaPAIn/";

declare function xf:consultaPAIn($salesforceMarcaViajeroTC as element(ns0:salesforceMarcaViajeroTC))
    as element(ns1:Consulta) {
        <ns1:Consulta>
            <ns1:Begin_Date>{ data($salesforceMarcaViajeroTC/BEGIN_DATE) }</ns1:Begin_Date>
            <ns1:End_Date>{ data($salesforceMarcaViajeroTC/END_DATE) }</ns1:End_Date>
            <ns1:Account>{ data($salesforceMarcaViajeroTC/ACCOUNT_NUMBER) }</ns1:Account>
            <ns1:Card_Number>{ data($salesforceMarcaViajeroTC/CREDIT_CARD_NUMBER) }</ns1:Card_Number>
            <ns1:Type>ALL</ns1:Type>
            <ns1:Emails>{ data($salesforceMarcaViajeroTC/EMAILS) }</ns1:Emails>
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
        </ns1:Consulta>
};

declare variable $salesforceMarcaViajeroTC as element(ns0:salesforceMarcaViajeroTC) external;

xf:consultaPAIn($salesforceMarcaViajeroTC)