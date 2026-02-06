xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bulkProvisionStatusJobDig" element="ns0:BulkProvisionStatusJob" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:BulkProvisionStatusJob" location="../../../BusinessServices/BulkProvisionStatusJob/xsd/bulkProvisionStatusJobTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bulkProvisionStatusJobTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BulkProvisionStatusJob/xq/bulkProvisionStatusJobOICIn/";

declare function xf:bulkProvisionStatusJobOICIn($bulkProvisionStatusJobDig as element(ns0:BulkProvisionStatusJob))
    as element(ns1:BulkProvisionStatusJob) {
        <ns1:BulkProvisionStatusJob>
            <REQUEST_ID>{ data($bulkProvisionStatusJobDig/REQUEST_ID) }</REQUEST_ID>
            <INSTITUTION_CODE>{ data($bulkProvisionStatusJobDig/INSTITUTION_CODE) }</INSTITUTION_CODE>
            <BULK_PUSH_RECEIPT_ID>{ data($bulkProvisionStatusJobDig/BULK_PUSH_RECEIPT_ID) }</BULK_PUSH_RECEIPT_ID>
        </ns1:BulkProvisionStatusJob>
};

declare variable $bulkProvisionStatusJobDig as element(ns0:BulkProvisionStatusJob) external;

xf:bulkProvisionStatusJobOICIn($bulkProvisionStatusJobDig)