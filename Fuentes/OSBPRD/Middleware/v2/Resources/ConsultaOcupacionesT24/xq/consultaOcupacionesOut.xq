(:: pragma bea:global-element-parameter parameter="$getCustomerOccupationsResponse1" element="ns0:getCustomerOccupationsResponse" location="../../../BusinessServices/ConsultaOcupacionesT24/services_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaOcupacionesResponse" location="../xsd/consultaOcupacionesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaOcupacionesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOcupacionesT24/xq/consultaOcupaciones2Out/";

declare function xf:consultaOcupaciones2Out($getCustomerOccupationsResponse1 as element(ns0:getCustomerOccupationsResponse))
    as element(ns1:consultaOcupacionesResponse) {
        <ns1:consultaOcupacionesResponse>
            <ns1:consultaOcupacionesResponseType>
                {
                    for $mFICOENQOCCUPATIONSDetailType in $getCustomerOccupationsResponse1/FICOENQOCCUPATIONSType[1]/gFICOENQOCCUPATIONSDetailType/mFICOENQOCCUPATIONSDetailType
                    return
                        <ns1:consultaOcupacionesResponseRecordType>
                            {
                                for $ID in $mFICOENQOCCUPATIONSDetailType/ID
                                return
                                    <OCUPATTION_ID>{ data($ID) }</OCUPATTION_ID>
                            }
                            {
                                for $DESCRIPTION in $mFICOENQOCCUPATIONSDetailType/DESCRIPTION
                                return
                                    <OCUPATTION>{ data($DESCRIPTION) }</OCUPATTION>
                            }
                        </ns1:consultaOcupacionesResponseRecordType>
                }
            </ns1:consultaOcupacionesResponseType>
        </ns1:consultaOcupacionesResponse>
};

declare variable $getCustomerOccupationsResponse1 as element(ns0:getCustomerOccupationsResponse) external;

xf:consultaOcupaciones2Out($getCustomerOccupationsResponse1)