(:: pragma bea:global-element-parameter parameter="$listaderecaudosResponse" element="ns0:ListaderecaudosResponse" location="../Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:listaRecaudosResponse" location="listaRecaudosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/listaRecaudosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/listaRecaudos/listaRecaudosOut/";

declare function xf:listaRecaudosOut($listaderecaudosResponse as element(ns0:ListaderecaudosResponse))
    as element(ns1:listaRecaudosResponse) {
        <ns1:listaRecaudosResponse>
            <ns1:listaRecaudosResponseType>
                {
                    for $mWSCOLLECTIONSLISTDetailType in $listaderecaudosResponse/WSCOLLECTIONSLISTType[1]/gWSCOLLECTIONSLISTDetailType/mWSCOLLECTIONSLISTDetailType
                    return
                        <ns1:listaRecaudosResponseRecordType>
                            {
                                for $ID in $mWSCOLLECTIONSLISTDetailType/ID
                                return
                                    <COLLECTION_ID>{ data($ID) }</COLLECTION_ID>
                            }
                            {
                                for $DESCRIPTION in $mWSCOLLECTIONSLISTDetailType/DESCRIPTION
                                return
                                    <COLLECTION_NAME>{ data($DESCRIPTION) }</COLLECTION_NAME>
                            }
                        </ns1:listaRecaudosResponseRecordType>
                }
            </ns1:listaRecaudosResponseType>
        </ns1:listaRecaudosResponse>
};

declare variable $listaderecaudosResponse as element(ns0:ListaderecaudosResponse) external;

xf:listaRecaudosOut($listaderecaudosResponse)