xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHDebitosResponse1" element="ns0:transferenciasACHDebitosResponse" location="../../TransferenciasACHDebitos/xsd/transferenciasACHDebitosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHDebitosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionACHdebitoHeaderOut/";

declare function xf:creaTransaccionACHdebitoHeaderOut($transferenciasACHDebitosResponse1 as element(ns0:transferenciasACHDebitosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $TRANSACTION_ID in $transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/TRANSACTION_ID
                return
                    <transactionId>{ data($TRANSACTION_ID) }</transactionId>
            }
            {
                for $ERROR_MESSAGE in $transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/ERROR_MESSAGE
                return
                    <messageId>{ data($ERROR_MESSAGE) }</messageId>
            }
            {
                for $SUCCESS_INDICATOR in $transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/SUCCESS_INDICATOR
                return
                    <successIndicator>{ data($SUCCESS_INDICATOR) }</successIndicator>
            }
            {
                for $ERROR_CODE in $transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/ERROR_CODE
                return
                    <messages>{ data($ERROR_CODE) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $transferenciasACHDebitosResponse1 as element(ns0:transferenciasACHDebitosResponse) external;

xf:creaTransaccionACHdebitoHeaderOut($transferenciasACHDebitosResponse1)