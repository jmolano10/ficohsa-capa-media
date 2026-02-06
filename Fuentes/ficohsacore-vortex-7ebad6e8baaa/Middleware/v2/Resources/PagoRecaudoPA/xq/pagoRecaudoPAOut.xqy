xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registrarPagoRecaudo" element="ns0:OutputParameters" location="../../../BusinessServices/TercerosPA/registrarPagoRecaudo/xsd/registrarPagoRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validarInformacionPago" element="ns2:OutputParameters" location="../../../BusinessServices/TercerosPA/validarInformacionPago/xsd/validarInformacionPago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoResponse" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarInformacionPago";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarPagoRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPA/xq/pagoRecaudoPAOut/";

declare function xf:pagoRecaudoPAOut($pagoRecaudo as element(ns1:pagoRecaudo),
    $registrarPagoRecaudo as element(ns0:OutputParameters),
    $validarInformacionPago as element(ns2:OutputParameters))
    as element(ns1:pagoRecaudoResponse) {
        <ns1:pagoRecaudoResponse>
            {
                for $PV_NOMBRECOBRANZA in $validarInformacionPago/ns2:PV_NOMBRECOBRANZA
                return
                    <CONTRACT_NAME>{ data($PV_NOMBRECOBRANZA) }</CONTRACT_NAME>
            }
            {
                for $PV_NOMBREDEUDOR in $registrarPagoRecaudo/ns0:PV_NOMBREDEUDOR
                return
                    <DEBTOR_NAME>{ data($PV_NOMBREDEUDOR) }</DEBTOR_NAME>
            }
            <INPUTTER>INTERBANCA</INPUTTER>
            <DATE_TIME>{ fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss", fn:adjust-dateTime-to-timezone(fn:current-dateTime(),())) }</DATE_TIME>
            <BRANCH_NAME>AGENCIA VIRTUAL</BRANCH_NAME>
            {
                let $PAYMENT_INFORMATION := $pagoRecaudo/PAYMENT_INFORMATION
                return
                    <PAYMENT_INFORMATION>
                        <PAYMENT_METHOD>{ data($PAYMENT_INFORMATION/PAYMENT_METHOD) }</PAYMENT_METHOD>
                        <PAYMENT_CURRENCY>{ data($PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
                        {
                            for $PAYMENT_AMOUNT in $PAYMENT_INFORMATION/PAYMENT_AMOUNT
                            return
                                <PAYMENT_AMOUNT>{ data($PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
                        }
                        {
                            for $DEBIT_ACCOUNT in $PAYMENT_INFORMATION/DEBIT_ACCOUNT
                            return
                                <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                        }
                        {
                            for $CREDIT_CARD_NUMBER in $PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                            return
                                <CREDIT_CARD_NUMBER>{ data($CREDIT_CARD_NUMBER) }</CREDIT_CARD_NUMBER>
                        }
                        {
                            for $EXPIRATION_DATE in $PAYMENT_INFORMATION/EXPIRATION_DATE
                            return
                                <EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</EXPIRATION_DATE>
                        }
                    </PAYMENT_INFORMATION>
            }
            {
                for $PC_RECIBOHTML in $registrarPagoRecaudo/ns0:PC_RECIBOHTML
                return
                    <BILL_DETAIL>{ data($PC_RECIBOHTML) }</BILL_DETAIL>
            }
        </ns1:pagoRecaudoResponse>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $registrarPagoRecaudo as element(ns0:OutputParameters) external;
declare variable $validarInformacionPago as element(ns2:OutputParameters) external;

xf:pagoRecaudoPAOut($pagoRecaudo,
    $registrarPagoRecaudo,
    $validarInformacionPago)