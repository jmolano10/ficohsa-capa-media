(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/TSP/cobroTSPTransferencia/xsd/cobroTSPTransferencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cobroTSPTransferencia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CobroTSPTransferencia/xq/cobroTSPTransferenciaOut/";

declare function xf:cobroTSPTransferenciaOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $PV_REF_FT_TT_COBRO in $outputParameters1/ns0:PV_REF_FT_TT_COBRO
                return
                    <transactionId>{ data($PV_REF_FT_TT_COBRO) }</transactionId>
            }
            {
                for $PV_COD_RSPTA in $outputParameters1/ns0:PV_COD_RSPTA
                return
                    <successIndicator>{ data($PV_COD_RSPTA) }</successIndicator>
            }
            {
                for $PV_DES_RSPTA in $outputParameters1/ns0:PV_DES_RSPTA
                return
                    <messages>{ data($PV_DES_RSPTA) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:cobroTSPTransferenciaOut($outputParameters1)