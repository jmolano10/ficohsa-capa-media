(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAMDC" element="ns0:pagoRecaudoAMDC" location="../../xsds/PagoRecaudoAMDC/PagoRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/Recaudos/ConsultarRelacionOperacionRecaudoAMDC/FLINK_OSB_CON_OPER_RECAUDO_AMDC.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CON_OPER_RECAUDO_AMDC/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAMDC/ConsultaRelacionOperAMDCIn/";

declare function xf:ConsultaRelacionOperAMDCIn($pagoRecaudoAMDC as element(ns0:pagoRecaudoAMDC))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CONTRATO>{ data($pagoRecaudoAMDC/CONTRACT_ID) }</ns1:CONTRATO>
            <ns1:DEUDOR>{ data($pagoRecaudoAMDC/DEBTOR_CODE) }</ns1:DEUDOR>
            <ns1:CANT_MESES>{ data($pagoRecaudoAMDC/MONTHS_TO_PAY) }</ns1:CANT_MESES>
        </ns1:InputParameters>
};

declare variable $pagoRecaudoAMDC as element(ns0:pagoRecaudoAMDC) external;

xf:ConsultaRelacionOperAMDCIn($pagoRecaudoAMDC)