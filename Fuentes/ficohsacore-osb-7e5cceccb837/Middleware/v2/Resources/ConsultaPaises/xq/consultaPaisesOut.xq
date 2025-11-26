(:: pragma bea:global-element-parameter parameter="$consultadepaisesResponse1" element="ns0:ConsultadepaisesResponse" location="../../../../Business_Resources/direcciones/Resources/XMLSchema_1123420404.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPaisesResponse" location="../../../../Business_Resources/direcciones/consultaPaises/consultaPaisesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPaisesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPaises/xq/consultaPaisesOut/";

declare function xf:consultaPaisesOut($consultadepaisesResponse1 as element(ns0:ConsultadepaisesResponse))
    as element(ns1:consultaPaisesResponse) {
        <ns1:consultaPaisesResponse>
            <ns1:consultaPaisesResponseType>
                {
                    for $mWSCOUNTRYLISTDetailType in $consultadepaisesResponse1/WSCOUNTRYLISTType[1]/gWSCOUNTRYLISTDetailType/mWSCOUNTRYLISTDetailType
                    return
                        <ns1:consultaPaisesResponseRecordType>
                            {
                                for $ID in $mWSCOUNTRYLISTDetailType/ID
                                return
                                    <COUNTRY_CODE>{ data($ID) }</COUNTRY_CODE>
                            }
                            {
                                for $SHORTNAME in $mWSCOUNTRYLISTDetailType/SHORTNAME
                                return
                                    <COUNTRY_NAME>{ data($SHORTNAME) }</COUNTRY_NAME>
                            }
                        </ns1:consultaPaisesResponseRecordType>
                }
            </ns1:consultaPaisesResponseType>
        </ns1:consultaPaisesResponse>
};

declare variable $consultadepaisesResponse1 as element(ns0:ConsultadepaisesResponse) external;

xf:consultaPaisesOut($consultadepaisesResponse1)