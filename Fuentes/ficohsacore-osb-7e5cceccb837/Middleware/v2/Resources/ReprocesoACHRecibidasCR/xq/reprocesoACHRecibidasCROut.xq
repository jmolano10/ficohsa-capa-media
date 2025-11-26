(:: pragma bea:global-element-return element="ns0:reprocesoACHRecibidasCRResponse" location="../xsd/reprocesoACHRecibidasCRTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reprocesoACHRecibidasCRTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHRecibidasCR/xq/reprocesoACHRecibidasCROut/";

declare function xf:reprocesoACHRecibidasCROut($sequenceACH as xs:integer,
    $t24ClientCod as xs:string,
    $t24ControlRef as xs:string,
    $t24TransactionRef as xs:string,
    $pxpIdTxnRef as xs:string,
    $pxpBatchRef as xs:string)
    as element(ns0:reprocesoACHRecibidasCRResponse) {
        <ns0:reprocesoACHRecibidasCRResponse>
            <ACH_SEQUENCE>{ $sequenceACH }</ACH_SEQUENCE>
            <T24_CUSTOMER_ID>{ $t24ClientCod }</T24_CUSTOMER_ID>
            <T24_CONTROL_REF>{ $t24ControlRef }</T24_CONTROL_REF>
            <T24_TRANSACTION_REF>{ $t24TransactionRef }</T24_TRANSACTION_REF>
            <PXP_ID_TXN_REF>{ $pxpIdTxnRef }</PXP_ID_TXN_REF>
            <PXP_BATCH_REF>{ $pxpBatchRef }</PXP_BATCH_REF>
        </ns0:reprocesoACHRecibidasCRResponse>
};

declare variable $sequenceACH as xs:integer external;
declare variable $t24ClientCod as xs:string external;
declare variable $t24ControlRef as xs:string external;
declare variable $t24TransactionRef as xs:string external;
declare variable $pxpIdTxnRef as xs:string external;
declare variable $pxpBatchRef as xs:string external;

xf:reprocesoACHRecibidasCROut($sequenceACH,
    $t24ClientCod,
    $t24ControlRef,
    $t24TransactionRef,
    $pxpIdTxnRef,
    $pxpBatchRef)