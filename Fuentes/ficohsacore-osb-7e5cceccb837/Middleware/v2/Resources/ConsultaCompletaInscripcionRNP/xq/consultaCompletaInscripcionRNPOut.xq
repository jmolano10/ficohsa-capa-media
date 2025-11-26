(:: pragma bea:global-element-parameter parameter="$consultaCompletaInscripcionResponse1" element="ns0:consultaCompletaInscripcionResponse" location="../../../BusinessServices/RNP/consultaCompletaInscripcion/xsd/consultaCompletaInscripcionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCompletaInscripcionResponse" location="../../InscripcionesRNP/xsd/inscripcionesRNPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/inscripcionesRNPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCompletaInscripcionRNP/xq/consultaCompletaInscripcionRNPOut/";

declare function xf:consultaCompletaInscripcionRNPOut($consultaCompletaInscripcionResponse1 as element(ns0:consultaCompletaInscripcionResponse))
    as element(ns0:consultaCompletaInscripcionResponse) {
        <ns0:consultaCompletaInscripcionResponse>
            <PERSONAL_INFORMATION>
                {
                    for $INSCRIPTION_NUMBER in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/INSCRIPTION_NUMBER
                    return
                        <INSCRIPTION_NUMBER>{ data($INSCRIPTION_NUMBER) }</INSCRIPTION_NUMBER>
                }
                {
                    for $GIVEN_NAMES in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/GIVEN_NAMES
                    return
                        <GIVEN_NAMES>{ data($GIVEN_NAMES) }</GIVEN_NAMES>
                }
                {
                    for $LAST_NAME in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/LAST_NAME
                    return
                        <LAST_NAME>{ data($LAST_NAME) }</LAST_NAME>
                }
                {
                    for $SECOND_SURNAME in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/SECOND_SURNAME
                    return
                        <SECOND_SURNAME>{ data($SECOND_SURNAME) }</SECOND_SURNAME>
                }
                {
                    for $GENDER in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/GENDER
                    return
                        <GENDER>{ data($GENDER) }</GENDER>
                }
                {
                    for $DATE_OF_BIRTH in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/DATE_OF_BIRTH
                    return
                        <DATE_OF_BIRTH>{ data($DATE_OF_BIRTH) }</DATE_OF_BIRTH>
                }
                {
                    for $MARITAL_STATUS in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/MARITAL_STATUS
                    return
                        <MARITAL_STATUS>{ data($MARITAL_STATUS) }</MARITAL_STATUS>
                }
                {
                    for $STATUS in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/STATUS
                    return
                        <STATUS>{ data($STATUS) }</STATUS>
                }
                {
                    for $DATE_OF_DEATH in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/DATE_OF_DEATH
                    return
                        <DATE_OF_DEATH>{ data($DATE_OF_DEATH) }</DATE_OF_DEATH>
                }
                <ERROR_DETAILS>
                    {
                        for $ERROR_CODE in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/ERROR_DETAILS/ERROR_CODE
                        return
                            <ERROR_CODE>{ data($ERROR_CODE) }</ERROR_CODE>
                    }
                    {
                        for $ERROR_MESSAGE in $consultaCompletaInscripcionResponse1/PERSONAL_INFORMATION/ERROR_DETAILS/ERROR_MESSAGE
                        return
                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                    }
                </ERROR_DETAILS>
            </PERSONAL_INFORMATION>
            {
                for $PARENTS_INFORMATION in $consultaCompletaInscripcionResponse1/PARENTS_INFORMATION
                return
                    <PARENTS_INFORMATION>
                        {
                            for $PARENT in $PARENTS_INFORMATION/PARENT
                            return
                                <PARENT>
                                    <TYPE>{ data($PARENT/TYPE) }</TYPE>
                                    {
                                        for $INSCRIPTION_NUMBER in $PARENT/INSCRIPTION_NUMBER
                                        return
                                            <INSCRIPTION_NUMBER>{ data($INSCRIPTION_NUMBER) }</INSCRIPTION_NUMBER>
                                    }
                                    {
                                        for $GIVEN_NAMES in $PARENT/GIVEN_NAMES
                                        return
                                            <GIVEN_NAMES>{ data($GIVEN_NAMES) }</GIVEN_NAMES>
                                    }
                                    {
                                        for $LAST_NAME in $PARENT/LAST_NAME
                                        return
                                            <LAST_NAME>{ data($LAST_NAME) }</LAST_NAME>
                                    }
                                    {
                                        for $SECOND_SURNAME in $PARENT/SECOND_SURNAME
                                        return
                                            <SECOND_SURNAME>{ data($SECOND_SURNAME) }</SECOND_SURNAME>
                                    }
                                    {
                                        for $GENDER in $PARENT/GENDER
                                        return
                                            <GENDER>{ data($GENDER) }</GENDER>
                                    }
                                    {
                                        for $DATE_OF_BIRTH in $PARENT/DATE_OF_BIRTH
                                        return
                                            <DATE_OF_BIRTH>{ data($DATE_OF_BIRTH) }</DATE_OF_BIRTH>
                                    }
                                    {
                                        for $MARITAL_STATUS in $PARENT/MARITAL_STATUS
                                        return
                                            <MARITAL_STATUS>{ data($MARITAL_STATUS) }</MARITAL_STATUS>
                                    }
                                    {
                                        for $STATUS in $PARENT/STATUS
                                        return
                                            <STATUS>{ data($STATUS) }</STATUS>
                                    }
                                    {
                                        for $DATE_OF_DEATH in $PARENT/DATE_OF_DEATH
                                        return
                                            <DATE_OF_DEATH>{ data($DATE_OF_DEATH) }</DATE_OF_DEATH>
                                    }
                                    <ERROR_DETAILS>
                                        {
                                            for $ERROR_CODE in $PARENT/ERROR_DETAILS/ERROR_CODE
                                            return
                                                <ERROR_CODE>{ data($ERROR_CODE) }</ERROR_CODE>
                                        }
                                        {
                                            for $ERROR_MESSAGE in $PARENT/ERROR_DETAILS/ERROR_MESSAGE
                                            return
                                                <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                        }
                                    </ERROR_DETAILS>
                                </PARENT>
                        }
                    </PARENTS_INFORMATION>
            }
        </ns0:consultaCompletaInscripcionResponse>
};

declare variable $consultaCompletaInscripcionResponse1 as element(ns0:consultaCompletaInscripcionResponse) external;

xf:consultaCompletaInscripcionRNPOut($consultaCompletaInscripcionResponse1)
