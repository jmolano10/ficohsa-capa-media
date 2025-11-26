xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaSaldoTCBatch" element="ns1:consultaSaldoTCBatch" location="../../AlertasProductos/xsd/alertasProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataHN/consultaSaldoTCBatch/xsd/consultaSaldoTCBatch_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoTCBatch/xq/consultaSaldoTCBatchIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/alertasProductosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldoTCBatch_db";

declare function xf:consultaSaldoTCBatchIn($consultaSaldoTCBatch as element(ns1:consultaSaldoTCBatch))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_XML_TC> { fn-bea:serialize($consultaSaldoTCBatch/CARDS) } </ns0:P_XML_TC>
        </ns0:InputParameters>
};

declare variable $consultaSaldoTCBatch as element(ns1:consultaSaldoTCBatch) external;

xf:consultaSaldoTCBatchIn($consultaSaldoTCBatch)