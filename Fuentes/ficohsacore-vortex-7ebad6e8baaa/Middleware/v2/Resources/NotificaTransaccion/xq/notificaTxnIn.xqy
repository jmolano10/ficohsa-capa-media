xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$notificaTransaccion" element="ns1:notificaTransaccion" location="../xsd/notificaTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Alertas/notificaTxn/xsd/notificaTxn_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaTxn";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/notificaTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaTransaccion/xq/notificaTxnIn/";

declare function xf:notificaTxnIn($notificaTransaccion as element(ns1:notificaTransaccion),
    $sourceBank as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_COUNTRY>{ $sourceBank }</ns0:PV_COUNTRY>
            {
                for $TRANSACTION_REFERENCE in $notificaTransaccion/TRANSACTION_REFERENCE
                return
                    <ns0:PV_TRANSACTION_REFERENCE>{ data($TRANSACTION_REFERENCE) }</ns0:PV_TRANSACTION_REFERENCE>
            }
            {
                for $TRANSACTION_CODE in $notificaTransaccion/TRANSACTION_CODE
                return
                    <ns0:PV_TRANSACTION_CODE>{ data($TRANSACTION_CODE) }</ns0:PV_TRANSACTION_CODE>
            }
            {
                for $TRANSACTION_TYPE_CODE in $notificaTransaccion/TRANSACTION_TYPE_CODE
                return
                    <ns0:PV_TRANSACTION_TYPE_CODE>{ data($TRANSACTION_TYPE_CODE) }</ns0:PV_TRANSACTION_TYPE_CODE>
            }
            {
                for $TRANSACTION_ERROR_CODE in $notificaTransaccion/TRANSACTION_ERROR_CODE
                return
                    <ns0:PV_TRANSACTION_ERROR_CODE>{ data($TRANSACTION_ERROR_CODE) }</ns0:PV_TRANSACTION_ERROR_CODE>
            }
            {
                for $BIN in $notificaTransaccion/BIN
                return
                    <ns0:PV_BIN>{ data($BIN) }</ns0:PV_BIN>
            }
            {
                for $CARD_NUMBER in $notificaTransaccion/CARD_NUMBER
                return
                    <ns0:PV_CARD_NUMBER>{ data($CARD_NUMBER) }</ns0:PV_CARD_NUMBER>
            }
            {
                for $ACCOUNT_NUMBER in $notificaTransaccion/ACCOUNT_NUMBER
                return
                    <ns0:PV_ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ns0:PV_ACCOUNT_NUMBER>
            }
            {
                for $TERMINAL_ID in $notificaTransaccion/TERMINAL_ID
                return
                    <ns0:PV_TERMINAL_ID>{ data($TERMINAL_ID) }</ns0:PV_TERMINAL_ID>
            }
            {
                for $TRANSACTION_CURRENCY in $notificaTransaccion/TRANSACTION_CURRENCY
                return
                    <ns0:PV_TRANSACTION_CURRENCY>{ data($TRANSACTION_CURRENCY) }</ns0:PV_TRANSACTION_CURRENCY>
            }
            <ns0:PN_TRANSACTION_AMOUNT>{ data($notificaTransaccion/TRANSACTION_AMOUNT) }</ns0:PN_TRANSACTION_AMOUNT>
            <ns0:PN_TRANS_ORIGINAL_AMOUNT>{ data($notificaTransaccion/TRANSACTION_ORIGINAL_AMOUNT) }</ns0:PN_TRANS_ORIGINAL_AMOUNT>
            <ns0:PD_TRANS_ORIGINAL_DATE>{ data($notificaTransaccion/TRANSACTION_ORIGINAL_DATE) }</ns0:PD_TRANS_ORIGINAL_DATE>
            {
                for $TRANSACTION_SOURCE_COUNTRY in $notificaTransaccion/TRANSACTION_SOURCE_COUNTRY
                return
                    <ns0:PV_TRANSACTION_SOURCE_COUNTRY>{ data($TRANSACTION_SOURCE_COUNTRY) }</ns0:PV_TRANSACTION_SOURCE_COUNTRY>
            }
            {
                for $TRANSACTION_SOURCE_CITY in $notificaTransaccion/TRANSACTION_SOURCE_CITY
                return
                    <ns0:PV_TRANSACTION_SOURCE_CITY>{ data($TRANSACTION_SOURCE_CITY) }</ns0:PV_TRANSACTION_SOURCE_CITY>
            }
            {
                for $TRANSACTION_MERCHANT in $notificaTransaccion/TRANSACTION_MERCHANT
                return
                    <ns0:PV_TRANSACTION_MERCHANT>{ data($TRANSACTION_MERCHANT) }</ns0:PV_TRANSACTION_MERCHANT>
            }
            {
                for $TRANSACTION_MERCHANT_CODE in $notificaTransaccion/TRANSACTION_MERCHANT_CODE
                return
                    <ns0:PV_TRANSACTION_MERCHANT_CODE>{ data($TRANSACTION_MERCHANT_CODE) }</ns0:PV_TRANSACTION_MERCHANT_CODE>
            }
            {
                for $TRANSACTION_STATUS in $notificaTransaccion/TRANSACTION_STATUS
                return
                    <ns0:PV_TRANSACTION_STATUS>{ data($TRANSACTION_STATUS) }</ns0:PV_TRANSACTION_STATUS>
            }
            {
                for $TRANSACTION_AUTH_CODE in $notificaTransaccion/TRANSACTION_AUTH_CODE
                return
                    <ns0:PV_TRANSACTION_AUTH_CODE>{ data($TRANSACTION_AUTH_CODE) }</ns0:PV_TRANSACTION_AUTH_CODE>
            }
            {
                for $TRANSACTION_RSP_CODE in $notificaTransaccion/TRANSACTION_RSP_CODE
                return
                    <ns0:PV_TRANSACTION_RSP_CODE>{ data($TRANSACTION_RSP_CODE) }</ns0:PV_TRANSACTION_RSP_CODE>
            }
            {
                for $TRANSACTION_TRACE in $notificaTransaccion/TRANSACTION_TRACE
                return
                    <ns0:PV_TRANSACTION_TRACE>{ data($TRANSACTION_TRACE) }</ns0:PV_TRANSACTION_TRACE>
            }
        </ns0:InputParameters>
};

declare variable $notificaTransaccion as element(ns1:notificaTransaccion) external;
declare variable $sourceBank as xs:string external;

xf:notificaTxnIn($notificaTransaccion,
    $sourceBank)