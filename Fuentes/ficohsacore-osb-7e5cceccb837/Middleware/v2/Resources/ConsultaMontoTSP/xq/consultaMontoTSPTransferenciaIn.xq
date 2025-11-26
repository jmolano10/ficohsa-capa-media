(:: pragma bea:global-element-parameter parameter="$consultaMontoTSPTransferencia1" element="ns0:consultaMontoTSPTransferencia" location="../xsd/consultaMontoTSPTransferenciaTypes.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$authentication1" type="ns2:RequestHeader/Authentication" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TSP/consultaMontoTSPTransferencia/xsd/consultaMontoTSPTransferencia_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMontoTSPTransferencia";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTSPTransferenciaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMontoTSP/xq/xin/";

declare function xf:xin($consultaMontoTSPTransferencia1 as element(ns0:consultaMontoTSPTransferencia),
    $authentication1 as element())
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_TIPO_TRANS>{ data($consultaMontoTSPTransferencia1/TRANSACTION_TYPE_CODE) }</ns1:PV_CODIGO_TIPO_TRANS>
            <ns1:PV_FT_TT_TRANS>{ data($consultaMontoTSPTransferencia1/TRANSACTION_REFERENCE) }</ns1:PV_FT_TT_TRANS>
            <ns1:PV_ID_TRANSACCION>{ data($consultaMontoTSPTransferencia1/TRANSACTION_ID) }</ns1:PV_ID_TRANSACCION>
            <ns1:PV_ID_CLIENTE_ORIGEN>{ data($consultaMontoTSPTransferencia1/TRANSACTION_CUSTOMER_ID) }</ns1:PV_ID_CLIENTE_ORIGEN>
            <ns1:PV_ID_CUENTA_TRANS>{ data($consultaMontoTSPTransferencia1/TRANSACTION_ACCOUNT_NUMBER) }</ns1:PV_ID_CUENTA_TRANS>
            <ns1:PV_MONTO_TRANS>{ data($consultaMontoTSPTransferencia1/TRANSACTION_AMOUNT) }</ns1:PV_MONTO_TRANS>
            <ns1:PV_MONEDA_TRANS>{ data($consultaMontoTSPTransferencia1/TRANSACTION_CURRENCY) }</ns1:PV_MONEDA_TRANS>
            <ns1:PV_FECHA_TRANS>{ data($consultaMontoTSPTransferencia1/TRANSACTION_DATE) }</ns1:PV_FECHA_TRANS>
            <ns1:PV_ID_CLIENTE_DESTINO>{ data($consultaMontoTSPTransferencia1/DESTINATION_CUSTOMER_ID) }</ns1:PV_ID_CLIENTE_DESTINO>
            <ns1:PV_ID_CUENTA_DESTINO>{ data($consultaMontoTSPTransferencia1/DESTINATION_ACCOUNT_NUMBER) }</ns1:PV_ID_CUENTA_DESTINO>
            <ns1:PV_MONEDA_DESTINO>{ data($consultaMontoTSPTransferencia1/DESTINATION_CURRENCY) }</ns1:PV_MONEDA_DESTINO>
            <ns1:PV_USUARIO>{ data($authentication1/UserName) }</ns1:PV_USUARIO>
            <ns1:PV_CODIGO_CONVENIO>{ data($consultaMontoTSPTransferencia1/AGREEMENT_ID) }</ns1:PV_CODIGO_CONVENIO>
        </ns1:InputParameters>
};

declare variable $consultaMontoTSPTransferencia1 as element(ns0:consultaMontoTSPTransferencia) external;
declare variable $authentication1 as element() external;

xf:xin($consultaMontoTSPTransferencia1,
    $authentication1)