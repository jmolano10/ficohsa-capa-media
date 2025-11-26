(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/ConsultarRelacionOpRecaudo/xsd/consultarRelacionOperacionRecaudo_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRelacionOperacionRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoRecaudo/xq/pagoRecaudoGTConsRelaPagIn/";

declare function xf:pagoRecaudoGTConsRelaPagIn($pagoRecaudo1 as element(ns1:pagoRecaudo),
    $factura as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CODIGO_CONTRATO>{ data($pagoRecaudo1/CONTRACT_ID) }</ns0:CODIGO_CONTRATO>
            <ns0:CODIGO_DEUDOR>{ data($pagoRecaudo1/DEBTOR_CODE) }</ns0:CODIGO_DEUDOR>
            <ns0:CODIGO_FACTURA_REQ>{ $factura }</ns0:CODIGO_FACTURA_REQ>
            <ns0:MONEDA_SOLICITUD>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:MONEDA_SOLICITUD>
        </ns0:InputParameters>
};

declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $factura as xs:string external;

xf:pagoRecaudoGTConsRelaPagIn($pagoRecaudo1,
    $factura)