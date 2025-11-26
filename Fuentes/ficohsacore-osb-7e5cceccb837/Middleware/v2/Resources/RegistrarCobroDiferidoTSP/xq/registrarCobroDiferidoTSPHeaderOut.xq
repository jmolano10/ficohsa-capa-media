(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/TSP/registrarCobroDiferidoTSP/xsd/registrarCobroDiferidoTSP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarCobroDiferidoTSP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarCobroDiferidoTSP/xsd/registrarCobroDiferidoTSPHeaderOut/";

declare function xf:registrarCobroDiferidoTSPHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $PV_DES_RSPTA in $outputParameters1/ns0:PV_DES_RSPTA
                return
                    <messageId>{ data($PV_DES_RSPTA) }</messageId>
            }
            {
                for $PV_COD_RSPTA in $outputParameters1/ns0:PV_COD_RSPTA
                return
                    <successIndicator>{ data($PV_COD_RSPTA) }</successIndicator>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:registrarCobroDiferidoTSPHeaderOut($outputParameters1)