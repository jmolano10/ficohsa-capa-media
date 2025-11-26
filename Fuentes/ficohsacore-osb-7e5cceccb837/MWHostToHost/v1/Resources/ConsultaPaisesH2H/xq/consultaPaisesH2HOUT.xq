(:: pragma bea:global-element-parameter parameter="$consultaPaisesResponse" element="ns0:consultaPaisesResponse" location="../../../../../Middleware/Business_Resources/direcciones/consultaPaises/consultaPaisesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPaisesH2HResponse" location="../xsd/consultaPaisesH2HTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaPaisesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPaisesH2HTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaPaisesH2H/xq/consultaPaisesH2HOUT/";

declare function xf:consultaPaisesH2HOUT($consultaPaisesResponse as element(ns0:consultaPaisesResponse))
    as element(ns1:consultaPaisesH2HResponse) {
        <ns1:consultaPaisesH2HResponse>
            <ns1:consultaPaisesResponseType>
                {
                    for $responseRecord in $consultaPaisesResponse/ns0:consultaPaisesResponseType/ns0:consultaPaisesResponseRecordType
                    return
                        <ns1:consultaPaisesResponseRecordType>
                            <COUNTRY_CODE>{ data($responseRecord/COUNTRY_CODE) }</COUNTRY_CODE>
                            <COUNTRY_NAME>{ data($responseRecord/COUNTRY_NAME) }</COUNTRY_NAME>
                        </ns1:consultaPaisesResponseRecordType>
                }
            </ns1:consultaPaisesResponseType>
        </ns1:consultaPaisesH2HResponse>
};

declare variable $consultaPaisesResponse as element(ns0:consultaPaisesResponse) external;

xf:consultaPaisesH2HOUT($consultaPaisesResponse)