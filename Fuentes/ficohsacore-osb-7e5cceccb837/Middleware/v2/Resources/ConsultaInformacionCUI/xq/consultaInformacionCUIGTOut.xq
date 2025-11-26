(:: pragma bea:global-element-parameter parameter="$consultaInformacionCUIResponse" element="ns0:consultaInformacionCUIResponse" location="../../../BusinessServices/OIC/consultaInformacionCUI/xsd/XMLSchema_-198101730.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaInformacionCUIResponse" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionCUITypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionCUI/xq/consultaInformacionCUIGTOut/";

declare function xf:consultaInformacionCUIGTOut($consultaInformacionCUIResponse as element(ns0:consultaInformacionCUIResponse))
    as element(ns1:consultaInformacionCUIResponse) {
        <ns1:consultaInformacionCUIResponse>
            <DATE>{ data($consultaInformacionCUIResponse/DATE) }</DATE>
            <HIT>{ data($consultaInformacionCUIResponse/HIT) }</HIT>
            <SIZE>{ data($consultaInformacionCUIResponse/SIZE) }</SIZE>
            {
                for $DEATH_DATE in $consultaInformacionCUIResponse/DEATH_DATE
                return
                    <DEATH_DATE>{ data($DEATH_DATE) }</DEATH_DATE>
            }
            <OCCUPATION>{ data($consultaInformacionCUIResponse/OCCUPATION) }</OCCUPATION>
            <MUNICIPALITY_OF_BIRTH>{ data($consultaInformacionCUIResponse/MUNICIPALITY_OF_BIRTH) }</MUNICIPALITY_OF_BIRTH>
            <PHOTOGRAPHY>{ data($consultaInformacionCUIResponse/PHOTOGRAPHY) }</PHOTOGRAPHY>
            <COUNTRY_OF_BIRTH>{ data($consultaInformacionCUIResponse/COUNTRY_OF_BIRTH) }</COUNTRY_OF_BIRTH>
            {
                for $LEGAL_ID_ORDER in $consultaInformacionCUIResponse/LEGAL_ID_ORDER
                return
                    <LEGAL_ID_ORDER>{ data($LEGAL_ID_ORDER) }</LEGAL_ID_ORDER>
            }
            {
                for $THIRD_NAME in $consultaInformacionCUIResponse/THIRD_NAME
                return
                    <THIRD_NAME>{ data($THIRD_NAME) }</THIRD_NAME>
            }
            <GENDER>{ data($consultaInformacionCUIResponse/GENDER) }</GENDER>
            <LAST_NAME>{ data($consultaInformacionCUIResponse/LAST_NAME) }</LAST_NAME>
            <NATIONALITY>{ data($consultaInformacionCUIResponse/NATIONALITY) }</NATIONALITY>
            <DEPARTMENT_OF_BIRTH>{ data($consultaInformacionCUIResponse/DEPARTMENT_OF_BIRTH) }</DEPARTMENT_OF_BIRTH>
            <MESSAGE>{ data($consultaInformacionCUIResponse/MESSAGE) }</MESSAGE>
            <SECOND_NAME>{ data($consultaInformacionCUIResponse/SECOND_NAME) }</SECOND_NAME>
            {
                for $LEGAL_ID_REGISTRATION in $consultaInformacionCUIResponse/LEGAL_ID_REGISTRATION
                return
                    <LEGAL_ID_REGISTRATION>{ data($LEGAL_ID_REGISTRATION) }</LEGAL_ID_REGISTRATION>
            }
            <FIRST_NAME>{ data($consultaInformacionCUIResponse/FIRST_NAME) }</FIRST_NAME>
            <SECOND_LAST_NAME>{ data($consultaInformacionCUIResponse/SECOND_LAST_NAME) }</SECOND_LAST_NAME>
            <CUI>{ data($consultaInformacionCUIResponse/CUI) }</CUI>
            <CIVIL_STATUS>{ data($consultaInformacionCUIResponse/CIVIL_STATUS) }</CIVIL_STATUS>
            {
                for $LAST_NAME_MARRIED in $consultaInformacionCUIResponse/LAST_NAME_MARRIED
                return
                    <LAST_NAME_MARRIED>{ data($LAST_NAME_MARRIED) }</LAST_NAME_MARRIED>
            }
            <EXPIRATION_DATE>{ data($consultaInformacionCUIResponse/EXPIRATION_DATE) }</EXPIRATION_DATE>
            <CORRELATIVE_DPI>{ data($consultaInformacionCUIResponse/CORRELATIVE_DPI) }</CORRELATIVE_DPI>
            <BIRTH_DATE>{ data($consultaInformacionCUIResponse/BIRTH_DATE) }</BIRTH_DATE>
            <NEIGHBORHOOD>{ data($consultaInformacionCUIResponse/NEIGHBORHOOD) }</NEIGHBORHOOD>
            <HOUR>{ data($consultaInformacionCUIResponse/HOUR) }</HOUR>
            <REFERENCE>{ data($consultaInformacionCUIResponse/REFERENCE) }</REFERENCE>
        </ns1:consultaInformacionCUIResponse>
};

declare variable $consultaInformacionCUIResponse as element(ns0:consultaInformacionCUIResponse) external;

xf:consultaInformacionCUIGTOut($consultaInformacionCUIResponse)
