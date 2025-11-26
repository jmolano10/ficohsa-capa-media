(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../xsds/PagoRecaudo/PagoRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/ConsultarNombreDeudorDeposito/FLINK_OSB_CONSULTAR_REF_DEPOSITANTE.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_REF_DEPOSITANTE/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/ConsultarNombreDeudorDepositoIn/";

declare function xf:ConsultarNombreDeudorDepositoIn($pagoRecaudo as element(ns1:pagoRecaudo))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CODIGO_CONTRATO>{ data($pagoRecaudo/CONTRACT_ID) }</ns0:CODIGO_CONTRATO>
            <ns0:CODIGO_DEUDOR>{ data($pagoRecaudo/DEBTOR_CODE) }</ns0:CODIGO_DEUDOR>
        </ns0:InputParameters>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;

xf:ConsultarNombreDeudorDepositoIn($pagoRecaudo)