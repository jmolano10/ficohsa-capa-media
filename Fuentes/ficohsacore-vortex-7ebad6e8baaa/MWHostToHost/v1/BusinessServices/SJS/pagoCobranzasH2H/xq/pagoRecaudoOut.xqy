xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns1:ResponseHeader" location="../../../../Resources/EsquemasGenerales/headerElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoResponse" element="ns2:pagoRecaudoResponse" location="../../../OSB/pagoRecaudo_v2/xsd/XMLSchema_-909699091.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjPagoCobranzasResponse/SERVICES/SERVICE/DEBTORS/DEBTOR" location="../xsd/sjPagoCobranzasH2H.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/BusinessServices/SJS/pagoCobranzasH2H/xq/pagoRecaudoOut/";

declare function xf:pagoRecaudoOut($responseHeader as element(ns1:ResponseHeader),
    $pagoRecaudoResponse as element(ns2:pagoRecaudoResponse),
    $trace as xs:string,
    $code as xs:string)
    as element() {
        <DEBTOR>
            {
                for $transactionId in $responseHeader/transactionId
                return
                    <TRANSACTION_ID>{ data($transactionId) }</TRANSACTION_ID>
            }
            {
                for $successIndicator in $responseHeader/successIndicator
                return
                    <SUCCESS_INDICATOR>{ data($successIndicator) }</SUCCESS_INDICATOR>         
            }            
            {
                for $messages in $responseHeader/messages
                return
                    <ERROR_MESSAGE>{ data($messages) }</ERROR_MESSAGE>
                
            }
            <TRACE>{ $trace }</TRACE>
            <CODE>{ $code }</CODE>
            {
                for $name in $pagoRecaudoResponse/DEBTOR_NAME
                return
                    <NAME>{ data($name) }</NAME>
            }
            {
                for $formaPago in $pagoRecaudoResponse/PAYMENT_INFORMATION
                return
                    <PAYMENT_INFORMATION>
                        {
                            for $metodo in $formaPago/PAYMENT_METHOD
                            return
                                <PYMT_METHOD>{ data($metodo) }</PYMT_METHOD>
                        }
                        {
                            for $moneda in $formaPago/PAYMENT_CURRENCY
                            return
                                <CURRENCY>{ data($moneda) }</CURRENCY>
                        }
                        {
                            for $monto in $formaPago/PAYMENT_AMOUNT
                            return
                                <AMOUNT>{ data($monto) }</AMOUNT>
                        }
                        {
                            for $monto in $formaPago/PAYMENT_AMOUNT
                            return
                                <TOTAL>{ data($monto) }</TOTAL>
                        }
                    </PAYMENT_INFORMATION>
            }
            {
                for $BILL_DETAIL in $pagoRecaudoResponse/BILL_DETAIL
                return
                    <DEALSLIP>{ data($BILL_DETAIL) }</DEALSLIP>
            }
        </DEBTOR>
};

declare variable $responseHeader as element(ns1:ResponseHeader) external;
declare variable $pagoRecaudoResponse as element(ns2:pagoRecaudoResponse) external;
declare variable $trace as xs:string external;
declare variable $code as xs:string external;

xf:pagoRecaudoOut($responseHeader,
    $pagoRecaudoResponse,
    $trace,
    $code)