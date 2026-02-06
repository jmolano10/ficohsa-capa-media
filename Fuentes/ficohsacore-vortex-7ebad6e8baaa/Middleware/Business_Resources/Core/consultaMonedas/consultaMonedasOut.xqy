xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiolcyResponse" element="ns0:ConsultadetasadecambiolcyResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMonedasResponse" location="consultaMonedasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMonedasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaMonedas/consultaMonedasOut/";

declare function xf:consultaMonedasOut($consultadetasadecambiolcyResponse as element(ns0:ConsultadetasadecambiolcyResponse))
    as element(ns1:consultaMonedasResponse) {
        <ns1:consultaMonedasResponse>
            <ns1:consultaMonedasResponseType>
                {
                    for $mWSLCYEXCHRATEDetailType in $consultadetasadecambiolcyResponse/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType
                    return
                        <ns1:consultaMonedasResponseRecordType>
                            {
                                for $CCYCODE in $mWSLCYEXCHRATEDetailType/CCYCODE
                                return
                                    <CURRENCY_ID>{ data($CCYCODE) }</CURRENCY_ID>
                            }
                            {
                                for $CCYNAME in $mWSLCYEXCHRATEDetailType/CCYNAME
                                return
                                    <DESCRIPTION>{ data($CCYNAME) }</DESCRIPTION>
                            }
                        </ns1:consultaMonedasResponseRecordType>
                }
            </ns1:consultaMonedasResponseType>
        </ns1:consultaMonedasResponse>
};

declare variable $consultadetasadecambiolcyResponse as element(ns0:ConsultadetasadecambiolcyResponse) external;

xf:consultaMonedasOut($consultadetasadecambiolcyResponse)