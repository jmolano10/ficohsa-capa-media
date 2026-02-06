xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaProductosLineaCreditoMovimientos" element="ns0:consultaProductosLineaCreditoMovimientos" location="../../ConsultaProductosLineasCredito/xsd/consultaProductosLineasCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/consultaProductosLineaCredito/xsd/consultaProductosLineaCredito_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductosLineasCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaProductosLineaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductosLineaCreditoMovimientos/xq/consultaProductosLineaCreditoIn/";

declare function xf:consultaProductosLineaCreditoIn($consultaProductosLineaCreditoMovimientos as element(ns0:consultaProductosLineaCreditoMovimientos))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_NUM_LIN_CRED>{ data($consultaProductosLineaCreditoMovimientos/CUSTOMER_QUERY/VALUE) }</ns1:P_NUM_LIN_CRED>
            <ns1:P_INITIAL_RECORD>{ data($consultaProductosLineaCreditoMovimientos/PAGING_INFO[1]/INITIAL_RECORD) }</ns1:P_INITIAL_RECORD>
            <ns1:P_RECORD_COUNT>{ data($consultaProductosLineaCreditoMovimientos/PAGING_INFO[1]/RECORD_COUNT) }</ns1:P_RECORD_COUNT>
            <ns1:P_ORDER>{ data($consultaProductosLineaCreditoMovimientos/PAGING_INFO[1]/ORDER) }</ns1:P_ORDER>
            <ns1:P_PAGING>{ data($consultaProductosLineaCreditoMovimientos/PAGING_INFO[1]/PAGING) }</ns1:P_PAGING>
        </ns1:InputParameters>
};

declare variable $consultaProductosLineaCreditoMovimientos as element(ns0:consultaProductosLineaCreditoMovimientos) external;

xf:consultaProductosLineaCreditoIn($consultaProductosLineaCreditoMovimientos)