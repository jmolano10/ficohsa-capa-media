xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldoTCBatchInterno" element="ns0:ConsultaSaldoTCBatchInterno" location="../xsd/consultaSaldoTCBatchInternoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/VASA/consultaSaldoTCBatch/xsd/consultaSaldoTCBatch_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaSaldoTCBatchInterno";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldosTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoTCBatchInterno/xq/consultaSaldoTCBatchInternoHNIn/";

declare function xf:consultaSaldoTCBatchInternoHNIn($consultaSaldoTCBatchInterno as element(ns0:ConsultaSaldoTCBatchInterno))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_XML_TC> { fn-bea:serialize($consultaSaldoTCBatchInterno/CARDS) } </ns1:P_XML_TC>
        </ns1:InputParameters>
};

declare variable $consultaSaldoTCBatchInterno as element(ns0:ConsultaSaldoTCBatchInterno) external;

xf:consultaSaldoTCBatchInternoHNIn($consultaSaldoTCBatchInterno)