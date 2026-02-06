xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../recaudos/Resources/ConsultarRelacionOperacionRecaudo/xsd/FLINK_OSB_CONSULTAR_OPER_RECAUDO.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_OPER_RECAUDO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoConsultaRelacionOperIn/";

declare function xf:pagoRecaudoConsultaRelacionOperIn($pagoRecaudo as element(ns0:pagoRecaudo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CODIGO_CONTRATO>{ data($pagoRecaudo/CONTRACT_ID) }</ns1:CODIGO_CONTRATO>
            <ns1:CODIGO_DEUDOR>{ data($pagoRecaudo/DEBTOR_CODE) }</ns1:CODIGO_DEUDOR>
            <ns1:MONEDA_SOLICITUD>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns1:MONEDA_SOLICITUD>
			<ns1:CODIGO_FACTURA_REQ>{ data($pagoRecaudo/BILL_INFORMATION/BILL_NUMBER) }</ns1:CODIGO_FACTURA_REQ>            
        </ns1:InputParameters>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:pagoRecaudoConsultaRelacionOperIn($pagoRecaudo)