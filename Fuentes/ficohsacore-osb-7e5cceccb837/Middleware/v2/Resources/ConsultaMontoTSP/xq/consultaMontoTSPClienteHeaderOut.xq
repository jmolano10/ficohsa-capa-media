(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/TSP/consultaMontoTSPCliente/xsd/consultaMontoTSPCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMontoTSPTransferencia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMontoTSP/xq/consultaMontoTSPTransferenciaHeaderOut/";

declare function xf:consultaMontoTSPTransferenciaHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
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

xf:consultaMontoTSPTransferenciaHeaderOut($outputParameters1)