xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bulkProvisionStartJobResponseOIC" element="ns1:BulkProvisionStartJobResponse" location="../../../BusinessServices/BulkProvisionStartJob/xsd/bulkProvisionStartJobTypes.xsd" ::)

(:: pragma bea:global-element-return element="ns0:BulkProvisionStartJobResponse" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)


declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bulkProvisionStartJobTypes";

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BulkProvisionStartJob/xq/xqueryPruebaa/";


declare function xf:bulkProvisionStartJobOICOut($bulkProvisionStartJobResponseOIC as element(ns1:BulkProvisionStartJobResponse))

    as element(ns0:BulkProvisionStartJobResponse) {

        <ns0:BulkProvisionStartJobResponse>
            <REQUEST_ID>{ data($bulkProvisionStartJobResponseOIC/REQUEST_ID) }</REQUEST_ID>
            <BULK_PUSH_RECEIPT_ID>{ data($bulkProvisionStartJobResponseOIC/BULK_PUSH_RECEIPT_ID) }</BULK_PUSH_RECEIPT_ID>
            {
                for $returnDetails in $bulkProvisionStartJobResponseOIC/RETURN_DETAILS
                return
                    <RETURN_DETAILS>
                        {
                            for $RETURN_CODE in $returnDetails/RETURN_CODE
                            return
                                <RETURN_CODE>{ data($RETURN_CODE) }</RETURN_CODE>
                        }
                        <ERROR_DESCRIPTION>{ data($returnDetails/ERROR_DESCRIPTION) }</ERROR_DESCRIPTION>
                    </RETURN_DETAILS>
            }
        </ns0:BulkProvisionStartJobResponse>

};


declare variable $bulkProvisionStartJobResponseOIC as element(ns1:BulkProvisionStartJobResponse) external;


xf:bulkProvisionStartJobOICOut($bulkProvisionStartJobResponseOIC)