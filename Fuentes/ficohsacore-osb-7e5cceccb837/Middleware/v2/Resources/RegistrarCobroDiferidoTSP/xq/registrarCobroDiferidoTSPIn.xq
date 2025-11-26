(:: pragma bea:global-element-parameter parameter="$registrarCobroDiferidoTSP1" element="ns1:registrarCobroDiferidoTSP" location="../xsd/registrarCobroDiferidoTSPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TSP/registrarCobroDiferidoTSP/xsd/registrarCobroDiferidoTSP_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registrarCobroDiferidoTSPTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarCobroDiferidoTSP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarCobroDiferidoTSP/xq/registrarCobroDiferidoIn/";

declare function xf:registrarCobroDiferidoIn($registrarCobroDiferidoTSP1 as element(ns1:registrarCobroDiferidoTSP))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID_TRANSACCION>{ data($registrarCobroDiferidoTSP1/TRANSACTION_ID) }</ns0:PV_ID_TRANSACCION>
            <ns0:PV_CODIGO_TIPO_TRANS>{ data($registrarCobroDiferidoTSP1/TRANSACTION_TYPE_CODE) }</ns0:PV_CODIGO_TIPO_TRANS>
            <ns0:PV_REF_FT_TT>{ data($registrarCobroDiferidoTSP1/TRANSACTION_REFERENCE) }</ns0:PV_REF_FT_TT>
            <ns0:PV_ID_CUENTA>{ data($registrarCobroDiferidoTSP1/TRANSACTION_ACCOUNT_NUMBER) }</ns0:PV_ID_CUENTA>
            <ns0:PV_ID_CLIENTE>{ data($registrarCobroDiferidoTSP1/TRANSACTION_CUSTOMER_ID) }</ns0:PV_ID_CLIENTE>
            <ns0:PV_MONEDA>{ data($registrarCobroDiferidoTSP1/TRANSACTION_CURRENCY) }</ns0:PV_MONEDA>
            <ns0:PV_FECHA>{ data($registrarCobroDiferidoTSP1/TRANSACTION_DATE) }</ns0:PV_FECHA>
            <ns0:PV_MOTIVO>{ data($registrarCobroDiferidoTSP1/TRANSACTION_DEFERRED_PAYMENT_REASON) }</ns0:PV_MOTIVO>
            <ns0:PV_MONTO>{ data($registrarCobroDiferidoTSP1/TRANSACTION_AMOUNT) }</ns0:PV_MONTO>
            <ns0:PV_MONTO_TSP>{ data($registrarCobroDiferidoTSP1/TRANSACTION_RATE_AMOUNT) }</ns0:PV_MONTO_TSP>
        </ns0:InputParameters>
};

declare variable $registrarCobroDiferidoTSP1 as element(ns1:registrarCobroDiferidoTSP) external;

xf:registrarCobroDiferidoIn($registrarCobroDiferidoTSP1)