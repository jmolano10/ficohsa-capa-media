(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/TSP/consultaMontoTSPBanco/xsd/consultaMontoTSPBanco_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMontoTSPBancoResponse" location="../xsd/consultaMontoTSPTransferenciaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTSPTransferenciaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMontoTSPBanco";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMontoTSP/xq/consultaMontoTSPBancoOut/";

declare function xf:consultaMontoTSPBancoOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaMontoTSPBancoResponse) {
        <ns1:consultaMontoTSPBancoResponse>
            <RATABLE_INDICATOR>{ data($outputParameters1/ns0:PV_TASABLE) }</RATABLE_INDICATOR>
            <NON_RATABLE_REASON>{ data($outputParameters1/ns0:PV_MOTIVO) }</NON_RATABLE_REASON>
            <RATE_AMOUNT>{ data($outputParameters1/ns0:PV_MONTO_TSP) }</RATE_AMOUNT>
            <DEBIT_ACCOUNT>{ data($outputParameters1/ns0:PV_PLCATEGORY) }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ data($outputParameters1/ns0:PV_CUENTA_ACREDITAR) }</CREDIT_ACCOUNT>
            <LOG_ID>{ data($outputParameters1/ns0:PV_ID_LOG) }</LOG_ID>
        </ns1:consultaMontoTSPBancoResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaMontoTSPBancoOut($outputParameters1)