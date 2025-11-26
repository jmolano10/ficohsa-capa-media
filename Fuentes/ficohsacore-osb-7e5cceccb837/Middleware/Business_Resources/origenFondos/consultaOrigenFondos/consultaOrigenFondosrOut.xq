(:: pragma bea:global-element-parameter parameter="$consultadeorigendefondosResponse1" element="ns0:ConsultadeorigendefondosResponse" location="../resources/XMLSchema_-253522267.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaOrigenFondosResponse" location="consultaOrigenFondosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaOrigenFondosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/origenFondos/consultaOrigenFondos/consultaOrigenFondosrOut/";

declare function xf:consultaOrigenFondosrOut($consultadeorigendefondosResponse1 as element(ns0:ConsultadeorigendefondosResponse))
    as element(ns1:consultaOrigenFondosResponse) {
        <ns1:consultaOrigenFondosResponse>
            <ns1:consultaOrigenFondosResponseType>
                {
                    for $mWSFUNDSORIGINLISTDetailType in $consultadeorigendefondosResponse1/WSFUNDSORIGINLISTType[1]/gWSFUNDSORIGINLISTDetailType/mWSFUNDSORIGINLISTDetailType
                    return
                        <ns1:consultaOrigenFondosResponseRecordType>
                            {
                                for $ID in $mWSFUNDSORIGINLISTDetailType/ID
                                return
                                    <FUNDS_ORIGIN_ID>{ data($ID) }</FUNDS_ORIGIN_ID>
                            }
                            {
                                for $DESCRIPTION in $mWSFUNDSORIGINLISTDetailType/DESCRIPTION
                                return
                                    <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                            }
                        </ns1:consultaOrigenFondosResponseRecordType>
                }
            </ns1:consultaOrigenFondosResponseType>
        </ns1:consultaOrigenFondosResponse>
};

declare variable $consultadeorigendefondosResponse1 as element(ns0:ConsultadeorigendefondosResponse) external;

xf:consultaOrigenFondosrOut($consultadeorigendefondosResponse1)