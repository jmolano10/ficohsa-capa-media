xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bulkProvisionStatusJobResponseOIC" element="ns1:BulkProvisionStatusJobResponse" location="../../../BusinessServices/BulkProvisionStatusJob/xsd/bulkProvisionStatusJobTypes.xsd" ::)

(:: pragma bea:global-element-return element="ns0:BulkProvisionStatusJobResponse" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)


declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bulkProvisionStatusJobTypes";

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BulkProvisionStatusJob/xq/bulkProvisionStatusJobOICOut/";


declare function xf:bulkProvisionStatusJobOICOut($bulkProvisionStatusJobResponseOIC as element(ns1:BulkProvisionStatusJobResponse))

    as element(ns0:BulkProvisionStatusJobResponse) {

        <ns0:BulkProvisionStatusJobResponse>
            <REQUEST_ID>{ data($bulkProvisionStatusJobResponseOIC/REQUEST_ID) }</REQUEST_ID>
            <BULK_JOB_STATUS>{ substring-before(data($bulkProvisionStatusJobResponseOIC/BULK_JOB_STATUS), '|') }</BULK_JOB_STATUS>
            <STARTED_AT>{ data($bulkProvisionStatusJobResponseOIC/STARTED_AT) }</STARTED_AT>
            <FINISHED_AT>{ data($bulkProvisionStatusJobResponseOIC/FINISHED_AT) }</FINISHED_AT>
            <PROVISIONED_CARD_ID_LIST>
                {
                    for $CARD_ID in $bulkProvisionStatusJobResponseOIC/PROVISIONED_CARD_ID_LIST/CARD_ID
                    return
                        <CARD_ID>{ data($CARD_ID) }</CARD_ID>
                }
            </PROVISIONED_CARD_ID_LIST>
            <ERROR_CARD_ID_LIST>
                {
                    for $cardDetail in $bulkProvisionStatusJobResponseOIC/ERROR_CARD_ID_LIST/CARD_DETAILS
                    return
                        <CARD_DETAILS>
                            {
                            	if ($cardDetail/CARD_ID) then
                                    <CARD_ID>{ data($cardDetail/CARD_ID) }</CARD_ID>
                                else ()
                            }
                            {
                                if ($cardDetail/ERROR_CODE) then
                                    <ERROR_CODE>{ data($cardDetail/ERROR_CODE) }</ERROR_CODE>
                                else ()
                            }
                            {
                                if ($cardDetail/ERROR_DESCRIPTION) then
                                    <ERROR_DESCRIPTION>{ data($cardDetail/ERROR_DESCRIPTION) }</ERROR_DESCRIPTION>
                                else ()
                            }
                        </CARD_DETAILS>
                }
            </ERROR_CARD_ID_LIST>
        </ns0:BulkProvisionStatusJobResponse>

};


declare variable $bulkProvisionStatusJobResponseOIC as element(ns1:BulkProvisionStatusJobResponse) external;


xf:bulkProvisionStatusJobOICOut($bulkProvisionStatusJobResponseOIC)