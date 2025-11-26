(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/TSP/cobroTSPTransferencia/xsd/cobroTSPTransferencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cobroTSPTransferenciaResponse" location="../xsd/cobroTSPTransferenciaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobroTSPTransferenciaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cobroTSPTransferencia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CobroTSPTransferencia/xq/cobroTSPTransferenciaOut/";

declare function xf:cobroTSPTransferenciaOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:cobroTSPTransferenciaResponse) {
        <ns1:cobroTSPTransferenciaResponse>
            <PAID_AMOUNT>{ data($outputParameters1/ns0:PV_MONTO_PAGADO) }</PAID_AMOUNT>
            <LOG_ID>{ data($outputParameters1/ns0:PV_ID_LOG) }</LOG_ID>
        </ns1:cobroTSPTransferenciaResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:cobroTSPTransferenciaOut($outputParameters1)