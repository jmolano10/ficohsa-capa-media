(:: pragma bea:global-element-parameter parameter="$consultaafiliacionsubastaResponse" element="ns0:ConsultaafiliacionsubastaResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaAfiliacionSubastaResponse" location="consultaAfiliacionSubastaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaAfiliacionSubastaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaSubasta/consultaAfiliacionSubasta/consultaAfiliacionSubastaOut/";

declare function xf:consultaAfiliacionSubastaOut($consultaafiliacionsubastaResponse as element(ns0:ConsultaafiliacionsubastaResponse))
    as element(ns1:consultaAfiliacionSubastaResponse) {
        <ns1:consultaAfiliacionSubastaResponse>
            <ns1:consultaAfiliacionSubastaResponseType>
                {
                    for $mWSFICOEAUCAFFVIEWDetailType in $consultaafiliacionsubastaResponse/WSFICOEAUCAFFVIEWType[1]/gWSFICOEAUCAFFVIEWDetailType/mWSFICOEAUCAFFVIEWDetailType
                    return
                        <ns1:consultaAfiliacionSubastaResponseRecordType>
                            {
                                for $ID in $mWSFICOEAUCAFFVIEWDetailType/ID
                                return
                                    <CUSTOMER_ID>{ data($ID) }</CUSTOMER_ID>
                            }
                            {
                                for $CUSTOMERNAME in $mWSFICOEAUCAFFVIEWDetailType/CUSTOMERNAME
                                return
                                    <CUSTOMER_NAME>{ data($CUSTOMERNAME) }</CUSTOMER_NAME>
                            }
                            {
                                for $AFFDATE in $mWSFICOEAUCAFFVIEWDetailType/AFFDATE
                                return
                                    <AFFILIATION_DATE>{ data($AFFDATE) }</AFFILIATION_DATE>
                            }
                        </ns1:consultaAfiliacionSubastaResponseRecordType>
                }
            </ns1:consultaAfiliacionSubastaResponseType>
        </ns1:consultaAfiliacionSubastaResponse>
};

declare variable $consultaafiliacionsubastaResponse as element(ns0:ConsultaafiliacionsubastaResponse) external;

xf:consultaAfiliacionSubastaOut($consultaafiliacionsubastaResponse)