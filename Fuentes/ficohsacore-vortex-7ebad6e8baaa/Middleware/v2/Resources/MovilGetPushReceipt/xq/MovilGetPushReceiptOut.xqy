xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/MovilGetPushReceipt/xsd/movilGetPushReceipt_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$getPushReceiptResponse" element="ns0:GetPushReceiptResponse" location="../../../BusinessServices/MovilGetPushReceipt/xsd/GetPushReceipt.xsd" ::)
(:: pragma bea:global-element-return element="ns1:movilGetPushReceiptResponse" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetPushReceipt";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/GetPushReceiptTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetPushReceipt/xq/MovilGetPushReceiptOut/";

declare function xf:MovilGetPushReceiptOut($outputParameters as element(ns2:OutputParameters),
    $getPushReceiptResponse as element(ns0:GetPushReceiptResponse))
    as element(ns1:movilGetPushReceiptResponse) {
        <ns1:movilGetPushReceiptResponse>
            <REQUEST_ID>{ data($getPushReceiptResponse/REQUEST_ID) }</REQUEST_ID>
            <RETURN_CODE>{ data($getPushReceiptResponse/RETURN_CODE) }</RETURN_CODE>
            {
                for $ERROR_DESCRIPTION in $getPushReceiptResponse/ERROR_DESCRIPTION
                return
                    <ERROR_DESCRIPTION>{ data($ERROR_DESCRIPTION) }</ERROR_DESCRIPTION>
            }
            {
                for $PUSH_RECEIPT_ID in $getPushReceiptResponse/PUSH_RECEIPT_ID
                return
                    <PUSH_RECEIPT_ID>{ data($PUSH_RECEIPT_ID) }</PUSH_RECEIPT_ID>
            }
            {
                for $RECEIPT_EXPIRATION_TIME in $getPushReceiptResponse/RECEIPT_EXPIRATION_TIME
                return
                    <RECEIPT_EXPIRATION_TIME>{ data($RECEIPT_EXPIRATION_TIME) }</RECEIPT_EXPIRATION_TIME>
            }
            {
                for $PV_INSTITUTIONCODE in $outputParameters/ns2:PV_INSTITUTIONCODE
                return
                    <INSTITUTION_CODE>{ data($PV_INSTITUTIONCODE) }</INSTITUTION_CODE>
            }
            {
                for $PV_CARDHOLDERNAME in $outputParameters/ns2:PV_CARDHOLDERNAME
                return
                    <CARD_HOLDER_NAME>{ data($PV_CARDHOLDERNAME) }</CARD_HOLDER_NAME>
            }
            {
                for $PV_PNP in $outputParameters/ns2:PV_PNP
                return
                    <PNP>{ data($PV_PNP) }</PNP>
            }
        </ns1:movilGetPushReceiptResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $getPushReceiptResponse as element(ns0:GetPushReceiptResponse) external;

xf:MovilGetPushReceiptOut($outputParameters,
    $getPushReceiptResponse)