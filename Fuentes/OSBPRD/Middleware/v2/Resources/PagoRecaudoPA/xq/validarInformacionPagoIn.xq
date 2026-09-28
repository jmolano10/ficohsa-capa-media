(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TercerosPA/validarInformacionPago/xsd/validarInformacionPago_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarInformacionPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPA/xq/validarInformacionPagoIn/";

declare function xf:validarInformacionPagoIn($pagoRecaudo as element(ns1:pagoRecaudo))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDCONVENIO>{ data($pagoRecaudo/CONTRACT_ID) }</ns0:PV_IDCONVENIO>
            {
                for $DEBIT_ACCOUNT in $pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                return
                    <ns0:PV_NOCUENTA>{ data($DEBIT_ACCOUNT) }</ns0:PV_NOCUENTA>
            }
            <ns0:PV_TIPOPAGO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_METHOD) }</ns0:PV_TIPOPAGO>
            <ns0:PV_CODIGODEUDOR>{ data($pagoRecaudo/DEBTOR_CODE) }</ns0:PV_CODIGODEUDOR>
            <ns0:PV_MONTO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns0:PV_MONTO>
        </ns0:InputParameters>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;

xf:validarInformacionPagoIn($pagoRecaudo)