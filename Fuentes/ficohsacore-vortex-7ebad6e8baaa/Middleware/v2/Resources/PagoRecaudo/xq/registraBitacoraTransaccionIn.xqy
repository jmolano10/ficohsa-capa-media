xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../xsd/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoResponse" element="ns0:pagoRecaudoResponse" location="../xsd/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registroBitacoraTransaccion" location="../../RegistraBitacoraTransaccion/xsd/RegistraBitacoraTransaccionTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraTransaccionTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/registraBitacoraTransaccionIn/";

declare function xf:registraBitacoraTransaccionIn($requestHeader as element(ns2:RequestHeader),
    $responseHeader as element(ns2:ResponseHeader),
    $pagoRecaudo as element(ns0:pagoRecaudo),
    $pagoRecaudoResponse as element(ns0:pagoRecaudoResponse),
    $uuid as xs:string)
    as element(ns1:registroBitacoraTransaccion) {
        <ns1:registroBitacoraTransaccion>
            <UUID>{ $uuid }</UUID>
            <TRANSACTION_TYPE>1</TRANSACTION_TYPE>
            {
                for $successIndicator in $responseHeader/successIndicator
                return
                    <ERROR_CODE>{ data($successIndicator) }</ERROR_CODE>
            }
            {
                let $result :=
                    for $messages in $responseHeader/messages
                    return
                        <ERROR_MESSAGE>{ substring(data($messages),1,70) }</ERROR_MESSAGE>
                return
                    $result[1]
            }
            <USER>{ data($requestHeader/Authentication/UserName) }</USER>
            <DATE_TIME>{ fn:current-dateTime() }</DATE_TIME>
            <XML_REQUEST>{ fn-bea:serialize(  (<REQUEST><CONTRACT_ID>{ data($pagoRecaudo/CONTRACT_ID) }</CONTRACT_ID>,<DEBTOR_CODE>{ data($pagoRecaudo/DEBTOR_CODE) }</DEBTOR_CODE>,<DEBTOR_NAME>{ data($pagoRecaudo/DEBTOR_NAME) }</DEBTOR_NAME>,<PAYMENT_METHOD>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_METHOD) }</PAYMENT_METHOD>,<PAYMENT_CURRENCY>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>,<PAYMENT_AMOUNT>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>,<DEBIT_ACCOUNT>{ data($pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>,<CHEQUE_NUMBER>{ data($pagoRecaudo/PAYMENT_INFORMATION/CHEQUE_NUMBER) }</CHEQUE_NUMBER>,<CREDIT_CARD_NUMBER>{ data($pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER></REQUEST> ))}</XML_REQUEST>
            <XML_RESPONSE>{fn-bea:serialize(  ( <RESPONSE><CONTRACT_NAME>{ data($pagoRecaudoResponse/CONTRACT_NAME) }</CONTRACT_NAME>,<DEBTOR_NAME>{ data($pagoRecaudoResponse/DEBTOR_NAME) }</DEBTOR_NAME>,<PAYMENT_METHOD>{ data($pagoRecaudoResponse/PAYMENT_INFORMATION/PAYMENT_METHOD) }</PAYMENT_METHOD>,<PAYMENT_CURRENCY>{ data($pagoRecaudoResponse/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>,<PAYMENT_AMOUNT>{ data($pagoRecaudoResponse/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>,<DEBIT_ACCOUNT>{ data($pagoRecaudoResponse/PAYMENT_INFORMATION/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>,<CHEQUE_NUMBER>{ data($pagoRecaudoResponse/PAYMENT_INFORMATION/CHEQUE_NUMBER) }</CHEQUE_NUMBER>,<CREDIT_CARD_NUMBER>{ data($pagoRecaudoResponse/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>,<TRANSACTION_ID>{ data($responseHeader/transactionId) }</TRANSACTION_ID></RESPONSE> ))}</XML_RESPONSE>
        </ns1:registroBitacoraTransaccion>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $responseHeader as element(ns2:ResponseHeader) external;
declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;
declare variable $pagoRecaudoResponse as element(ns0:pagoRecaudoResponse) external;
declare variable $uuid as xs:string external;

xf:registraBitacoraTransaccionIn($requestHeader,
    $responseHeader,
    $pagoRecaudo,
    $pagoRecaudoResponse,
    $uuid)