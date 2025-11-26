(:: pragma bea:global-element-parameter parameter="$consultasuborigendefondosResponse1" element="ns1:ConsultasuborigendefondosResponse" location="../resources/XMLSchema_-253522267.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSubOrigenFondosResponse" location="consultaSubOrigenFondosTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSubOrigenFondosTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/origenFondos/consultaSubOrigenFondos/consultaSubOrigenOut/";

declare function xf:consultaSubOrigenOut($consultasuborigendefondosResponse1 as element(ns1:ConsultasuborigendefondosResponse))
    as element(ns0:consultaSubOrigenFondosResponse) {
        <ns0:consultaSubOrigenFondosResponse>
            <ns0:consultaSubOrigenFondosResponseType>
                {
                    for $mWSFUNDSSUBORIGINLISTDetailType in $consultasuborigendefondosResponse1/WSFUNDSSUBORIGINLISTType[1]/gWSFUNDSSUBORIGINLISTDetailType/mWSFUNDSSUBORIGINLISTDetailType
                    return
                        <ns0:consultaSubOrigenFondosResponseRecordType>
                            {
                                for $ID in $mWSFUNDSSUBORIGINLISTDetailType/ID
                                return
                                    <FUNDS_ORIGIN_ID>{ data($ID) }</FUNDS_ORIGIN_ID>
                            }
                            {
                                for $ORIGINDESCRIPTION in $mWSFUNDSSUBORIGINLISTDetailType/ORIGINDESCRIPTION
                                return
                                    <DESCRIPTION>{ data($ORIGINDESCRIPTION) }</DESCRIPTION>
                            }
                            {
                                for $SUBCODE in $mWSFUNDSSUBORIGINLISTDetailType/SUBCODE
                                return
                                    <FUNDS_SUB_ORIGIN_ID>{ data($SUBCODE) }</FUNDS_SUB_ORIGIN_ID>
                            }
                            {
                                for $SUBORIGINDESCRIPTION in $mWSFUNDSSUBORIGINLISTDetailType/SUBORIGINDESCRIPTION
                                return
                                    <SUB_DESCRIPTION>{ data($SUBORIGINDESCRIPTION) }</SUB_DESCRIPTION>
                            }
                        </ns0:consultaSubOrigenFondosResponseRecordType>
                }
            </ns0:consultaSubOrigenFondosResponseType>
        </ns0:consultaSubOrigenFondosResponse>
};

declare variable $consultasuborigendefondosResponse1 as element(ns1:ConsultasuborigendefondosResponse) external;

xf:consultaSubOrigenOut($consultasuborigendefondosResponse1)