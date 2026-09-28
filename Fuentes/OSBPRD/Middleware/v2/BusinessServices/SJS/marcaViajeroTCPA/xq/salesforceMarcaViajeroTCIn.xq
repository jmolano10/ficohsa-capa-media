(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCreditoResponse1" element="ns2:consultaDatosTarjetaCreditoResponse" location="../../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjMarcaViajeroTC" element="ns0:sjMarcaViajeroTC" location="../xsd/sjMarcaViajeroTCPATypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:salesforceMarcaViajeroTC" location="../../../../Resources/SalesforceMarcaViajeroTC/xsd/salesforceMarcaViajeroTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjMarcaViajeroTCPATypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/salesforceMarcaViajeroTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/marcaViajeroTCPA/xq/salesforceMarcaViajeroTCIn/";

declare function xf:salesforceMarcaViajeroTCIn($consultaDatosTarjetaCreditoResponse1 as element(ns2:consultaDatosTarjetaCreditoResponse),
    $sjMarcaViajeroTC as element(ns0:sjMarcaViajeroTC))
    as element(ns1:salesforceMarcaViajeroTC) {
        <ns1:salesforceMarcaViajeroTC>
            {
                let $SALESFORCE_INFO := $sjMarcaViajeroTC/SALESFORCE_INFO
                return
                    <SALESFORCE_INFO>
                        <USERNAME>{ data($SALESFORCE_INFO/USERNAME) }</USERNAME>
                        <PASSWORD>{ data($SALESFORCE_INFO/PASSWORD) }</PASSWORD>
                        <SESION_ID>{ data($SALESFORCE_INFO/SESION_ID) }</SESION_ID>
                    </SALESFORCE_INFO>
            }
            <CREDIT_CARD_NUMBER>{ data($consultaDatosTarjetaCreditoResponse1/ns2:consultaDatosTarjetaCreditoResponseType/ns2:consultaDatosTarjetaCreditoResponseRecordType[1]/CARD_NUMBER) }</CREDIT_CARD_NUMBER>
            <ACCOUNT_NUMBER>{ data($consultaDatosTarjetaCreditoResponse1/ns2:consultaDatosTarjetaCreditoResponseType/ns2:consultaDatosTarjetaCreditoResponseRecordType[1]/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <BEGIN_DATE>{ data($sjMarcaViajeroTC/BEGIN_DATE) }</BEGIN_DATE>
            <END_DATE>{ data($sjMarcaViajeroTC/END_DATE) }</END_DATE>
            <EMAILS>{ data($sjMarcaViajeroTC/EMAILS) }</EMAILS>
            <COUNTRIES>
                {
                    for $COUNTRY_INFO in $sjMarcaViajeroTC/COUNTRIES/COUNTRY_INFO
                    return
                        <COUNTRY_INFO>
                            <COUNTRY_CODE>{ data($COUNTRY_INFO/COUNTRY_CODE) }</COUNTRY_CODE>
                            {
                                for $COUNTRY_NAME in $COUNTRY_INFO/COUNTRY_NAME
                                return
                                    <COUNTRY_NAME>{ data($COUNTRY_NAME) }</COUNTRY_NAME>
                            }
                        </COUNTRY_INFO>
                }
            </COUNTRIES>
        </ns1:salesforceMarcaViajeroTC>
};

declare variable $consultaDatosTarjetaCreditoResponse1 as element(ns2:consultaDatosTarjetaCreditoResponse) external;
declare variable $sjMarcaViajeroTC as element(ns0:sjMarcaViajeroTC) external;

xf:salesforceMarcaViajeroTCIn($consultaDatosTarjetaCreditoResponse1,
    $sjMarcaViajeroTC)