(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/TSP/consultaMontoTSPTransferencia/xsd/consultaMontoTSPTransferencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMontoTSPTransferenciaResponse" location="../xsd/consultaMontoTSPTransferenciaTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMontoTSPTransferencia";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTSPTransferenciaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMontoTSP/xq/consultaMontoTSPTransferenciaOut/";

declare function xf:consultaMontoTSPTransferenciaOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaMontoTSPTransferenciaResponse) {
        <ns0:consultaMontoTSPTransferenciaResponse>
            <RATABLE_INDICATOR>{ data($outputParameters1/ns1:PV_TASABLE) }</RATABLE_INDICATOR>
            <NON_RATABLE_REASON>{ data($outputParameters1/ns1:PV_MOTIVO) }</NON_RATABLE_REASON>
            <TRANSACTION_AMOUNT>{ data($outputParameters1/ns1:PV_MONTO) }</TRANSACTION_AMOUNT>
            <RATE_AMOUNT>{ data($outputParameters1/ns1:PV_MONTO_TSP) }</RATE_AMOUNT>
            <CREDIT_ACCOUNT>{ data($outputParameters1/ns1:PV_CUENTA_ACREDITAR) }</CREDIT_ACCOUNT>
            <LOG_ID>{ data($outputParameters1/ns1:PV_ID_LOG) }</LOG_ID>
        </ns0:consultaMontoTSPTransferenciaResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaMontoTSPTransferenciaOut($outputParameters1)