(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/TSP/registrarCobroDiferidoTSP/xsd/registrarCobroDiferidoTSP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registrarCobroDiferidoTSPResponse" location="../xsd/registrarCobroDiferidoTSPTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registrarCobroDiferidoTSPTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarCobroDiferidoTSP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarCobroDiferidoTSP/xq/registrarCobroDiferidoTSPHeader/";

declare function xf:registrarCobroDiferidoTSPHeader($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:registrarCobroDiferidoTSPResponse) {
        <ns1:registrarCobroDiferidoTSPResponse>
            <LOG_ID>{ data($outputParameters1/ns0:PV_ID_LOG) }</LOG_ID>
        </ns1:registrarCobroDiferidoTSPResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:registrarCobroDiferidoTSPHeader($outputParameters1)