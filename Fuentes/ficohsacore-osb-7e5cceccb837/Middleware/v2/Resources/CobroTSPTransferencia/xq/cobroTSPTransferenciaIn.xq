(:: pragma bea:global-element-parameter parameter="$cobroTSPTransferencia1" element="ns1:cobroTSPTransferencia" location="../xsd/cobroTSPTransferenciaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TSP/cobroTSPTransferencia/xsd/cobroTSPTransferencia_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobroTSPTransferenciaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cobroTSPTransferencia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CobroTSPTransferencia/xq/xin/";

declare function xf:xin($cobroTSPTransferencia1 as element(ns1:cobroTSPTransferencia))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_TIPO_TRANS>{ data($cobroTSPTransferencia1/TRANSACTION_TYPE_CODE) }</ns0:PV_CODIGO_TIPO_TRANS>
            <ns0:PV_ID_TRANSACCION>{ data($cobroTSPTransferencia1/TRANSACTION_ID) }</ns0:PV_ID_TRANSACCION>
            <ns0:PV_ID_CLIENTE>{ data($cobroTSPTransferencia1/CUSTOMER_ID) }</ns0:PV_ID_CLIENTE>
            <ns0:PV_CUENTA_DEBITO>{ data($cobroTSPTransferencia1/DEBIT_ACCOUNT) }</ns0:PV_CUENTA_DEBITO>
            <ns0:PV_CUENTA_CREDITO>{ data($cobroTSPTransferencia1/CREDIT_ACCOUNT) }</ns0:PV_CUENTA_CREDITO>
            <ns0:PV_MONTO>{ data($cobroTSPTransferencia1/TRANSACTION_AMOUNT) }</ns0:PV_MONTO>
            <ns0:PV_MONTO_TSP>{ data($cobroTSPTransferencia1/RATE_AMOUNT) }</ns0:PV_MONTO_TSP>
            <ns0:PV_MONEDA>{ data($cobroTSPTransferencia1/TRANSACTION_CURRENCY) }</ns0:PV_MONEDA>
            <ns0:PV_FECHA>{ data($cobroTSPTransferencia1/TRANSACTION_DATE) }</ns0:PV_FECHA>
            <ns0:PV_REF_FT_TT>{ data($cobroTSPTransferencia1/TRANSACTION_REFERENCE) }</ns0:PV_REF_FT_TT>
            <ns0:PV_CENTRO_BENEF>{ data($cobroTSPTransferencia1/PROFIT_CENTRE) }</ns0:PV_CENTRO_BENEF>
            <ns0:PV_CANAL>{ data($cobroTSPTransferencia1/CHANNEL_IDENTIFICATOR) }</ns0:PV_CANAL>
            <ns0:PV_TIPO_PROCESO>{ data($cobroTSPTransferencia1/PROCESS_TYPE) }</ns0:PV_TIPO_PROCESO>
        </ns0:InputParameters>
};

declare variable $cobroTSPTransferencia1 as element(ns1:cobroTSPTransferencia) external;
xf:xin($cobroTSPTransferencia1)