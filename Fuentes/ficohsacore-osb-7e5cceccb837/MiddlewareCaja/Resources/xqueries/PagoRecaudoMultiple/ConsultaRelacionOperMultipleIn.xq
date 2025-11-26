(:: pragma bea:global-element-parameter parameter="$pagoRecaudoMultiple" element="ns1:pagoRecaudoMultiple" location="../../xsds/PagoRecaudoMultiple/PagoRecaudoMultiple.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/ConsultarRelacionOperacionRecaudoMultiple/FLINK_OSB_CON_OPER_RECAUDO_MULTIPLE.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMultipleTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CON_OPER_RECAUDO_MULTIPLE/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMultiple/ConsultaRelacionOperMultipleIn/";

declare function xf:ConsultaRelacionOperMultipleIn($pagoRecaudoMultiple as element(ns1:pagoRecaudoMultiple))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CODIGO_CONTRATO>{ data($pagoRecaudoMultiple/CONTRACT_ID) }</ns0:CODIGO_CONTRATO>
            <ns0:CODIGO_DEUDOR>{ data($pagoRecaudoMultiple/DEBTOR_CODE) }</ns0:CODIGO_DEUDOR>
            <ns0:MONEDA_SOLICITUD>{ data($pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:MONEDA_SOLICITUD>
            {
                for $NUMBER_OF_BILLS in $pagoRecaudoMultiple/NUMBER_OF_BILLS
                return
                    <ns0:CANTIDAD_FACTURAS>{ data($NUMBER_OF_BILLS) }</ns0:CANTIDAD_FACTURAS>
            }
            {
                for $BILL_NUMBER in $pagoRecaudoMultiple/BILL_NUMBER
                return
                    <ns0:NRO_FACTURA>{ data($BILL_NUMBER) }</ns0:NRO_FACTURA>
            }
            {
                for $PAYMENT_AMOUNT in $pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                return
                    <ns0:MONTO_PAGO>{ data($PAYMENT_AMOUNT) }</ns0:MONTO_PAGO>
            }
        </ns0:InputParameters>
};

declare variable $pagoRecaudoMultiple as element(ns1:pagoRecaudoMultiple) external;

xf:ConsultaRelacionOperMultipleIn($pagoRecaudoMultiple)