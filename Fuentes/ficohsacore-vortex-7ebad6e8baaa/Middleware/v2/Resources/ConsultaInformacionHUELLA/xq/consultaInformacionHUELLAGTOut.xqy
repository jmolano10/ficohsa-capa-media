xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaInformacionHuellaResponse" element="ns1:consultaInformacionHuellaResponse" location="../../../BusinessServices/OIC/consultaInformacionHUELLA/xsd/XMLSchema_1993028425.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionHUELLAResponse" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionHuellaTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionHUELLA/xq/consultaInformacionHUELLAGTOut/";

declare function xf:consultaInformacionHUELLAGTOut($consultaInformacionHuellaResponse as element(ns1:consultaInformacionHuellaResponse))
    as element(ns0:consultaInformacionHUELLAResponse) {
        <ns0:consultaInformacionHUELLAResponse>
            <DATE>{ data($consultaInformacionHuellaResponse/DATE) }</DATE>
            <HIT>{ data($consultaInformacionHuellaResponse/HIT) }</HIT>
            <SIZE>{ data($consultaInformacionHuellaResponse/SIZE) }</SIZE>
            {
                for $DEATH_DATE in $consultaInformacionHuellaResponse/DEATH_DATE
                return
                    <DEATH_DATE>{ data($DEATH_DATE) }</DEATH_DATE>
            }
            <OCCUPATION>{ data($consultaInformacionHuellaResponse/OCCUPATION) }</OCCUPATION>
            <MUNICIPALITY_OF_BIRTH>{ data($consultaInformacionHuellaResponse/MUNICIPALITY_OF_BIRTH) }</MUNICIPALITY_OF_BIRTH>
            <PHOTOGRAPHY>{ data($consultaInformacionHuellaResponse/PHOTOGRAPHY) }</PHOTOGRAPHY>
            <COUNTRY_OF_BIRTH>{ data($consultaInformacionHuellaResponse/COUNTRY_OF_BIRTH) }</COUNTRY_OF_BIRTH>
            {
                for $LEGAL_ID_ORDER in $consultaInformacionHuellaResponse/LEGAL_ID_ORDER
                return
                    <LEGAL_ID_ORDER>{ data($LEGAL_ID_ORDER) }</LEGAL_ID_ORDER>
            }
            {
                for $THIRD_NAME in $consultaInformacionHuellaResponse/THIRD_NAME
                return
                    <THIRD_NAME>{ data($THIRD_NAME) }</THIRD_NAME>
            }
            <GENDER>{ data($consultaInformacionHuellaResponse/GENDER) }</GENDER>
            <LAST_NAME>{ data($consultaInformacionHuellaResponse/LAST_NAME) }</LAST_NAME>
            <NATIONALITY>{ data($consultaInformacionHuellaResponse/NATIONALITY) }</NATIONALITY>
            <DEPARTMENT_OF_BIRTH>{ data($consultaInformacionHuellaResponse/DEPARTMENT_OF_BIRTH) }</DEPARTMENT_OF_BIRTH>
            <MESSAGE>{ data($consultaInformacionHuellaResponse/MESSAGE) }</MESSAGE>
            <SECOND_NAME>{ data($consultaInformacionHuellaResponse/SECOND_NAME) }</SECOND_NAME>
            {
                for $LEGAL_ID_REGISTRATION in $consultaInformacionHuellaResponse/LEGAL_ID_REGISTRATION
                return
                    <LEGAL_ID_REGISTRATION>{ data($LEGAL_ID_REGISTRATION) }</LEGAL_ID_REGISTRATION>
            }
            <FIRST_NAME>{ data($consultaInformacionHuellaResponse/FIRST_NAME) }</FIRST_NAME>
            <SECOND_LAST_NAME>{ data($consultaInformacionHuellaResponse/SECOND_LAST_NAME) }</SECOND_LAST_NAME>
            <CUI>{ data($consultaInformacionHuellaResponse/CUI) }</CUI>
            <CIVIL_STATUS>{ data($consultaInformacionHuellaResponse/CIVIL_STATUS) }</CIVIL_STATUS>
            {
                for $LAST_NAME_MARRIED in $consultaInformacionHuellaResponse/LAST_NAME_MARRIED
                return
                    <LAST_NAME_MARRIED>{ data($LAST_NAME_MARRIED) }</LAST_NAME_MARRIED>
            }
            <BIRTH_DATE>{ data($consultaInformacionHuellaResponse/BIRTH_DATE) }</BIRTH_DATE>
            <EXPIRATION_DATE>{ data($consultaInformacionHuellaResponse/EXPIRATION_DATE) }</EXPIRATION_DATE>
            <CORRELATIVE_DPI>{ data($consultaInformacionHuellaResponse/CORRELATIVE_DPI) }</CORRELATIVE_DPI>
            <NEIGHBORHOOD>{ data($consultaInformacionHuellaResponse/NEIGHBORHOOD) }</NEIGHBORHOOD>
            <HOUR>{ data($consultaInformacionHuellaResponse/HOUR) }</HOUR>
            <REFERENCE>{ data($consultaInformacionHuellaResponse/REFERENCE) }</REFERENCE>
        </ns0:consultaInformacionHUELLAResponse>
};

declare variable $consultaInformacionHuellaResponse as element(ns1:consultaInformacionHuellaResponse) external;

xf:consultaInformacionHUELLAGTOut($consultaInformacionHuellaResponse)