(:: pragma bea:global-element-parameter parameter="$consultaMontoTSPBanco1" element="ns1:consultaMontoTSPBanco" location="../xsd/consultaMontoTSPTransferenciaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TSP/consultaMontoTSPBanco/xsd/consultaMontoTSPBanco_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTSPTransferenciaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMontoTSPBanco";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMontoTSP/xq/consultaMontoTSPBancoIn/";

declare function xf:consultaMontoTSPBancoIn($consultaMontoTSPBanco1 as element(ns1:consultaMontoTSPBanco))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_TIPO_TRANS>{ data($consultaMontoTSPBanco1/TRANSACTION_TYPE_CODE) }</ns0:PV_CODIGO_TIPO_TRANS>
            <ns0:PV_FT_TT_TRANS>{ data($consultaMontoTSPBanco1/TRANSACTION_PRODUCT_ID) }</ns0:PV_FT_TT_TRANS>
            <ns0:PV_ID_TRANSACCION>{ data($consultaMontoTSPBanco1/TRANSACTION_PRODUCT_ID) }</ns0:PV_ID_TRANSACCION>
            <ns0:PV_TYPE_CREDIT>{ data($consultaMontoTSPBanco1/TRANSACTION_CREDIT_TYPE) }</ns0:PV_TYPE_CREDIT>
            <ns0:PV_SUB_APPLICATION>{ data($consultaMontoTSPBanco1/TRANSACTION_CATEGORY) }</ns0:PV_SUB_APPLICATION>
            <ns0:PV_MONTO_TRANS>{ data($consultaMontoTSPBanco1/TRANSACTION_AMOUNT) }</ns0:PV_MONTO_TRANS>
            <ns0:PV_MONEDA_TRANS>{ data($consultaMontoTSPBanco1/TRANSACTION_CURRENCY) }</ns0:PV_MONEDA_TRANS>
            <ns0:PV_FECHA_TRANS>{ data($consultaMontoTSPBanco1/TRANSACTION_DATE) }</ns0:PV_FECHA_TRANS>
            <ns0:PV_ID_CUENTA_DESTINO>999999</ns0:PV_ID_CUENTA_DESTINO>
        </ns0:InputParameters>
};

declare variable $consultaMontoTSPBanco1 as element(ns1:consultaMontoTSPBanco) external;

xf:consultaMontoTSPBancoIn($consultaMontoTSPBanco1)