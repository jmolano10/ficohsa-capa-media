xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$marcaViajeroTC" element="ns1:marcaViajeroTC" location="../xsd/marcaViajeroTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjMarcaViajeroTC" location="../../../BusinessServices/SJS/marcaViajeroTCGT/xsd/sjMarcaViajeroTCGTTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjMarcaViajeroTCGTTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/marcaViajeroTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MarcaViajeroTC/xq/sjMarcaViajeroTCGTIn/";

declare function xf:sjMarcaViajeroTCGTIn($sessionId as xs:string,
    $username as xs:string,
    $password as xs:string,
    $marcaViajeroTC as element(ns1:marcaViajeroTC))
    as element(ns0:sjMarcaViajeroTC) {
        <ns0:sjMarcaViajeroTC>
            <SALESFORCE_INFO>
                <USERNAME>{ $username }</USERNAME>
                <PASSWORD>{ $password }</PASSWORD>
                <SESION_ID>{ $sessionId }</SESION_ID>
            </SALESFORCE_INFO>
            {
                let $CREDIT_CARDS := $marcaViajeroTC/CREDIT_CARDS
                return
                    <CREDIT_CARDS>
                        {
                            for $CREDIT_CARD_INFORMATION in $CREDIT_CARDS/CREDIT_CARD_INFORMATION
                            return
                                <CREDIT_CARD_INFORMATION>
                                    {
                                        for $CREDIT_CARD_NUMBER in $CREDIT_CARD_INFORMATION/CREDIT_CARD_NUMBER
                                        return
                                            <CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
                                    }
                                </CREDIT_CARD_INFORMATION>
                        }
                    </CREDIT_CARDS>
            }
            <BEGIN_DATE>{ data($marcaViajeroTC/BEGIN_DATE) }</BEGIN_DATE>
            <END_DATE>{ data($marcaViajeroTC/END_DATE) }</END_DATE>
            <EMAILS>{ data($marcaViajeroTC/EMAILS) }</EMAILS>
            {
                let $COUNTRIES := $marcaViajeroTC/COUNTRIES
                return
                    <COUNTRIES>
                        {
                            for $COUNTRY_INFO in $COUNTRIES/COUNTRY_INFO
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
            }
        </ns0:sjMarcaViajeroTC>
};

declare variable $sessionId as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $marcaViajeroTC as element(ns1:marcaViajeroTC) external;

xf:sjMarcaViajeroTCGTIn($sessionId,
    $username,
    $password,
    $marcaViajeroTC)